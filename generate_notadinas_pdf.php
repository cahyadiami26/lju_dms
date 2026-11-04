<?php
ini_set('display_errors', 1);
ini_set('display_startup_errors', 1);
error_reporting(E_ALL);

require_once __DIR__ . '/config.php';
require_once __DIR__ . '/lib/fpdf/fpdf.php';

requireLogin();

$id = isset($_GET['id']) ? (int)$_GET['id'] : 0;

// Ambil data Nota Dinas
$stmt = $pdo->prepare("
    SELECT nd.*, 
           u1.name as from_name, u1.position as from_pos, u1.division as from_div,
           u2.name as to_name, u2.position as to_pos, u2.division as to_div
    FROM nota_dinas nd
    JOIN users u1 ON nd.from_user_id = u1.id
    JOIN users u2 ON nd.to_user_id = u2.id
    WHERE nd.id = ? AND (nd.to_user_id = ? OR nd.from_user_id = ? OR ? = 'admin')
");
$stmt->execute([$id, $_SESSION['user_id'], $_SESSION['user_id'], $_SESSION['role']]);
$nota = $stmt->fetch();

if (!$nota) {
    exit('Nota dinas tidak ditemukan atau Anda tidak memiliki akses.');
}

/* ============================================================
 * Helper Functions
 * ============================================================
 */
function value($val) {
    return empty($val) ? '-' : $val;
}

function indoDate($date) {
    if (empty($date)) {
        return '-';
    }
    return formatDate($date);
}

/* ============================================================
 * GENERATE QR CODE (API Main + GD Fallback)
 * ============================================================
 */
$qrDir = APP_PATH . '/uploads/qrcodes';
if (!is_dir($qrDir)) {
    mkdir($qrDir, 0755, true);
}

$qrPath = $qrDir . '/qr_nd_' . $nota['id'] . '.png';
$qrUrl = APP_URL . '/notadinas_scan.php?token=' . urlencode($nota['verification_token']);

// 1. Coba ambil dari Online API (api.qrserver.com)
$apiUrl = 'https://api.qrserver.com/v1/create-qr-code/?size=200x200&data=' . urlencode($qrUrl);
$qrImageData = @file_get_contents($apiUrl);

if ($qrImageData !== false && strlen($qrImageData) > 0) {
    file_put_contents($qrPath, $qrImageData);
} else {
    // 2. Fallback: Menggunakan GD Library jika API Offline/Gagal
    $img = imagecreatetruecolor(150, 150);
    $white = imagecolorallocate($img, 255, 255, 255);
    $black = imagecolorallocate($img, 0, 0, 0);
    $gray  = imagecolorallocate($img, 100, 100, 100);

    imagefill($img, 0, 0, $white);
    imagerectangle($img, 0, 0, 149, 149, $black);
    
    imagerectangle($img, 10, 10, 40, 40, $black);
    imagerectangle($img, 110, 10, 140, 40, $black);
    imagerectangle($img, 10, 110, 40, 140, $black);
    
    imagestring($img, 2, 35, 65, "SCAN ME", $black);
    imagestring($img, 1, 20, 80, "ND #" . $nota['id'], $gray);

    imagepng($img, $qrPath);
    imagedestroy($img);
}

/* ============================================================
 * CLASS PDF (FPDF Wrapper)
 * ============================================================
 */
class NotaDinasPDF extends FPDF
{
    public $logo;

    function Header()
    {
        // Header Background Brand Primary (#0f4c75)
        $this->SetFillColor(15, 76, 117);
        $this->Rect(0, 0, 210, 22, 'F');

        if ($this->logo && file_exists($this->logo)) {
            $this->Image($this->logo, 10, 3, 16);
            $this->SetXY(30, 3);
        } else {
            $this->SetXY(10, 3);
        }

        $this->SetTextColor(255, 255, 255);
        $this->SetFont('Arial', 'B', 11);
        $this->Cell(0, 5, COMPANY_NAME, 0, 1);

        $this->SetFont('Arial', '', 8);
        $this->SetX($this->logo && file_exists($this->logo) ? 30 : 10);
        $this->Cell(0, 4, APP_NAME . ' - ' . APP_SUBTITLE, 0, 1);

        $this->SetFont('Arial', '', 7);
        $this->SetX($this->logo && file_exists($this->logo) ? 30 : 10);
        $this->Cell(0, 4, COMPANY_ADDRESS . ' | Telp: ' . COMPANY_PHONE . ' | Email: ' . COMPANY_EMAIL, 0, 1);

        // Teks "DOKUMEN NOTA DINAS" di bawah header biru
        $this->SetXY(0, 25);
        $this->SetTextColor(15, 76, 117);
        $this->SetFont('Arial', 'B', 12);
        $this->Cell(210, 6, 'DOKUMEN NOTA DINAS', 0, 1, 'C');

        $this->Ln(3);
    }

    function Footer()
    {
        $this->SetY(-15);
        $this->SetDrawColor(200, 200, 200);
        $this->Line(10, $this->GetY(), 200, $this->GetY());

        $this->SetFont('Arial', 'I', 7);
        $this->SetTextColor(100, 100, 100);
        $this->Ln(2);

        $this->Cell(95, 4, APP_NAME . ' - ' . COMPANY_NAME, 0, 0, 'L');
        $this->Cell(95, 4, 'Halaman ' . $this->PageNo() . '/{nb}', 0, 0, 'R');
    }
}

/* ============================================================
 * RENDER PDF DOKUMEN
 * ============================================================
 */
$pdf = new NotaDinasPDF();
$pdf->AliasNbPages();
$pdf->SetAutoPageBreak(true, 20);
$pdf->logo = __DIR__ . '/assets/img/logo.png'; // Menggunakan logo yang sama
$pdf->AddPage();
$pdf->SetMargins(10, 10, 10);

/* ============================================================
 * INFORMASI DOKUMEN (INFORMATION BOX)
 * ============================================================
 */
$pdf->SetFont('Arial', 'B', 10);
$pdf->SetTextColor(15, 76, 117);
$pdf->Cell(0, 6, 'INFORMASI DOKUMEN', 0, 1);

$pdf->SetDrawColor(15, 76, 117);
$pdf->Line(10, $pdf->GetY(), 200, $pdf->GetY());
$pdf->Ln(4);

$boxX = 10;
$boxY = $pdf->GetY();
$boxW = 190;
$boxH = 34;

$pdf->SetFillColor(248, 250, 252);
$pdf->SetDrawColor(210, 220, 230);
$pdf->Rect($boxX, $boxY, $boxW, $boxH, 'DF');

/* Data Dokumen */
$nomorNota = value($nota['nomor_nota_dinas'] ?? '');
$tanggalND  = indoDate($nota['tanggal'] ?? '');
$pengirim   = value($nota['from_name'] . ' (' . $nota['from_pos'] . ')');
$penerima   = value($nota['to_name'] . ' (' . $nota['to_pos'] . ')');

$y = $boxY + 4;

function infoRowND($pdf, $label, $val, &$y, $x = 15) {
    $pdf->SetXY($x, $y);
    $pdf->SetFont('Arial', 'B', 8);
    $pdf->SetTextColor(80, 80, 80);
    $pdf->Cell(34, 5, $label, 0, 0);

    $pdf->SetFont('Arial', '', 8);
    $pdf->SetTextColor(30, 30, 30);
    $pdf->MultiCell(135, 5, $val, 0, 'L');
    $y = $pdf->GetY();
}

infoRowND($pdf, 'Nomor Nota', $nomorNota, $y);
infoRowND($pdf, 'Tanggal', $tanggalND, $y);
infoRowND($pdf, 'Pengirim (Dari)', $pengirim, $y);
infoRowND($pdf, 'Penerima (Kepada)', $penerima, $y);

/* ============================================================
 * PERIHAL & ISI NOTA DINAS (PERIHAL BOX)
 * ============================================================
 */
$pdf->SetY($boxY + $boxH + 6);
$pdf->SetFont('Arial', 'B', 10);
$pdf->SetTextColor(15, 76, 117);
$pdf->Cell(0, 6, 'PERIHAL & ISI NOTA DINAS', 0, 1);

$pdf->SetDrawColor(15, 76, 117);
$pdf->Line(10, $pdf->GetY(), 200, $pdf->GetY());
$pdf->Ln(3);

$descY = $pdf->GetY();
$pdf->SetFillColor(252, 252, 252);
$pdf->SetDrawColor(225, 225, 225);

$perihalContent = trim(strip_tags($nota['perihal'] ?? ''));
if ($perihalContent == '') {
    $perihalContent = 'Tidak terdapat perihal/isi pada nota dinas.';
}

// Hitung estimasi tinggi box perihal secara dinamis
$nbLines = ceil($pdf->GetStringWidth($perihalContent) / 180);
$perihalBoxH = max(25, $nbLines * 5 + 6);

$pdf->Rect(10, $descY, 190, $perihalBoxH, 'DF');

$pdf->SetXY(13, $descY + 3);
$pdf->SetFont('Arial', '', 8);
$pdf->SetTextColor(40, 40, 40);
$pdf->MultiCell(184, 4.5, $perihalContent);

$pdf->SetY($descY + $perihalBoxH + 6);

/* ============================================================
 * OTENTIKASI DOKUMEN (BOX OTENTIKASI 2 KOLOM)
 * ============================================================
 */
if ($pdf->GetY() > 210) {
    $pdf->AddPage();
}

$pdf->SetFont('Arial', 'B', 10);
$pdf->SetTextColor(15, 76, 117);
$pdf->Cell(0, 6, 'OTENTIKASI DOKUMEN', 0, 1);

$pdf->SetDrawColor(15, 76, 117);
$pdf->Line(10, $pdf->GetY(), 200, $pdf->GetY());
$pdf->Ln(6);

$authBoxY = $pdf->GetY();
$authBoxH = 45;

// Kolom 1: QR Code Verifikasi (Kiri)
$pdf->SetDrawColor(180, 180, 180);
$pdf->Rect(10, $authBoxY, 92, $authBoxH);

$pdf->SetXY(12, $authBoxY + 3);
$pdf->SetFont('Arial', 'B', 8);
$pdf->SetTextColor(40, 40, 40);
$pdf->Cell(88, 4, 'VERIFIKASI DIGITAL', 0, 1, 'C');

if (file_exists($qrPath)) {
    $pdf->Image($qrPath, 43, $authBoxY + 8, 26, 26);
    $pdf->SetXY(12, $authBoxY + 35);
    $pdf->SetFont('Arial', '', 6);
    $pdf->SetTextColor(100, 100, 100);
    $pdf->Cell(88, 4, 'Scan QR Code untuk verifikasi keabsahan dokumen', 0, 0, 'C');
}

// Kolom 2: Penandatangan / Pengirim (Kanan)
$pdf->Rect(108, $authBoxY, 92, $authBoxH);

$pdf->SetXY(110, $authBoxY + 3);
$pdf->SetFont('Arial', 'B', 8);
$pdf->SetTextColor(40, 40, 40);
$pdf->Cell(88, 4, 'PENGIRIM NOTA DINAS', 0, 1, 'C');

// Render Tanda Tangan Gambar dari Base64 jika ada
if (!empty($nota['signature_data'])) {
    $sigData = str_replace(' ', '+', $nota['signature_data']);

    if (preg_match('/^data:image\/(\w+);base64,/', $sigData, $type)) {
        $sigData = substr($sigData, strpos($sigData, ',') + 1);
    }

    $imgBinary = base64_decode($sigData);

    if ($imgBinary !== false) {
        $tempSigPath = $qrDir . '/temp_sig_' . $nota['id'] . '.png';
        $gdImage = @imagecreatefromstring($imgBinary);
        
        if ($gdImage !== false) {
            imagealphablending($gdImage, false);
            imagesavealpha($gdImage, true);
            imagepng($gdImage, $tempSigPath);
            imagedestroy($gdImage);

            $pdf->Image($tempSigPath, 134, $authBoxY + 8, 40, 20);
            @unlink($tempSigPath);
        }
    }
}

$pdf->SetXY(110, $authBoxY + 30);
$pdf->SetFont('Arial', 'B', 8);
$pdf->SetTextColor(30, 30, 30);
$pdf->Cell(88, 4, value($nota['from_name']), 0, 1, 'C');

$pdf->SetXY(110, $authBoxY + 34);
$pdf->SetFont('Arial', '', 7);
$pdf->SetTextColor(90, 90, 90);
$pdf->Cell(88, 4, value($nota['from_pos']), 0, 1, 'C');

$pdf->SetY($authBoxY + $authBoxH + 6);

/* ============================================================
 * RINGKASAN DOKUMEN
 * ============================================================
 */
if ($pdf->GetY() > 230) {
    $pdf->AddPage();
}

$pdf->SetFont('Arial', 'B', 10);
$pdf->SetTextColor(15, 76, 117);
$pdf->Cell(0, 6, 'RINGKASAN DOKUMEN', 0, 1);

$pdf->SetDrawColor(15, 76, 117);
$pdf->Line(10, $pdf->GetY(), 200, $pdf->GetY());
$pdf->Ln(4);

$summaryY = $pdf->GetY();
$pdf->SetFillColor(250, 250, 250);
$pdf->SetDrawColor(220, 220, 220);
$pdf->Rect(10, $summaryY, 190, 16, 'DF');

$pdf->SetXY(14, $summaryY + 3);
$pdf->SetFont('Arial', '', 8);
$pdf->SetTextColor(60, 60, 60);

$printedAt = formatDate(date('Y-m-d H:i:s'));
$pdf->MultiCell(
    182,
    4,
    "Dokumen Nota Dinas Digital ini dicetak dari " . APP_NAME . " pada " . $printedAt . ".\n" .
    "Status Dokumen: TERVERIFIKASI & TERSIMPAN DI SISTEM"
);

// Output PDF
$pdf->Output('I', 'Nota_Dinas_' . $nota['id'] . '.pdf');