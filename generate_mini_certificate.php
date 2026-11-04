<?php
/**
 * Generate Mini Certificate PNG
 *
 * Bentuk certificate kecil yang dapat ditempel pada dokumen asli.
 *
 * Output:
 *   uploads/generated/mini_certificate_<document_id>_<hash>.png
 *
 * QR Code berisi URL verification.php?token=...
 *
 * Catatan:
 * - Membutuhkan PHP GD.
 * - QR Code dibuat menggunakan QR Server API jika library QR lokal belum tersedia.
 * - Jika QR Server tidak dapat diakses, proses dihentikan agar tidak menghasilkan
 *   QR palsu/tidak valid.
 */

require_once __DIR__ . '/config.php';
requireLogin();

if (!extension_loaded('gd')) {
    http_response_code(500);
    die('PHP GD extension belum aktif. Aktifkan extension=gd pada PHP.');
}

$document_id = (int)($_GET['id'] ?? 0);
$outputMode = strtolower(trim((string)($_GET['output'] ?? 'download')));
$isInlinePreview = ($outputMode === 'inline');

if ($document_id <= 0) {
    http_response_code(400);
    die('ID dokumen tidak valid.');
}

// ------------------------------------------------------------
// Helper lokal
// ------------------------------------------------------------
function miniFail($message, $status = 400)
{
    http_response_code($status);
    die($message);
}

function miniEscPath($path)
{
    return str_replace(['\\', "\0"], ['/', ''], $path);
}

/**
 * Membuat QR Code PNG yang benar.
 * Prioritas:
 * 1. Library phpqrcode lokal jika tersedia.
 * 2. QR Server API melalui cURL.
 *
 * Tidak menggunakan generator QR palsu/fallback pola acak.
 */
function generateMiniQr($url, $size = 300)
{
    $temp = sys_get_temp_dir() . '/mini_qr_' . hash('sha256', $url . '|' . $size) . '.png';

    // 1. Gunakan phpqrcode jika suatu saat library ditambahkan ke aplikasi.
    $localQrCandidates = [
        __DIR__ . '/includes/phpqrcode/qrlib.php',
        __DIR__ . '/lib/phpqrcode/qrlib.php',
    ];

    foreach ($localQrCandidates as $qrLib) {
        if (is_file($qrLib)) {
            require_once $qrLib;
            if (class_exists('QRcode')) {
                QRcode::png($url, $temp, QR_ECLEVEL_M, max(4, (int)floor($size / 37)), 2);
                if (is_file($temp) && filesize($temp) > 100) {
                    return $temp;
                }
            }
        }
    }

    // 2. QR Server API.
    if (!function_exists('curl_init')) {
        miniFail('cURL PHP belum aktif dan library QR lokal tidak tersedia.', 500);
    }

    $apiUrl = 'https://api.qrserver.com/v1/create-qr-code/?size=' .
        $size . 'x' . $size .
        '&margin=10&format=png&ecc=M&data=' . rawurlencode($url);

    $ch = curl_init($apiUrl);
    curl_setopt_array($ch, [
        CURLOPT_RETURNTRANSFER => true,
        CURLOPT_FOLLOWLOCATION => true,
        CURLOPT_CONNECTTIMEOUT => 5,
        CURLOPT_TIMEOUT => 15,
        CURLOPT_SSL_VERIFYPEER => true,
        CURLOPT_SSL_VERIFYHOST => 2,
        CURLOPT_USERAGENT => APP_NAME . '/MiniCertificate',
    ]);

    $data = curl_exec($ch);
    $httpCode = (int)curl_getinfo($ch, CURLINFO_HTTP_CODE);
    $curlError = curl_error($ch);
    curl_close($ch);

    if ($data === false || $httpCode < 200 || $httpCode >= 300 || strlen($data) < 100) {
        miniFail(
            'QR Code gagal dibuat. Pastikan server dapat mengakses api.qrserver.com.' .
            ($curlError ? ' Error: ' . $curlError : ''),
            502
        );
    }

    // Pastikan response benar-benar image PNG yang dapat dibaca GD.
    $image = @imagecreatefromstring($data);
    if ($image === false) {
        miniFail('Response QR Code bukan gambar PNG yang valid.', 502);
    }

    imagepng($image, $temp, 6);
    imagedestroy($image);

    if (!is_file($temp) || filesize($temp) < 100) {
        miniFail('File QR Code gagal disimpan.', 500);
    }

    return $temp;
}

function findMiniFont($bold = false)
{
    $candidates = $bold ? [
        __DIR__ . '/assets/fonts/DejaVuSans-Bold.ttf',
        '/usr/share/fonts/truetype/dejavu/DejaVuSans-Bold.ttf',
        '/usr/share/fonts/dejavu/DejaVuSans-Bold.ttf',
        '/usr/share/fonts/truetype/liberation2/LiberationSans-Bold.ttf',
    ] : [
        __DIR__ . '/assets/fonts/DejaVuSans.ttf',
        '/usr/share/fonts/truetype/dejavu/DejaVuSans.ttf',
        '/usr/share/fonts/dejavu/DejaVuSans.ttf',
        '/usr/share/fonts/truetype/liberation2/LiberationSans-Regular.ttf',
    ];

    foreach ($candidates as $font) {
        if (is_file($font)) {
            return $font;
        }
    }

    return null;
}

function miniText($img, $text, $x, $y, $size, $color, $bold = false)
{
    $font = findMiniFont($bold);
    if ($font && function_exists('imagettftext')) {
        // imagettftext menggunakan baseline, bukan top-left.
        $baseline = $y + $size;
        imagettftext($img, $size, 0, $x, $baseline, $color, $font, $text);
        return;
    }

    // Fallback jika TTF tidak tersedia.
    $fontId = $bold ? 5 : 4;
    imagestring($img, $fontId, $x, $y, $text, $color);
}

function miniTextWidth($text, $size, $bold = false)
{
    $font = findMiniFont($bold);
    if ($font && function_exists('imagettfbbox')) {
        $box = imagettfbbox($size, 0, $font, $text);
        return abs($box[2] - $box[0]);
    }

    return imagefontwidth($bold ? 5 : 4) * strlen($text);
}

function miniWrapText($text, $maxWidth, $size, $bold = false)
{
    $text = trim(preg_replace('/\s+/', ' ', (string)$text));
    if ($text === '') return ['-'];

    $words = preg_split('/\s+/', $text);
    $lines = [];
    $line = '';

    foreach ($words as $word) {
        $candidate = $line === '' ? $word : $line . ' ' . $word;
        if (miniTextWidth($candidate, $size, $bold) <= $maxWidth) {
            $line = $candidate;
            continue;
        }

        if ($line !== '') {
            $lines[] = $line;
            $line = $word;
        } else {
            // Satu kata lebih panjang dari area; potong secara karakter.
            $part = '';
            for ($i = 0; $i < strlen($word); $i++) {
                $candidatePart = $part . $word[$i];
                if (miniTextWidth($candidatePart, $size, $bold) > $maxWidth && $part !== '') {
                    $lines[] = $part;
                    $part = $word[$i];
                } else {
                    $part = $candidatePart;
                }
            }
            $line = $part;
        }
    }

    if ($line !== '') $lines[] = $line;
    return $lines ?: ['-'];
}

function miniRoundedRect($img, $x1, $y1, $x2, $y2, $radius, $color, $thickness = 3)
{
    imagesetthickness($img, $thickness);

    // Rounded rectangle menggunakan kombinasi garis + arc.
    imageline($img, $x1 + $radius, $y1, $x2 - $radius, $y1, $color);
    imageline($img, $x1 + $radius, $y2, $x2 - $radius, $y2, $color);
    imageline($img, $x1, $y1 + $radius, $x1, $y2 - $radius, $color);
    imageline($img, $x2, $y1 + $radius, $x2, $y2 - $radius, $color);

    imagearc($img, $x1 + $radius, $y1 + $radius, $radius * 2, $radius * 2, 180, 270, $color);
    imagearc($img, $x2 - $radius, $y1 + $radius, $radius * 2, $radius * 2, 270, 360, $color);
    imagearc($img, $x2 - $radius, $y2 - $radius, $radius * 2, $radius * 2, 0, 90, $color);
    imagearc($img, $x1 + $radius, $y2 - $radius, $radius * 2, $radius * 2, 90, 180, $color);

    imagesetthickness($img, 1);
}

function miniOutputFile($path, $filename, $inline = false)
{
    if (!is_file($path)) {
        miniFail('File mini certificate tidak ditemukan.', 404);
    }

    header('Content-Type: image/png');
    header(
        'Content-Disposition: ' .
        ($inline ? 'inline' : 'attachment') .
        '; filename="' . basename($filename) . '"'
    );
    header('Content-Length: ' . filesize($path));
    header('Cache-Control: private, no-store, max-age=0');
    header('Pragma: no-cache');
    readfile($path);
    exit;
}

// ------------------------------------------------------------
// Ambil dokumen
// ------------------------------------------------------------
$stmt = $pdo->prepare(
    "SELECT d.*, u.name AS uploader_name, u.position AS uploader_position
     FROM documents d
     LEFT JOIN users u ON d.user_id = u.id
     WHERE d.id = ?
     LIMIT 1"
);
$stmt->execute([$document_id]);
$doc = $stmt->fetch();

if (!$doc) {
    miniFail('Dokumen tidak ditemukan.', 404);
}

// ------------------------------------------------------------
// Authorization: admin, pemilik, penerima, atau signer dokumen.
// ------------------------------------------------------------
if (($_SESSION['role'] ?? '') !== 'admin') {
    $stmt = $pdo->prepare(
        "SELECT COUNT(*)
         FROM documents d
         LEFT JOIN signatures s ON s.document_id = d.id AND s.user_id = ?
         WHERE d.id = ?
           AND (d.user_id = ? OR d.recipient_id = ? OR s.user_id IS NOT NULL)"
    );
    $stmt->execute([
        $_SESSION['user_id'],
        $document_id,
        $_SESSION['user_id'],
        $_SESSION['user_id']
    ]);

    if ((int)$stmt->fetchColumn() === 0) {
        miniFail('Anda tidak memiliki akses ke mini certificate dokumen ini.', 403);
    }
}

// Mini certificate hanya sah untuk dokumen yang sudah selesai ditandatangani.
if (($doc['status'] ?? '') !== 'signed') {
    miniFail('Mini certificate hanya dapat dibuat untuk dokumen dengan status SIGNED.', 409);
}

// ------------------------------------------------------------
// Ambil semua signer yang benar-benar signed.
// ------------------------------------------------------------
$stmt = $pdo->prepare(
    "SELECT s.id, s.user_id, s.signer_name, s.signer_position,
            s.signature_type, s.signed_at, s.hash, s.status,
            u.name AS user_name, u.position AS user_position, u.division
     FROM signatures s
     LEFT JOIN users u ON u.id = s.user_id
     WHERE s.document_id = ?
       AND s.status = 'signed'
     ORDER BY s.signed_at ASC, s.id ASC"
);
$stmt->execute([$document_id]);
$signatures = $stmt->fetchAll();

if (!$signatures) {
    miniFail('Belum ada penandatangan yang berstatus SIGNED.', 409);
}

// ------------------------------------------------------------
// Pastikan verification token tersedia.
// ------------------------------------------------------------
if (empty($doc['verification_token'])) {
    $token = generateToken();
    $stmt = $pdo->prepare("UPDATE documents SET verification_token = ? WHERE id = ?");
    $stmt->execute([$token, $document_id]);
    $doc['verification_token'] = $token;
}

// Jika hash belum ada, buat hash file asli jika tersedia.
if (empty($doc['verification_hash'])) {
    $filePath = $doc['file_path'];
    if (is_file($filePath)) {
        $verificationHash = hash_file('sha256', $filePath);
    } else {
        $verificationHash = hash('sha256', $doc['id'] . '|' . $doc['title'] . '|' . $doc['created_at']);
    }

    $stmt = $pdo->prepare("UPDATE documents SET verification_hash = ? WHERE id = ?");
    $stmt->execute([$verificationHash, $document_id]);
    $doc['verification_hash'] = $verificationHash;
}

$verificationUrl = APP_URL . '/verification.php?token=' . rawurlencode($doc['verification_token']);

// ------------------------------------------------------------
// Tentukan nama file cache.
// Hash dimasukkan ke nama agar certificate lama tidak dipakai
// jika data verifikasi berubah.
// ------------------------------------------------------------
$certificateHash = substr(hash('sha256',
    $document_id . '|' .
    ($doc['verification_hash'] ?? '') . '|' .
    ($doc['verification_token'] ?? '') . '|' .
    implode('|', array_map(function ($sig) {
        return $sig['id'] . ':' . $sig['signed_at'] . ':' . ($sig['hash'] ?? '');
    }, $signatures))
), 0, 16);

$filename = 'mini_certificate_' . $document_id . '_' . $certificateHash . '.png';
$outputPath = GENERATED_PATH . '/' . $filename;

// Jika sudah pernah dibuat dan tidak diminta regenerasi, langsung download.
if (is_file($outputPath) && filesize($outputPath) > 100) {
    miniOutputFile($outputPath, $filename, $isInlinePreview);
}

// ------------------------------------------------------------
// Ukuran canvas
// Rasio kurang lebih 3:1 seperti contoh pengguna.
// ------------------------------------------------------------
$width = 1200;
$height = 400;

$img = imagecreatetruecolor($width, $height);
imagealphablending($img, true);
imagesavealpha($img, true);

// Warna
$white = imagecolorallocate($img, 255, 255, 255);
$blue = imagecolorallocate($img, 66, 112, 190);       // mendekati contoh
$dark = imagecolorallocate($img, 25, 25, 25);
$gray = imagecolorallocate($img, 90, 90, 90);
$lightGray = imagecolorallocate($img, 235, 235, 235);

imagefill($img, 0, 0, $white);

// ------------------------------------------------------------
// Border rounded dengan aksen seperti contoh:
// bukan kotak penuh yang kaku, tetapi sudut/garis melengkung.
// ------------------------------------------------------------
$borderX1 = 25;
$borderY1 = 25;
$borderX2 = $width - 25;
$borderY2 = $height - 25;
$radius = 58;
$thickness = 5;

// Border penuh terlebih dahulu.
miniRoundedRect($img, $borderX1, $borderY1, $borderX2, $borderY2, $radius, $blue, $thickness);

// Tutup bagian tengah garis atas/bawah sehingga tampilan lebih mirip
// bracket/sertifikat pada gambar contoh.
$whiteCover = imagecolorallocate($img, 255, 255, 255);
imagefilledrectangle($img, 110, $borderY1 - 5, 1090, $borderY1 + 5, $whiteCover);
imagefilledrectangle($img, 110, $borderY2 - 5, 1090, $borderY2 + 5, $whiteCover);

// ------------------------------------------------------------
// QR Code
// ------------------------------------------------------------
$qrSize = 285;
$qrFile = generateMiniQr($verificationUrl, $qrSize);
$qrImage = @imagecreatefrompng($qrFile);

if (!$qrImage) {
    @unlink($qrFile);
    imagedestroy($img);
    miniFail('QR Code tidak dapat dibaca sebagai PNG.', 500);
}

$qrX = 60;
$qrY = (int)(($height - $qrSize) / 2);

// Background putih untuk QR + sedikit padding.
imagefilledrectangle(
    $img,
    $qrX - 8,
    $qrY - 8,
    $qrX + $qrSize + 8,
    $qrY + $qrSize + 8,
    $white
);
imagecopyresampled($img, $qrImage, $qrX, $qrY, 0, 0, $qrSize, $qrSize, imagesx($qrImage), imagesy($qrImage));
imagedestroy($qrImage);
@unlink($qrFile);

// ------------------------------------------------------------
// Text area
// ------------------------------------------------------------
$textX = 390;
$textWidth = $width - $textX - 65;

// Header
$headerSize = 25;
miniText($img, 'DIGITALLY SIGNED', $textX, 60, $headerSize, $dark, true);

$subtitle = 'Dokumen ini ditandatangani secara digital oleh sistem : ' . APP_NAME;
$subtitleLines = miniWrapText($subtitle, $textWidth, 17, false);
$y = 105;
foreach ($subtitleLines as $line) {
    miniText($img, $line, $textX, $y, 17, $dark, false);
    $y += 27;
}

// Data utama
$labelSize = 17;
$valueSize = 17;
$lineGap = 38;
$labelX = $textX;
$valueX = $textX + 190;
$y += 18;

function miniLabeledValue($img, $label, $value, &$y, $labelX, $valueX, $maxValueWidth, $labelSize, $valueSize, $dark, $gray)
{
    miniText($img, $label, $labelX, $y, $labelSize, $gray, false);
    $lines = miniWrapText($value, $maxValueWidth, $valueSize, false);
    foreach ($lines as $idx => $line) {
        miniText($img, $line, $valueX, $y + ($idx * 24), $valueSize, $dark, false);
    }
    $y += max(1, count($lines)) * 24 + 7;
}

// Gabungkan semua signer. Jika banyak, setiap nama tetap terbaca.
$signerParts = [];
foreach ($signatures as $sig) {
    $name = trim($sig['signer_name'] ?: $sig['user_name'] ?: 'Tanpa Nama');
    $position = trim($sig['signer_position'] ?: $sig['user_position'] ?: '');
    $division = trim($sig['division'] ?? '');

    // Format: Nama (Jabatan - Divisi)
    if ($position !== '' && $division !== '') {
        $signerParts[] = $name . ' (' . $position . ' - ' . $division . ')';
    } elseif ($position !== '') {
        $signerParts[] = $name . ' (' . $position . ')';
    } elseif ($division !== '') {
        $signerParts[] = $name . ' (' . $division . ')';
    } else {
        $signerParts[] = $name;
    }
}
$signerText = implode(', ', $signerParts);

// Untuk tampilan mini, jika lebih dari 1 signer, gunakan semua nama.
miniLabeledValue(
    $img,
    'ID Dokumen :',
    (string)$doc['document_number'],
    $y, $labelX, $valueX, $textWidth - 190, $labelSize, $valueSize, $dark, $gray
);

miniLabeledValue(
    $img,
    'Nama Dokumen :',
    (string)$doc['title'],
    $y, $labelX, $valueX, $textWidth - 190, $labelSize, $valueSize, $dark, $gray
);

miniLabeledValue(
    $img,
    'Penandatangan :',
    $signerText,
    $y, $labelX, $valueX, $textWidth - 190, $labelSize, $valueSize, $dark, $gray
);

// Tanggal tanda tangan ditampilkan berdasarkan tanda tangan terakhir.
$lastSignedAt = null;
foreach ($signatures as $sig) {
    if (!empty($sig['signed_at'])) {
        $lastSignedAt = $sig['signed_at'];
    }
}

$signDate = $lastSignedAt ? formatDate($lastSignedAt) : '-';
miniLabeledValue(
    $img,
    'Tanggal Tanda Tangan :',
    $signDate,
    $y, $labelX, $valueX, $textWidth - 190, $labelSize, $valueSize, $dark, $gray
);

// ------------------------------------------------------------
// Simpan PNG
// ------------------------------------------------------------
if (!is_dir(GENERATED_PATH)) {
    if (!mkdir(GENERATED_PATH, 0755, true) && !is_dir(GENERATED_PATH)) {
        imagedestroy($img);
        miniFail('Folder uploads/generated tidak dapat dibuat.', 500);
    }
}

if (!is_writable(GENERATED_PATH)) {
    imagedestroy($img);
    miniFail('Folder uploads/generated tidak dapat ditulis oleh PHP.', 500);
}

if (!imagepng($img, $outputPath, 6)) {
    imagedestroy($img);
    miniFail('Mini certificate gagal disimpan.', 500);
}

imagedestroy($img);

// ------------------------------------------------------------
// Catat aktivitas download/generate certificate.
// Tidak menghentikan download jika logging gagal.
// ------------------------------------------------------------
try {
    logActivity(
        (int)$_SESSION['user_id'],
        'generate_mini_certificate',
        'Membuat/mengunduh mini certificate dokumen ' . ($doc['document_number'] ?: '#' . $document_id),
        $document_id
    );
} catch (Throwable $e) {
    // Logging bukan bagian kritis dari proses download.
}

miniOutputFile($outputPath, $filename, $isInlinePreview);
