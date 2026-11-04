<?php
/**
 * Logout Handler yang Diperbaiki
 */

// 1. Muat config.php terlebih dahulu agar session_set_cookie_params() 
//    dengan domain '.lju.co.id' diterapkan sebelum session dimulai.
require_once 'config.php';

// 2. Mulai session (mengikuti aturan dari config.php)
if (session_status() === PHP_SESSION_NONE) {
    session_start();
}

// 3. Hapus semua data session
$_SESSION = [];

// 4. Hapus session cookie dengan parameter domain yang sesuai (.lju.co.id)
if (ini_get("session.use_cookies")) {
    $params = session_get_cookie_params();
    setcookie(
        session_name(), 
        '', 
        time() - 42000,
        $params["path"], 
        $params["domain"],
        $params["secure"], 
        $params["httponly"]
    );
}

// 5. Hancurkan session
session_destroy();

// 6. Mulai session baru khusus untuk menampung flash message logout
session_start();
$_SESSION['flash'] = [
    'type' => 'success',
    'message' => 'Anda telah berhasil keluar dari sistem ' . (defined('APP_NAME') ? APP_NAME : '') . '.'
];
session_write_close();

// 7. Redirect ke halaman login
header('Location: index.php');
exit;
?>