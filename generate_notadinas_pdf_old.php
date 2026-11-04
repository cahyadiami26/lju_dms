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
    // Berhasil ambil dari API
    file_put_contents($qrPath, $qrImageData);
} else {
    // 2. Fallback: Menggunakan GD Library jika API Offline/Gagal
    $img = imagecreatetruecolor(150, 150);
    $white = imagecolorallocate($img, 255, 255, 255);
    $black = imagecolorallocate($img, 0, 0, 0);
    $gray  = imagecolorallocate($img, 100, 100, 100);

    imagefill($img, 0, 0, $white);
    imagerectangle($img, 0, 0, 149, 149, $black);
    
    // Pattern placeholder fallback
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
    function Header()
    {
        $this->SetFont('Arial', 'B', 14);
        $this->Cell(0, 6, COMPANY_NAME, 0, 1, 'C');
        $this->SetFont('Arial', '', 9);
        $this->Cell(0, 4, COMPANY_ADDRESS, 0, 1, 'C');
        $this->SetDrawColor(0, 0, 0);
        $this->SetLineWidth(0.6);
        $this->Line(10, $this->GetY() + 3, 200, $this->GetY() + 3);
        $this->Ln(8);
    }

    function Footer()
    {
        $this->SetY(-15);
        $this->SetFont('Arial', 'I', 8);
        $this->SetTextColor(120, 120, 120);
        $this->Cell(0, 10, 'Dokumen Nota Dinas Digital - ' . APP_NAME, 0, 0, 'C');
    }
}

/* ============================================================
 * RENDER PDF DOKUMEN
 * ============================================================
 */
$pdf = new NotaDinasPDF();
$pdf->AddPage();
$pdf->SetMargins(10, 10, 10);

// Judul Nota Dinas
$pdf->SetFont('Arial', 'B', 12);
$pdf->Cell(0, 6, 'NOTA DINAS', 0, 1, 'C');
$pdf->SetFont('Arial', '', 10);
$pdf->Cell(0, 5, 'Nomor: ' . $nota['nomor_nota_dinas'], 0, 1, 'C');
$pdf->Ln(6);

// Table Meta
$pdf->SetFont('Arial', '', 10);
$pdf->Cell(30, 6, 'Kepada', 0, 0);
$pdf->Cell(5, 6, ':', 0, 0);
$pdf->Cell(0, 6, $nota['to_name'] . ' (' . $nota['to_pos'] . ')', 0, 1);

$pdf->Cell(30, 6, 'Dari', 0, 0);
$pdf->Cell(5, 6, ':', 0, 0);
$pdf->Cell(0, 6, $nota['from_name'] . ' (' . $nota['from_pos'] . ')', 0, 1);

$pdf->Cell(30, 6, 'Tanggal', 0, 0);
$pdf->Cell(5, 6, ':', 0, 0);
$pdf->Cell(0, 6, date('d/m/Y', strtotime($nota['tanggal'])), 0, 1);
$pdf->Ln(3);

$pdf->SetLineWidth(0.2);
$pdf->Line(10, $pdf->GetY(), 200, $pdf->GetY());
$pdf->Ln(6);

// Perihal / Isi (Strip tag HTML untuk FPDF dasar)
$pdf->SetFont('Arial', '', 10);
$pdf->MultiCell(0, 5, strip_tags($nota['perihal']));
$pdf->Ln(10);

// Penandatanganan & QR Code
$xSign = 130;
$ySign = $pdf->GetY();

$pdf->SetXY($xSign, $ySign);
$pdf->SetFont('Arial', '', 10);
$pdf->Cell(60, 5, 'Pengirim,', 0, 1, 'C');

// Render Tanda Tangan Gambar dari Base64
// Render Tanda Tangan Gambar dari Base64
if (!empty($nota['signature_data'])) {
    $sigData = $nota['signature_data'];
    
    // Fix whitespace corruption in Base64 strings caused by POST transfers
    $sigData = str_replace(' ', '+', $sigData);

    if (preg_match('/^data:image\/(\w+);base64,/', $sigData, $type)) {
        $sigData = substr($sigData, strpos($sigData, ',') + 1);
        $type = strtolower($type[1]); // png, jpeg, webp, etc.
    } else {
        $type = 'png';
    }

    $imgBinary = base64_decode($sigData);

    if ($imgBinary !== false) {
        $tempSigPath = $qrDir . '/temp_sig_' . $nota['id'] . '.png';
        
        // Convert stream to GD resource to ensure valid PNG format
        $gdImage = imagecreatefromstring($imgBinary);
        
        if ($gdImage !== false) {
            // Preserve PNG alpha channel transparency
            imagealphablending($gdImage, false);
            imagesavealpha($gdImage, true);

            // Save clean PNG file to disk
            imagepng($gdImage, $tempSigPath);
            imagedestroy($gdImage);

            // Output image to FPDF
            $pdf->Image($tempSigPath, $xSign + 10, $pdf->GetY() + 1, 40, 20);
            @unlink($tempSigPath);
            $pdf->Ln(22);
        } else {
            // Fallback if binary is not a valid image stream
            $pdf->Ln(20);
        }
    } else {
        $pdf->Ln(20);
    }
} else {
    $pdf->Ln(20);
}

$pdf->SetX($xSign);
$pdf->SetFont('Arial', 'B', 10);
$pdf->Cell(60, 5, $nota['from_name'], 0, 1, 'C');
$pdf->SetX($xSign);
$pdf->SetFont('Arial', '', 9);
$pdf->Cell(60, 4, $nota['from_pos'], 0, 1, 'C');

// Tempelkan QR Code di Sisi Kiri
if (file_exists($qrPath)) {
    $pdf->Image($qrPath, 15, $ySign, 25, 25);
    $pdf->SetXY(15, $ySign + 26);
    $pdf->SetFont('Arial', '', 7);
    $pdf->Cell(25, 3, 'Scan Verifikasi', 0, 0, 'C');
}

// Output PDF
$pdf->Output('I', 'Nota_Dinas_' . $nota['id'] . '.pdf');