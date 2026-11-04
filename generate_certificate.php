<?php
/**
 * Generate Sertifikat Digital PDF
 * - Sertifikat standalone (download certificate only)
 * - Merge dengan dokumen asli (download original + certificate)
 * - QR Code via online API (qrserver.com) + fallback GD
 * - Footer digital di setiap halaman
 */

require_once 'config.php';

// Memastikan user sudah login
requireLogin();

$document_id = isset($_GET['id']) ? (int)$_GET['id'] : 0;
$mode = isset($_GET['mode']) ? $_GET['mode'] : 'certificate'; // 'certificate' atau 'merge'

if ($document_id <= 0) {
    die('ID dokumen tidak valid');
}

// Ambil data dokumen menggunakan PDO
$stmt = $pdo->prepare("SELECT d.*, u.name as uploader_name, u.position as uploader_position 
                        FROM documents d 
                        LEFT JOIN users u ON d.user_id = u.id 
                        WHERE d.id = ?");
$stmt->execute([$document_id]);
$doc = $stmt->fetch();

if (!$doc) {
    die('Dokumen tidak ditemukan');
}

// Ambil data penandatangan
$stmt = $pdo->prepare("SELECT s.*, u.name, u.position, u.division 
                        FROM signatures s 
                        LEFT JOIN users u ON s.user_id = u.id 
                        WHERE s.document_id = ? 
                        ORDER BY s.signed_at ASC");
$stmt->execute([$document_id]);
$signatures = $stmt->fetchAll();

// Ambil disposisi terkait
$stmt = $pdo->prepare("SELECT dp.*, 
                        uf.name as from_name, uf.position as from_position, uf.division as from_division,
                        ut.name as to_name, ut.position as to_position, ut.division as to_division
                        FROM dispositions dp
                        LEFT JOIN users uf ON dp.from_user_id = uf.id
                        LEFT JOIN users ut ON dp.to_user_id = ut.id
                        WHERE dp.document_id = ?
                        ORDER BY dp.created_at ASC");
$stmt->execute([$document_id]);
$dispositions = $stmt->fetchAll();

// Generate / ambil verification token
if (empty($doc['verification_token'])) {
    $token = hash('sha256', $doc['id'] . $doc['title'] . time() . bin2hex(random_bytes(16)));
    $stmt = $pdo->prepare("UPDATE documents SET verification_token = ? WHERE id = ?");
    $stmt->execute([$token, $document_id]);
    $doc['verification_token'] = $token;
}

// Document hash (verification_hash)
if (empty($doc['verification_hash'])) {
    $file_path = $doc['file_path'];
    if (file_exists($file_path)) {
        $doc_hash = hash_file('sha256', $file_path);
    } else {
        $doc_hash = hash('sha256', $doc['id'] . $doc['title'] . $doc['created_at']);
    }
    $stmt = $pdo->prepare("UPDATE documents SET verification_hash = ? WHERE id = ?");
    $stmt->execute([$doc_hash, $document_id]);
    $doc['verification_hash'] = $doc_hash;
}

$verification_url = APP_URL . '/verification.php?token=' . $doc['verification_token'];
$doc_hash = $doc['verification_hash'];

// ============================================================
// QR Code Generator
// ============================================================
function generateQRCodeImage($url, $size = 150) {
    // Coba online API terlebih dahulu
    $api_url = 'https://api.qrserver.com/v1/create-qr-code/?size=' . $size . 'x' . $size . '&data=' . urlencode($url) . '&format=png';
    
    $context = stream_context_create([
        'http' => ['timeout' => 5, 'ignore_errors' => true]
    ]);
    
    $qr_data = @file_get_contents($api_url, false, $context);
    if ($qr_data !== false && strlen($qr_data) > 100) {
        $temp = sys_get_temp_dir() . '/qr_' . md5($url . $size) . '.png';
        file_put_contents($temp, $qr_data);
        return $temp;
    }

    // Fallback: buat QR placeholder dengan GD
    return generateQRWithGD($url, $size);
}

function generateQRWithGD($text, $size = 150) {
    if (file_exists('includes/phpqrcode/qrlib.php')) {
        require_once 'includes/phpqrcode/qrlib.php';
        $temp = sys_get_temp_dir() . '/qr_gd_' . md5($text) . '.png';
        QRcode::png($text, $temp, QR_ECLEVEL_M, ceil($size / 37), 2);
        return $temp;
    }

    $img = imagecreate($size, $size);
    $white = imagecolorallocate($img, 255, 255, 255);
    $black = imagecolorallocate($img, 0, 0, 0);
    $gray = imagecolorallocate($img, 200, 200, 200);
    imagefill($img, 0, 0, $white);

    imagerectangle($img, 0, 0, $size - 1, $size - 1, $black);

    $cellSize = max(1, floor($size / 25));
    drawFinderPattern($img, $cellSize, 0, 0, $black, $white);
    drawFinderPattern($img, $cellSize, 18 * $cellSize, 0, $black, $white);
    drawFinderPattern($img, $cellSize, 0, 18 * $cellSize, $black, $white);

    $seed = crc32($text);
    mt_srand($seed);
    for ($y = 4 * $cellSize; $y < $size - 4 * $cellSize; $y += $cellSize) {
        for ($x = 4 * $cellSize; $x < $size - 4 * $cellSize; $x += $cellSize) {
            if (mt_rand(0, 1)) {
                imagefilledrectangle($img, $x, $y, $x + $cellSize - 1, $y + $cellSize - 1, $black);
            }
        }
    }

    $font_size = max(8, floor($size / 18));
    $label = "QR Code";
    $tw = imagefontwidth($font_size) * strlen($label);
    imagestring($img, $font_size, ($size - $tw) / 2, $size - $font_size - 6, $label, $gray);

    $temp = sys_get_temp_dir() . '/qr_fallback_' . md5($text) . '.png';
    imagepng($img, $temp);
    imagedestroy($img);
    return $temp;
}

function drawFinderPattern($img, $cs, $x, $y, $black, $white) {
    imagefilledrectangle($img, $x, $y, $x + 7 * $cs - 1, $y + 7 * $cs - 1, $black);
    imagefilledrectangle($img, $x + $cs, $y + $cs, $x + 6 * $cs - 1, $y + 6 * $cs - 1, $white);
    imagefilledrectangle($img, $x + 2 * $cs, $y + 2 * $cs, $x + 5 * $cs - 1, $y + 5 * $cs - 1, $black);
}

// Generate QR codes
$qr_file = generateQRCodeImage($verification_url, 150);
$qr_file_footer = generateQRCodeImage($verification_url, 35);

// ============================================================
// Decode signature base64 ke file sementara
// ============================================================
$sig_image_files = [];
foreach ($signatures as $idx => $sig) {
    if (!empty($sig['signature_data'])) {
        $sig_data = $sig['signature_data'];
        if (strpos($sig_data, 'data:image') === 0) {
            $parts = explode(',', $sig_data);
            $sig_data = base64_decode($parts[1]);
        } elseif (base64_decode($sig_data, true) !== false && strlen($sig_data) > 30) {
            $sig_data = base64_decode($sig_data);
        }
        $temp_sig = sys_get_temp_dir() . '/sig_' . $doc['id'] . '_' . $idx . '.png';
        file_put_contents($temp_sig, $sig_data);
        if (filesize($temp_sig) > 0) {
            $sig_image_files[$idx] = $temp_sig;
        }
    }
}

// Logo path
$logo_path = 'assets/img/logo.png';
$logo_exists = file_exists($logo_path);

// ============================================================
// FPDF & FPDI Load Handling
// ============================================================
require_once 'lib/fpdf/fpdf.php';

$fpdi_available = false;

// 1. Cek jika FPDI menggunakan Autoloader (Direktori lib/fpdi atau includes/fpdi)
if (file_exists(__DIR__ . '/lib/fpdi/autoload.php')) {
    require_once __DIR__ . '/lib/fpdi/autoload.php';
    if (class_exists('\setasign\Fpdi\Fpdi')) {
        class_alias('\setasign\Fpdi\Fpdi', 'FPDI');
        $fpdi_available = true;
    }
} elseif (file_exists(__DIR__ . '/lib/fpdi/src/autoload.php')) {
    require_once __DIR__ . '/lib/fpdi/src/autoload.php';
    if (class_exists('\setasign\Fpdi\Fpdi')) {
        class_alias('\setasign\Fpdi\Fpdi', 'FPDI');
        $fpdi_available = true;
    }
} 
// 2. Cek pemuatan manual FPDI v2 (Harus load FpdfTpl.php TERLEBIH DAHULU sebelum Fpdi.php)
elseif (file_exists(__DIR__ . '/lib/fpdi/FpdfTpl.php') && file_exists(__DIR__ . '/lib/fpdi/Fpdi.php')) {
    require_once __DIR__ . '/lib/fpdi/FpdfTpl.php';
    require_once __DIR__ . '/lib/fpdi/Fpdi.php';
    
    if (class_exists('\setasign\Fpdi\Fpdi')) {
        class_alias('\setasign\Fpdi\Fpdi', 'FPDI');
        $fpdi_available = true;
    } elseif (class_exists('FPDI')) {
        $fpdi_available = true;
    }
}
// 3. Cek pemuatan FPDI di folder includes/fpdi
elseif (file_exists(__DIR__ . '/lib/fpdi/FpdfTpl.php') && file_exists(__DIR__ . '/lib/fpdi/Fpdi.php')) {
    require_once __DIR__ . '/lib/fpdi/FpdfTpl.php';
    require_once __DIR__ . '/lib/fpdi/Fpdi.php';
    
    if (class_exists('\setasign\Fpdi\Fpdi')) {
        class_alias('\setasign\Fpdi\Fpdi', 'FPDI');
        $fpdi_available = true;
    } elseif (class_exists('FPDI')) {
        $fpdi_available = true;
    }
}

// ============================================================
// FPDF Class dengan Digital Footer
// ============================================================
if (!class_exists('DigitalCertPDF')) {
class DigitalCertPDF extends FPDF {
    public $doc_data;
    public $signatures_data;
    public $verification_url;
    public $doc_hash;
    public $qr_footer_file;
    public $logo_path;
    public $logo_exists;

    function Footer() {
        // Menggunakan $this->h sebagai pengganti GetPageHeight() agar kompatibel dengan seluruh versi FPDF
        $page_h = $this->h; 
        $footer_y = $page_h - 18;

        $this->SetY($footer_y);
        $this->SetFillColor(27, 38, 44); // BRAND_DARK #1b262c
        $this->Rect(0, $footer_y, 210, 18, 'F');

        $this->SetTextColor(200, 200, 210);
        $this->SetFont('Helvetica', '', 5.5);

        if ($this->qr_footer_file && file_exists($this->qr_footer_file)) {
            $this->Image($this->qr_footer_file, 4, $footer_y + 1.5, 13);
        }

        $this->SetXY(20, $footer_y + 1.5);
        $this->Cell(0, 3.5, 'Dokumen ini telah ditandatangani secara digital oleh ' . COMPANY_NAME, 0, 1);
        $this->SetX(20);
        $this->Cell(0, 3.5, 'Verifikasi: ' . $this->verification_url, 0, 1);
        $this->SetX(20);
        $hash_display = substr($this->doc_hash, 0, 24) . '...';
        $last_sig_date = '';
        if (!empty($this->signatures_data)) {
            $last = end($this->signatures_data);
            $last_sig_date = date('d-m-Y H:i', strtotime($last['signed_at']));
        }
        $this->Cell(0, 3.5, 'Hash: ' . $hash_display . '  |  Tanggal TTD: ' . $last_sig_date, 0, 1);

        $this->SetTextColor(0, 0, 0);
    }
}
}
if (!class_exists('DigitalMergePDF')) {
class DigitalMergePDF extends FPDI {
    public $verification_url;
    public $doc_hash;
    public $qr_footer_file;
    public $signatures_data;

    function Footer() {
        // Menggunakan $this->h sebagai pengganti GetPageHeight()
        $page_h = $this->h;
        $footer_y = $page_h - 16;

        $this->SetY($footer_y);
        $this->SetFillColor(27, 38, 44);
        $this->Rect(0, $footer_y, 210, 16, 'F');

        $this->SetTextColor(200, 200, 210);
        $this->SetFont('Helvetica', '', 5.5);

        if ($this->qr_footer_file && file_exists($this->qr_footer_file)) {
            $this->Image($this->qr_footer_file, 4, $footer_y + 1.2, 11);
        }

        $this->SetXY(18, $footer_y + 1.2);
        $this->Cell(0, 3.5, 'Ditandatangani secara digital | ' . COMPANY_NAME, 0, 1);
        $this->SetX(18);
        $this->Cell(0, 3.5, 'Verifikasi: ' . $this->verification_url, 0, 1);

        $this->SetTextColor(0, 0, 0);
    }
}
}


// ============================================================
// BUILD PDF — Mode Merge (Original + Certificate)
// ============================================================
if ($mode === 'merge' && $fpdi_available && file_exists($doc['file_path'])) {
    $ext = strtolower(pathinfo($doc['file_path'], PATHINFO_EXTENSION));

    if ($ext === 'pdf') {
        $pdf = new DigitalMergePDF();
        $pdf->verification_url = $verification_url;
        $pdf->doc_hash = $doc_hash;
        $pdf->qr_footer_file = $qr_file_footer;
        $pdf->signatures_data = $signatures;

        $page_count = $pdf->setSourceFile($doc['file_path']);
        for ($i = 1; $i <= $page_count; $i++) {
            $tpl_id = $pdf->importPage($i);
            $size = $pdf->getTemplateSize($tpl_id);
            $orientation = ($size['width'] > $size['height']) ? 'L' : 'P';
            $pdf->AddPage($orientation, [$size['width'], $size['height']]);
            $pdf->useTemplate($tpl_id);
        }

        buildCertificatePage($pdf, $doc, $signatures, $verification_url, $doc_hash, $qr_file, $sig_image_files, $logo_path, $logo_exists);

        $filename = 'Certified_' . preg_replace('/[^a-zA-Z0-9_-]/', '_', $doc['title']) . '.pdf';
        $pdf->Output('D', $filename);
        exit;
    }
}

// ============================================================
// BUILD PDF — Mode Certificate Only
// ============================================================
$pdf = new DigitalCertPDF();
$pdf->doc_data = $doc;
$pdf->signatures_data = $signatures;
$pdf->verification_url = $verification_url;
$pdf->doc_hash = $doc_hash;
$pdf->qr_footer_file = $qr_file_footer;
$pdf->logo_path = $logo_path;
$pdf->logo_exists = $logo_exists;

buildCertificatePage($pdf, $doc, $signatures, $verification_url, $doc_hash, $qr_file, $sig_image_files, $logo_path, $logo_exists);

$filename = 'Sertifikat_Digital_' . preg_replace('/[^a-zA-Z0-9_-]/', '_', $doc['title']) . '.pdf';
$pdf->Output('D', $filename);

// Cleanup temp files
@unlink($qr_file);
@unlink($qr_file_footer);
foreach ($sig_image_files as $f) @unlink($f);

exit;

// ============================================================
// FUNGSI BUILD CERTIFICATE PAGE
// ============================================================
function buildCertificatePage(&$pdf, $doc, $signatures, $verification_url, $doc_hash, $qr_file, $sig_image_files, $logo_path, $logo_exists) {
    $pdf->AddPage('P', 'A4');
    $pdf->SetAutoPageBreak(true, 22);

    // ---- HEADER ----
    // Background Header: BRAND_PRIMARY (#0f4c75 -> RGB 15, 76, 117)
    $pdf->SetFillColor(15, 76, 117);
    $pdf->Rect(0, 0, 210, 36, 'F');

    // Logo
    if ($logo_exists) {
        $pdf->Image($logo_path, 14, 6, 22);
        $pdf->SetXY(40, 7);
    } else {
        $pdf->SetXY(14, 7);
    }

    // Company name
    $pdf->SetFont('Helvetica', 'B', 16);
    $pdf->SetTextColor(255, 255, 255);
    $pdf->Cell(0, 8, COMPANY_NAME, 0, 1);

    // App name
    $pdf->SetX($logo_exists ? 40 : 14);
    $pdf->SetFont('Helvetica', '', 9);
    $pdf->SetTextColor(200, 230, 220);
    $pdf->Cell(0, 5, APP_NAME . ' — ' . APP_SUBTITLE, 0, 1);

    // Judul sertifikat
    $pdf->SetY(46);
    $pdf->SetFont('Helvetica', 'B', 18);
    $pdf->SetTextColor(15, 76, 117);
    $pdf->Cell(0, 10, 'SERTIFIKAT TANDA TANGAN DIGITAL', 0, 1, 'C');
    $pdf->SetFont('Helvetica', '', 10);
    $pdf->SetTextColor(100, 100, 100);
    $pdf->Cell(0, 6, 'Digital Signature Certificate', 0, 1, 'C');

    // Garis dekoratif
    $pdf->SetDrawColor(15, 76, 117);
    $pdf->SetLineWidth(0.8);
    $pdf->Line(30, 64, 180, 64);
    $pdf->SetLineWidth(0.3);
    $pdf->Line(30, 66, 180, 66);

    // ---- INFO DOKUMEN ----
    $pdf->SetY(72);
    $pdf->SetFont('Helvetica', 'B', 9);
    $pdf->SetTextColor(15, 76, 117);
    $pdf->Cell(0, 6, 'INFORMASI DOKUMEN', 0, 1);
    $pdf->SetDrawColor(200, 200, 200);
    $pdf->Line(10, $pdf->GetY(), 200, $pdf->GetY());

    $info_items = [
        ['Judul Dokumen', $doc['title']],
        ['Nomor Dokumen', $doc['document_number'] ?? '-'],
        ['Nomor Surat', $doc['mail_number'] ?? '-'],
        ['Kategori', ucfirst(str_replace('_', ' ', $doc['category'] ?? 'Umum'))],
        ['Pengirim', $doc['sender'] ?? $doc['uploader_name'] ?? '-'],
        ['Tanggal Surat', $doc['mail_date'] ? date('d F Y', strtotime($doc['mail_date'])) : '-'],
        ['Tanggal Upload', date('d F Y H:i', strtotime($doc['created_at']))],
        ['Status', strtoupper(str_replace('_', ' ', $doc['status'] ?? 'DRAFT'))],
    ];

    $pdf->SetFont('Helvetica', '', 8.5);
    foreach ($info_items as $item) {
        $pdf->SetX(14);
        $pdf->SetFont('Helvetica', 'B', 8.5);
        $pdf->SetTextColor(80, 80, 80);
        $pdf->Cell(40, 6, $item[0] . ':', 0, 0);
        $pdf->SetFont('Helvetica', '', 8.5);
        $pdf->SetTextColor(30, 30, 30);
        $pdf->Cell(0, 6, $item[1], 0, 1);
    }

    // ---- VERIFIKASI ----
    $pdf->Ln(3);
    $pdf->SetFont('Helvetica', 'B', 9);
    $pdf->SetTextColor(15, 76, 117);
    $pdf->Cell(0, 6, 'INFORMASI VERIFIKASI', 0, 1);
    $pdf->Line(10, $pdf->GetY(), 200, $pdf->GetY());

    $qr_x = 155;
    $qr_y = $pdf->GetY() + 2;
    if (file_exists($qr_file)) {
        $pdf->Image($qr_file, $qr_x, $qr_y, 35);
    }

    $verify_items = [
        ['Token Verifikasi', substr($doc['verification_token'], 0, 32) . '...'],
        ['URL Verifikasi', $verification_url],
        ['Document Hash', substr($doc_hash, 0, 40) . '...'],
        ['Jumlah Penandatangan', strval(count($signatures))],
    ];

    $pdf->SetFont('Helvetica', '', 8);
    foreach ($verify_items as $item) {
        $pdf->SetX(14);
        $pdf->SetFont('Helvetica', 'B', 8);
        $pdf->SetTextColor(80, 80, 80);
        $pdf->Cell(38, 5.5, $item[0] . ':', 0, 0);
        $pdf->SetFont('Helvetica', '', 7.5);
        $pdf->SetTextColor(30, 30, 30);
        $pdf->Cell(105, 5.5, $item[1], 0, 1);
    }

    $pdf->SetY(max($pdf->GetY(), $qr_y + 38));

    // ---- TABEL PENANDATANGANAN ----
    $pdf->Ln(3);
    $pdf->SetFont('Helvetica', 'B', 9);
    $pdf->SetTextColor(15, 76, 117);
    $pdf->Cell(0, 6, 'DAFTAR PENANDATANGAN', 0, 1);
    $pdf->Line(10, $pdf->GetY(), 200, $pdf->GetY());
    $pdf->Ln(2);

    $col_w = [8, 42, 38, 34, 38, 20];
    $headers = ['No', 'Nama', 'Jabatan', 'Divisi', 'Waktu TTD', 'TTD'];

    $pdf->SetFillColor(15, 76, 117);
    $pdf->SetTextColor(255, 255, 255);
    $pdf->SetFont('Helvetica', 'B', 7.5);
    foreach ($headers as $i => $h) {
        $pdf->Cell($col_w[$i], 7, $h, 1, 0, 'C', true);
    }
    $pdf->Ln();

    $pdf->SetTextColor(30, 30, 30);
    $pdf->SetFont('Helvetica', '', 7.5);
    $row_h = 14;

    if (empty($signatures)) {
        $pdf->SetFillColor(245, 245, 245);
        $pdf->Cell(array_sum($col_w), 10, 'Belum ada penandatangan', 1, 1, 'C', true);
    } else {
        foreach ($signatures as $idx => $sig) {
            $fill = ($idx % 2 === 0);
            if ($fill) $pdf->SetFillColor(248, 252, 250);
            else $pdf->SetFillColor(255, 255, 255);

            $y_start = $pdf->GetY();

            $pdf->Cell($col_w[0], $row_h, $idx + 1, 1, 0, 'C', $fill);
            $pdf->Cell($col_w[1], $row_h, $sig['name'] ?? $sig['signer_name'] ?? '-', 1, 0, 'L', $fill);
            $pdf->Cell($col_w[2], $row_h, $sig['position'] ?? $sig['signer_position'] ?? '-', 1, 0, 'L', $fill);
            $pdf->Cell($col_w[3], $row_h, $sig['division'] ?? '-', 1, 0, 'L', $fill);
            $pdf->Cell($col_w[4], $row_h, date('d-m-Y H:i', strtotime($sig['signed_at'])), 1, 0, 'C', $fill);

            $x_sig = $pdf->GetX();
            $pdf->Cell($col_w[5], $row_h, '', 1, 0, 'C', $fill);
            if (isset($sig_image_files[$idx]) && file_exists($sig_image_files[$idx])) {
                $pdf->Image($sig_image_files[$idx], $x_sig + 2, $y_start + 1, 16);
            }

            $pdf->Ln();
        }
    }

    // ---- CATATAN ----
    $pdf->Ln(6);
    $pdf->SetFont('Helvetica', 'B', 9);
    $pdf->SetTextColor(15, 76, 117);
    $pdf->Cell(0, 6, 'KETERANGAN', 0, 1);
    $pdf->Line(10, $pdf->GetY(), 200, $pdf->GetY());
    $pdf->Ln(2);

    $pdf->SetFont('Helvetica', '', 8);
    $pdf->SetTextColor(60, 60, 60);
    $pdf->MultiCell(0, 5,
        'Dokumen ini telah ditandatangani secara digital menggunakan sistem ' . APP_NAME . ' milik ' . COMPANY_NAME . '. ' .
        'Keaslian dokumen ini dapat diverifikasi melalui URL verifikasi atau memindai QR Code yang tertera. ' .
        'Tanda tangan digital ini sah dan memiliki kekuatan hukum sesuai peraturan yang berlaku.',
        0, 'J'
    );

    $pdf->Ln(2);
    $pdf->SetFont('Helvetica', 'I', 7);
    $pdf->SetTextColor(120, 120, 120);
    $pdf->Cell(0, 5, 'Sertifikat ini dihasilkan secara otomatis oleh sistem pada ' . date('d F Y H:i:s'), 0, 1, 'C');

    // ---- LEGALITY BADGE ----
    $pdf->Ln(3);
    $pdf->SetFillColor(15, 76, 117);
    $pdf->SetTextColor(255, 255, 255);
    $pdf->SetFont('Helvetica', 'B', 8);
    $badge_x = 55;
    $badge_w = 100;
    $pdf->SetX($badge_x);
    $pdf->Cell($badge_w, 8, 'DOKUMEN INI TELAH DIVERIFIKASI SECARA DIGITAL', 0, 1, 'C', true);
    $pdf->SetFont('Helvetica', '', 7);
    $pdf->SetX($badge_x);
    $pdf->Cell($badge_w, 5, 'Verified Digital Document', 0, 1, 'C', true);
}
?>