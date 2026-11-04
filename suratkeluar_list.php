<?php
error_reporting(E_ALL);
error_reporting(-1);
ini_set('error_reporting', E_ALL);
require_once 'includes/mail_helper.php';
require_once 'config.php';
requireLogin();

$pageTitle = 'Daftar Surat Keluar';
$currentUserId = (int)$_SESSION['user_id'];

// Handle Hapus Surat Keluar (Hanya pembuat / created_by yang dapat menghapus saat status draft)
if (isset($_GET['action']) && $_GET['action'] === 'delete' && isset($_GET['id'])) {
    $deleteId = (int)$_GET['id'];
    
    $stmtCheck = $pdo->prepare("SELECT nomor_surat, status FROM surat_keluar WHERE id = ? AND created_by = ?");
    $stmtCheck->execute([$deleteId, $currentUserId]);
    $surat = $stmtCheck->fetch();

    if ($surat) {
        if ($surat['status'] === 'draft') {
            $stmtDelete = $pdo->prepare("DELETE FROM surat_keluar WHERE id = ?");
            $stmtDelete->execute([$deleteId]);
            
            logActivity($currentUserId, 'delete_surat_keluar', "Menghapus Surat Keluar #{$surat['nomor_surat']}", null);
            header('Location: ' . APP_URL . '/suratkeluar_list.php?msg=deleted');
            exit;
        } else {
            $errorMsg = "Surat yang sudah dipublish/ditandatangani tidak dapat dihapus.";
        }
    } else {
        $errorMsg = "Anda tidak memiliki akses untuk menghapus surat ini.";
    }
}

// Ambil daftar surat keluar di mana user sebagai created_by ATAU sebagai penandatangan
$stmt = $pdo->prepare("
    SELECT sk.*, 
           u_buat.name AS pembuat_nama, 
           u_kirim.name AS pengirim_nama 
    FROM surat_keluar sk
    LEFT JOIN users u_buat ON sk.created_by = u_buat.id
    LEFT JOIN users u_kirim ON sk.dikirim_oleh = u_kirim.id
    WHERE sk.created_by = ? OR sk.dikirim_oleh = ? OR sk.penandatangan = ?
    ORDER BY sk.created_at DESC
");
$stmt->execute([$currentUserId, $currentUserId, $currentUserId]);
$suratList = $stmt->fetchAll();

require_once 'includes/header.php';
require_once 'includes/sidebar.php';
?>

<div class="lg:ml-64 pt-14 min-h-screen">
<main class="p-4 md:p-6 lg:p-8 max-w-7xl">

    <!-- Header Section -->
    <div class="flex flex-col md:flex-row md:items-center justify-between gap-4 mb-6">
        <div>
            <h2 class="text-xl font-black text-gray-900 mb-1">Daftar Surat Keluar</h2>
            <p class="text-gray-500 text-sm">Kelola dan pantau surat keluar yang Anda buat atau ditugaskan untuk ditandatangani</p>
        </div>
        <a href="suratkeluar_create.php" class="btn-primary inline-flex items-center gap-2 self-start md:self-auto px-4 py-2.5 text-sm font-semibold rounded-xl shadow-sm">
            <i class="fas fa-plus"></i> Buat Surat Keluar
        </a>
    </div>

    <!-- Alert Messages -->
    <?php if (isset($_GET['msg'])): ?>
        <?php if ($_GET['msg'] === 'deleted'): ?>
            <div class="bg-green-50 border border-green-200 text-green-700 px-4 py-3 rounded-xl text-sm mb-4">
                <i class="fas fa-check-circle mr-2"></i> Surat keluar berhasil dihapus.
            </div>
        <?php elseif ($_GET['msg'] === 'draft_created'): ?>
            <div class="bg-amber-50 border border-amber-200 text-amber-700 px-4 py-3 rounded-xl text-sm mb-4">
                <i class="fas fa-info-circle mr-2"></i> Draft surat keluar berhasil dibuat.
            </div>
        <?php elseif ($_GET['msg'] === 'updated'): ?>
            <div class="bg-blue-50 border border-blue-200 text-blue-700 px-4 py-3 rounded-xl text-sm mb-4">
                <i class="fas fa-check-circle mr-2"></i> Data surat keluar berhasil diperbarui.
            </div>
        <?php elseif ($_GET['msg'] === 'signed'): ?>
            <div class="bg-emerald-50 border border-emerald-200 text-emerald-700 px-4 py-3 rounded-xl text-sm mb-4">
                <i class="fas fa-check-circle mr-2"></i> Dokumen surat keluar berhasil ditandatangani dan dipublish.
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
                        <th class="py-3.5 px-4">Tujuan / Penerima</th>
                        <th class="py-3.5 px-4">Perihal</th>
                        <th class="py-3.5 px-4 text-center">Status</th>
                        <th class="py-3.5 px-4 text-center">Aksi</th>
                    </tr>
                </thead>
                <tbody class="divide-y divide-gray-100 text-sm text-gray-700">
                    <?php if (empty($suratList)): ?>
                        <tr>
                            <td colspan="6" class="text-center py-8 text-gray-400">
                                <i class="fas fa-inbox text-3xl mb-2 block"></i>
                                Belum ada dokumen surat keluar yang tersedia.
                            </td>
                        </tr>
                    <?php else: ?>
                        <?php foreach ($suratList as $row): ?>
                            <tr class="hover:bg-gray-50/50 transition-colors">
                                <td class="py-3.5 px-4 font-semibold text-gray-900">
                                    <?= htmlspecialchars($row['nomor_surat']) ?>
                                </td>
                                <td class="py-3.5 px-4 whitespace-nowrap">
                                    <?= date('d/m/Y', strtotime($row['tanggal_surat'])) ?>
                                </td>
                                <td class="py-3.5 px-4">
                                    <?= htmlspecialchars($row['penerima_surat']) ?>
                                </td>
                                <td class="py-3.5 px-4 max-w-xs truncate">
                                    <?= htmlspecialchars($row['perihal']) ?>
                                </td>
                                <td class="py-3.5 px-4 text-center whitespace-nowrap">
                                    <?php if ($row['status'] === 'published'): ?>
                                        <span class="inline-flex items-center gap-1 px-2.5 py-1 rounded-full text-xs font-semibold bg-emerald-50 text-emerald-700 border border-emerald-200">
                                            <span class="w-1.5 h-1.5 rounded-full bg-emerald-500"></span> Published
                                        </span>
                                    <?php else: ?>
                                        <span class="inline-flex items-center gap-1 px-2.5 py-1 rounded-full text-xs font-semibold bg-amber-50 text-amber-700 border border-amber-200">
                                            <span class="w-1.5 h-1.5 rounded-full bg-amber-500"></span> Draft
                                        </span>
                                    <?php endif; ?>
                                </td>
                                <td class="py-3.5 px-4 text-center whitespace-nowrap">
                                    <div class="inline-flex items-center gap-1.5">
                                        <!-- Aksi View (Selalu ada) -->
                                        <a href="suratkeluar_view.php?id=<?= $row['id'] ?>" class="p-2 rounded-lg text-blue-600 hover:bg-blue-50 transition-colors" title="Lihat Dokumen">
                                            <i class="fas fa-eye"></i>
                                        </a>

                                        <!-- Aksi PDF (Biasanya aktif setelah published atau siap diunduh) -->
                                        <a href="suratkeluar_pdf.php?id=<?= $row['id'] ?>" target="_blank" class="p-2 rounded-lg text-purple-600 hover:bg-purple-50 transition-colors" title="Unduh / Lihat PDF">
                                            <i class="fas fa-file-pdf"></i>
                                        </a>
                                
                                        <!-- Aksi Sign (Hanya muncul jika status draft DAN user login adalah pengirim/penandatangan) -->
                                        <?php if ($row['status'] === 'draft' && ((int)$row['dikirim_oleh'] === $currentUserId || (int)$row['penandatangan'] === $currentUserId)): ?>
                                            <a href="suratkeluar_sign.php?id=<?= $row['id'] ?>" class="p-2 rounded-lg text-emerald-600 hover:bg-emerald-50 transition-colors" title="Tanda Tangan Dokumen">
                                                <i class="fas fa-signature"></i>
                                            </a>
                                        <?php endif; ?>
                                
                                        <!-- Aksi Edit (Hanya muncul jika status masih draft DAN user adalah pembuat / created_by) -->
                                        <?php if ($row['status'] === 'draft' && (int)$row['created_by'] === $currentUserId): ?>
                                            <a href="suratkeluar_edit.php?id=<?= $row['id'] ?>" class="p-2 rounded-lg text-amber-600 hover:bg-amber-50 transition-colors" title="Edit Surat">
                                                <i class="fas fa-pen"></i>
                                            </a>
                                        <?php endif; ?>
                                
                                        <!-- Aksi Delete (Hanya saat draft & pembuat) -->
                                        <?php if ($row['status'] === 'draft' && (int)$row['created_by'] === $currentUserId): ?>
                                            <a href="suratkeluar_list.php?action=delete&id=<?= $row['id'] ?>" onclick="return confirm('Apakah Anda yakin ingin menghapus surat keluar ini?');" class="p-2 rounded-lg text-rose-600 hover:bg-rose-50 transition-colors" title="Hapus Surat">
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