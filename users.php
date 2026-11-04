<?php
require_once 'config.php';

// Memastikan user sudah login dan berkedudukan sebagai admin
requireAdmin();

// Hapus Single User
if (isset($_GET['delete'])) {
    $id = (int)$_GET['delete'];
    if ($id != $_SESSION['user_id']) {
        $stmt = $pdo->prepare("DELETE FROM users WHERE id = ?");
        $stmt->execute([$id]);
        $_SESSION['flash'] = ['type' => 'success', 'message' => 'User berhasil dihapus'];
    } else {
        $_SESSION['flash'] = ['type' => 'danger', 'message' => 'Tidak bisa menghapus akun sendiri'];
    }
    header('Location: users.php');
    exit;
}

// Hapus Multiple Users
if (isset($_POST['bulk_delete']) && isset($_POST['selected_users'])) {
    $selected_ids = $_POST['selected_users'];
    $deleted_count = 0;
    
    foreach ($selected_ids as $id) {
        $id = (int)$id;
        // Jangan hapus akun sendiri jika ikut terpilih
        if ($id != $_SESSION['user_id']) {
            $stmt = $pdo->prepare("DELETE FROM users WHERE id = ?");
            $stmt->execute([$id]);
            $deleted_count++;
        }
    }
    
    if ($deleted_count > 0) {
        $_SESSION['flash'] = ['type' => 'success', 'message' => "$deleted_count user berhasil dihapus"];
    } else {
        $_SESSION['flash'] = ['type' => 'danger', 'message' => 'Tidak ada user yang dihapus (atau Anda memilih akun sendiri)'];
    }
    header('Location: users.php');
    exit;
}

// Ambil daftar divisi unik untuk filter
$divisi_stmt = $pdo->query("SELECT DISTINCT division FROM users WHERE division IS NOT NULL AND division != ''");
$all_divisions = $divisi_stmt->fetchAll(PDO::FETCH_COLUMN);

// Search & Filter
$search = isset($_GET['search']) ? trim($_GET['search']) : '';
$role_filter = isset($_GET['role']) ? trim($_GET['role']) : '';
$div_filter = isset($_GET['division']) ? trim($_GET['division']) : '';

$query = "SELECT * FROM users WHERE 1=1";
$params = [];

if ($search !== '') {
    $query .= " AND (name LIKE ? OR username LIKE ? OR nik LIKE ?)";
    $s = "%$search%";
    $params = array_merge($params, [$s, $s, $s]);
}

if ($role_filter !== '') {
    $query .= " AND role = ?";
    $params[] = $role_filter;
}

if ($div_filter !== '') {
    $query .= " AND division = ?";
    $params[] = $div_filter;
}

$query .= " ORDER BY created_at DESC";

$stmt = $pdo->prepare($query);
$stmt->execute($params);
$users = $stmt->fetchAll();

$pageTitle = 'Manajemen User';
require_once 'includes/header.php';
require_once 'includes/sidebar.php';
?>

<div class="lg:ml-64 pt-14 min-h-screen">
<main class="p-4 md:p-6 lg:p-8">
    <!-- Header -->
    <div class="bg-gradient-to-r from-brand to-brand-dark rounded-2xl p-6 md:p-8 text-white mb-6 shadow-md relative overflow-hidden">
        <h2 class="text-xl md:text-2xl font-extrabold flex items-center gap-3">
            <i class="fas fa-users-cog"></i> Manajemen User
        </h2>
    </div>

    <!-- Flash Message Notification (Opsional jika template Anda mendukung) -->
    <?php if (isset($_SESSION['flash'])): ?>
        <div class="mb-4 p-4 rounded-lg text-xs font-semibold <?= $_SESSION['flash']['type'] === 'success' ? 'bg-green-100 text-green-700' : 'bg-red-100 text-red-700' ?>">
            <?= $_SESSION['flash']['message'] ?>
        </div>
        <?php unset($_SESSION['flash']); ?>
    <?php endif; ?>

    <!-- Table Card -->
    <div class="bg-white rounded-xl border border-gray-200 shadow-sm overflow-hidden">
        <!-- Header Filter & Action -->
        <div class="p-4 md:p-5 border-b border-gray-200 flex flex-col md:flex-row md:items-center justify-between gap-4">
            <h3 class="font-bold text-gray-800 text-base flex items-center gap-2">
                <i class="fas fa-list text-gray-400"></i>
                <span>Daftar Pengguna</span>
            </h3>
            
            <div class="flex flex-wrap items-center gap-3">
                <form method="GET" class="flex flex-wrap items-center gap-2">
                    <!-- Field Pencarian -->
                    <div class="relative flex-1 md:w-48">
                        <i class="fas fa-search absolute left-3 top-1/2 -translate-y-1/2 text-gray-400 text-xs"></i>
                        <input type="text" name="search" placeholder="Cari nama/NIK..." value="<?= esc($search) ?>" class="w-full pl-9 pr-3 py-2 text-xs border border-gray-300 rounded-lg focus:outline-none focus:border-brand">
                    </div>

                    <!-- Filter Divisi -->
                    <select name="division" onchange="this.form.submit()" class="text-xs border border-gray-300 rounded-lg px-3 py-2 focus:outline-none focus:border-brand bg-white">
                        <option value="">Semua Divisi</option>
                        <?php foreach ($all_divisions as $div): ?>
                            <option value="<?= esc($div) ?>" <?= $div_filter === $div ? 'selected' : '' ?>><?= esc($div) ?></option>
                        <?php endforeach; ?>
                    </select>

                    <!-- Filter Role -->
                    <select name="role" onchange="this.form.submit()" class="text-xs border border-gray-300 rounded-lg px-3 py-2 focus:outline-none focus:border-brand bg-white">
                        <option value="">Semua Role</option>
                        <option value="admin" <?= $role_filter === 'admin' ? 'selected' : '' ?>>Admin</option>
                        <option value="user" <?= $role_filter === 'user' ? 'selected' : '' ?>>Staff</option>
                    </select>

                    <!-- Tombol Tambah User -->
                    <a href="user_form.php" class="bg-brand hover:bg-brand-dark text-white px-4 py-2 rounded-lg text-xs font-semibold flex items-center gap-2 transition-colors whitespace-nowrap">
                        <i class="fas fa-plus"></i>
                        <span>Tambah User</span>
                    </a>
                </form>
            </div>
        </div>

        <!-- Form untuk Multiple Delete -->
        <form action="users.php" method="POST" id="bulkDeleteForm">
            <!-- Tombol Aksi Massal -->
            <div class="px-4 py-3 bg-gray-50 border-b border-gray-200 flex items-center justify-between">
                <div class="flex items-center gap-2">
                    <button type="submit" name="bulk_delete" id="btnBulkDelete" onclick="return confirm('Apakah Anda yakin ingin menghapus user yang dipilih?')" disabled class="bg-red-500 hover:bg-red-600 disabled:bg-gray-300 disabled:cursor-not-allowed text-white px-3 py-1.5 rounded-lg text-xs font-semibold flex items-center gap-1.5 transition-colors">
                        <i class="fas fa-trash-alt"></i> Hapus Terpilih
                    </button>
                    <span id="selectedCount" class="text-xs text-gray-500">0 user dipilih</span>
                </div>
            </div>

            <div class="overflow-x-auto">
                <table class="w-full text-left border-collapse">
                    <thead>
                        <tr class="bg-gray-50 border-b border-gray-200 text-[11px] font-bold text-gray-500 uppercase">
                            <th class="py-3 px-4 w-10 text-center">
                                <input type="checkbox" id="selectAll" class="rounded border-gray-300 text-brand focus:ring-brand">
                            </th>
                            <th class="py-3 px-4">#</th>
                            <th class="py-3 px-4">User</th>
                            <th class="py-3 px-4">NIK</th>
                            <th class="py-3 px-4">Username</th>
                            <th class="py-3 px-4">Jabatan</th>
                            <th class="py-3 px-4">E-Mail</th>
                            <th class="py-3 px-4">Role</th>
                            <th class="py-3 px-4 text-center">Aksi</th>
                        </tr>
                    </thead>
                    <tbody class="divide-y divide-gray-100 text-xs text-gray-700">
                        <?php 
                        $no = 1;
                        foreach ($users as $u): 
                        ?>
                        <tr class="hover:bg-gray-50/50">
                            <td class="py-3 px-4 text-center">
                                <?php if ($u['id'] != $_SESSION['user_id']): ?>
                                    <input type="checkbox" name="selected_users[]" value="<?= $u['id'] ?>" class="user-checkbox rounded border-gray-300 text-brand focus:ring-brand">
                                <?php else: ?>
                                    <span class="text-gray-300" title="Akun sendiri tidak dapat dipilih">-</span>
                                <?php endif; ?>
                            </td>
                            <td class="py-3 px-4"><?= $no++ ?></td>
                            <td class="py-3 px-4">
                                <div class="flex items-center gap-3">
                                    <?php if (!empty($u['avatar'])): ?>
                                        <img src="uploads/avatars/<?= esc($u['avatar']) ?>" class="w-8 h-8 rounded-lg object-cover">
                                    <?php else: ?>
                                        <div class="w-8 h-8 rounded-lg bg-brand text-white flex items-center justify-center font-bold">
                                            <?= strtoupper(substr($u['name'], 0, 1)) ?>
                                        </div>
                                    <?php endif; ?>
                                    <div>
                                        <p class="font-bold text-gray-800"><?= esc($u['name']) ?></p>
                                        <p class="text-[10px] text-gray-500"><?= esc($u['division'] ?? '-') ?></p>
                                    </div>
                                </div>
                            </td>
                            <td class="py-3 px-4 font-mono"><?= esc($u['nik'] ?? '-') ?></td>
                            <td class="py-3 px-4 font-mono"><?= esc($u['username']) ?></td>
                            <td class="py-3 px-4"><?= esc($u['position'] ?? '-') ?></td>
                            <td class="py-3 px-4 text-gray-600"><?= esc($u['email'] ?? '-') ?></td>
                            <td class="py-3 px-4">
                                <span class="px-2 py-1 rounded-full text-[10px] font-bold <?= $u['role'] === 'admin' ? 'bg-amber-50 text-amber-700' : 'bg-blue-50 text-blue-700' ?>">
                                    <?= ucfirst($u['role']) ?>
                                </span>
                            </td>
                            <td class="py-3 px-4 text-center space-x-2">
                                <a href="user_form.php?action=edit&id=<?= $u['id'] ?>" class="text-gray-500 hover:text-brand" title="Edit"><i class="fas fa-pen"></i></a>
                                <?php if ($u['id'] != $_SESSION['user_id']): ?>
                                    <a href="users.php?delete=<?= $u['id'] ?>" class="text-red-500 hover:text-red-700" onclick="return confirm('Yakin ingin menghapus user ini?')" title="Hapus"><i class="fas fa-trash"></i></a>
                                <?php endif; ?>
                            </td>
                        </tr>
                        <?php endforeach; ?>
                    </tbody>
                </table>
            </div>
        </form>
    </div>
</main>
</div>

<!-- JavaScript untuk Checkbox Select All & Counter -->
<script>
document.addEventListener('DOMContentLoaded', function() {
    const selectAllCheckbox = document.getElementById('selectAll');
    const userCheckboxes = document.querySelectorAll('.user-checkbox');
    const btnBulkDelete = document.getElementById('btnBulkDelete');
    const selectedCountSpan = document.getElementById('selectedCount');

    function updateBulkDeleteButton() {
        const checkedCount = document.querySelectorAll('.user-checkbox:checked').length;
        selectedCountSpan.textContent = `${checkedCount} user dipilih`;
        if (checkedCount > 0) {
            btnBulkDelete.removeAttribute('disabled');
        } else {
            btnBulkDelete.setAttribute('disabled', 'true');
        }
    }

    if (selectAllCheckbox) {
        selectAllCheckbox.addEventListener('change', function() {
            userCheckboxes.forEach(cb => {
                cb.checked = selectAllCheckbox.checked;
            });
            updateBulkDeleteButton();
        });
    }

    userCheckboxes.forEach(cb => {
        cb.addEventListener('change', function() {
            updateBulkDeleteButton();
            if (!this.checked && selectAllCheckbox) {
                selectAllCheckbox.checked = false;
            }
        });
    });
});
</script>

<?php require_once 'includes/footer.php'; ?>