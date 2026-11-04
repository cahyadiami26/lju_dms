<?php
ini_set('display_errors', 1);
ini_set('display_startup_errors', 1);
error_reporting(E_ALL);

require_once __DIR__ . '/config.php';
require_once __DIR__ . '/lib/fpdf/fpdf.php';

requireLogin();

$id = isset($_GET['id']) ? (int)$_GET['id'] : 0;
$currentUserId = (int)$_SESSION['user_id'];

// Ambil Data Surat Keluar & Data Penandatangan
$stmt = $pdo->prepare("
    SELECT sk.*, 
           u_kirim.name AS pengirim_name, u_kirim.position AS pengirim_pos, u_kirim.division AS pengirim_div, u_kirim.department AS pengirim_dept, u_kirim.signature AS pengirim_sig,
           u_buat.name AS creator_name
    FROM surat_keluar sk
    LEFT JOIN users u_kirim ON sk.dikirim_oleh = u_kirim.id
    LEFT JOIN users u_buat ON sk.created_by = u_buat.id
    WHERE sk.id = ? AND (sk.created_by = ? OR sk.dikirim_oleh = ? OR sk.penandatangan = ? OR ? = 'admin')
");
$stmt->execute([$id, $currentUserId, $currentUserId, $currentUserId, $_SESSION['role'] ?? '']);
$surat = $stmt->fetch();

if (!$surat) {
    exit('Surat keluar tidak ditemukan atau Anda tidak memiliki akses.');
}

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
$qrPath = $qrDir . '/qr_sk_' . $surat['id'] . '.png';
$scanUrl = APP_URL . '/suratkeluar_scan.php?id=' . urlencode($surat['id']);

if ($surat['status'] === 'published') {
    $apiUrl = 'https://api.qrserver.com/v1/create-qr-code/?size=200x200&data=' . urlencode($scanUrl);
    $qrImageData = @file_get_contents($apiUrl);

    if ($qrImageData !== false && strlen($qrImageData) > 0) {
        file_put_contents($qrPath, $qrImageData);
    }
}

/* CLASS EXTENDED FPDF DENGAN PARSER HTML & FOOTER KONTAK */
class SuratKeluarPDF extends FPDF
{
    public $status;
    public $watermarkLogo;

    function Header()
    {
        // Watermark tampil jika status published
        if ($this->status === 'published' && file_exists($this->watermarkLogo)) {
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
        $this->SetFont('Times', '', 8);
        $pageWidth = 210;

        // Baris 1: Email + Phone
        $emailLabel = 'Email : ';
        $emailValue = 'lampungjasautama@gmail.com';
        $phoneLabel = 'Phone : ';
        $phoneValue = '+62 812 9292 3311';

        $this->SetFont('Times', 'B', 8);
        $emailLabelWidth = $this->GetStringWidth($emailLabel);
        $this->SetFont('Times', '', 8);
        $emailValueWidth = $this->GetStringWidth($emailValue);

        $this->SetFont('Times', 'B', 8);
        $phoneLabelWidth = $this->GetStringWidth($phoneLabel);
        $this->SetFont('Times', '', 8);
        $phoneValueWidth = $this->GetStringWidth($phoneValue);

        $jarak = 15;
        $totalWidth = $emailLabelWidth + $emailValueWidth + $jarak + $phoneLabelWidth + $phoneValueWidth;
        $x = ($pageWidth - $totalWidth) / 2;

        $this->SetX($x);
        $this->SetFont('Times', 'B', 8);
        $this->Cell($emailLabelWidth, 3.5, $emailLabel, 0, 0, 'L');
        $this->SetFont('Times', '', 8);
        $this->Cell($emailValueWidth, 3.5, $emailValue, 0, 0, 'L');
        $this->Cell($jarak, 3.5, '', 0, 0);
        $this->SetFont('Times', 'B', 8);
        $this->Cell($phoneLabelWidth, 3.5, $phoneLabel, 0, 0, 'L');
        $this->SetFont('Times', '', 8);
        $this->Cell($phoneValueWidth, 3.5, $phoneValue, 0, 1, 'L');

        // Baris 2: Alamat
        $alamatLabel = 'Alamat : ';
        $alamatValue = 'Jl. Jend. Sudirman No.81, Tj. Raya, Kec. Kedamaian, Kota Bandar Lampung, Lampung 35128.';

        $this->SetFont('Times', 'B', 8);
        $alamatLabelWidth = $this->GetStringWidth($alamatLabel);
        $this->SetFont('Times', '', 8);
        $alamatValueWidth = $this->GetStringWidth($alamatValue);
        $alamatTotalWidth = $alamatLabelWidth + $alamatValueWidth;
        $xAlamat = ($pageWidth - $alamatTotalWidth) / 2;

        $this->SetX($xAlamat);
        $this->SetFont('Times', 'B', 8);
        $this->Cell($alamatLabelWidth, 3.5, $alamatLabel, 0, 0, 'L');
        $this->SetFont('Times', '', 8);
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

// Inisialisasi PDF (A4 Portrait, Margin Atas diubah menjadi 10mm / 1cm)
$pdf = new SuratKeluarPDF('P', 'mm', 'A4');
$pdf->status = $surat['status'];
$pdf->watermarkLogo = __DIR__ . '/assets/img/watermarklogo.png';
$pdf->SetMargins(20, 10, 20); // Margin atas 10mm (1cm)
$pdf->SetAutoPageBreak(true, 28);
$pdf->AddPage();

// 1. KOP SURAT LOGO (disesuaikan dengan margin atas 1cm)
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

// 2. METADATA SURAT
$pdf->SetFont($pdf->fontFamily, '', $this->font_size);
$pdf->SetTextColor(0, 0, 0);

$pdf->Cell(25, 6, 'Nomor', 0, 0);
$pdf->Cell(5, 6, ':', 0, 0);
$pdf->Cell(80, 6, $surat['nomor_surat'], 0, 0);
$pdf->Cell(60, 6, tgl_indo_pdf($surat['tanggal_surat']), 0, 1, 'R');

$pdf->Cell(25, 6, 'Perihal', 0, 0);
$pdf->Cell(5, 6, ':', 0, 0);
$pdf->MultiCell(140, 6, $surat['perihal'], 0, 'L');

$pdf->Cell(25, 6, 'Lampiran', 0, 0);
$pdf->Cell(5, 6, ':', 0, 0);
$pdf->Cell(140, 6, $surat['lampiran_surat'], 0, 1);

$pdf->Ln(6);

// 3. PENERIMA SURAT
$pdf->Cell(170, 5, 'Kepada Yth.', 0, 1);
$pdf->SetFont($pdf->fontFamily, 'B', $this->font_size);
$pdf->Cell(170, 5, $surat['penerima_surat'], 0, 1);
$pdf->SetFont($pdf->fontFamily, '', $this->font_size);
$pdf->Cell(170, 5, 'Di Tempat', 0, 1);

$pdf->Ln(6);

// 4. ISI SURAT (Render HTML Formatting dari WYSIWYG)
$pdf->SetFont($pdf->fontFamily, '', $this->font_size);
$pdf->WriteHTML($surat['isi_surat']);

$pdf->Ln(12);

// 5. TANDA TANGAN & QR CODE
if ($pdf->GetY() > 200) {
    $pdf->AddPage();
}

$ySign = $pdf->GetY();

// Kiri: QR Code
if ($surat['status'] === 'published' && file_exists($qrPath)) {
    $pdf->Image($qrPath, 20, $ySign, 25, 25);
    $pdf->SetXY(20, $ySign + 26);
    $pdf->SetFont('Times', '', 8);
    $pdf->MultiCell(75, 3.5, '[Dokumen ini ditandatangani secara digital]');
} else {
    $pdf->SetXY(20, $ySign);
    $pdf->SetFont('Times', 'I', 8);
    $pdf->SetTextColor(120, 120, 120);
    $pdf->Cell(75, 5, '[ QR Code Verifikasi ]', 0, 1);
    $pdf->SetFont('Times', '', 8);
    $pdf->SetTextColor(0, 0, 0);
    $pdf->MultiCell(75, 3.5, '[Dokumen ini ditandatangani secara digital]');
}

// Kanan: Penandatangan
$pdf->SetXY(110, $ySign);
$pdf->SetFont($pdf->fontFamily, 'B', $this->font_size);
$posText = trim(($surat['pengirim_pos'] ?? 'Jabatan') . ' ' . ($surat['pengirim_div'] ?? ''));
$pdf->Cell(80, 5, $posText, 0, 1, 'C');

// Logika Tanda Tangan: Cek apakah manual atau digital
$isManual = ($surat['jenis_tandatangan'] === 'manual');
// Ambil path file fisik tanda tangan jika ada
$sigFileRelative = str_replace(APP_URL, '', $surat['signature_path'] ?? '');
$sigFileRelative = ltrim($sigFileRelative, '/');
$sigFile = APP_PATH . '/' . $sigFileRelative;
if (empty($surat['signature_path']) && !empty($surat['pengirim_sig'])) {
    $sigFile = SIGNATURE_PATH . '/' . basename($surat['pengirim_sig']);
}

$pdf->SetXY(110, $pdf->GetY());
if ($surat['status'] === 'published') {
    if ($isManual) {
        // Jika manual, kosongkan gambar dan tampilkan keterangan teks tanda tangan basah
        $pdf->Ln(4);
        $pdf->SetFont('Times', 'I', 9);
        $pdf->SetTextColor(100, 100, 100);
        $pdf->Cell(80, 12, '[ Tanda Tangan Basah / Manual ]', 0, 1, 'C');
        $pdf->SetTextColor(0, 0, 0);
        $pdf->Ln(2);
    } elseif (!empty($surat['signature_path']) && file_exists($sigFile)) {
        $pdf->Image($sigFile, 135, $pdf->GetY() + 2, 30, 15);
        $pdf->Ln(18);
    } else {
        $pdf->SetFont('Times', 'I', 9);
        $pdf->SetTextColor(120, 120, 120);
        $pdf->Cell(80, 15, '[ Menunggu Tanda Tangan ]', 0, 1, 'C');
        $pdf->SetTextColor(0, 0, 0);
    }
} else {
    $pdf->SetFont('Times', 'I', 9);
    $pdf->SetTextColor(120, 120, 120);
    $pdf->Cell(80, 15, '[ Menunggu Tanda Tangan ]', 0, 1, 'C');
    $pdf->SetTextColor(0, 0, 0);
}

$pdf->SetX(110);
$pdf->SetFont($pdf->fontFamily, 'BU', $this->font_size);
$pdf->Cell(80, 5, strtoupper($surat['pengirim_name']), 0, 1, 'C');

// Output PDF
$pdf->Output('I', 'Surat_Keluar_' . $surat['id'] . '.pdf');