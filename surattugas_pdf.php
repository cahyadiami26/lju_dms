<?php
// surattugas_pdf.php
error_reporting(E_ALL);
ini_set('display_errors', 1);

require_once __DIR__ . '/config.php';
require_once __DIR__ . '/lib/fpdf/fpdf.php';

requireLogin();

$id = isset($_GET['id']) ? (int)$_GET['id'] : 0;
$currentUserId = (int)$_SESSION['user_id'];

// 1. Ambil Data Surat Tugas & Info Penandatangan
$stmt = $pdo->prepare("
    SELECT st.*, 
           u_sign.name AS sign_name, u_sign.position AS sign_pos, u_sign.division AS sign_div, u_sign.department AS sign_dept, u_sign.signature AS sign_sig,
           u_buat.name AS creator_name
    FROM tbl_surat_tugas st
    LEFT JOIN users u_sign ON st.penandatangan_id = u_sign.id
    LEFT JOIN users u_buat ON st.created_by = u_buat.id
    WHERE st.id = ?
");
$stmt->execute([$id]);
$surat = $stmt->fetch();

if (!$surat) {
    exit('Surat tugas tidak ditemukan.');
}

// 2. Ambil Daftar Personil yang Ditugaskan
$stmtPersonil = $pdo->prepare("
    SELECT u.name, u.position, u.division, u.department
    FROM tbl_surat_tugas_personil stp
    JOIN users u ON stp.user_id = u.id
    WHERE stp.surat_tugas_id = ?
    ORDER BY u.name ASC
");
$stmtPersonil->execute([$id]);
$assignedList = $stmtPersonil->fetchAll();

// Fungsi Format Tanggal Indonesia
function tgl_indo_pdf($tanggal) {
    if (empty($tanggal)) return '-';
    $bulan = [
        1 => 'Januari', 'Februari', 'Maret', 'April', 'Mei', 'Juni',
        'Juli', 'Agustus', 'September', 'Oktober', 'November', 'Desember'
    ];
    $pecahkan = explode('-', date('Y-m-d', strtotime($tanggal)));
    return $pecahkan[2] . ' ' . $bulan[(int)$pecahkan[1]] . ' ' . $pecahkan[0];
}

/* GENERATE QR CODE */
$qrDir = APP_PATH . '/uploads/qrcodes';
if (!is_dir($qrDir)) {
    mkdir($qrDir, 0755, true);
}
$qrPath = $qrDir . '/qr_st_' . $surat['id'] . '.png';
$scanUrl = APP_URL . '/surattugas_scan.php?id=' . urlencode($surat['id']);

if ($surat['status_surat'] === 'published' || $surat['status_surat'] === 'complete') {
    $apiUrl = 'https://api.qrserver.com/v1/create-qr-code/?size=200x200&data=' . urlencode($scanUrl);
    $qrImageData = @file_get_contents($apiUrl);

    if ($qrImageData !== false && strlen($qrImageData) > 0) {
        file_put_contents($qrPath, $qrImageData);
    }
}

/* CLASS EXTENDED FPDF DENGAN PARSER HTML & FOOTER KONTAK */
class SuratTugasPDF extends FPDF
{
    public $status_surat;
    public $watermarkLogo;
    public $fontFamily = 'Times'; // Default dari variabel config

    function Header()
    {
        // Watermark tampil jika status published/complete
        if (($this->status_surat === 'published' || $this->status_surat === 'complete') && file_exists($this->watermarkLogo)) {
            $this->Image($this->watermarkLogo, 45, 80, 120);
        }
    }

    function Footer()
    {
        $this->SetY(-25);
        $this->SetDrawColor(0, 0, 0);
        $this->SetLineWidth(0.4);
        $this->Line(20, $this->GetY(), 190, $this->GetY());
        $this->Ln(2);

        $this->SetTextColor(50, 50, 50);
        
        $this->SetFont($this->fontFamily, '', $this->font_size);
        $pageWidth = 210;

        // Baris 1: Email + Phone
        $emailLabel = 'Email : ';
        $emailValue = 'lampungjasautama@gmail.com';
        $phoneLabel = 'Phone : ';
        $phoneValue = '+62 812 9292 3311';

        $this->SetFont($this->fontFamily, 'B', $this->font_size);
        $emailLabelWidth = $this->GetStringWidth($emailLabel);
        $this->SetFont($this->fontFamily, '', $this->font_size);
        $emailValueWidth = $this->GetStringWidth($emailValue);

        $this->SetFont($this->fontFamily, 'B', $this->font_size);
        $phoneLabelWidth = $this->GetStringWidth($phoneLabel);
        $this->SetFont($this->fontFamily, '', $this->font_size);
        $phoneValueWidth = $this->GetStringWidth($phoneValue);

        $jarak = 15;
        $totalWidth = $emailLabelWidth + $emailValueWidth + $jarak + $phoneLabelWidth + $phoneValueWidth;
        $x = ($pageWidth - $totalWidth) / 2;

        $this->SetX($x);
        $this->SetFont($this->fontFamily, 'B', 8);
        $this->Cell($emailLabelWidth, 3.5, $emailLabel, 0, 0, 'L');
        $this->SetFont($this->fontFamily, '', 8);
        $this->Cell($emailValueWidth, 3.5, $emailValue, 0, 0, 'L');
        $this->Cell($jarak, 3.5, '', 0, 0);
        $this->SetFont($this->fontFamily, 'B', 8);
        $this->Cell($phoneLabelWidth, 3.5, $phoneLabel, 0, 0, 'L');
        $this->SetFont($this->fontFamily, '', 8);
        $this->Cell($phoneValueWidth, 3.5, $phoneValue, 0, 1, 'L');

        // Baris 2: Alamat
        $alamatLabel = 'Alamat : ';
        $alamatValue = 'Jl. Jend. Sudirman No.81, Tj. Raya, Kec. Kedamaian, Kota Bandar Lampung, Lampung 35128.';

        $this->SetFont($this->fontFamily, 'B', 8);
        $alamatLabelWidth = $this->GetStringWidth($alamatLabel);
        $this->SetFont($this->fontFamily, '', 8);
        $alamatValueWidth = $this->GetStringWidth($alamatValue);
        $alamatTotalWidth = $alamatLabelWidth + $alamatValueWidth;
        $xAlamat = ($pageWidth - $alamatTotalWidth) / 2;

        $this->SetX($xAlamat);
        $this->SetFont($this->fontFamily, 'B', 8);
        $this->Cell($alamatLabelWidth, 3.5, $alamatLabel, 0, 0, 'L');
        $this->SetFont($this->fontFamily, '', 8);
        $this->Cell($alamatValueWidth, 3.5, $alamatValue, 0, 1, 'L');
    }
    
    function WriteHTML($html)
    {
        $html = str_replace(['<p>', '</p>', '<br>', '<br/>', '<br />'], ['', "\n", "\n", "\n", "\n"], $html);
        $html = str_replace('&nbsp;', ' ', $html);
        $html = strip_tags($html, '<b><i><u>');

        $a = preg_split('/(<[^>]+>)/', $html, -1, PREG_SPLIT_DELIM_CAPTURE);
        foreach($a as $i => $e) {
            if($i % 2 == 0) {
                $this->Write(5, $e);
            } else {
                if($e[1] == '/') {
                    $this->SetStyle(substr($e, 2, -1), false);
                } else {
                    $this->SetStyle(substr($e, 1, -1), true);
                }
            }
        }
    }

    function SetStyle($tag, $enable)
    {
        $tag = strtoupper($tag);
        if($tag == 'B') $this->SetFont('', $enable ? 'B' : '');
        if($tag == 'I') $this->SetFont('', $enable ? 'I' : '');
        if($tag == 'U') $this->SetFont('', $enable ? 'U' : '');
    }
}

// Inisialisasi PDF (A4 Portrait, Margin Atas 10mm / 1cm, Samping 20mm / 2cm)
$pdf = new SuratTugasPDF('P', 'mm', 'A4');
$pdf->status_surat = $surat['status_surat'];
$pdf->watermarkLogo = __DIR__ . '/assets/img/watermarklogo.png';
$pdf->fontFamily = (isset($PDF_CONFIG['font_family']) && $PDF_CONFIG['font_family'] === 'Verdana') ? 'Arial' : 'Times'; // FPDF standar aman menggunakan Times/Arial
$pdf->SetMargins(20, 10, 20); 
$pdf->SetAutoPageBreak(true, 28);
$pdf->AddPage();

// 1. KOP SURAT LOGO
$logoKop = __DIR__ . '/assets/img/lju_logo.png';
if (file_exists($logoKop)) {
    $pdf->Image($logoKop, 20, 10, 55);
    $pdf->Ln(18);
} else {
    $pdf->Ln(6);
}

// Garis Pemisah Kop Surat
$pdf->SetDrawColor(0, 0, 0);
$pdf->SetLineWidth(0.6);
$pdf->Line(20, $pdf->GetY(), 190, $pdf->GetY());
$pdf->SetLineWidth(0.2);
$pdf->Ln(6);

// 2. JUDUL SURAT
$pdf->SetFont($pdf->fontFamily, 'B', 14);
$pdf->Cell(170, 6, 'SURAT TUGAS', 0, 1, 'C');
$pdf->SetFont($pdf->fontFamily, '', $this->font_size);
$pdf->Cell(170, 6, 'Nomor : ' . $surat['nomor_surat'], 0, 1, 'C');

$pdf->Ln(6);

// 3. TEKS PEMBUKA
$pdf->SetFont($pdf->fontFamily, '', $this->font_size);
$pdf->WriteHTML($surat['teks_pembuka']);

$pdf->Ln(6);

// 4. DAFTAR PERSONIL YANG DITUGASKAN
$pdf->Cell(170, 6, 'Dengan ini memberikan tugas kepada:', 0, 1, 'L');
$no = 1;
foreach ($assignedList as $person) {
    // Nomenklatur Jabatan
    $posLower = strtolower(trim($person['position'] ?? ''));
    $detailLabel = '';
    if (strpos($posLower, 'kepala bidang') !== false) {
        $detailLabel = 'Kepala Bidang'." ".$person['division'] ?? '-'; // division = Nama Bidang
    } elseif (strpos($posLower, 'kepala divisi') !== false) {
        $detailLabel = 'Kepala Divisi'." ".$person['department'] ?? '-'; // department = Nama Divisi
    } elseif (strpos($posLower, 'staff') !== false) {
        $detailLabel = 'Staff'." ".$person['division'] ?? '-';
    } else {
        $detailLabel = $person['position'];
    }

    $pdf->Cell(10, 6, $no . '.', 0, 0, 'R');
    $pdf->Cell(20, 6, 'Nama', 0, 0);
    $pdf->Cell(5, 6, ':', 0, 0);
    $pdf->SetFont($pdf->fontFamily, 'B', $this->font_size);
    $pdf->Cell(135, 6, $person['name'], 0, 1, 'L');
    
    $pdf->SetFont($pdf->fontFamily, '', $this->font_size);
    $pdf->Cell(10, 6, '', 0, 0);
    $pdf->Cell(20, 6, 'Jabatan', 0, 0);
    $pdf->Cell(5, 6, ':', 0, 0);
    $pdf->Cell(135, 6, $detailLabel, 0, 1, 'L');
    $no++;
}

$pdf->Ln(4);

// 5. BERITA PENUGASAN (Isi / Maksud & Tujuan)
$pdf->WriteHTML($surat['berita_penugasan']);

$pdf->Ln(8);

// 6. PARAGRAF PENUTUP
$pdf->WriteHTML('Surat tugas ini berlaku pada tanggal ditetapkan dan dinyatakan berakhir sampai adanya perubahan, penyelesaian tugas, dan/atau pencabutan.');
$pdf->Ln(4);
$pdf->WriteHTML('Demikian surat tugas ini dibuat untuk dapat dipergunakan sebagaimana mestinya dengan penuh tanggung jawab.');

$pdf->Ln(10);

// 7. TANDA TANGAN & QR CODE
if ($pdf->GetY() > 210) {
    $pdf->AddPage();
}

$ySign = $pdf->GetY();

// Kiri: QR Code
if (($surat['status_surat'] === 'published' || $surat['status_surat'] === 'complete') && file_exists($qrPath)) {
    $pdf->Image($qrPath, 20, $ySign, 25, 25);
    $pdf->SetXY(20, $ySign + 26);
    $pdf->SetFont($pdf->fontFamily, '', 8);
    $pdf->MultiCell(75, 3.5, '[Dokumen ini ditandatangani secara digital]');
} else {
    $pdf->SetXY(20, $ySign);
    $pdf->SetFont($pdf->fontFamily, 'I', 8);
    $pdf->SetTextColor(120, 120, 120);
    $pdf->Cell(75, 5, '[ QR Code Verifikasi ]', 0, 1);
    $pdf->SetFont($pdf->fontFamily, '', 8);
    $pdf->SetTextColor(0, 0, 0);
    $pdf->MultiCell(75, 3.5, '[Dokumen ini ditandatangani secara digital]');
}

// Kanan: Tempat, Tanggal, & Penandatangan
$pdf->SetXY(110, $ySign);
$pdf->SetFont($pdf->fontFamily, '', $this->font_size);
$pdf->Cell(35, 5, 'Dikeluarkan di', 0, 0);
$pdf->Cell(5, 5, ':', 0, 0);
$pdf->Cell(40, 5, 'Bandar Lampung', 0, 1);

$pdf->SetX(110);
$pdf->SetFont($pdf->fontFamily, '', $this->font_size);
$pdf->Cell(35, 5, 'Tanggal', 0, 0);
$pdf->Cell(5, 5, ':', 0, 0);
$pdf->Cell(40, 5, tgl_indo_pdf($surat['tanggal_surat']), 0, 1);

$pdf->Ln(2);
$pdf->SetX(110);
$pdf->SetFont($pdf->fontFamily, 'B', 11);
$pdf->Cell(80, 5, $surat['sign_pos'] ?? 'Pejabat Penandatangan', 0, 1, 'C');

// ==========================================================
// PEMBERSIHAN & KONVERSI AMAN TANDA TANGAN UNTUK FPDF
// ==========================================================
$isManual = ($surat['jenis_tandatangan'] === 'manual_wet');
$rawSigFile = '';

// Cari path file tanda tangan dari signature_data atau default user
if (!empty($surat['signature_data'])) {
    $potentialPath = SIGNATURE_PATH . '/' . basename($surat['signature_data']);
    if (file_exists($potentialPath)) {
        $rawSigFile = $potentialPath;
    }
}
if (empty($rawSigFile) && !empty($surat['sign_sig'])) {
    $potentialDefault = SIGNATURE_PATH . '/' . basename($surat['sign_sig']);
    if (file_exists($potentialDefault)) {
        $rawSigFile = $potentialDefault;
    }
}

$validSigFile = '';
if (!empty($rawSigFile) && file_exists($rawSigFile)) {
    // Buat file temporary PNG yang dijamin kompatibel 100% dengan FPDF
    $imgInfo = @getimagesize($rawSigFile);
    if ($imgInfo !== false) {
        $imgType = $imgInfo[2];
        $gdImage = false;

        if ($imgType === IMAGETYPE_PNG) {
            $gdImage = @imagecreatefrompng($rawSigFile);
        } elseif ($imgType === IMAGETYPE_JPEG) {
            $gdImage = @imagecreatefromjpeg($rawSigFile);
        } elseif ($imgType === IMAGETYPE_WEBP && function_exists('imagecreatefromwebp')) {
            $gdImage = @imagecreatefromwebp($rawSigFile);
        }

        if ($gdImage) {
            // Path file cache PNG sementara untuk FPDF
            $tempPngPath = sys_get_temp_dir() . '/fpdf_sig_' . md5($rawSigFile) . '.png';
            
            // Pertahankan transparansi warna
            imagealphablending($gdImage, false);
            imagesavealpha($gdImage, true);
            
            if (@imagepng($gdImage, $tempPngPath)) {
                $validSigFile = $tempPngPath;
            }
            @imagedestroy($gdImage);
        }
    }
}

// Render Bagian Tanda Tangan ke PDF
$pdf->SetXY(110, $pdf->GetY());
if ($surat['status_surat'] === 'published' || $surat['status_surat'] === 'complete') {
    if ($isManual) {
        $pdf->Ln(4);
        $pdf->SetFont($pdf->fontFamily, 'I', 9);
        $pdf->SetTextColor(100, 100, 100);
        $pdf->Cell(80, 12, ' ', 0, 1, 'C');
        $pdf->SetTextColor(0, 0, 0);
        $pdf->Ln(2);
    } elseif (!empty($validSigFile) && file_exists($validSigFile)) {
        // Menggunakan file hasil konversi bersih format PNG
        $pdf->Image($validSigFile, 135, $pdf->GetY() + 2, 30, 15);
        $pdf->Ln(18);
    } else {
        $pdf->SetFont($pdf->fontFamily, 'I', 9);
        $pdf->SetTextColor(120, 120, 120);
        $pdf->Cell(80, 15, '[ Menunggu Tanda Tangan ]', 0, 1, 'C');
        $pdf->SetTextColor(0, 0, 0);
    }
} else {
    $pdf->SetFont($pdf->fontFamily, 'I', 9);
    $pdf->SetTextColor(120, 120, 120);
    $pdf->Cell(80, 15, '[ Menunggu Tanda Tangan ]', 0, 1, 'C');
    $pdf->SetTextColor(0, 0, 0);
}

$pdf->SetX(110);
$pdf->SetFont($pdf->fontFamily, 'BU', 11);
$pdf->Cell(80, 5, strtoupper($surat['sign_name'] ?? '-'), 0, 1, 'C');

// Output PDF ke Browser
$pdf->Output('I', 'Surat_Tugas_' . $surat['id'] . '.pdf');