<?php
require_once 'config.php';
requireLogin();
$pageTitle = 'Dashboard';

// Set up hak akses dan filter berdasarkan role
$userId = (int)$_SESSION['user_id'];
$isAdmin = (isset($_SESSION['role']) && $_SESSION['role'] === 'admin');

// Filter query untuk user biasa (bukan admin)
$docFilter = $isAdmin ? "" : " AND (user_id = $userId OR recipient_id = $userId)";
$docAliasFilter = $isAdmin ? "" : " AND (d.user_id = $userId OR d.recipient_id = $userId)";
$dispFilter = $isAdmin ? "" : " AND (from_user_id = $userId OR to_user_id = $userId)";
$actAliasFilter = $isAdmin ? "" : " WHERE a.user_id = $userId";

// Statistik
$stmt = $pdo->query("SELECT COUNT(*) FROM documents WHERE 1=1 $docFilter"); $totalDocs = $stmt->fetchColumn();
$stmt = $pdo->query("SELECT COUNT(*) FROM documents WHERE status = 'signed' $docFilter"); $signedDocs = $stmt->fetchColumn();
$stmt = $pdo->query("SELECT COUNT(*) FROM documents WHERE status = 'draft' $docFilter"); $draftDocs = $stmt->fetchColumn();
$stmt = $pdo->query("SELECT COUNT(*) FROM dispositions WHERE status = 'pending' $dispFilter"); $pendingDisp = $stmt->fetchColumn();
$stmt = $pdo->prepare("SELECT COUNT(*) FROM dispositions WHERE to_user_id = ? AND status = 'pending'"); $stmt->execute([$userId]); $myPending = $stmt->fetchColumn();
$stmt = $pdo->query("SELECT COUNT(*) FROM users WHERE is_active = 1"); $totalUsers = $stmt->fetchColumn();
$stmt = $pdo->query("SELECT COUNT(*) FROM dispositions WHERE status = 'completed' $dispFilter"); $completedDisp = $stmt->fetchColumn();

// Surat per bulan (6 bulan terakhir)
$monthlyData = [];
for ($i = 5; $i >= 0; $i--) {
    $month = date('m', strtotime("-$i months"));
    $year = date('Y', strtotime("-$i months"));
    $stmt = $pdo->prepare("SELECT COUNT(*) FROM documents WHERE MONTH(created_at) = ? AND YEAR(created_at) = ? $docFilter");
    $stmt->execute([$month, $year]);
    $monthlyData[] = (int)$stmt->fetchColumn();
}

// Dokumen terbaru
$stmt = $pdo->prepare("SELECT d.*, u.name as uploader FROM documents d JOIN users u ON d.user_id = u.id WHERE 1=1 $docAliasFilter ORDER BY d.created_at DESC LIMIT 5");
$stmt->execute();
$recentDocs = $stmt->fetchAll();

// Activity terbaru
$stmt = $pdo->prepare("SELECT a.*, u.name FROM activity_logs a LEFT JOIN users u ON a.user_id = u.id $actAliasFilter ORDER BY a.created_at DESC LIMIT 8");
$stmt->execute();
$recentActivities = $stmt->fetchAll();

// Disposisi terbaru untuk user (Selalu difilter untuk user yang sedang login)
$stmt = $pdo->prepare("SELECT d.*, doc.title, u.name as from_name FROM dispositions d JOIN documents doc ON d.document_id = doc.id JOIN users u ON d.from_user_id = u.id WHERE d.to_user_id = ? ORDER BY d.created_at DESC LIMIT 5");
$stmt->execute([$userId]);
$myDispositions = $stmt->fetchAll();

require_once 'includes/header.php';
require_once 'includes/sidebar.php';
?>

<!-- Content -->
<div class="lg:ml-64 pt-14 min-h-screen">
<main class="p-4 md:p-6 lg:p-8">

    <!-- Welcome Banner -->
    <div class="bg-gradient-to-r from-brand to-teal-600 rounded-2xl p-6 md:p-8 mb-6 text-white relative overflow-hidden">
        <div class="absolute right-0 top-0 w-64 h-64 bg-white/5 rounded-full -translate-y-1/2 translate-x-1/4"></div>
        <div class="absolute right-20 bottom-0 w-32 h-32 bg-white/5 rounded-full translate-y-1/2"></div>
        <div class="relative">
            <h2 class="text-2xl md:text-3xl font-black">Selamat Datang, <?= esc($_SESSION['name']) ?></h2>
            <p class="text-white/70 mt-1 text-sm"><?= esc(COMPANY_NAME) ?> — <?= esc(APP_SUBTITLE) ?></p>
            <?php if ($myPending > 0): ?>
            <div class="mt-4 inline-flex items-center gap-2 bg-white/15 backdrop-blur rounded-lg px-4 py-2 text-sm font-semibold">
                <i class="fas fa-bell"></i>
                Anda memiliki <?= $myPending ?> disposisi menunggu
                <a href="<?= APP_URL ?>/disposition_inbox.php" class="underline ml-1">Lihat</a>
            </div>
            <?php endif; ?>
        </div>
    </div>

    <!-- Stats Cards -->
    <div class="grid grid-cols-2 md:grid-cols-3 lg:grid-cols-6 gap-4 mb-6">
        <div class="stat-card bg-white shadow-sm border border-gray-100">
            <div class="w-10 h-10 rounded-xl bg-blue-50 flex items-center justify-center mb-3">
                <i class="fas fa-folder-open text-blue-500"></i>
            </div>
            <p class="text-2xl font-black text-gray-900"><?= $totalDocs ?></p>
            <p class="text-xs text-gray-500 font-medium">Total Dokumen</p>
        </div>
        <div class="stat-card bg-white shadow-sm border border-gray-100">
            <div class="w-10 h-10 rounded-xl bg-amber-50 flex items-center justify-center mb-3">
                <i class="fas fa-file-alt text-amber-500"></i>
            </div>
            <p class="text-2xl font-black text-gray-900"><?= $draftDocs ?></p>
            <p class="text-xs text-gray-500 font-medium">Draft</p>
        </div>
        <div class="stat-card bg-white shadow-sm border border-gray-100">
            <div class="w-10 h-10 rounded-xl bg-emerald-50 flex items-center justify-center mb-3">
                <i class="fas fa-signature text-emerald-500"></i>
            </div>
            <p class="text-2xl font-black text-gray-900"><?= $signedDocs ?></p>
            <p class="text-xs text-gray-500 font-medium">Ditandatangani</p>
        </div>
        <div class="stat-card bg-white shadow-sm border border-gray-100">
            <div class="w-10 h-10 rounded-xl bg-orange-50 flex items-center justify-center mb-3">
                <i class="fas fa-paper-plane text-orange-500"></i>
            </div>
            <p class="text-2xl font-black text-gray-900"><?= $pendingDisp ?></p>
            <p class="text-xs text-gray-500 font-medium">Disposisi Pending</p>
        </div>
        <div class="stat-card bg-white shadow-sm border border-gray-100">
            <div class="w-10 h-10 rounded-xl bg-teal-50 flex items-center justify-center mb-3">
                <i class="fas fa-check-double text-teal-500"></i>
            </div>
            <p class="text-2xl font-black text-gray-900"><?= $completedDisp ?></p>
            <p class="text-xs text-gray-500 font-medium">Disposisi Selesai</p>
        </div>
        <div class="stat-card bg-white shadow-sm border border-gray-100">
            <div class="w-10 h-10 rounded-xl bg-purple-50 flex items-center justify-center mb-3">
                <i class="fas fa-users text-purple-500"></i>
            </div>
            <p class="text-2xl font-black text-gray-900"><?= $totalUsers ?></p>
            <p class="text-xs text-gray-500 font-medium">Pengguna</p>
        </div>
    </div>

    <!-- Charts & Tables -->
    <div class="grid lg:grid-cols-3 gap-6 mb-6">
        <!-- Chart -->
        <div class="lg:col-span-2 bg-white rounded-2xl shadow-sm border border-gray-100 p-6">
            <h3 class="font-bold text-gray-800 text-sm mb-4"><i class="fas fa-chart-bar text-brand mr-2"></i>Dokumen 6 Bulan Terakhir</h3>
            <canvas id="monthlyChart" height="200"></canvas>
        </div>

        <!-- Dokumen Terbaru -->
        <div class="bg-white rounded-2xl shadow-sm border border-gray-100 p-6">
            <h3 class="font-bold text-gray-800 text-sm mb-4"><i class="fas fa-clock text-brand mr-2"></i>Dokumen Terbaru</h3>
            <div class="space-y-3">
                <?php foreach ($recentDocs as $doc): ?>
                <a href="<?= APP_URL ?>/document_view.php?id=<?= $doc['id'] ?>" class="block p-3 rounded-xl hover:bg-gray-50 transition-colors border border-gray-50">
                    <p class="text-xs font-semibold text-gray-800 truncate"><?= esc($doc['title']) ?></p>
                    <div class="flex items-center justify-between mt-1">
                        <span class="text-[10px] text-gray-400"><?= esc($doc['uploader']) ?></span>
                        <?= statusBadge($doc['status']) ?>
                    </div>
                </a>
                <?php endforeach; ?>
                <?php if (empty($recentDocs)): ?>
                <p class="text-gray-400 text-xs text-center py-4">Belum ada dokumen</p>
                <?php endif; ?>
            </div>
        </div>
    </div>

    <div class="grid lg:grid-cols-2 gap-6">
        <!-- Disposisi untuk Saya -->
        <div class="bg-white rounded-2xl shadow-sm border border-gray-100 p-6">
            <h3 class="font-bold text-gray-800 text-sm mb-4"><i class="fas fa-inbox text-teal mr-2"></i>Disposisi Masuk</h3>
            <div class="space-y-3">
                <?php foreach ($myDispositions as $disp): ?>
                <a href="<?= APP_URL ?>/disposition_view.php?id=<?= $disp['id'] ?>" class="block p-3 rounded-xl hover:bg-gray-50 transition-colors border border-gray-50">
                    <p class="text-xs font-semibold text-gray-800 truncate"><?= esc($disp['title']) ?></p>
                    <div class="flex items-center justify-between mt-1">
                        <span class="text-[10px] text-gray-400">Dari: <?= esc($disp['from_name']) ?></span>
                        <div class="flex items-center gap-2">
                            <?= priorityBadge($disp['priority']) ?>
                            <?= statusBadge($disp['status']) ?>
                        </div>
                    </div>
                </a>
                <?php endforeach; ?>
                <?php if (empty($myDispositions)): ?>
                <p class="text-gray-400 text-xs text-center py-4">Tidak ada disposisi masuk</p>
                <?php endif; ?>
            </div>
        </div>

        <!-- Activity Timeline -->
        <div class="bg-white rounded-2xl shadow-sm border border-gray-100 p-6">
            <h3 class="font-bold text-gray-800 text-sm mb-4"><i class="fas fa-stream text-brand mr-2"></i>Activity Timeline</h3>
            <div class="space-y-0">
                <?php foreach ($recentActivities as $i => $act): ?>
                <div class="relative pl-10 pb-4 timeline-item">
                    <div class="absolute left-0 top-0 w-8 h-8 rounded-full bg-gray-50 flex items-center justify-center text-xs z-10 border-2 border-white">
                        <i class="fas fa-circle text-[6px] text-teal"></i>
                    </div>
                    <div>
                        <p class="text-xs font-semibold text-gray-700"><?= esc($act['description'] ?? $act['action']) ?></p>
                        <p class="text-[10px] text-gray-400 mt-0.5"><?= esc($act['name']) ?> — <?= formatDateShort($act['created_at']) ?></p>
                    </div>
                </div>
                <?php endforeach; ?>
            </div>
        </div>
    </div>

</main>
</div>

<script src="https://cdn.jsdelivr.net/npm/chart.js@4"></script>
<script>
new Chart(document.getElementById('monthlyChart'), {
    type: 'bar',
    data: {
        labels: [<?php for ($i = 5; $i >= 0; $i--) echo "'" . date('M Y', strtotime("-$i months")) . "'" . ($i > 0 ? ',' : ''); ?>],
        datasets: [{
            label: 'Dokumen',
            data: [<?= implode(',', $monthlyData) ?>],
            backgroundColor: 'rgba(13,148,136,0.15)',
            borderColor: '#0d9488',
            borderWidth: 2,
            borderRadius: 8,
            borderSkipped: false,
        }]
    },
    options: {
        responsive: true,
        plugins: { legend: { display: false } },
        scales: {
            y: { beginAtZero: true, ticks: { stepSize: 1 } },
            x: { grid: { display: false } }
        }
    }
});
</script>
<?php require_once 'includes/footer.php'; ?>