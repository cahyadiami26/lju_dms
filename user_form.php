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
    'email' => '', 
    'position' => '', 
    'division' => '',
    'department' => '',
    'username' => '', 
    'rfid' => '',
    'role' => 'user',
    'is_active' => 1
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
    $department = trim($_POST['department'] ?? '');
    $username = trim($_POST['username'] ?? '');
    $rfid = trim($_POST['rfid'] ?? '');
    $password = trim($_POST['password'] ?? '');
    $confirm_password = trim($_POST['confirm_password'] ?? '');
    $role = $_POST['role'] ?? 'user';
    $is_active = isset($_POST['is_active']) ? 1 : 0;

    $errors = [];

    // Validasi Wajib Isi
    if (empty($name)) $errors[] = 'Nama wajib diisi';
    if (empty($username)) $errors[] = 'Username wajib diisi';
    if (strlen($username) < 3) $errors[] = 'Username minimal 3 karakter';
    
    if (!empty($email) && !filter_var($email, FILTER_VALIDATE_EMAIL)) {
        $errors[] = 'Format email tidak valid';
    }

    // Cek duplikat NIK (jika NIK diisi)
    if (!empty($nik)) {
        $check_nik = $pdo->prepare("SELECT id FROM users WHERE nik = ? AND id != ?");
        $check_nik->execute([$nik, $id]);
        if ($check_nik->fetchColumn()) {
            $errors[] = 'NIK sudah terdaftar oleh user lain';
        }
    }

    // Cek duplikat Username
    $check_uname = $pdo->prepare("SELECT id FROM users WHERE username = ? AND id != ?");
    $check_uname->execute([$username, $id]);
    if ($check_uname->fetchColumn()) {
        $errors[] = 'Username sudah digunakan oleh akun lain';
    }

    // Cek duplikat Email (jika Email diisi)
    if (!empty($email)) {
        $check_email = $pdo->prepare("SELECT id FROM users WHERE email = ? AND id != ?");
        $check_email->execute([$email, $id]);
        if ($check_email->fetchColumn()) {
            $errors[] = 'Email sudah terdaftar oleh user lain';
        }
    }

    // Cek duplikat RFID (jika RFID diisi)
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

    // Simpan data jika bebas error
    if (empty($errors)) {
        // Konversi string kosong menjadi NULL untuk field nullable
        $nik_val = ($nik === '') ? null : $nik;
        $email_val = ($email === '') ? null : $email;
        $position_val = ($position === '') ? null : $position;
        $division_val = ($division === '') ? null : $division;
        $department_val = ($department === '') ? null : $department;
        $rfid_val = ($rfid === '') ? null : $rfid;

        if ($edit_mode) {
            if (!empty($password)) {
                $hashed = password_hash($password, PASSWORD_DEFAULT);
                $stmt = $pdo->prepare("UPDATE users SET nik=?, name=?, email=?, position=?, division=?, department=?, username=?, rfid=?, password=?, role=?, is_active=? WHERE id=?");
                $stmt->execute([$nik_val, $name, $email_val, $position_val, $division_val, $department_val, $username, $rfid_val, $hashed, $role, $is_active, $id]);
            } else {
                $stmt = $pdo->prepare("UPDATE users SET nik=?, name=?, email=?, position=?, division=?, department=?, username=?, rfid=?, role=?, is_active=? WHERE id=?");
                $stmt->execute([$nik_val, $name, $email_val, $position_val, $division_val, $department_val, $username, $rfid_val, $role, $is_active, $id]);
            }
        } else {
            $hashed = password_hash($password, PASSWORD_DEFAULT);
            $stmt = $pdo->prepare("INSERT INTO users (nik, name, email, position, division, department, username, rfid, password, role, is_active) VALUES (?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?)");
            $stmt->execute([$nik_val, $name, $email_val, $position_val, $division_val, $department_val, $username, $rfid_val, $hashed, $role, $is_active]);
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
        'email' => $email,
        'position' => $position, 
        'division' => $division,
        'department' => $department,
        'username' => $username, 
        'rfid' => $rfid,
        'role' => $role,
        'is_active' => $is_active
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
            <?php if ($edit_mode): ?>
                <input type="hidden" name="id" value="<?= esc($formData['id']) ?>">
            <?php endif; ?>
            
            <!-- Section: Data Diri & Organisasi -->
            <div>
                <h3 class="text-xs font-extrabold uppercase tracking-wider text-brand border-b border-gray-100 pb-2 mb-4 flex items-center gap-2">
                    <i class="fas fa-id-card"></i>
                    <span>Data Diri & Pengaturan Struktur</span>
                </h3>
                
                <div class="grid grid-cols-1 md:grid-cols-2 gap-4">
                    <!-- NIK -->
                    <div>
                        <label class="block text-xs font-semibold text-gray-700 mb-1">NIK <span class="text-gray-400 font-normal">(Opsional)</span></label>
                        <div class="relative">
                            <i class="fas fa-id-badge absolute left-3 top-1/2 -translate-y-1/2 text-gray-400 text-xs"></i>
                            <input type="text" name="nik" maxlength="20" class="w-full pl-9 pr-3 py-2 text-xs border border-gray-300 rounded-lg focus:outline-none focus:border-brand" placeholder="Masukkan NIK" value="<?= esc($formData['nik']) ?>">
                        </div>
                    </div>

                    <!-- Nama Lengkap -->
                    <div>
                        <label class="block text-xs font-semibold text-gray-700 mb-1">Nama Lengkap <span class="text-red-500">*</span></label>
                        <div class="relative">
                            <i class="fas fa-user absolute left-3 top-1/2 -translate-y-1/2 text-gray-400 text-xs"></i>
                            <input type="text" name="name" maxlength="100" class="w-full pl-9 pr-3 py-2 text-xs border border-gray-300 rounded-lg focus:outline-none focus:border-brand" placeholder="Masukkan nama lengkap" value="<?= esc($formData['name']) ?>" required>
                        </div>
                    </div>

                    <!-- Email -->
                    <div>
                        <label class="block text-xs font-semibold text-gray-700 mb-1">Email <span class="text-gray-400 font-normal">(Opsional)</span></label>
                        <div class="relative">
                            <i class="fas fa-envelope absolute left-3 top-1/2 -translate-y-1/2 text-gray-400 text-xs"></i>
                            <input type="email" name="email" maxlength="100" class="w-full pl-9 pr-3 py-2 text-xs border border-gray-300 rounded-lg focus:outline-none focus:border-brand" placeholder="contoh@domain.com" value="<?= esc($formData['email']) ?>">
                        </div>
                    </div>

                    <!-- Jabatan (Position Enum) -->
                    <div>
                        <label class="block text-xs font-semibold text-gray-700 mb-1">Jabatan (Position)</label>
                        <div class="relative">
                            <i class="fas fa-briefcase absolute left-3 top-1/2 -translate-y-1/2 text-gray-400 text-xs z-10"></i>
                            <select name="position" class="w-full pl-9 pr-3 py-2 text-xs border border-gray-300 rounded-lg focus:outline-none focus:border-brand bg-white relative z-0">
                                <option value="">-- Pilih Jabatan --</option>
                                <?php 
                                $positions = ['Direktur Utama','Direktur Operasional','Kepala Bidang','Kepala Divisi','Manager','Sekretaris','Staff','System Administrator','Corporate Secretary','Sekretaris Direksi','Sekretaris Komisaris'];
                                foreach ($positions as $pos): 
                                ?>
                                    <option value="<?= $pos ?>" <?= $formData['position'] === $pos ? 'selected' : '' ?>><?= $pos ?></option>
                                <?php endforeach; ?>
                            </select>
                        </div>
                    </div>

                    <!-- Divisi (Division Enum) -->
                    <div>
                        <label class="block text-xs font-semibold text-gray-700 mb-1">Bidang (Department)</label>
                        <div class="relative">
                            <i class="fas fa-building absolute left-3 top-1/2 -translate-y-1/2 text-gray-400 text-xs z-10"></i>
                            <select name="division" class="w-full pl-9 pr-3 py-2 text-xs border border-gray-300 rounded-lg focus:outline-none focus:border-brand bg-white relative z-0">
                                <option value="">-- Pilih Bidang --</option>
                                <?php 
                                $divisions = ['Keuangan','Pengadaan','Keamanan','Infokom','SDM','Direksi','IT','Legal','Kesekretariatan','Jasa Konstruksi','Pengangkutan & Pergudangan','Perdagangan','Energi & Migas'];
                                foreach ($divisions as $div): 
                                ?>
                                    <option value="<?= $div ?>" <?= $formData['division'] === $div ? 'selected' : '' ?>><?= $div ?></option>
                                <?php endforeach; ?>
                            </select>
                        </div>
                    </div>

                    <!-- Departemen (Department Enum) -->
                    <div>
                        <label class="block text-xs font-semibold text-gray-700 mb-1">Divisi (Division)</label>
                        <div class="relative">
                            <i class="fas fa-sitemap absolute left-3 top-1/2 -translate-y-1/2 text-gray-400 text-xs z-10"></i>
                            <select name="department" class="w-full pl-9 pr-3 py-2 text-xs border border-gray-300 rounded-lg focus:outline-none focus:border-brand bg-white relative z-0">
                                <option value="">-- Pilih Divisi --</option>
                                <?php 
                                $departments = ['Direksi','Keuangan & Umum','Bisnis','Sekretariat','Pengawas Internal'];
                                foreach ($departments as $dept): 
                                ?>
                                    <option value="<?= $dept ?>" <?= $formData['department'] === $dept ? 'selected' : '' ?>><?= $dept ?></option>
                                <?php endforeach; ?>
                            </select>
                        </div>
                    </div>
                </div>
            </div>

            <!-- Section: Akun Login & Hak Akses -->
            <div>
                <h3 class="text-xs font-extrabold uppercase tracking-wider text-brand border-b border-gray-100 pb-2 mb-4 flex items-center gap-2">
                    <i class="fas fa-key"></i>
                    <span>Akun Login & Akses</span>
                </h3>

                <div class="grid grid-cols-1 md:grid-cols-2 gap-4">
                    <!-- Username -->
                    <div>
                        <label class="block text-xs font-semibold text-gray-700 mb-1">Username <span class="text-red-500">*</span></label>
                        <div class="relative">
                            <i class="fas fa-at absolute left-3 top-1/2 -translate-y-1/2 text-gray-400 text-xs"></i>
                            <input type="text" name="username" maxlength="50" class="w-full pl-9 pr-3 py-2 text-xs border border-gray-300 rounded-lg focus:outline-none focus:border-brand" placeholder="Username untuk login" value="<?= esc($formData['username']) ?>" required minlength="3">
                        </div>
                    </div>

                    <!-- RFID -->
                    <div>
                        <label class="block text-xs font-semibold text-gray-700 mb-1">RFID <span class="text-gray-400 font-normal">(Opsional)</span></label>
                        <div class="relative">
                            <i class="fas fa-wifi absolute left-3 top-1/2 -translate-y-1/2 text-gray-400 text-xs"></i>
                            <input type="text" name="rfid" maxlength="50" class="w-full pl-9 pr-3 py-2 text-xs border border-gray-300 rounded-lg focus:outline-none focus:border-brand" placeholder="Nomor Card/RFID" value="<?= esc($formData['rfid']) ?>">
                        </div>
                    </div>

                    <!-- Role -->
                    <div>
                        <label class="block text-xs font-semibold text-gray-700 mb-1">Role System <span class="text-red-500">*</span></label>
                        <div class="relative">
                            <i class="fas fa-user-shield absolute left-3 top-1/2 -translate-y-1/2 text-gray-400 text-xs z-10"></i>
                            <select name="role" class="w-full pl-9 pr-3 py-2 text-xs border border-gray-300 rounded-lg focus:outline-none focus:border-brand bg-white relative z-0" required>
                                <option value="user" <?= $formData['role'] === 'user' ? 'selected' : '' ?>>User</option>
                                <option value="admin" <?= $formData['role'] === 'admin' ? 'selected' : '' ?>>Admin</option>
                            </select>
                        </div>
                    </div>

                    <!-- Status Aktif (is_active) -->
                    <div class="flex items-center pt-5">
                        <label class="relative inline-flex items-center cursor-pointer">
                            <input type="checkbox" name="is_active" value="1" class="sr-only peer" <?= (int)$formData['is_active'] === 1 ? 'checked' : '' ?>>
                            <div class="w-9 h-5 bg-gray-200 peer-focus:outline-none rounded-full peer peer-checked:after:translate-x-full peer-checked:after:border-white after:content-[''] after:absolute after:top-[2px] after:left-[2px] after:bg-white after:border-gray-300 after:border after:rounded-full after:h-4 after:w-4 after:transition-all peer-checked:bg-brand"></div>
                            <span class="ml-3 text-xs font-semibold text-gray-700">Akun Aktif</span>
                        </label>
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

            <!-- Action Buttons -->
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
require_once 'includes/footer.php'; 
?>