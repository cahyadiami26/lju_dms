<?php
require_once 'config.php';
requireLogin();
$pageTitle = 'Riwayat Disposisi';

$stmt = $pdo->prepare("
    SELECT d.*, doc.title, doc.document_number,
           u1.name as from_name, u1.position as from_pos,
           u2.name as to_name, u2.position as to_pos
    FROM dispositions d
    JOIN documents doc ON d.document_id = doc.id
    JOIN users u1 ON d.from_user_id = u1.id
    JOIN users u2 ON d.to_user_id = u2.id
    WHERE d.from_user_id = ? OR d.to_user_id = ?
    ORDER BY d.created_at DESC
");
$stmt->execute([$_SESSION['user_id'], $_SESSION['user_id']]);
$allDisps = $stmt->fetchAll();

require_once 'includes/header.php';
require_once 'includes/sidebar.php';
?>

<div class="lg:ml-64 pt-14 min-h-screen">
<main class="p-4 md:p-6 lg:p-8">

    <h2 class="text-xl font-black text-gray-900 mb-1">Riwayat Disposisi</h2>
    <p class="text-gray-500 text-sm mb-6">Semua disposisi yang terkait dengan Anda</p>

    <div class="bg-white rounded-2xl shadow-sm border border-gray-100 overflow-hidden">
        <div class="overflow-x-auto">
            <table class="table-modern">
                <thead>
                    <tr>
                        <th>Dokumen</th>
                        <th>Dari</th>
                        <th>Kepada</th>
                        <th>Prioritas</th>
                        <th>Status</th>
                        <th>Tanggal</th>
                        <th>Aksi</th>
                    </tr>
                </thead>
                <tbody>
                    <?php foreach ($allDisps as $d): ?>
                    <tr>
                        <td>
                            <p class="font-semibold text-gray-800 text-xs"><?= esc($d['title']) ?></p>
                            <p class="text-[10px] text-gray-400 font-mono"><?= esc($d['document_number']) ?></p>
                        </td>
                        <td class="text-xs"><?= esc($d['from_name']) ?></td>
                        <td class="text-xs"><?= esc($d['to_name']) ?></td>
                        <td><?= priorityBadge($d['priority']) ?></td>
                        <td><?= statusBadge($d['status']) ?></td>
                        <td class="text-xs text-gray-500"><?= formatDateShort($d['created_at']) ?></td>
                        <td><a href="<?= APP_URL ?>/disposition_view.php?id=<?= $d['id'] ?>" class="text-teal hover:text-brand text-xs font-semibold"><i class="fas fa-eye"></i></a></td>
                    </tr>
                    <?php endforeach; ?>
                    <?php if (empty($allDisps)): ?>
                    <tr><td colspan="7" class="text-center py-8 text-gray-400 text-sm">Tidak ada riwayat disposisi</td></tr>
                    <?php endif; ?>
                </tbody>
            </table>
        </div>
    </div>

</main>
</div>
<?php require_once 'includes/footer.php'; ?>