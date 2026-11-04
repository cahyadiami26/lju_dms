<?php
require_once 'config.php';
requireLogin();
$pageTitle = 'Detail Nota Dinas';

$id = (int)($_GET['id'] ?? 0);

// Izinkan Pengirim ATAU Penerima untuk melihat detail
$stmt = $pdo->prepare("
    SELECT nd.*,
           u1.name as from_name, u1.position as from_pos, u1.division as from_div,
           u2.name as to_name, u2.position as to_pos, u2.division as to_div
    FROM nota_dinas nd
    JOIN users u1 ON nd.from_user_id = u1.id
    JOIN users u2 ON nd.to_user_id = u2.id
    WHERE nd.id = ? AND (nd.to_user_id = ? OR nd.from_user_id = ? OR ? = 'admin')
");
$stmt->execute([$id, $_SESSION['user_id'], $_SESSION['user_id'], $_SESSION['role']]);
$nota = $stmt->fetch();

if (!$nota) {
    header('Location: ' . APP_URL . '/notadinas_inbox.php');
    exit;
}

// Handle Form Action Update Status oleh Penerima
if ($_SERVER['REQUEST_METHOD'] === 'POST' && $nota['to_user_id'] == $_SESSION['user_id']) {
    $action = $_POST['action'] ?? '';

    if ($action === 'process') {
        $stmt = $pdo->prepare("UPDATE nota_dinas SET status = 'processed' WHERE id = ?");
        $stmt->execute([$id]);
        logActivity($_SESSION['user_id'], 'process_nota_dinas', "Memproses Nota Dinas #$id", null);
    } elseif ($action === 'complete') {
        $stmt = $pdo->prepare("UPDATE nota_dinas SET status = 'complete', completed_at = NOW() WHERE id = ?");
        $stmt->execute([$id]);
        logActivity($_SESSION['user_id'], 'complete_nota_dinas', "Menyelesaikan Nota Dinas #$id", null);
    }

    header('Location: ' . APP_URL . "/notadinas_view.php?id=$id&msg=updated");
    exit;
}

require_once 'includes/header.php';
require_once 'includes/sidebar.php';
?>

<div class="lg:ml-64 pt-14 min-h-screen">
<main class="p-4 md:p-6 lg:p-8">

    <?php if (($_GET['msg'] ?? '') === 'updated'): ?>
        <script>showToast('Status nota dinas berhasil diperbarui', 'success');</script>
    <?php endif; ?>

    <a href="<?= APP_URL ?>/notadinas_inbox.php" class="inline-flex items-center gap-2 text-sm text-gray-500 hover:text-brand mb-4">
        <i class="fas fa-arrow-left"></i> Kembali ke Daftar
    </a>

    <div class="grid lg:grid-cols-3 gap-6">
        <!-- Main Content -->
        <div class="lg:col-span-2 space-y-6">
            <div class="bg-white rounded-2xl shadow-sm border border-gray-100 p-6">
                <div class="flex items-center justify-between mb-4">
                    <h2 class="text-lg font-black text-gray-900">Detail Nota Dinas</h2>
                    <?php
                    $badgeClasses = [
                        'created'   => 'bg-gray-100 text-gray-700',
                        'sent'      => 'bg-blue-100 text-blue-700',
                        'processed' => 'bg-amber-100 text-amber-700',
                        'complete'  => 'bg-emerald-100 text-emerald-700'
                    ];
                    $statusClass = $badgeClasses[$nota['status']] ?? 'bg-gray-100 text-gray-700';
                    ?>
                    <span class="px-3 py-1 rounded-full text-xs font-bold uppercase tracking-wider <?= $statusClass ?>">
                        <?= esc($nota['status']) ?>
                    </span>
                </div>

                <!-- Metadata -->
                <div class="grid grid-cols-2 gap-4 p-4 bg-gray-50 rounded-xl mb-4">
                    <div>
                        <p class="text-[10px] text-gray-400 uppercase font-bold">Pengirim</p>
                        <p class="text-sm font-semibold text-gray-800"><?= esc($nota['from_name']) ?></p>
                        <p class="text-[10px] text-gray-500"><?= esc($nota['from_pos']) ?> - <?= esc($nota['from_div']) ?></p>
                    </div>
                    <div>
                        <p class="text-[10px] text-gray-400 uppercase font-bold">Penerima</p>
                        <p class="text-sm font-semibold text-gray-800"><?= esc($nota['to_name']) ?></p>
                        <p class="text-[10px] text-gray-500"><?= esc($nota['to_pos']) ?> - <?= esc($nota['to_div']) ?></p>
                    </div>
                    <div>
                        <p class="text-[10px] text-gray-400 uppercase font-bold">Nomor Nota Dinas</p>
                        <p class="text-xs font-mono font-bold text-gray-700"><?= esc($nota['nomor_nota_dinas']) ?></p>
                    </div>
                    <div>
                        <p class="text-[10px] text-gray-400 uppercase font-bold">Tanggal</p>
                        <p class="text-xs font-semibold text-gray-700"><?= date('d/m/Y', strtotime($nota['tanggal'])) ?></p>
                    </div>
                </div>

                <!-- Isi Perihal/Catatan -->
                <div class="mt-4">
                    <p class="text-xs font-semibold text-gray-600 mb-2">Isi Catatan / Perihal:</p>
                    <div class="p-4 bg-gray-50 rounded-xl border border-gray-100 text-sm text-gray-800 leading-relaxed prose max-w-none">
                        <?= $nota['perihal'] ?>
                    </div>
                </div>

                <!-- Tanda Tangan Digital Visual -->
                <?php if ($nota['signature_data']): ?>
                <div class="mt-6 pt-6 border-t border-gray-100 flex justify-end">
                    <div class="text-center w-48">
                        <p class="text-xs text-gray-500 mb-2">Tertanda,</p>
                        <img src="<?= $nota['signature_data'] ?>" alt="Signature" class="h-16 mx-auto object-contain bg-gray-50 p-1 border rounded-lg">
                        <p class="text-xs font-bold text-gray-800 mt-2"><?= esc($nota['from_name']) ?></p>
                        <p class="text-[10px] text-gray-400"><?= esc($nota['from_pos']) ?></p>
                    </div>
                </div>
                <?php endif; ?>
            </div>
        </div>

        <!-- Sidebar Aksi & Unduh -->
        <div class="space-y-4">
            <!-- Unduh PDF & QR Code -->
            <div class="bg-white rounded-2xl shadow-sm border border-gray-100 p-6 text-center">
                <h3 class="font-bold text-gray-800 text-sm mb-3">Dokumen & QR Code</h3>
                <a href="<?= APP_URL ?>/generate_notadinas_pdf.php?id=<?= $nota['id'] ?>" target="_blank" class="btn-primary w-full justify-center text-xs py-2.5 mb-4">
                    <i class="fas fa-file-pdf mr-1"></i> Cetak / Download PDF
                </a>
                
                <div class="border-t border-gray-100 pt-4">
                    <p class="text-[11px] text-gray-400 mb-2 font-semibold">QR Code Verifikasi Publik</p>
                    <?php 
                    $scanUrl = APP_URL . '/notadinas_scan.php?token=' . urlencode($nota['verification_token']); 
                    ?>
                    <img src="https://api.qrserver.com/v1/create-qr-code/?size=150x150&data=<?= urlencode($scanUrl) ?>" alt="QR Code" class="w-32 h-32 mx-auto border p-1 rounded-lg">
                    <a href="<?= $scanUrl ?>" target="_blank" class="block text-[10px] text-teal-600 hover:underline mt-2">Buka Halaman Verifikasi</a>
                </div>
            </div>

            <!-- Form Aksi Penerima -->
            <?php if ($nota['to_user_id'] == $_SESSION['user_id'] && $nota['status'] !== 'complete'): ?>
            <div class="bg-white rounded-2xl shadow-sm border border-gray-100 p-6">
                <h3 class="font-bold text-gray-800 text-sm mb-4"><i class="fas fa-hand-pointer text-brand mr-2"></i>Aksi Nota Dinas</h3>
                <form method="POST" action="" class="space-y-2">
                    <?php if ($nota['status'] === 'sent'): ?>
                    <button type="submit" name="action" value="process" class="w-full bg-amber-50 text-amber-700 py-2.5 rounded-lg text-xs font-bold hover:bg-amber-100 transition-colors">
                        <i class="fas fa-spinner mr-1"></i> Tandai Diproses
                    </button>
                    <?php endif; ?>

                    <?php if (in_array($nota['status'], ['sent', 'processed'])): ?>
                    <button type="submit" name="action" value="complete" class="w-full bg-emerald-50 text-emerald-700 py-2.5 rounded-lg text-xs font-bold hover:bg-emerald-100 transition-colors">
                        <i class="fas fa-check mr-1"></i> Tandai Selesai
                    </button>
                    <?php endif; ?>
                </form>
            </div>
            <?php endif; ?>
        </div>
    </div>

</main>
</div>

<?php require_once 'includes/footer.php'; ?>