<?php
require_once 'config.php';

// Memastikan user sudah login dan berkedudukan sebagai admin
requireAdmin();

$edit_mode = false;
$id = 0;

// Tangkap ID dari URL (GET) atau dari Form (POST)
if (isset($_REQUEST['id']) && is_numeric($_REQUEST['id'])) {
    $id = (int)$_REQUEST['id'];
    if ($id > 0) {
        $edit_mode = true;
    }
}

// Inisialisasi data form
$formData = [
    'id' => $id, 
    'nik' => '',
    'name' => '', 
    'email' => '', // <-- Tambahan field email
    'position' => '', 
    'division' => '',
    'username' => '', 
    'rfid' => '',
    'role' => 'user'
];
$pageTitle = 'Tambah User Baru';
$btn_label = 'Simpan Data';
$btn_icon = 'fa-plus';

// Jika dalam mode edit dan request BUKAN POST (baru buka halaman), ambil data dari DB
if ($edit_mode && $_SERVER['REQUEST_METHOD'] !== 'POST') {
    $stmt = $pdo->prepare("SELECT * FROM users WHERE id = ?");
    $stmt->execute([$id]);
    $fetched_user = $stmt->fetch();

    if (!$fetched_user) {
        $_SESSION['flash'] = ['type' => 'danger', 'message' => 'User tidak ditemukan'];
        header('Location: users.php');
        exit;
    }
    
    $formData = $fetched_user;
    $pageTitle = 'Edit User';
    $btn_label = 'Update Data';
    $btn_icon = 'fa-check';
}

// Proses form submission
if ($_SERVER['REQUEST_METHOD'] === 'POST') {
    if ($edit_mode) {
        $pageTitle = 'Edit User';
        $btn_label = 'Update Data';
        $btn_icon = 'fa-check';
    }

    $nik = trim($_POST['nik'] ?? '');
    $name = trim($_POST['name'] ?? '');
    $email = trim($_POST['email'] ?? '');
    $position = trim($_POST['position'] ?? '');
    $division = trim($_POST['division'] ?? '');
    $username = trim($_POST['username'] ?? '');
    // RFID dibuat opsional, jika kosong diubah menjadi NULL atau string kosong
    $rfid = trim($_POST['rfid'] ?? '');
    $password = trim($_POST['password'] ?? '');
    $confirm_password = trim($_POST['confirm_password'] ?? '');
    $role = $_POST['role'] ?? 'user';

    $errors = [];

    // Validasi Field (RFID dihapus dari syarat wajib/empty)
    if (empty($nik)) $errors[] = 'NIK wajib diisi';
    if (empty($name)) $errors[] = 'Nama wajib diisi';
    if (empty($email)) {
        $errors[] = 'Email wajib diisi';
    } elseif (!filter_var($email, FILTER_VALIDATE_EMAIL)) {
        $errors[] = 'Format email tidak valid';
    }
    if (empty($position)) $errors[] = 'Jabatan wajib diisi';
    if (empty($division)) $errors[] = 'Divisi wajib diisi';
    if (empty($username)) $errors[] = 'Username wajib diisi';
    if (strlen($username) < 3) $errors[] = 'Username minimal 3 karakter';

    // Cek duplikat NIK (Abaikan ID user yang sedang diedit)
    $check_nik = $pdo->prepare("SELECT id FROM users WHERE nik = ? AND id != ?");
    $check_nik->execute([$nik, $id]);
    if ($check_nik->fetchColumn()) {
        $errors[] = 'NIK sudah terdaftar oleh user lain';
    }

    // Cek duplikat username (Abaikan ID user yang sedang diedit)
    $check_uname = $pdo->prepare("SELECT id FROM users WHERE username = ? AND id != ?");
    $check_uname->execute([$username, $id]);
    if ($check_uname->fetchColumn()) {
        $errors[] = 'Username sudah digunakan oleh akun lain';
    }

    // Cek duplikat RFID hanya jika RFID diisi oleh user
    if (!empty($rfid)) {
        $check_rfid = $pdo->prepare("SELECT id FROM users WHERE rfid = ? AND id != ?");
        $check_rfid->execute([$rfid, $id]);
        if ($check_rfid->fetchColumn()) {
            $errors[] = 'Nomor RFID sudah terdaftar oleh user lain';
        }
    }

    // Validasi Password
    if (!$edit_mode) {
        if (empty($password)) $errors[] = 'Password wajib diisi';
        if (strlen($password) < 6) $errors[] = 'Password minimal 6 karakter';
    } else {
        if (!empty($password) && strlen($password) < 6) {
            $errors[] = 'Password baru minimal 6 karakter';
        }
    }
    
    if (!empty($password) && $password !== $confirm_password) {
        $errors[] = 'Konfirmasi password tidak cocok';
    }

    // Cek duplikat email
    $check_email = $pdo->prepare("SELECT id FROM users WHERE email = ? AND id != ?");
    $check_email->execute([$email, $id]);
    if ($check_email->fetchColumn()) {
        $errors[] = 'Email sudah terdaftar oleh user lain';
    }

    // Simpan data jika bebas error
    if (empty($errors)) {
        // Konversi string kosong pada rfid menjadi NULL agar tidak terjadi duplikasi error pada database SQL constraint unique (jika ada)
        $rfid_val = ($rfid === '') ? null : $rfid;

        if ($edit_mode) {
            if (!empty($password)) {
                $hashed = password_hash($password, PASSWORD_DEFAULT);
                $stmt = $pdo->prepare("UPDATE users SET nik=?, name=?, email=?, position=?, division=?, username=?, rfid=?, password=?, role=? WHERE id=?");
                $stmt->execute([$nik, $name, $email, $position, $division, $username, $rfid_val, $hashed, $role, $id]);
            } else {
                $$stmt = $pdo->prepare("UPDATE users SET nik=?, name=?, email=?, position=?, division=?, username=?, rfid=?, role=? WHERE id=?");
                $stmt->execute([$nik, $name, $email, $position, $division, $username, $rfid_val, $role, $id]);
            }
        } else {
            $hashed = password_hash($password, PASSWORD_DEFAULT);
            $stmt = $pdo->prepare("INSERT INTO users (nik, name, email, position, division, username, rfid, password, role) VALUES (?, ?, ?, ?, ?, ?, ?, ?, ?)");
            $stmt->execute([$nik, $name, $email, $position, $division, $username, $rfid_val, $hashed, $role]);
        }

        $_SESSION['flash'] = [
            'type' => 'success',
            'message' => $edit_mode ? 'User berhasil diperbarui' : 'User baru berhasil ditambahkan'
        ];
        header('Location: users.php');
        exit;
    }

    // Kembalikan isi form jika terjadi error validasi
    $formData = array_merge($formData, [
        'id' => $id,
        'nik' => $nik,
        'name' => $name, 
        'position' => $position, 
        'division' => $division,
        'username' => $username, 
        'rfid' => $rfid,
        'role' => $role
    ]);
}

require_once 'includes/header.php';
require_once 'includes/sidebar.php';
?>
<div class="lg:ml-64 pt-14 min-h-screen">
<main class="p-4 md:p-6 lg:p-8">
    <!-- Page Header -->
    <div class="bg-gradient-to-r from-brand to-brand-dark rounded-2xl p-6 text-white mb-6 shadow-md relative overflow-hidden">
        <div class="relative z-10 flex flex-col md:flex-row md:items-center justify-between gap-4">
            <div>
                <h2 class="text-xl md:text-2xl font-extrabold flex items-center gap-3">
                    <i class="fas fa-<?= $edit_mode ? 'user-pen' : 'user-plus' ?>"></i>
                    <span><?= esc($pageTitle) ?></span>
                </h2>
                <nav class="flex text-xs text-white/80 mt-2" aria-label="Breadcrumb">
                    <ol class="inline-flex items-center space-x-1 md:space-x-2">
                        <li>
                            <a href="users.php" class="hover:text-white flex items-center gap-1">
                                <i class="fas fa-users text-[10px]"></i> Manajemen User
                            </a>
                        </li>
                        <li><span class="text-white/50">/</span></li>
                        <li class="font-semibold text-white"><?= esc($pageTitle) ?></li>
                    </ol>
                </nav>
            </div>
            <div>
                <a href="users.php" class="inline-flex items-center gap-2 bg-white/10 hover:bg-white/20 text-white text-xs px-3.5 py-2 rounded-lg transition-colors border border-white/20">
                    <i class="fas fa-arrow-left"></i>
                    <span>Kembali</span>
                </a>
            </div>
        </div>
        <div class="absolute -right-10 -top-10 w-44 h-44 bg-white/10 rounded-full blur-2xl pointer-events-none"></div>
    </div>

    <!-- Errors Alert -->
    <?php if (!empty($errors)): ?>
    <div class="mb-6 p-4 rounded-xl bg-red-50 border border-red-200 text-red-700 text-sm">
        <div class="flex items-center gap-2 font-bold mb-1">
            <i class="fas fa-exclamation-triangle"></i>
            <span>Terjadi kesalahan:</span>
        </div>
        <ul class="list-disc list-inside space-y-0.5 text-xs">
            <?php foreach ($errors as $e): ?>
            <li><?= esc($e) ?></li>
            <?php endforeach; ?>
        </ul>
    </div>
    <?php endif; ?>

    <!-- Form Card -->
    <div class="bg-white rounded-xl border border-gray-200 shadow-sm p-6 max-w-3xl">
        
        <form method="POST" action="user_form.php<?= $edit_mode ? '?id=' . $id : '' ?>" class="space-y-6">
            <!-- Input Hidden ID User -->
            <?php if ($edit_mode): ?>
                <input type="hidden" name="id" value="<?= esc($formData['id']) ?>">
            <?php endif; ?>
            
            <!-- Section: Data Diri -->
            <div>
                <h3 class="text-xs font-extrabold uppercase tracking-wider text-brand border-b border-gray-100 pb-2 mb-4 flex items-center gap-2">
                    <i class="fas fa-id-card"></i>
                    <span>Data Diri</span>
                </h3>
                
                <div class="grid grid-cols-1 md:grid-cols-2 gap-4">
                    <!-- NIK -->
                    <div class="md:col-span-2">
                        <label class="block text-xs font-semibold text-gray-700 mb-1">NIK <span class="text-red-500">*</span></label>
                        <div class="relative">
                            <i class="fas fa-id-badge absolute left-3 top-1/2 -translate-y-1/2 text-gray-400 text-xs"></i>
                            <input type="text" name="nik" class="w-full pl-9 pr-3 py-2 text-xs border border-gray-300 rounded-lg focus:outline-none focus:border-brand" placeholder="Masukkan Nomor Induk Kependudukan (NIK)" value="<?= esc($formData['nik']) ?>" required>
                        </div>
                    </div>

                    <!-- Nama Lengkap -->
                    <div>
                        <label class="block text-xs font-semibold text-gray-700 mb-1">Nama Lengkap <span class="text-red-500">*</span></label>
                        <div class="relative">
                            <i class="fas fa-user absolute left-3 top-1/2 -translate-y-1/2 text-gray-400 text-xs"></i>
                            <input type="text" name="name" class="w-full pl-9 pr-3 py-2 text-xs border border-gray-300 rounded-lg focus:outline-none focus:border-brand" placeholder="Masukkan nama lengkap" value="<?= esc($formData['name']) ?>" required>
                        </div>
                    </div>

                    <!-- Email (Baru) -->
                    <div>
                        <label class="block text-xs font-semibold text-gray-700 mb-1">Email <span class="text-red-500">*</span></label>
                        <div class="relative">
                            <i class="fas fa-envelope absolute left-3 top-1/2 -translate-y-1/2 text-gray-400 text-xs"></i>
                            <input type="email" name="email" class="w-full pl-9 pr-3 py-2 text-xs border border-gray-300 rounded-lg focus:outline-none focus:border-brand" placeholder="contoh@domain.com" value="<?= esc($formData['email']) ?>" required>
                        </div>
                    </div>

                    <!-- Jabatan -->
                    <div>
                        <label class="block text-xs font-semibold text-gray-700 mb-1">Jabatan <span class="text-red-500">*</span></label>
                        <div class="relative">
                            <i class="fas fa-briefcase absolute left-3 top-1/2 -translate-y-1/2 text-gray-400 text-xs"></i>
                            <input type="text" name="position" class="w-full pl-9 pr-3 py-2 text-xs border border-gray-300 rounded-lg focus:outline-none focus:border-brand" placeholder="Contoh: Kepala Divisi" value="<?= esc($formData['position']) ?>" required>
                        </div>
                    </div>

                    <!-- Divisi -->
                    <div>
                        <label class="block text-xs font-semibold text-gray-700 mb-1">Divisi <span class="text-red-500">*</span></label>
                        <div class="relative">
                            <i class="fas fa-building absolute left-3 top-1/2 -translate-y-1/2 text-gray-400 text-xs"></i>
                            <input type="text" name="division" class="w-full pl-9 pr-3 py-2 text-xs border border-gray-300 rounded-lg focus:outline-none focus:border-brand" placeholder="Contoh: Keuangan" value="<?= esc($formData['division']) ?>" required>
                        </div>
                    </div>

                    <!-- Role -->
                    <div>
                        <label class="block text-xs font-semibold text-gray-700 mb-1">Role <span class="text-red-500">*</span></label>
                        <div class="relative">
                            <i class="fas fa-shield-halved absolute left-3 top-1/2 -translate-y-1/2 text-gray-400 text-xs z-10"></i>
                            <select name="role" class="w-full pl-9 pr-3 py-2 text-xs border border-gray-300 rounded-lg focus:outline-none focus:border-brand bg-white relative z-0" required>
                                <option value="user" <?= $formData['role'] === 'user' ? 'selected' : '' ?>>Staff</option>
                                <option value="admin" <?= $formData['role'] === 'admin' ? 'selected' : '' ?>>Admin</option>
                            </select>
                        </div>
                    </div>
                </div>
            </div>

            <!-- Section: Akun Login -->
            <div>
                <h3 class="text-xs font-extrabold uppercase tracking-wider text-brand border-b border-gray-100 pb-2 mb-4 flex items-center gap-2">
                    <i class="fas fa-key"></i>
                    <span>Akun Login</span>
                </h3>

                <div class="grid grid-cols-1 md:grid-cols-2 gap-4">
                    <!-- Username -->
                    <div>
                        <label class="block text-xs font-semibold text-gray-700 mb-1">Username <span class="text-red-500">*</span></label>
                        <div class="relative">
                            <i class="fas fa-at absolute left-3 top-1/2 -translate-y-1/2 text-gray-400 text-xs"></i>
                            <input type="text" name="username" class="w-full pl-9 pr-3 py-2 text-xs border border-gray-300 rounded-lg focus:outline-none focus:border-brand" placeholder="Username untuk login" value="<?= esc($formData['username']) ?>" required minlength="3">
                        </div>
                    </div>

                    <!-- RFID (Opsional) -->
                    <div>
                        <label class="block text-xs font-semibold text-gray-700 mb-1">RFID <span class="text-gray-400 font-normal">(Opsional)</span></label>
                        <div class="relative">
                            <i class="fas fa-wifi absolute left-3 top-1/2 -translate-y-1/2 text-gray-400 text-xs"></i>
                            <input type="text" name="rfid" class="w-full pl-9 pr-3 py-2 text-xs border border-gray-300 rounded-lg focus:outline-none focus:border-brand" placeholder="Tap atau masukkan nomor RFID" value="<?= esc($formData['rfid']) ?>">
                        </div>
                    </div>

                    <!-- Password -->
                    <div>
                        <label class="block text-xs font-semibold text-gray-700 mb-1">
                            Password <?= !$edit_mode ? '<span class="text-red-500">*</span>' : '<span class="text-gray-400 font-normal">(kosongkan jika tidak diubah)</span>' ?>
                        </label>
                        <div class="relative">
                            <i class="fas fa-lock absolute left-3 top-1/2 -translate-y-1/2 text-gray-400 text-xs"></i>
                            <input type="password" name="password" id="password" class="w-full pl-9 pr-9 py-2 text-xs border border-gray-300 rounded-lg focus:outline-none focus:border-brand" placeholder="<?= $edit_mode ? 'Kosongkan jika tidak diubah' : 'Minimal 6 karakter' ?>" <?= !$edit_mode ? 'required' : '' ?> minlength="6">
                            <button type="button" class="absolute right-3 top-1/2 -translate-y-1/2 text-gray-400 hover:text-gray-600 text-xs" onclick="togglePassword('password', this)">
                                <i class="fas fa-eye"></i>
                            </button>
                        </div>
                    </div>

                    <!-- Konfirmasi Password -->
                    <div>
                        <label class="block text-xs font-semibold text-gray-700 mb-1">
                            Konfirmasi Password <?= !$edit_mode ? '<span class="text-red-500">*</span>' : '' ?>
                        </label>
                        <div class="relative">
                            <i class="fas fa-lock absolute left-3 top-1/2 -translate-y-1/2 text-gray-400 text-xs"></i>
                            <input type="password" name="confirm_password" id="confirm_password" class="w-full pl-9 pr-9 py-2 text-xs border border-gray-300 rounded-lg focus:outline-none focus:border-brand" placeholder="Ulangi password" <?= !$edit_mode ? 'required' : '' ?>>
                            <button type="button" class="absolute right-3 top-1/2 -translate-y-1/2 text-gray-400 hover:text-gray-600 text-xs" onclick="togglePassword('confirm_password', this)">
                                <i class="fas fa-eye"></i>
                            </button>
                        </div>
                    </div>
                </div>
            </div>

            <!-- Buttons -->
            <div class="pt-4 border-t border-gray-100 flex items-center gap-3">
                <button type="submit" class="bg-brand hover:bg-brand-dark text-white px-5 py-2.5 rounded-lg text-xs font-bold flex items-center gap-2 transition-colors">
                    <i class="fas <?= $btn_icon ?>"></i>
                    <span><?= $btn_label ?></span>
                </button>
                <a href="users.php" class="bg-gray-100 hover:bg-gray-200 text-gray-700 px-5 py-2.5 rounded-lg text-xs font-semibold border border-gray-300 transition-colors">
                    Batal
                </a>
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
// Include Footer
require_once 'includes/footer.php'; 
?>