<?php
ini_set('display_errors', 1);
ini_set('display_startup_errors', 1);
error_reporting(E_ALL);
// ============================================================
// KONSTANTA BRANDING — Edit bagian ini untuk kustomisasi
// ============================================================
define('COMPANY_NAME', 'PT. Lampung Jasa Utama');
define('APP_NAME', 'LJU-Document System');
define('APP_SUBTITLE', 'Document Management System');
define('APP_VERSION', ' 4.1-Rev-2');
define('APP_LOGO_TEXT', 'LJU');
define('COMPANY_ADDRESS', 'Jl. Jend. Sudirman No.81, Tj. Raya, Kec. Kedamaian,Kota Bandar Lampung');
define('COMPANY_PHONE', '+62 812 9292 3311');
define('COMPANY_EMAIL', 'info@lju.co.id');
define('COMPANY_WEBSITE', 'https://lju.co.id');
define('APP_LOGO', '/assets/img/logo.png');

// Warna Branding
define('BRAND_PRIMARY', '#0f4c75');
define('BRAND_SECONDARY', '#0d9488');
define('BRAND_ACCENT', '#d97706');
define('BRAND_DARK', '#1b262c');
define('BRAND_LIGHT', '#f0f4f8');

// ============================================================
// KONFIGURASI DATABASE
// ============================================================
define('DB_HOST', 'localhost');
define('DB_NAME', 'ljucoid_dms');
define('DB_USER', 'ljucoid_dms');
define('DB_PASS', 'icikiwir2026');

// ============================================================
// KONFIGURASI SMTP EMAIL
// ============================================================
define('SMTP_HOST', 'mail.lju.co.id');
define('SMTP_USER', 'info@lju.co.id');
define('SMTP_PASS', 'Infolju@2026');
define('SMTP_PORT', 465); // atau 587
define('SMTP_FROM', 'info@lju.co.id');
define('SMTP_FROM_NAME', COMPANY_NAME);

// ============================================================
// KONFIGURASI APLIKASI
// ============================================================
define('APP_URL', 'https://dms.lju.co.id');
define('APP_URL_2', 'https://dms.lju.co.id/arsip');
define('APP_PATH', __DIR__);
define('UPLOAD_PATH', APP_PATH . '/uploads/documents');
define('SIGNATURE_PATH', APP_PATH . '/uploads/signatures');
define('AVATAR_PATH', APP_PATH . '/uploads/avatars');
define('PHOTO_PATH', APP_PATH . '/uploads/photos');
define('GENERATED_PATH', APP_PATH . '/uploads/generated');
define('MAX_FILE_SIZE', 20 * 1024 * 1024); // 20MB
define('ALLOWED_EXTENSIONS', ['pdf','jpg','jpeg','png','doc','docx','xls','xlsx']);

// Konfigurasi Standar Font & Margin (Dapat diubah via variabel ini)
$PDF_CONFIG = [
    'font_family' => 'Times New Roman', // Pilihan: 'Times New Roman', 'Verdana'
    'font_size'   => '12pt',
    'margin'      => [
        'top'    => '1cm',
        'bottom' => '2cm',
        'left'   => '2cm',
        'right'  => '2cm'
    ]
];
    

// ============================================================
// KONEKSI DATABASE (PDO)
// ============================================================
try {
    $pdo = new PDO(
        "mysql:host=" . DB_HOST . ";dbname=" . DB_NAME . ";charset=utf8mb4",
        DB_USER,
        DB_PASS,
        [
            PDO::ATTR_ERRMODE => PDO::ERRMODE_EXCEPTION,
            PDO::ATTR_DEFAULT_FETCH_MODE => PDO::FETCH_ASSOC,
            PDO::ATTR_EMULATE_PREPARES => false
        ]
    );
} catch (PDOException $e) {
    die("Koneksi database gagal: " . $e->getMessage());
}

// ============================================================
// HELPER FUNCTIONS
// ============================================================
// Konfigurasi Session Bersama (Single Sign-On Sederhana)
ini_set('session.cookie_domain', '.lju.co.id'); // Titik di depan LJU sangat penting!
session_name('LJU_APPS'); // Gunakan nama session yang persis sama di WBS dan DMS

// Jika kedua aplikasi berada dalam satu domain utama (misal: dms.lju.co.id dan wbs.lju.co.id)
session_set_cookie_params([
    'lifetime' => 86400,
    'path' => '/',
    'domain' => '.lju.co.id', // Sesuaikan dengan domain utama Anda
    'secure' => isset($_SERVER['HTTPS']),
    'httponly' => true,
    'samesite' => 'Lax'
]);

if (session_status() === PHP_SESSION_NONE) {
    session_start();
}

// 2. Proteksi Halaman: Jika belum login, redirect ke Portal SSO dengan parameter target
if (empty($_SESSION['user_id'])) {
    $current_url = (isset($_SERVER['HTTPS']) ? "https" : "http") . "://" . $_SERVER['HTTP_HOST'] . $_SERVER['REQUEST_URI'];
    
    // Redirect ke SSO Portal
    header('Location: https://lju.co.id/dashboard/?target_system=' . urlencode('https://dms.lju.co.id') . '&redirect_after_login=' . urlencode($_SERVER['REQUEST_URI']));
    exit;
}


function isLoggedIn() {
    return isset($_SESSION['user_id']);
}

function requireLogin() {
    if (!isLoggedIn()) {
        header('Location: https://lju.co.id/dashboard/?target_system=' . urlencode('https://dms.lju.co.id') . '&redirect_after_login=' . urlencode($_SERVER['REQUEST_URI']));
        exit;
    }
}

function requireAdmin() {
    requireLogin();
    if ($_SESSION['role'] !== 'admin') {
        header('Location: ' . APP_URL . '/dashboard.php');
        exit;
    }
}

function currentUser() {
    global $pdo;
    if (!isLoggedIn()) return null;
    $stmt = $pdo->prepare("SELECT * FROM users WHERE id = ?");
    $stmt->execute([$_SESSION['user_id']]);
    return $stmt->fetch();
}

/**
 * Mendapatkan URL Avatar user yang sedang login
 */
function getUserAvatar() {
    $user = currentUser();
    $avatarName = $user['avatar'] ?? 'default.png'; // Pastikan ada kolom 'avatar' di tabel users
    $filePath = AVATAR_PATH . '/' . $avatarName;

    if (file_exists($filePath)) {
        return APP_URL . '/uploads/avatars/' . $avatarName;
    }
    return null; // null jika kosong
}

/**
 * Mendapatkan URL Signature user yang sedang login
 */
function getUserSignature() {
    $user = currentUser();
    // Pastikan ada kolom 'signature' di tabel users yang menyimpan nama file
    if (!empty($user['signature'])) {
        $filePath = SIGNATURE_PATH . '/' . $user['signature'];
        if (file_exists($filePath)) {
            return APP_URL . '/uploads/signatures/' . $user['signature'];
        }
    }
    return null; // Return null jika tidak ada signature
}

function generateDocNumber() {
    $prefix = 'LJU';
    $year = date('Y');
    $month = date('m');
    $rand = strtoupper(substr(md5(uniqid(mt_rand(), true)), 0, 6));
    return "$prefix/$year/$month/$rand";
}

function generateToken() {
    return bin2hex(random_bytes(32));
}

function generateHash($data) {
    return hash('sha256', $data);
}

function logActivity($userId, $action, $description, $documentId = null) {
    global $pdo;
    $stmt = $pdo->prepare("INSERT INTO activity_logs (user_id, action, description, document_id) VALUES (?, ?, ?, ?)");
    $stmt->execute([$userId, $action, $description, $documentId]);
}

function formatDate($date) {
    if (!$date) return '-';
    $months = [
        1=>'Januari','Februari','Maret','April','Mei','Juni',
        'Juli','Agustus','September','Oktober','November','Desember'
    ];
    $d = date('j', strtotime($date));
    $m = $months[(int)date('n', strtotime($date))];
    $y = date('Y', strtotime($date));
    $h = date('H:i', strtotime($date));
    return "$d $m $y $h";
}

function formatDateShort($date) {
    if (!$date) return '-';
    return date('d/m/Y H:i', strtotime($date));
}

function statusBadge($status) {
    $colors = [
        'draft' => 'bg-gray-200 text-gray-700',
        'pending_signature' => 'bg-amber-100 text-amber-800',
        'signed' => 'bg-emerald-100 text-emerald-800',
        'dispositioned' => 'bg-blue-100 text-blue-800',
        'completed' => 'bg-teal-100 text-teal-800',
        'rejected' => 'bg-red-100 text-red-800',
        'pending' => 'bg-amber-100 text-amber-800',
        'accepted' => 'bg-emerald-100 text-emerald-800',
        'forwarded' => 'bg-blue-100 text-blue-800',
        'returned' => 'bg-orange-100 text-orange-800',
    ];
    $color = $colors[$status] ?? 'bg-gray-200 text-gray-700';
    $label = ucwords(str_replace('_', ' ', $status));
    return "<span class=\"px-2.5 py-0.5 rounded-full text-xs font-semibold $color\">$label</span>";
}

function priorityBadge($priority) {
    $colors = [
        'biasa' => 'bg-gray-100 text-gray-700',
        'segera' => 'bg-orange-100 text-orange-800',
        'sangat_segera' => 'bg-red-100 text-red-800',
    ];
    $color = $colors[$priority] ?? 'bg-gray-100 text-gray-700';
    $label = ucwords(str_replace('_', ' ', $priority));
    return "<span class=\"px-2 py-0.5 rounded text-xs font-semibold $color\">$label</span>";
}

function esc($str) {
    return htmlspecialchars($str ?? '', ENT_QUOTES, 'UTF-8');
}

function getNotifSurat() {
    global $pdo;
    if (!isLoggedIn()) return 0;
    $stmt = $pdo->prepare("select count(*) from documents d where d.recipient_id = ? and status = 'draft'");
    $stmt->execute([$_SESSION['user_id']]);
    return $stmt->fetchColumn();
}

function getNotifications() {
    global $pdo;
    if (!isLoggedIn()) return 0;
    $stmt = $pdo->prepare("SELECT COUNT(*) FROM dispositions WHERE to_user_id = ? AND status = 'pending'");
    $stmt->execute([$_SESSION['user_id']]);
    return $stmt->fetchColumn();
}

function getNotifNotaDinas() {
    global $pdo;
    if (!isLoggedIn()) return 0;
    $stmt = $pdo->prepare("SELECT COUNT(*) FROM nota_dinas WHERE to_user_id = ? AND status = 'sent'");
    $stmt->execute([$_SESSION['user_id']]);
    return $stmt->fetchColumn();
}

function getNotifTerimaST() {
    global $pdo;
    if (!isLoggedIn()) return 0;
    $stmt = $pdo->prepare("select count(*) from tbl_surat_tugas_personil tp, tbl_surat_tugas ts where tp.user_id = ? and tp.surat_tugas_id = ts.id and ts.status_surat='published'");
    $stmt->execute([$_SESSION['user_id']]);
    return $stmt->fetchColumn();
}

function getNotifttdST() {
    global $pdo;
    if (!isLoggedIn()) return 0;
    $stmt = $pdo->prepare("SELECT COUNT(*) FROM tbl_surat_tugas WHERE penandatangan_id = ? AND status_surat = 'draft'");
    $stmt->execute([$_SESSION['user_id']]);
    return $stmt->fetchColumn();
}

function getNotifttdSK() {
    global $pdo;
    if (!isLoggedIn()) return 0;
    $stmt = $pdo->prepare("SELECT COUNT(*) FROM surat_keluar WHERE penandatangan = ? AND status = 'draft'");
    $stmt->execute([$_SESSION['user_id']]);
    return $stmt->fetchColumn();
}

function ensureUploadDirs() {
    $dirs = [UPLOAD_PATH, SIGNATURE_PATH, GENERATED_PATH];
    foreach ($dirs as $dir) {
        if (!is_dir($dir)) mkdir($dir, 0755, true);
    }
}
ensureUploadDirs();
?>
