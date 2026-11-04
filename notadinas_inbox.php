<?php
require_once 'config.php';
requireLogin();
$pageTitle = 'Inbox & Nota Dinas Terkirim';

// Tab aktif (default: inbox)
$tab = $_GET['tab'] ?? 'inbox';

// Handle Action Delete Nota Dinas (Hanya bisa dihapus oleh pembuatnya)
if ($_SERVER['REQUEST_METHOD'] === 'POST' && ($_POST['action'] ?? '') === 'delete') {
    $deleteId = (int)($_POST['nota_id'] ?? 0);
    
    if ($deleteId > 0) {
        // Cek kepemilikan nota dinas sebelum menghapus
        $stmtCheck = $pdo->prepare("SELECT nomor_nota_dinas FROM nota_dinas WHERE id = ? AND from_user_id = ?");
        $stmtCheck->execute([$deleteId, $_SESSION['user_id']]);
        $notaToDelete = $stmtCheck->fetch();

        if ($notaToDelete) {
            $stmtDel = $pdo->prepare("DELETE FROM nota_dinas WHERE id = ? AND from_user_id = ?");
            $stmtDel->execute([$deleteId, $_SESSION['user_id']]);

            logActivity($_SESSION['user_id'], 'delete_nota_dinas', "Menghapus Nota Dinas #" . $notaToDelete['nomor_nota_dinas'], null);
            header('Location: ' . APP_URL . '/notadinas_inbox.php?tab=sent&msg=deleted');
            exit;
        }
    }
}

// 1. Ambil Nota Dinas MASUK (to_user_id = user yang login)
$stmtInbox = $pdo->prepare("
    SELECT nd.*, 
           u.name as from_name, u.position as from_pos, u.division as from_div
    FROM nota_dinas nd
    JOIN users u ON nd.from_user_id = u.id
    WHERE nd.to_user_id = ?
    ORDER BY nd.created_at DESC
");
$stmtInbox->execute([$_SESSION['user_id']]);
$inboxList = $stmtInbox->fetchAll();

// 2. Ambil Nota Dinas TERKIRIM / DIBUAT (from_user_id = user yang login)
$stmtSent = $pdo->prepare("
    SELECT nd.*, 
           u.name as to_name, u.position as to_pos, u.division as to_div
    FROM nota_dinas nd
    JOIN users u ON nd.to_user_id = u.id
    WHERE nd.from_user_id = ?
    ORDER BY nd.created_at DESC
");
$stmtSent->execute([$_SESSION['user_id']]);
$sentList = $stmtSent->fetchAll();

require_once 'includes/header.php';
require_once 'includes/sidebar.php';
?>

<div class="lg:ml-64 pt-14 min-h-screen">
<main class="p-4 md:p-6 lg:p-8">

    <?php if (($_GET['msg'] ?? '') === 'sent'): ?>
        <script>showToast('Nota dinas berhasil dikirim', 'success');</script>
    <?php endif; ?>
    <?php if (($_GET['msg'] ?? '') === 'deleted'): ?>
        <script>showToast('Nota dinas berhasil dihapus', 'success');</script>
    <?php endif; ?>

    <div class="flex flex-col sm:flex-row sm:items-center sm:justify-between gap-4 mb-6">
        <div>
            <h2 class="text-xl font-black text-gray-900 mb-1">Nota Dinas</h2>
            <p class="text-gray-500 text-sm">Kelola nota dinas masuk dan nota dinas yang Anda buat</p>
        </div>
        <a href="<?= APP_URL ?>/notadinas_create.php" class="btn-primary self-start sm:self-auto">
            <i class="fas fa-plus mr-1"></i> Buat Nota Dinas
        </a>
    </div>

    <!-- Navigation Tabs -->
    <div class="flex border-b border-gray-200 mb-6">
        <a href="?tab=inbox" class="px-4 py-2.5 text-sm font-bold border-b-2 transition-colors flex items-center gap-2 <?= $tab === 'inbox' ? 'border-teal-600 text-teal-600' : 'border-transparent text-gray-500 hover:text-gray-700' ?>">
            <i class="fas fa-inbox"></i>
            Nota Dinas Masuk
            <span class="bg-gray-100 text-gray-600 text-xs px-2 py-0.5 rounded-full font-semibold"><?= count($inboxList) ?></span>
        </a>
        <a href="?tab=sent" class="px-4 py-2.5 text-sm font-bold border-b-2 transition-colors flex items-center gap-2 <?= $tab === 'sent' ? 'border-teal-600 text-teal-600' : 'border-transparent text-gray-500 hover:text-gray-700' ?>">
            <i class="fas fa-paper-plane"></i>
            Nota Dinas Terkirim
            <span class="bg-gray-100 text-gray-600 text-xs px-2 py-0.5 rounded-full font-semibold"><?= count($sentList) ?></span>
        </a>
    </div>

    <?php if ($tab === 'inbox'): ?>
    <!-- TAB 1: NOTA DINAS MASUK -->
    <div class="space-y-3">
        <?php foreach ($inboxList as $nota): ?>
        <a href="<?= APP_URL ?>/notadinas_view.php?id=<?= $nota['id'] ?>" class="block bg-white rounded-2xl shadow-sm border border-gray-100 p-5 hover:shadow-md transition-all group">
            <div class="flex items-start justify-between gap-4">
                <div class="flex-1">
                    <div class="flex items-center gap-2 mb-1">
                        <?php
                        $badgeClasses = [
                            'created'   => 'bg-gray-100 text-gray-700',
                            'sent'      => 'bg-blue-100 text-blue-700',
                            'processed' => 'bg-amber-100 text-amber-700',
                            'complete'  => 'bg-emerald-100 text-emerald-700'
                        ];
                        $statusClass = $badgeClasses[$nota['status']] ?? 'bg-gray-100 text-gray-700';
                        ?>
                        <span class="px-2.5 py-0.5 rounded-full text-[10px] font-bold uppercase tracking-wider <?= $statusClass ?>">
                            <?= esc($nota['status']) ?>
                        </span>

                        <?php if ($nota['status'] === 'sent'): ?>
                        <span class="w-2 h-2 rounded-full bg-red-500 animate-pulse"></span>
                        <?php endif; ?>
                    </div>

                    <h3 class="text-sm font-bold text-gray-800 group-hover:text-brand transition-colors line-clamp-1">
                        <?= esc(strip_tags($nota['perihal'])) ?>
                    </h3>
                    <p class="text-[10px] text-gray-400 font-mono mt-0.5"><?= esc($nota['nomor_nota_dinas']) ?></p>

                    <div class="flex items-center gap-3 mt-2 text-xs text-gray-500">
                        <span><i class="fas fa-user mr-1"></i>Dari: <strong><?= esc($nota['from_name']) ?></strong> (<?= esc($nota['from_pos']) ?>)</span>
                        <span><i class="fas fa-calendar mr-1"></i><?= date('d/m/Y', strtotime($nota['tanggal'])) ?></span>
                    </div>
                </div>
                <i class="fas fa-chevron-right text-gray-300 group-hover:text-brand transition-colors mt-2"></i>
            </div>
        </a>
        <?php endforeach; ?>

        <?php if (empty($inboxList)): ?>
        <div class="bg-white rounded-2xl shadow-sm border border-gray-100 p-12 text-center">
            <i class="fas fa-inbox text-4xl text-gray-200 mb-3"></i>
            <p class="text-gray-400 text-sm">Tidak ada nota dinas masuk</p>
        </div>
        <?php endif; ?>
    </div>

    <?php else: ?>
    <!-- TAB 2: NOTA DINAS TERKIRIM (TABEL DIBUAT USER) -->
    <div class="bg-white rounded-2xl shadow-sm border border-gray-100 overflow-hidden">
        <div class="overflow-x-auto">
            <table class="w-full text-left border-collapse text-sm">
                <thead>
                    <tr class="bg-gray-50 border-b border-gray-100 text-[11px] font-bold uppercase tracking-wider text-gray-500">
                        <th class="py-3.5 px-4">No. Nota Dinas</th>
                        <th class="py-3.5 px-4">Tujuan</th>
                        <th class="py-3.5 px-4">Perihal</th>
                        <th class="py-3.5 px-4">Tanggal</th>
                        <th class="py-3.5 px-4">Status</th>
                        <th class="py-3.5 px-4 text-center">Aksi</th>
                    </tr>
                </thead>
                <tbody class="divide-y divide-gray-100 text-gray-700">
                    <?php foreach ($sentList as $nota): ?>
                    <tr class="hover:bg-gray-50/60 transition-colors">
                        <td class="py-3.5 px-4 font-mono text-xs font-bold text-gray-800">
                            <?= esc($nota['nomor_nota_dinas']) ?>
                        </td>
                        <td class="py-3.5 px-4">
                            <p class="font-semibold text-gray-800 text-xs"><?= esc($nota['to_name']) ?></p>
                            <p class="text-[10px] text-gray-400"><?= esc($nota['to_pos']) ?></p>
                        </td>
                        <td class="py-3.5 px-4">
                            <p class="line-clamp-1 text-xs text-gray-800 max-w-xs"><?= esc(strip_tags($nota['perihal'])) ?></p>
                        </td>
                        <td class="py-3.5 px-4 text-xs text-gray-500 whitespace-nowrap">
                            <!-- Menampilkan tanggal hanya dd/mm/yyyy tanpa jam -->
                            <?= date('d/m/Y', strtotime($nota['tanggal'])) ?>
                        </td>
                        <td class="py-3.5 px-4 whitespace-nowrap">
                            <?php
                            $badgeClasses = [
                                'created'   => 'bg-gray-100 text-gray-700',
                                'sent'      => 'bg-blue-100 text-blue-700',
                                'processed' => 'bg-amber-100 text-amber-700',
                                'complete'  => 'bg-emerald-100 text-emerald-700'
                            ];
                            $statusClass = $badgeClasses[$nota['status']] ?? 'bg-gray-100 text-gray-700';
                            ?>
                            <span class="px-2.5 py-0.5 rounded-full text-[10px] font-bold uppercase tracking-wider <?= $statusClass ?>">
                                <?= esc($nota['status']) ?>
                            </span>
                        </td>
                        <td class="py-3.5 px-4 text-center whitespace-nowrap">
                            <div class="inline-flex items-center gap-1.5">
                                <a href="<?= APP_URL ?>/notadinas_view.php?id=<?= $nota['id'] ?>" class="inline-flex items-center gap-1 text-xs font-semibold text-teal-600 hover:text-teal-800 bg-teal-50 px-2.5 py-1.5 rounded-lg transition-colors">
                                    <i class="fas fa-eye"></i> Lihat
                                </a>
                                <form method="POST" action="" onsubmit="return confirm('Apakah Anda yakin ingin menghapus nota dinas ini?');" class="inline">
                                    <input type="hidden" name="action" value="delete">
                                    <input type="hidden" name="nota_id" value="<?= $nota['id'] ?>">
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
                            Anda belum pernah membuat atau mengirim nota dinas
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