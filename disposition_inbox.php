<?php
require_once 'config.php';
requireLogin();
$pageTitle = 'Inbox & Disposisi Terkirim';

// Tab aktif (default: inbox)
$tab = $_GET['tab'] ?? 'inbox';

// Handle Action Delete Disposisi (Hanya bisa dihapus oleh pembuatnya)
if ($_SERVER['REQUEST_METHOD'] === 'POST' && ($_POST['action'] ?? '') === 'delete') {
    $deleteId = (int)($_POST['disposition_id'] ?? 0);
    
    if ($deleteId > 0) {
        // Cek kepemilikan disposisi sebelum menghapus
        $stmtCheck = $pdo->prepare("SELECT id FROM dispositions WHERE id = ? AND from_user_id = ?");
        $stmtCheck->execute([$deleteId, $_SESSION['user_id']]);
        $dispToDelete = $stmtCheck->fetch();

        if ($dispToDelete) {
            $stmtDel = $pdo->prepare("DELETE FROM dispositions WHERE id = ? AND from_user_id = ?");
            $stmtDel->execute([$deleteId, $_SESSION['user_id']]);

            logActivity($_SESSION['user_id'], 'delete_disposition', "Menghapus Disposisi #" . $deleteId, null);
            header('Location: ' . APP_URL . '/disposition_inbox.php?tab=sent&msg=deleted');
            exit;
        }
    }
}

// 1. Ambil Disposisi MASUK (to_user_id = user yang login)
$stmtInbox = $pdo->prepare("
    SELECT d.*, doc.title, doc.document_number, doc.file_path,
           u.name as from_name, u.position as from_pos, u.division as from_div
    FROM dispositions d
    JOIN documents doc ON d.document_id = doc.id
    JOIN users u ON d.from_user_id = u.id
    WHERE d.to_user_id = ?
    ORDER BY d.created_at DESC
");
$stmtInbox->execute([$_SESSION['user_id']]);
$inboxList = $stmtInbox->fetchAll();

// 2. Ambil Disposisi TERKIRIM / DIBUAT (from_user_id = user yang login)
$stmtSent = $pdo->prepare("
    SELECT d.*, doc.title, doc.document_number, doc.file_path,
           u.name as to_name, u.position as to_pos, u.division as to_div
    FROM dispositions d
    JOIN documents doc ON d.document_id = doc.id
    JOIN users u ON d.to_user_id = u.id
    WHERE d.from_user_id = ?
    ORDER BY d.created_at DESC
");
$stmtSent->execute([$_SESSION['user_id']]);
$sentList = $stmtSent->fetchAll();

require_once 'includes/header.php';
require_once 'includes/sidebar.php';
?>

<div class="lg:ml-64 pt-14 min-h-screen">
<main class="p-4 md:p-6 lg:p-8">

    <?php if (($_GET['msg'] ?? '') === 'created'): ?>
        <script>showToast('Disposisi berhasil dibuat', 'success');</script>
    <?php endif; ?>
    <?php if (($_GET['msg'] ?? '') === 'deleted'): ?>
        <script>showToast('Disposisi berhasil dihapus', 'success');</script>
    <?php endif; ?>

    <div class="flex flex-col sm:flex-row sm:items-center sm:justify-between gap-4 mb-6">
        <div>
            <h2 class="text-xl font-black text-gray-900 mb-1">Disposisi</h2>
            <p class="text-gray-500 text-sm">Kelola disposisi masuk dan disposisi yang Anda kirimkan</p>
        </div>
    </div>

    <!-- Navigation Tabs -->
    <div class="flex border-b border-gray-200 mb-6">
        <a href="?tab=inbox" class="px-4 py-2.5 text-sm font-bold border-b-2 transition-colors flex items-center gap-2 <?= $tab === 'inbox' ? 'border-teal-600 text-teal-600' : 'border-transparent text-gray-500 hover:text-gray-700' ?>">
            <i class="fas fa-inbox"></i>
            Disposisi Masuk
            <span class="bg-gray-100 text-gray-600 text-xs px-2 py-0.5 rounded-full font-semibold"><?= count($inboxList) ?></span>
        </a>
        <a href="?tab=sent" class="px-4 py-2.5 text-sm font-bold border-b-2 transition-colors flex items-center gap-2 <?= $tab === 'sent' ? 'border-teal-600 text-teal-600' : 'border-transparent text-gray-500 hover:text-gray-700' ?>">
            <i class="fas fa-paper-plane"></i>
            Disposisi Terkirim
            <span class="bg-gray-100 text-gray-600 text-xs px-2 py-0.5 rounded-full font-semibold"><?= count($sentList) ?></span>
        </a>
    </div>

    <?php if ($tab === 'inbox'): ?>
    <!-- TAB 1: DISPOSISI MASUK -->
    <div class="space-y-3">
        <?php foreach ($inboxList as $disp): ?>
        <a href="<?= APP_URL ?>/disposition_view.php?id=<?= $disp['id'] ?>" class="block bg-white rounded-2xl shadow-sm border border-gray-100 p-5 hover:shadow-md transition-all group">
            <div class="flex items-start justify-between gap-4">
                <div class="flex-1">
                    <div class="flex items-center gap-2 mb-1">
                        <?= statusBadge($disp['status']) ?>
                        <?= priorityBadge($disp['priority']) ?>
                        <?php if ($disp['status'] === 'pending'): ?>
                        <span class="w-2 h-2 rounded-full bg-red-500 animate-pulse"></span>
                        <?php endif; ?>
                    </div>
                    <h3 class="text-sm font-bold text-gray-800 group-hover:text-brand transition-colors"><?= esc($disp['title']) ?></h3>
                    <p class="text-[10px] text-gray-400 font-mono mt-0.5"><?= esc($disp['document_number']) ?></p>
                    <div class="flex items-center gap-3 mt-2 text-xs text-gray-500">
                        <span><i class="fas fa-user mr-1"></i>Dari: <strong><?= esc($disp['from_name']) ?></strong> (<?= esc($disp['from_pos']) ?>)</span>
                        <span><i class="fas fa-clock mr-1"></i><?= formatDateShort($disp['created_at']) ?></span>
                    </div>
                    <?php if ($disp['notes']): ?>
                    <p class="text-xs text-gray-500 mt-2 bg-gray-50 rounded-lg p-2 italic">"<?= esc($disp['notes']) ?>"</p>
                    <?php endif; ?>
                </div>
                <i class="fas fa-chevron-right text-gray-300 group-hover:text-brand transition-colors mt-2"></i>
            </div>
        </a>
        <?php endforeach; ?>

        <?php if (empty($inboxList)): ?>
        <div class="bg-white rounded-2xl shadow-sm border border-gray-100 p-12 text-center">
            <i class="fas fa-inbox text-4xl text-gray-200 mb-3"></i>
            <p class="text-gray-400 text-sm">Tidak ada disposisi masuk</p>
        </div>
        <?php endif; ?>
    </div>

    <?php else: ?>
    <!-- TAB 2: DISPOSISI TERKIRIM (TABEL) -->
    <div class="bg-white rounded-2xl shadow-sm border border-gray-100 overflow-hidden">
        <div class="overflow-x-auto">
            <table class="w-full text-left border-collapse text-sm">
                <thead>
                    <tr class="bg-gray-50 border-b border-gray-100 text-[11px] font-bold uppercase tracking-wider text-gray-500">
                        <th class="py-3.5 px-4">No. Dokumen</th>
                        <th class="py-3.5 px-4">Tujuan</th>
                        <th class="py-3.5 px-4">Judul Dokumen</th>
                        <th class="py-3.5 px-4">Tanggal</th>
                        <th class="py-3.5 px-4">Status & Prioritas</th>
                        <th class="py-3.5 px-4 text-center">Aksi</th>
                    </tr>
                </thead>
                <tbody class="divide-y divide-gray-100 text-gray-700">
                    <?php foreach ($sentList as $disp): ?>
                    <tr class="hover:bg-gray-50/60 transition-colors">
                        <td class="py-3.5 px-4 font-mono text-xs font-bold text-gray-800">
                            <?= esc($disp['document_number']) ?>
                        </td>
                        <td class="py-3.5 px-4">
                            <p class="font-semibold text-gray-800 text-xs"><?= esc($disp['to_name']) ?></p>
                            <p class="text-[10px] text-gray-400"><?= esc($disp['to_pos']) ?></p>
                        </td>
                        <td class="py-3.5 px-4">
                            <p class="line-clamp-1 text-xs text-gray-800 max-w-xs"><?= esc($disp['title']) ?></p>
                        </td>
                        <td class="py-3.5 px-4 text-xs text-gray-500 whitespace-nowrap">
                            <?= formatDateShort($disp['created_at']) ?>
                        </td>
                        <td class="py-3.5 px-4 whitespace-nowrap space-y-1">
                            <div><?= statusBadge($disp['status']) ?></div>
                            <div><?= priorityBadge($disp['priority']) ?></div>
                        </td>
                        <td class="py-3.5 px-4 text-center whitespace-nowrap">
                            <div class="inline-flex items-center gap-1.5">
                                <a href="<?= APP_URL ?>/disposition_view.php?id=<?= $disp['id'] ?>" class="inline-flex items-center gap-1 text-xs font-semibold text-teal-600 hover:text-teal-800 bg-teal-50 px-2.5 py-1.5 rounded-lg transition-colors">
                                    <i class="fas fa-eye"></i> Lihat
                                </a>
                                <form method="POST" action="" onsubmit="return confirm('Apakah Anda yakin ingin menghapus disposisi ini?');" class="inline">
                                    <input type="hidden" name="action" value="delete">
                                    <input type="hidden" name="disposition_id" value="<?= $disp['id'] ?>">
                                    <button type="submit" class="inline-flex items-center gap-1 text-xs font-semibold text-red-600 hover:text-red-800 bg-red-50 px-2.5 py-1.5 rounded-lg transition-colors">
                                        <i class="fas fa-trash-alt"></i> Hapus
                                    </button>
                                </form>
                            </div>
                        </td>
                    </tr>
                    <?php endforeach; ?>

                    <?php if (empty($sentList)): ?>
                    <tr>
                        <td colspan="6" class="py-12 text-center text-gray-400 text-sm">
                            <i class="fas fa-paper-plane text-4xl text-gray-200 mb-3 block"></i>
                            Anda belum pernah mengirim disposisi
                        </td>
                    </tr>
                    <?php endif; ?>
                </tbody>
            </table>
        </div>
    </div>
    <?php endif; ?>

</main>
</div>

<?php require_once 'includes/footer.php'; ?>