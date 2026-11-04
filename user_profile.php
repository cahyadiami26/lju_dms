<?php
ini_set('display_errors', 1);
ini_set('display_startup_errors', 1);
error_reporting(E_ALL);

require_once 'config.php';
requireLogin();
$pageTitle = 'User Profile';

$user_id = $_SESSION['user_id'];
$errors = [];
$success_msg = '';

// 1. Ambil data user di awal untuk mengecek role admin
try {
    $stmt = $pdo->prepare("SELECT * FROM users WHERE id = ?");
    $stmt->execute([$user_id]);
    $user = $stmt->fetch();
} catch (PDOException $e) {
    die("Gagal mengambil data user: " . $e->getMessage());
}

// Cek apakah user yang login adalah admin
$is_admin = ($user['role'] === 'admin');

// Proses jika ada request POST dari form
if ($_SERVER['REQUEST_METHOD'] == 'POST') {
    $name = trim($_POST['name'] ?? '');
    $email = trim($_POST['email'] ?? '');
    $username = trim($_POST['username'] ?? '');
    $password = trim($_POST['password'] ?? '');
    $confirm_password = trim($_POST['confirm_password'] ?? '');
    
    // Tangkap data tambahan jika admin
    if ($is_admin) {
        $nik = trim($_POST['nik'] ?? '');
        $position = trim($_POST['position'] ?? '');
        $division = trim($_POST['division'] ?? '');
    }
    
    // Validasi
    if (empty($name)) $errors[] = 'Nama lengkap wajib diisi';
    if (empty($email)) {
        $errors[] = 'Email wajib diisi';
    } elseif (!filter_var($email, FILTER_VALIDATE_EMAIL)) {
        $errors[] = 'Format email tidak valid';
    }
    if (empty($username)) $errors[] = 'Username wajib diisi';
    if (strlen($username) < 3) $errors[] = 'Username minimal 3 karakter';
    
    if (!empty($password) && strlen($password) < 6) {
        $errors[] = 'Password baru minimal 6 karakter';
    }
    if (!empty($password) && $password !== $confirm_password) {
        $errors[] = 'Konfirmasi password tidak cocok';
    }

    // Cek duplikat username (Abaikan ID user yang sedang login)
    $check_uname = $pdo->prepare("SELECT id FROM users WHERE username = ? AND id != ?");
    $check_uname->execute([$username, $user_id]);
    if ($check_uname->fetchColumn()) {
        $errors[] = 'Username sudah digunakan oleh akun lain';
    }

    // Cek duplikat NIK khusus untuk admin
    if ($is_admin && !empty($nik)) {
        $check_nik = $pdo->prepare("SELECT id FROM users WHERE nik = ? AND id != ?");
        $check_nik->execute([$nik, $user_id]);
        if ($check_nik->fetchColumn()) {
            $errors[] = 'NIK sudah terdaftar pada akun lain';
        }
    }

    // Cek duplikat email
    $check_email = $pdo->prepare("SELECT id FROM users WHERE email = ? AND id != ?");
    $check_email->execute([$email, $user_id]);
    if ($check_email->fetchColumn()) {
        $errors[] = 'Email sudah terdaftar pada akun lain';
    }

    if (empty($errors)) {
        // Query disesuaikan berdasarkan role
        if ($is_admin) {
            $query = "UPDATE users SET name = ?, username = ?, email = ?, nik = ?, position = ?, division = ? ";
            $params = [$name, $username, $email, $nik, $position, $division];
        } else {
            $query = "UPDATE users SET name = ?, username = ?, email = ? ";
            $params = [$name, $username, $email];
        }

        if (!empty($password)) {
            $query .= ", password = ? ";
            $params[] = password_hash($password, PASSWORD_DEFAULT);
        }

        // Fungsi pembantu untuk upload file menggunakan konstanta path
        function uploadFile($fileInputName, $targetDir) {
            if (isset($_FILES[$fileInputName]) && $_FILES[$fileInputName]['error'] === UPLOAD_ERR_OK) {
                $tmp_name = $_FILES[$fileInputName]['tmp_name'];
                $ext = pathinfo($_FILES[$fileInputName]['name'], PATHINFO_EXTENSION);
                
                $new_name = $fileInputName . '_' . uniqid() . '_' . time() . '.' . $ext; 
                
                $targetDir = rtrim($targetDir, '/') . '/';
                $destination = $targetDir . $new_name;
                
                if (move_uploaded_file($tmp_name, $destination)) {
                    return $new_name;
                }
            }
            return false;
        }

        // Upload files
        $avatar = uploadFile('avatar', AVATAR_PATH);
        if ($avatar) {
            $query .= ", avatar = ? ";
            $params[] = $avatar;
        }

        $photo = uploadFile('photo', PHOTO_PATH);
        if ($photo) {
            $query .= ", photo = ? ";
            $params[] = $photo;
        }

        $signature = uploadFile('signature', SIGNATURE_PATH);
        if ($signature) {
            $query .= ", signature = ? ";
            $params[] = $signature;
        }

        $query .= " WHERE id = ?";
        $params[] = $user_id;

        // Eksekusi query menggunakan PDO
        try {
            $stmt = $pdo->prepare($query);
            $stmt->execute($params); 
            $success_msg = 'Profil berhasil diperbarui.';
            
            // Re-fetch user data agar form langsung terupdate dengan data terbaru
            $stmt = $pdo->prepare("SELECT * FROM users WHERE id = ?");
            $stmt->execute([$user_id]);
            $user = $stmt->fetch();
            
        } catch (PDOException $e) {
            $errors[] = 'Gagal memperbarui profil: ' . $e->getMessage();
        }
    }
}

require_once 'includes/header.php';
require_once 'includes/sidebar.php';
?>

<div class="lg:ml-64 pt-14 min-h-screen bg-gray-50/50">
<main class="p-4 md:p-6 lg:p-8">
    <!-- Page Header -->
    <div class="bg-gradient-to-r from-brand to-brand-dark rounded-2xl p-6 text-white mb-6 shadow-md relative overflow-hidden">
        <div class="relative z-10 flex flex-col md:flex-row md:items-center justify-between gap-4">
            <div>
                <h2 class="text-xl md:text-2xl font-extrabold flex items-center gap-3">
                    <i class="fas fa-user-circle"></i>
                    <span>Profil Pengguna</span>
                </h2>
                <nav class="flex text-xs text-white/80 mt-2" aria-label="Breadcrumb">
                    <ol class="inline-flex items-center space-x-1 md:space-x-2">
                        <li>
                            <a href="dashboard.php" class="hover:text-white flex items-center gap-1">
                                <i class="fas fa-home text-[10px]"></i> Dashboard
                            </a>
                        </li>
                        <li><span class="text-white/50">/</span></li>
                        <li class="font-semibold text-white">Profil Saya</li>
                    </ol>
                </nav>
            </div>
            <div>
                <a href="dashboard.php" class="inline-flex items-center gap-2 bg-white/10 hover:bg-white/20 text-white text-xs px-3.5 py-2 rounded-lg transition-colors border border-white/20">
                    <i class="fas fa-arrow-left"></i>
                    <span>Kembali</span>
                </a>
            </div>
        </div>
        <div class="absolute -right-10 -top-10 w-44 h-44 bg-white/10 rounded-full blur-2xl pointer-events-none"></div>
    </div>

    <!-- Errors Alert -->
    <?php if (!empty($errors)): ?>
    <div class="mb-6 p-4 rounded-xl bg-red-50 border border-red-200 text-red-700 text-sm shadow-sm">
        <div class="flex items-center gap-2 font-bold mb-1">
            <i class="fas fa-exclamation-triangle"></i>
            <span>Terjadi kesalahan:</span>
        </div>
        <ul class="list-disc list-inside space-y-0.5 text-xs">
            <?php foreach ($errors as $e): ?>
            <li><?= htmlspecialchars($e) ?></li>
            <?php endforeach; ?>
        </ul>
    </div>
    <?php endif; ?>

    <!-- Success Alert -->
    <?php if ($success_msg): ?>
    <div class="mb-6 p-4 rounded-xl bg-green-50 border border-green-200 text-green-700 text-sm shadow-sm">
        <div class="flex items-center gap-2 font-bold">
            <i class="fas fa-check-circle"></i>
            <span><?= htmlspecialchars($success_msg) ?></span>
        </div>
    </div>
    <?php endif; ?>

    <!-- Form Card -->
    <div class="bg-white rounded-xl border border-gray-200 shadow-sm p-6 max-w-4xl">
        <form method="POST" action="" enctype="multipart/form-data" class="space-y-8">
            
            <!-- Section: Data Diri & Akun -->
            <div>
                <h3 class="text-xs font-extrabold uppercase tracking-wider text-brand border-b border-gray-100 pb-2 mb-4 flex items-center gap-2">
                    <i class="fas fa-id-card"></i>
                    <span>Informasi Dasar & Akun</span>
                </h3>
                
                <div class="grid grid-cols-1 md:grid-cols-2 gap-4">
                    <!-- Nama Lengkap -->
                    <div>
                        <label class="block text-xs font-semibold text-gray-700 mb-1">Nama Lengkap <span class="text-red-500">*</span></label>
                        <div class="relative">
                            <i class="fas fa-user absolute left-3 top-1/2 -translate-y-1/2 text-gray-400 text-xs"></i>
                            <input type="text" name="name" class="w-full pl-9 pr-3 py-2 text-xs border border-gray-300 rounded-lg focus:outline-none focus:border-brand" value="<?= htmlspecialchars($user['name'] ?? '') ?>" required>
                        </div>
                    </div>

                    <!-- Username -->
                    <div>
                        <label class="block text-xs font-semibold text-gray-700 mb-1">Username <span class="text-red-500">*</span></label>
                        <div class="relative">
                            <i class="fas fa-at absolute left-3 top-1/2 -translate-y-1/2 text-gray-400 text-xs"></i>
                            <input type="text" name="username" class="w-full pl-9 pr-3 py-2 text-xs border border-gray-300 rounded-lg focus:outline-none focus:border-brand" value="<?= htmlspecialchars($user['username'] ?? '') ?>" required minlength="3">
                        </div>
                    </div>

                    <!-- Email (Baru) -->
                    <div>
                        <label class="block text-xs font-semibold text-gray-700 mb-1">Email <span class="text-red-500">*</span></label>
                        <div class="relative">
                            <i class="fas fa-envelope absolute left-3 top-1/2 -translate-y-1/2 text-gray-400 text-xs"></i>
                            <input type="email" name="email" class="w-full pl-9 pr-3 py-2 text-xs border border-gray-300 rounded-lg focus:outline-none focus:border-brand" value="<?= htmlspecialchars($user['email'] ?? '') ?>" required>
                        </div>
                    </div>

                    <!-- NIK -->
                    <div>
                        <label class="block text-xs font-semibold <?= $is_admin ? 'text-gray-700' : 'text-gray-500' ?> mb-1">NIK <?= $is_admin ? '' : '(Hanya Baca)' ?></label>
                        <div class="relative">
                            <i class="fas fa-id-badge absolute left-3 top-1/2 -translate-y-1/2 text-gray-400 text-xs"></i>
                            <input type="text" <?= $is_admin ? 'name="nik"' : '' ?> class="w-full pl-9 pr-3 py-2 text-xs border <?= $is_admin ? 'border-gray-300 focus:border-brand focus:outline-none' : 'border-gray-200 bg-gray-50 text-gray-500 cursor-not-allowed' ?> rounded-lg" value="<?= htmlspecialchars($user['nik'] ?? '') ?>" <?= $is_admin ? '' : 'readonly' ?>>
                        </div>
                    </div>

                    <!-- Jabatan -->
                    <div>
                        <label class="block text-xs font-semibold <?= $is_admin ? 'text-gray-700' : 'text-gray-500' ?> mb-1">Jabatan <?= $is_admin ? '' : '(Hanya Baca)' ?></label>
                        <div class="relative">
                            <i class="fas fa-briefcase absolute left-3 top-1/2 -translate-y-1/2 text-gray-400 text-xs z-10"></i>
                            <?php if($is_admin): ?>
                                <select name="position" class="w-full pl-9 pr-3 py-2 text-xs border border-gray-300 rounded-lg focus:outline-none focus:border-brand bg-white relative z-0">
                                    <option value="">Pilih Jabatan...</option>
                                    <?php 
                                    $positions = ['Direktur Utama','Direktur Operasional','Kepala Bidang','Kepala Divisi','Manager','Sekretaris','Staff','System Administrator'];
                                    foreach($positions as $pos): ?>
                                        <option value="<?= $pos ?>" <?= ($user['position'] === $pos) ? 'selected' : '' ?>><?= $pos ?></option>
                                    <?php endforeach; ?>
                                </select>
                            <?php else: ?>
                                <input type="text" class="w-full pl-9 pr-3 py-2 text-xs border border-gray-200 rounded-lg bg-gray-50 text-gray-500 cursor-not-allowed" value="<?= htmlspecialchars($user['position'] ?? '') ?>" readonly>
                            <?php endif; ?>
                        </div>
                    </div>

                    <!-- Divisi -->
                    <div>
                        <label class="block text-xs font-semibold <?= $is_admin ? 'text-gray-700' : 'text-gray-500' ?> mb-1">Divisi <?= $is_admin ? '' : '(Hanya Baca)' ?></label>
                        <div class="relative">
                            <i class="fas fa-building absolute left-3 top-1/2 -translate-y-1/2 text-gray-400 text-xs z-10"></i>
                            <?php if($is_admin): ?>
                                <select name="division" class="w-full pl-9 pr-3 py-2 text-xs border border-gray-300 rounded-lg focus:outline-none focus:border-brand bg-white relative z-0">
                                    <option value="">Pilih Divisi...</option>
                                    <?php 
                                    $divisions = ['Bisnis','Keuangan','Sekretariat','Umum','Pengadaan','Keamanan','Infokom','SDM','Direksi','IT'];
                                    foreach($divisions as $div): ?>
                                        <option value="<?= $div ?>" <?= ($user['division'] === $div) ? 'selected' : '' ?>><?= $div ?></option>
                                    <?php endforeach; ?>
                                </select>
                            <?php else: ?>
                                <input type="text" class="w-full pl-9 pr-3 py-2 text-xs border border-gray-200 rounded-lg bg-gray-50 text-gray-500 cursor-not-allowed" value="<?= htmlspecialchars($user['division'] ?? '') ?>" readonly>
                            <?php endif; ?>
                        </div>
                    </div>
                </div>
            </div>

            <!-- Section: Keamanan -->
            <div>
                <h3 class="text-xs font-extrabold uppercase tracking-wider text-brand border-b border-gray-100 pb-2 mb-4 flex items-center gap-2">
                    <i class="fas fa-shield-alt"></i>
                    <span>Keamanan</span>
                </h3>

                <div class="grid grid-cols-1 md:grid-cols-2 gap-4">
                    <!-- Password Baru -->
                    <div>
                        <label class="block text-xs font-semibold text-gray-700 mb-1">
                            Password Baru <span class="text-gray-400 font-normal">(kosongkan jika tidak diubah)</span>
                        </label>
                        <div class="relative">
                            <i class="fas fa-lock absolute left-3 top-1/2 -translate-y-1/2 text-gray-400 text-xs"></i>
                            <input type="password" name="password" id="password" class="w-full pl-9 pr-9 py-2 text-xs border border-gray-300 rounded-lg focus:outline-none focus:border-brand" placeholder="Minimal 6 karakter" minlength="6">
                            <button type="button" class="absolute right-3 top-1/2 -translate-y-1/2 text-gray-400 hover:text-gray-600 text-xs" onclick="togglePassword('password', this)">
                                <i class="fas fa-eye"></i>
                            </button>
                        </div>
                    </div>

                    <!-- Konfirmasi Password -->
                    <div>
                        <label class="block text-xs font-semibold text-gray-700 mb-1">
                            Konfirmasi Password Baru
                        </label>
                        <div class="relative">
                            <i class="fas fa-lock absolute left-3 top-1/2 -translate-y-1/2 text-gray-400 text-xs"></i>
                            <input type="password" name="confirm_password" id="confirm_password" class="w-full pl-9 pr-9 py-2 text-xs border border-gray-300 rounded-lg focus:outline-none focus:border-brand" placeholder="Ulangi password baru">
                            <button type="button" class="absolute right-3 top-1/2 -translate-y-1/2 text-gray-400 hover:text-gray-600 text-xs" onclick="togglePassword('confirm_password', this)">
                                <i class="fas fa-eye"></i>
                            </button>
                        </div>
                    </div>
                </div>
            </div>

            <!-- Section: Media & File -->
            <div>
                <h3 class="text-xs font-extrabold uppercase tracking-wider text-brand border-b border-gray-100 pb-2 mb-4 flex items-center gap-2">
                    <i class="fas fa-images"></i>
                    <span>Media & Tanda Tangan</span>
                </h3>

                <div class="grid grid-cols-1 md:grid-cols-3 gap-6">
                    <!-- Avatar -->
                    <div class="p-4 border border-gray-200 rounded-xl bg-gray-50/50 flex flex-col items-center text-center">
                        <label class="block text-xs font-semibold text-gray-700 mb-3">Avatar Saat Ini</label>
                        <div class="h-20 w-20 rounded-full border-2 border-white shadow-sm overflow-hidden mb-3 bg-gray-200 flex items-center justify-center">
                            <?php if(!empty($user['avatar'])): ?>
                                <img src="uploads/avatars/<?= htmlspecialchars($user['avatar']) ?>" class="h-full w-full object-cover" alt="Avatar">
                            <?php else: ?>
                                <i class="fas fa-user text-2xl text-gray-400"></i>
                            <?php endif; ?>
                        </div>
                        <input type="file" name="avatar" accept="image/*" class="w-full text-[10px] text-gray-500 file:mr-2 file:py-1.5 file:px-3 file:rounded-md file:border-0 file:text-[10px] file:font-semibold file:bg-brand/10 file:text-brand hover:file:bg-brand/20 cursor-pointer">
                    </div>

                    <!-- Photo -->
                    <div class="p-4 border border-gray-200 rounded-xl bg-gray-50/50 flex flex-col items-center text-center">
                        <label class="block text-xs font-semibold text-gray-700 mb-3">Foto Saat Ini</label>
                        <div class="h-24 w-20 rounded-lg border-2 border-white shadow-sm overflow-hidden mb-3 bg-gray-200 flex items-center justify-center">
                            <?php if(!empty($user['photo'])): ?>
                                <img src="uploads/photos/<?= htmlspecialchars($user['photo']) ?>" class="h-full w-full object-cover" alt="Photo">
                            <?php else: ?>
                                <i class="fas fa-portrait text-3xl text-gray-400"></i>
                            <?php endif; ?>
                        </div>
                        <input type="file" name="photo" accept="image/*" class="w-full text-[10px] text-gray-500 file:mr-2 file:py-1.5 file:px-3 file:rounded-md file:border-0 file:text-[10px] file:font-semibold file:bg-brand/10 file:text-brand hover:file:bg-brand/20 cursor-pointer">
                    </div>

                    <!-- Signature -->
                    <div class="p-4 border border-gray-200 rounded-xl bg-gray-50/50 flex flex-col items-center text-center">
                        <label class="block text-xs font-semibold text-gray-700 mb-3">Tanda Tangan</label>
                        <div class="h-20 w-32 rounded-lg border-2 border-white shadow-sm overflow-hidden mb-3 bg-white flex items-center justify-center p-2">
                            <?php if(!empty($user['signature'])): ?>
                                <img src="uploads/signatures/<?= htmlspecialchars($user['signature']) ?>" class="h-full w-full object-contain" alt="Signature">
                            <?php else: ?>
                                <i class="fas fa-signature text-2xl text-gray-400"></i>
                            <?php endif; ?>
                        </div>
                        <input type="file" name="signature" accept="image/*" class="w-full text-[10px] text-gray-500 file:mr-2 file:py-1.5 file:px-3 file:rounded-md file:border-0 file:text-[10px] file:font-semibold file:bg-brand/10 file:text-brand hover:file:bg-brand/20 cursor-pointer">
                    </div>
                </div>
            </div>

            <!-- Buttons -->
            <div class="pt-6 border-t border-gray-100 flex items-center justify-end gap-3">
                <a href="dashboard.php" class="bg-gray-100 hover:bg-gray-200 text-gray-700 px-5 py-2.5 rounded-lg text-xs font-semibold border border-gray-300 transition-colors">
                    Batal
                </a>
                <button type="submit" class="bg-brand hover:bg-brand-dark text-white px-5 py-2.5 rounded-lg text-xs font-bold flex items-center gap-2 transition-colors">
                    <i class="fas fa-save"></i>
                    <span>Simpan Perubahan</span>
                </button>
            </div>
        </form>
    </div>
</main>
</div>

<script>
function togglePassword(fieldId, btn) {
    const field = document.getElementById(fieldId);
    const icon = btn.querySelector('i');
    if (field.type === 'password') {
        field.type = 'text';
        icon.classList.replace('fa-eye', 'fa-eye-slash');
    } else {
        field.type = 'password';
        icon.classList.replace('fa-eye-slash', 'fa-eye');
    }
}
</script>

<?php 
require_once 'includes/footer.php'; 
?>