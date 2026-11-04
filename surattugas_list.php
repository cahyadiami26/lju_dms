<?php
// surattugas_list.php
error_reporting(E_ALL);
ini_set('display_errors', 1);

require_once 'includes/mail_helper.php';
require_once 'config.php';
requireLogin();

$pageTitle = 'Daftar Surat Tugas';
$currentUserId = (int)$_SESSION['user_id'];

// Ambil data user yang sedang login untuk memeriksa divisi dan role
$stmtUser = $pdo->prepare("SELECT division, role FROM users WHERE id = ?");
$stmtUser->execute([$currentUserId]);
$currentUser = $stmtUser->fetch();

$userDivision = strtolower(trim($currentUser['division'] ?? ''));
$userRole     = strtolower(trim($currentUser['role'] ?? ''));
$isSecretariat = ($userDivision === 'kesekretariatan' || $userRole === 'op-arsip'); //[cite: 1]

// Handle Hapus Surat Tugas
if (isset($_GET['action']) && $_GET['action'] === 'delete' && isset($_GET['id'])) {
    $deleteId = (int)$_GET['id'];
    
    // Pastikan hanya pembuat (created_by) yang bisa menghapus
    $stmtCheck = $pdo->prepare("SELECT nomor_surat FROM tbl_surat_tugas WHERE id = ? AND created_by = ?");
    $stmtCheck->execute([$deleteId, $currentUserId]);
    $surat = $stmtCheck->fetch();

    if ($surat) {
        $stmtDelete = $pdo->prepare("DELETE FROM tbl_surat_tugas WHERE id = ?");
        $stmtDelete->execute([$deleteId]);
        
        if (function_exists('logActivity')) {
            logActivity($currentUserId, 'delete_surat_tugas', "Menghapus Surat Tugas #{$surat['nomor_surat']}", null);
        }
        header('Location: ' . APP_URL . '/surattugas_list.php?msg=deleted');
        exit;
    } else {
        $errorMsg = "Anda tidak memiliki akses untuk menghapus surat tugas ini.";
    }
}

// Ambil daftar surat tugas berdasarkan hak akses[cite: 1, 2]
if ($isSecretariat) {
    // Jika bagian kesekretariatan atau op-arsip, tampilkan SEMUA surat tugas[cite: 1]
    $stmt = $pdo->prepare("
        SELECT DISTINCT st.*, 
               u_sign.name AS penandatangan_nama,
               u_create.name AS creator_nama
        FROM tbl_surat_tugas st
        LEFT JOIN users u_sign ON st.penandatangan_id = u_sign.id
        LEFT JOIN users u_create ON st.created_by = u_create.id
        ORDER BY st.created_at DESC
    ");
    $stmt->execute();
} else {
    // Jika user biasa, tampilkan hanya yang terkait dengan dirinya sendiri[cite: 2]
    $stmt = $pdo->prepare("
        SELECT DISTINCT st.*, 
               u_sign.name AS penandatangan_nama,
               u_create.name AS creator_nama
        FROM tbl_surat_tugas st
        LEFT JOIN users u_sign ON st.penandatangan_id = u_sign.id
        LEFT JOIN users u_create ON st.created_by = u_create.id
        LEFT JOIN tbl_surat_tugas_personil stp ON st.id = stp.surat_tugas_id
        WHERE st.created_by = ? OR st.penandatangan_id = ? OR stp.user_id = ?
        ORDER BY st.created_at DESC
    ");
    $stmt->execute([$currentUserId, $currentUserId, $currentUserId]);
}
$suratList = $stmt->fetchAll();

require_once 'includes/header.php';
require_once 'includes/sidebar.php';
?>

<div class="lg:ml-64 pt-14 min-h-screen">
<main class="p-4 md:p-6 lg:p-8 max-w-7xl">

    <!-- Header Section -->
    <div class="flex flex-col md:flex-row md:items-center justify-between gap-4 mb-6">
        <div>
            <h2 class="text-xl font-black text-gray-900 mb-1">Daftar Surat Tugas</h2>
            <p class="text-gray-500 text-sm">Surat tugas yang Anda buat, tandatangani, atau di mana Anda ditugaskan</p>
        </div>
        <a href="surattugas_create.php" class="btn-primary inline-flex items-center gap-2 self-start md:self-auto px-4 py-2.5 text-sm font-semibold rounded-xl shadow-sm">
            <i class="fas fa-plus"></i> Buat Surat Tugas
        </a>
    </div>

    <!-- Alert Messages -->
    <?php if (isset($_GET['msg'])): ?>
        <?php if ($_GET['msg'] === 'deleted'): ?>
            <div class="bg-green-50 border border-green-200 text-green-700 px-4 py-3 rounded-xl text-sm mb-4">
                <i class="fas fa-check-circle mr-2"></i> Surat tugas berhasil dihapus.
            </div>
        <?php elseif ($_GET['msg'] === 'created'): ?>
            <div class="bg-amber-50 border border-amber-200 text-amber-700 px-4 py-3 rounded-xl text-sm mb-4">
                <i class="fas fa-info-circle mr-2"></i> Draft surat tugas berhasil dibuat.
            </div>
        <?php elseif ($_GET['msg'] === 'updated'): ?>
            <div class="bg-blue-50 border border-blue-200 text-blue-700 px-4 py-3 rounded-xl text-sm mb-4">
                <i class="fas fa-check-circle mr-2"></i> Data surat tugas berhasil diperbarui.
            </div>
        <?php endif; ?>
    <?php endif; ?>

    <?php if (isset($errorMsg)): ?>
        <div class="bg-red-50 border border-red-200 text-red-700 px-4 py-3 rounded-xl text-sm mb-4">
            <i class="fas fa-exclamation-circle mr-2"></i> <?= htmlspecialchars($errorMsg) ?>
        </div>
    <?php endif; ?>

    <!-- Table Section -->
    <div class="bg-white rounded-2xl shadow-sm border border-gray-100 overflow-hidden">
        <div class="overflow-x-auto">
            <table class="w-full text-left border-collapse">
                <thead>
                    <tr class="bg-gray-50 border-b border-gray-100 text-xs uppercase tracking-wider text-gray-500 font-bold">
                        <th class="py-3.5 px-4">No. Surat</th>
                        <th class="py-3.5 px-4">Tanggal</th>
                        <th class="py-3.5 px-4">User yang Ditugaskan</th>
                        <th class="py-3.5 px-4">Penandatangan</th>
                        <th class="py-3.5 px-4 text-center">Status</th>
                        <th class="py-3.5 px-4 text-center">Aksi</th>
                    </tr>
                </thead>
                <tbody class="divide-y divide-gray-100 text-sm text-gray-700">
                    <?php if (empty($suratList)): ?>
                        <tr>
                            <td colspan="6" class="text-center py-8 text-gray-400">
                                <i class="fas fa-clipboard-list text-3xl mb-2 block"></i>
                                Belum ada data surat tugas yang dapat diakses.
                            </td>
                        </tr>
                    <?php else: ?>
                        <?php foreach ($suratList as $row): ?>
                            <?php
                                // Ambil daftar personil yang ditugaskan untuk surat ini
                                $stmtPersonil = $pdo->prepare("
                                    SELECT u.name, u.position, u.division, u.department
                                    FROM tbl_surat_tugas_personil stp
                                    JOIN users u ON stp.user_id = u.id
                                    WHERE stp.surat_tugas_id = ?
                                    ORDER BY u.name ASC
                                ");
                                $stmtPersonil->execute([$row['id']]);
                                $personilList = $stmtPersonil->fetchAll();
                            ?>
                            <tr class="hover:bg-gray-50/50 transition-colors">
                                <td class="py-3.5 px-4 font-semibold text-gray-900 align-top">
                                    <?= htmlspecialchars($row['nomor_surat']) ?>
                                </td>
                                <td class="py-3.5 px-4 whitespace-nowrap align-top">
                                    <?= date('d/m/Y', strtotime($row['tanggal_surat'])) ?>
                                </td>
                                <!-- Kolom User yang Ditugaskan (Tersusun ke bawah) -->
                                <td class="py-3.5 px-4 align-top">
                                    <ul class="list-disc pl-4 space-y-1 text-xs">
                                        <?php foreach ($personilList as $p): ?>
                                            <?php 
                                                // Logika Nomenklatur Jabatan
                                                $posLower = strtolower(trim($p['position'] ?? ''));
                                                $detailLabel = '';
                                                if (strpos($posLower, 'kepala bidang') !== false) {
                                                    $detailLabel = $p['division'] ?? '-';
                                                } elseif (strpos($posLower, 'kepala divisi') !== false) {
                                                    $detailLabel = $p['department'] ?? '-';
                                                } elseif (strpos($posLower, 'staff') !== false) {
                                                    $detailLabel = $p['division'] ?? '-';
                                                } else {
                                                    $detailLabel = $p['position'];
                                                }
                                            ?>
                                            <li>
                                                <span class="font-semibold text-gray-900"><?= htmlspecialchars($p['name']) ?></span>
                                                <span class="text-gray-500">(<?= htmlspecialchars($detailLabel) ?>)</span>
                                            </li>
                                        <?php endforeach; ?>
                                    </ul>
                                </td>
                                <td class="py-3.5 px-4 align-top">
                                    <?= htmlspecialchars($row['penandatangan_nama'] ?? '-') ?>
                                </td>
                                <td class="py-3.5 px-4 text-center whitespace-nowrap align-top">
                                    <?php if ($row['status_surat'] === 'published' || $row['status_surat'] === 'complete'): ?>
                                        <span class="inline-flex items-center gap-1 px-2.5 py-1 rounded-full text-xs font-semibold bg-emerald-50 text-emerald-700 border border-emerald-200">
                                            <span class="w-1.5 h-1.5 rounded-full bg-emerald-500"></span> Published
                                        </span>
                                    <?php else: ?>
                                        <span class="inline-flex items-center gap-1 px-2.5 py-1 rounded-full text-xs font-semibold bg-amber-50 text-amber-700 border border-amber-200">
                                            <span class="w-1.5 h-1.5 rounded-full bg-amber-500"></span> Draft
                                        </span>
                                    <?php endif; ?>
                                </td>
                                <td class="py-3.5 px-4 text-center whitespace-nowrap align-top">
                                    <div class="inline-flex items-center gap-1.5">
                                        <!-- Aksi View -->
                                        <a href="surattugas_view.php?id=<?= $row['id'] ?>" class="p-2 rounded-lg text-blue-600 hover:bg-blue-50 transition-colors" title="Lihat Surat Tugas">
                                            <i class="fas fa-eye"></i>
                                        </a>

                                        <!-- Aksi Sign (Hanya Penandatangan & Status Draft) -->
                                        <?php if ($row['penandatangan_id'] == $currentUserId && $row['status_surat'] === 'draft'): ?>
                                            <a href="surattugas_sign.php?id=<?= $row['id'] ?>" class="p-2 rounded-lg text-emerald-600 hover:bg-emerald-50 transition-colors" title="Sign / Tanda Tangan">
                                                <i class="fas fa-signature"></i>
                                            </a>
                                        <?php endif; ?>

                                        <!-- Aksi Edit (Hanya Pembuat & Status Draft) -->
                                        <?php if ($row['created_by'] == $currentUserId && $row['status_surat'] === 'draft'): ?>
                                            <a href="surattugas_edit.php?id=<?= $row['id'] ?>" class="p-2 rounded-lg text-amber-600 hover:bg-amber-50 transition-colors" title="Edit Surat Tugas">
                                                <i class="fas fa-pen"></i>
                                            </a>
                                        <?php endif; ?>
                                
                                        <!-- Aksi Delete (Hanya Pembuat) -->
                                        <?php if ($row['created_by'] == $currentUserId): ?>
                                            <a href="surattugas_list.php?action=delete&id=<?= $row['id'] ?>" onclick="return confirm('Apakah Anda yakin ingin menghapus surat tugas ini?');" class="p-2 rounded-lg text-rose-600 hover:bg-rose-50 transition-colors" title="Hapus Surat">
                                                <i class="fas fa-trash"></i>
                                            </a>
                                        <?php endif; ?>
                                    </div>
                                </td>
                            </tr>
                        <?php endforeach; ?>
                    <?php endif; ?>
                </tbody>
            </table>
        </div>
    </div>
</main>
</div>

<?php require_once 'includes/footer.php'; ?>