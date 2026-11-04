<?php
require_once 'config.php';

if (isLoggedIn()) {
    // Default redirect jika pengguna sudah dalam posisi login
    header('Location: ' . APP_URL . '/dashboard.php');
    exit;
}

$error = '';

if ($_SERVER['REQUEST_METHOD'] === 'POST') {
    $username = trim($_POST['username'] ?? '');
    $password = $_POST['password'] ?? '';
    // Ambil pilihan sistem target, default ke APP_URL jika tidak diisi
    $target_system = $_POST['target_system'] ?? APP_URL;

    // Validasi agar target URL hanya URL yang sah (APP_URL atau APP_URL_2)
    $allowed_urls = [APP_URL, APP_URL_2];
    $target_url = in_array($target_system, $allowed_urls) ? $target_system : APP_URL;

    if ($username && $password) {
        $stmt = $pdo->prepare("SELECT * FROM users WHERE username = ? AND is_active = 1");
        $stmt->execute([$username]);
        $user = $stmt->fetch();

        if ($user && password_verify($password, $user['password'])) {
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
            
            // Redirect sesuai sistem yang dipilih
            header('Location: ' . $target_url . '/dashboard.php');
            exit;
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
    <style>
        body { font-family: 'Plus Jakarta Sans', sans-serif; }
        .login-bg {
            background: linear-gradient(135deg, #1b262c 0%, #0f4c75 50%, #0d9488 100%);
            min-height: 100vh;
        }
        .glass-card {
            background: rgba(255,255,255,0.95);
            backdrop-filter: blur(20px);
            border-radius: 1.5rem;
            box-shadow: 0 25px 50px rgba(0,0,0,0.25);
        }
        .input-field {
            border: 2px solid #e2e8f0;
            border-radius: 0.75rem;
            padding: 0.75rem 1rem 0.75rem 2.75rem;
            font-size: 0.875rem;
            transition: all 0.2s;
            width: 100%;
            outline: none;
        }
        .input-field:focus {
            border-color: #0d9488;
            box-shadow: 0 0 0 3px rgba(13,148,136,0.15);
        }
        .select-field {
            border: 2px solid #e2e8f0;
            border-radius: 0.75rem;
            padding: 0.75rem 1rem 0.75rem 2.75rem;
            font-size: 0.875rem;
            transition: all 0.2s;
            width: 100%;
            outline: none;
            background-color: #ffffff;
        }
        .select-field:focus {
            border-color: #0d9488;
            box-shadow: 0 0 0 3px rgba(13,148,136,0.15);
        }
    </style>
</head>
<body class="login-bg flex items-center justify-center p-4">
    <div class="glass-card w-full max-w-md p-8 md:p-10">
        <!-- Logo -->
        <div class="text-center mb-8">
            <img src="<?= APP_URL ?>/assets/img/logo.png" alt="Logo <?= esc(APP_NAME) ?>" class="h-16 w-auto object-contain mx-auto mb-4 drop-shadow-sm">
            <h1 class="text-2xl font-black text-gray-900"><?= esc(APP_NAME) ?></h1>
            <p class="text-gray-500 text-sm mt-1"><?= esc(APP_SUBTITLE) ?></p>
            <p class="text-gray-400 text-xs mt-0.5"><?= esc(COMPANY_NAME) ?></p>
        </div>

        <?php if ($error): ?>
        <div class="bg-red-50 border border-red-200 text-red-700 px-4 py-3 rounded-xl text-sm mb-6 flex items-center gap-2">
            <i class="fas fa-exclamation-circle"></i>
            <?= esc($error) ?>
        </div>
        <?php endif; ?>

        <form method="POST" action="">
            <div class="space-y-4">
                <div class="relative">
                    <i class="fas fa-user absolute left-3.5 top-1/2 -translate-y-1/2 text-gray-400 text-sm"></i>
                    <input type="text" name="username" placeholder="Username" required
                        class="input-field" value="<?= esc($_POST['username'] ?? '') ?>" autocomplete="username">
                </div>
                <div class="relative">
                    <i class="fas fa-lock absolute left-3.5 top-1/2 -translate-y-1/2 text-gray-400 text-sm"></i>
                    <input type="password" name="password" placeholder="Password" required
                        class="input-field" autocomplete="current-password">
                </div>
                <!-- Dropdown Pilih Tujuan Sistem -->
                <div class="relative">
                    <i class="fas fa-server absolute left-3.5 top-1/2 -translate-y-1/2 text-gray-400 text-sm"></i>
                    <select name="target_system" class="select-field text-gray-700 font-medium">
                        <option value="<?= APP_URL ?>" <?= (($_POST['target_system'] ?? '') === APP_URL) ? 'selected' : '' ?>>
                            Sistem Manajemen Dokumen / Disposisi
                        </option>
                        <option value="<?= APP_URL_2 ?>" <?= (($_POST['target_system'] ?? '') === APP_URL_2) ? 'selected' : '' ?>>
                            Sistem Manajemen Arsip
                        </option>
                    </select>
                </div>
            </div>

            <button type="submit"
                class="w-full mt-6 bg-gradient-to-r from-blue-600 to-teal-500 text-white py-3 rounded-xl font-bold text-sm hover:opacity-90 transition-all hover:shadow-lg active:scale-[0.98]">
                <i class="fas fa-sign-in-alt mr-2"></i>Masuk
            </button>
        </form>

        <div class="mt-8 pt-6 border-t border-gray-100 text-center">
            <p class="text-gray-400 text-xs">&copy; <?= date('Y') ?> <?= esc(COMPANY_NAME) ?></p>
            <p class="text-gray-300 text-[10px] mt-1"><?= esc(APP_NAME) ?> v<?= APP_VERSION ?></p>
        </div>
    </div>
</body>
</html>