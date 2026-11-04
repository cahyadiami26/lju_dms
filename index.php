<?php
require_once 'config.php';

// Pastikan konstanta URL Project Management sudah didefinisikan 
// (Bisa diletakkan di config.php DMS Anda)
if (!defined('APP_URL_PM')) {
    define('APP_URL_PM', 'https://pm.lju.co.id'); // Sesuaikan dengan domain PM Anda
}

// Tangkap parameter redirect jika user dilempar dari aplikasi PM
$redirect_after_login = trim($_GET['redirect'] ?? '');

if (isLoggedIn()) {
    // Jika ada request redirect (misal dari PM), langsung arahkan ke sana
    if (!empty($redirect_after_login) && filter_var(APP_URL_PM . $redirect_after_login, FILTER_VALIDATE_URL)) {
        header('Location: ' . APP_URL_PM . $redirect_after_login);
        exit;
    }
    // Default redirect jika pengguna sudah dalam posisi login
    header('Location: ' . APP_URL . '/dashboard.php');
    exit;
}

$error = '';
// Set default target system jika pertama kali dibuka
$target_system = $_POST['target_system'] ?? APP_URL;

// Jika user dilempar dari aplikasi PM, otomatis set dropdown/target ke PM
if (!empty($redirect_after_login)) {
    $target_system = APP_URL_PM;
}

if ($_SERVER['REQUEST_METHOD'] === 'POST') {
    $username = trim($_POST['username'] ?? '');
    $password = $_POST['password'] ?? '';
    
    // Tambahkan APP_URL_PM ke dalam daftar URL yang diizinkan
    $allowed_urls = [APP_URL, APP_URL_2 ?? '', APP_URL_PM];
    $target_url = in_array($target_system, $allowed_urls) ? $target_system : APP_URL;

    if ($username && $password) {
        $stmt = $pdo->prepare("SELECT * FROM users WHERE username = ? AND is_active = 1");
        $stmt->execute([$username]);
        $user = $stmt->fetch();

        if ($user && password_verify($password, $user['password'])) {
            // Setup Session
            $_SESSION['user_id'] = $user['id'];
            $_SESSION['username'] = $user['username'];
            $_SESSION['user_name'] = $user['name'];
            $_SESSION['role'] = $user['role'];
            $_SESSION['user_email'] = $user['email'];
            $_SESSION['department'] = $user['department'];
            $_SESSION['division'] = $user['division'];
            $_SESSION['position'] = $user['position'];
            $_SESSION['avatar'] = $user['avatar'];
            
            logActivity($user['id'], 'login', 'User logged in');
            
            // LOGIC REDIRECT YANG BARU
            // 1. Jika ada parameter redirect dari PM
            if (!empty($redirect_after_login) && $target_url === APP_URL_PM) {
                header('Location: ' . APP_URL_PM . $redirect_after_login);
                exit;
            }
            
            // 2. Jika targetnya adalah Project Management (PM)
            if ($target_url === APP_URL_PM) {
                header('Location: ' . APP_URL_PM . '/?page=dashboard');
                exit;
            } 
            // 3. Jika targetnya adalah DMS / Sistem lain
            else {
                header('Location: ' . $target_url . '/dashboard.php');
                exit;
            }
            
        } else {
            $error = 'Username atau password salah';
        }
    } else {
        $error = 'Mohon isi username dan password';
    }
}
?>
<!DOCTYPE html>
<html lang="id">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Login — <?= esc(APP_NAME) ?></title>
    <script src="https://cdn.tailwindcss.com"></script>
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.5.1/css/all.min.css">
    <link href="https://fonts.googleapis.com/css2?family=Plus+Jakarta+Sans:wght@300;400;500;600;700;800;900&display=swap" rel="stylesheet">
    <link rel="icon" type="image/x-icon" href="favicon.png">
    <style>
        body { 
            font-family: 'Plus Jakarta Sans', sans-serif; 
        }
        .page-bg {
            background-image: url('<?= APP_URL ?>/assets/img/bg.jpg');
            background-size: cover;
            background-position: center;
            background-repeat: no-repeat;
        }
        .main-wrapper {
            background: rgba(255, 255, 255, 0.85);
            backdrop-filter: blur(14px);
            -webkit-backdrop-filter: blur(14px);
            border: 1px solid rgba(255, 255, 255, 0.6);
        }
        .login-card {
            background: #ffffff;
            box-shadow: 0 15px 30px -5px rgba(0, 0, 0, 0.08), 0 10px 12px -6px rgba(0, 0, 0, 0.04);
        }
        .input-field {
            border: 1px solid #e2e8f0;
            border-radius: 0.75rem;
            padding: 0.85rem 1.15rem 0.85rem 3rem;
            font-size: 0.95rem;
            transition: all 0.2s;
            width: 100%;
            outline: none;
            background-color: #f8fafc;
        }
        .input-field:focus {
            border-color: #0d9488;
            background-color: #ffffff;
            box-shadow: 0 0 0 4px rgba(13, 148, 136, 0.15);
        }
    </style>
</head>
<body class="page-bg min-h-screen flex items-center justify-center p-4 md:p-10">

    <!-- Container Utama diperbesar -->
    <div class="main-wrapper w-full max-w-6xl rounded-3xl p-6 md:p-12 shadow-2xl">
        <div class="grid grid-cols-1 lg:grid-cols-12 gap-10 items-center">
            
            <!-- Kolom Kiri: Branding & Ilustrasi -->
            <div class="hidden lg:flex lg:col-span-6 flex-col justify-between items-center text-center p-4">
                <div class="mb-8">
                    <img src="<?= APP_URL ?>/assets/img/logo_lju.png" alt="Logo <?= esc(APP_NAME) ?>" class="h-20 w-auto object-contain mx-auto mb-3">
                </div>
                <div class="w-full max-w-lg">
                    <img src="<?= APP_URL ?>/assets/img/illustration.png" alt="Illustration" class="w-full h-auto object-contain mx-auto">
                </div>
            </div>

            <!-- Kolom Kanan: Card Form Login (Diperbesar) -->
            <div class="lg:col-span-6 w-full">
                <div class="login-card rounded-3xl p-8 sm:p-10 border border-gray-100">
                    
                    <!-- Header Card -->
                    <div class="text-center mb-8">
                        <!-- Logo Layar Mobile -->
                        <div class="lg:hidden mb-4">
                            <img src="<?= APP_URL ?>/assets/img/logo_lju.png" alt="Logo <?= esc(APP_NAME) ?>" class="h-14 w-auto object-contain mx-auto">
                        </div>
                        <h1 class="text-2xl sm:text-3xl font-extrabold text-gray-900 tracking-tight"><?= esc(APP_NAME) ?></h1>
                        <p class="text-gray-500 text-sm mt-1.5 font-medium"><?= esc(APP_SUBTITLE) ?></p>
                        <p class="text-gray-400 text-xs mt-1 font-semibold uppercase tracking-wider"><?= esc(COMPANY_NAME) ?></p>
                    </div>

                    <?php if ($error): ?>
                    <div class="bg-red-50 border border-red-200 text-red-600 px-4 py-3 rounded-xl text-sm mb-6 flex items-center gap-3">
                        <i class="fas fa-exclamation-circle text-base flex-shrink-0"></i>
                        <span><?= esc($error) ?></span>
                    </div>
                    <?php endif; ?>

                    <form method="POST" action="">
                        <div class="space-y-5">
                            <!-- Input Username -->
                            <div class="relative">
                                <i class="fas fa-user absolute left-4 top-1/2 -translate-y-1/2 text-gray-400 text-base"></i>
                                <input type="text" name="username" placeholder="Masukkan Username Anda" required
                                    class="input-field text-gray-800 placeholder-gray-400 font-medium" value="<?= esc($_POST['username'] ?? '') ?>" autocomplete="username">
                            </div>

                            <!-- Input Password -->
                            <div class="relative">
                                <i class="fas fa-lock absolute left-4 top-1/2 -translate-y-1/2 text-gray-400 text-base"></i>
                                <input type="password" name="password" placeholder="Masukkan Password Anda" required
                                    class="input-field text-gray-800 placeholder-gray-400 font-medium" autocomplete="current-password">
                            </div>

                            <!-- Opsi Pilihan Sistem (Menggunakan Radio Button Modern) -->
                            <div class="space-y-2.5 pt-2">
                                <label class="block text-xs font-bold text-gray-500 uppercase tracking-wider mb-2">Pilih Akses Layanan Sistem:</label>
                                
                                <div class="grid grid-cols-1 gap-3">
                                    <!-- Radio Option 1 -->
                                    <label class="relative flex items-center p-3.5 rounded-xl border border-gray-200 bg-slate-50 cursor-pointer hover:bg-slate-100 transition-all peer-checked:border-teal-600 has-[:checked]:border-teal-600 has-[:checked]:bg-teal-50/50 has-[:checked]:ring-2 has-[:checked]:ring-teal-500/20">
                                        <input type="radio" name="target_system" value="<?= APP_URL ?>" 
                                            class="w-4 h-4 text-teal-600 border-gray-300 focus:ring-teal-500"
                                            <?= ($target_system === APP_URL) ? 'checked' : '' ?>>
                                        <div class="ml-3.5 flex items-center gap-2.5 text-gray-800">
                                            <i class="fas fa-file-signature text-teal-600 text-sm"></i>
                                            <span class="text-sm font-semibold">Sistem Manajemen Dokumen / Disposisi</span>
                                        </div>
                                    </label>

                                    <!-- Radio Option 2 -->
                                    <label class="relative flex items-center p-3.5 rounded-xl border border-gray-200 bg-slate-50 cursor-pointer hover:bg-slate-100 transition-all peer-checked:border-teal-600 has-[:checked]:border-teal-600 has-[:checked]:bg-teal-50/50 has-[:checked]:ring-2 has-[:checked]:ring-teal-500/20">
                                        <input type="radio" name="target_system" value="<?= APP_URL_2 ?>" 
                                            class="w-4 h-4 text-teal-600 border-gray-300 focus:ring-teal-500"
                                            <?= ($target_system === APP_URL_2) ? 'checked' : '' ?>>
                                        <div class="ml-3.5 flex items-center gap-2.5 text-gray-800">
                                            <i class="fas fa-box-archive text-teal-600 text-sm"></i>
                                            <span class="text-sm font-semibold">Sistem Manajemen Arsip</span>
                                        </div>
                                    </label>
                                </div>
                            </div>
                        </div>

                        <!-- Tombol Submit -->
                        <button type="submit"
                            class="w-full mt-7 bg-gradient-to-r from-blue-600 to-teal-500 hover:from-blue-700 hover:to-teal-600 text-white py-3.5 rounded-xl font-bold text-base shadow-lg hover:shadow-xl transition-all active:scale-[0.99] flex items-center justify-center gap-2">
                            <i class="fas fa-right-to-bracket"></i>
                            <span>Masuk ke Sistem</span>
                        </button>
                    </form>

                    <!-- Footer Card -->
                    <div class="mt-8 pt-5 border-t border-gray-100 text-center">
                        <p class="text-gray-400 text-xs font-medium">&copy; <?= date('Y') ?> <?= esc(COMPANY_NAME) ?></p>
                        <p class="text-gray-300 text-[11px] mt-1 font-medium"><?= esc(APP_NAME) ?> v<?= APP_VERSION ?></p>
                    </div>

                </div>
            </div>

        </div>
    </div>

</body>
</html>