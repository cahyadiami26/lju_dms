<?php
require_once 'config.php';
requireLogin();
$pageTitle = 'Detail Dokumen';

$id = (int)($_GET['id'] ?? 0);
$currentUserId = (int)$_SESSION['user_id'];

// Ambil data user yang sedang login untuk memeriksa divisi dan role
$stmtUser = $pdo->prepare("SELECT division, role FROM users WHERE id = ?");
$stmtUser->execute([$currentUserId]);
$currentUser = $stmtUser->fetch();

$userDivision  = strtolower(trim($currentUser['division'] ?? ''));
$userRole      = strtolower(trim($currentUser['role'] ?? ''));
$isSecretariat = ($userDivision === 'kesekretariatan' || $userRole === 'op-arsip');

if (!$isUploader && !$isRecipient && !$isAdmin && !$isSecretariat) {
    header('Location: ' . APP_URL . '/documents.php');
    exit;
}

// Handle aksi Tandai Sudah Dibaca
if (isset($_POST['action']) && $_POST['action'] === 'mark_completed') {
    $stmtUpdate = $pdo->prepare("UPDATE documents SET status = 'completed' WHERE id = ?");
    $stmtUpdate->execute([$id]);
    header('Location: ' . APP_URL . '/document_view.php?id=' . $id);
    exit;
}

$stmt = $pdo->prepare("SELECT d.*, u.name as uploader, u.position as uploader_pos FROM documents d JOIN users u ON d.user_id = u.id WHERE d.id = ?");
$stmt->execute([$id]);
$doc = $stmt->fetch();

if (!$doc) { header('Location: ' . APP_URL . '/documents.php'); exit; }

// Dispositions
$stmt = $pdo->prepare("SELECT d.*, u1.name as from_name, u1.position as from_pos, u2.name as to_name, u2.position as to_pos FROM dispositions d JOIN users u1 ON d.from_user_id = u1.id JOIN users u2 ON d.to_user_id = u2.id WHERE d.document_id = ? ORDER BY d.created_at");
$stmt->execute([$id]);
$dispositions = $stmt->fetchAll();

require_once 'includes/header.php';
require_once 'includes/sidebar.php';
?>

<div class="lg:ml-64 pt-14 min-h-screen">
<main class="p-4 md:p-6 lg:p-8">

    <!-- Back -->
    <a href="<?= APP_URL ?>/documents.php" class="inline-flex items-center gap-2 text-sm text-gray-500 hover:text-brand mb-4"><i class="fas fa-arrow-left"></i> Kembali ke Daftar</a>

    <div class="grid lg:grid-cols-3 gap-6">
        <!-- Main Info -->
        <div class="lg:col-span-2 space-y-6">
            <div class="bg-white rounded-2xl shadow-sm border border-gray-100 p-6">
                <div class="flex items-start justify-between gap-4 mb-4">
                    <div>
                        <h2 class="text-lg font-black text-gray-900"><?= esc($doc['title']) ?></h2>
                        <p class="text-xs text-gray-400 mt-1 font-mono"><?= esc($doc['document_number']) ?></p>
                    </div>
                    <?= statusBadge($doc['status']) ?>
                </div>

                <div class="grid grid-cols-2 md:grid-cols-4 gap-4 p-4 bg-gray-50 rounded-xl mb-4">
                    <div><p class="text-[10px] text-gray-400 uppercase font-bold">Jenis</p><p class="text-sm font-semibold text-gray-700"><?= ucwords(str_replace('_',' ',$doc['document_type'])) ?></p></div>
                    <div><p class="text-[10px] text-gray-400 uppercase font-bold">Prioritas</p><?= priorityBadge($doc['priority']) ?></div>
                    <div><p class="text-[10px] text-gray-400 uppercase font-bold">Sifat</p><p class="text-sm font-semibold text-gray-700"><?= ucwords(str_replace('_',' ',$doc['nature'])) ?></p></div>
                    <div><p class="text-[10px] text-gray-400 uppercase font-bold">Diupload</p><p class="text-sm font-semibold text-gray-700"><?= formatDateShort($doc['created_at']) ?></p></div>
                </div>

                <?php if ($doc['sender']): ?><p class="text-sm"><span class="text-gray-400">Pengirim:</span> <span class="font-semibold"><?= esc($doc['sender']) ?></span></p><?php endif; ?>
                <?php if ($doc['mail_number']): ?><p class="text-sm"><span class="text-gray-400">No. Surat:</span> <span class="font-semibold"><?= esc($doc['mail_number']) ?></span></p><?php endif; ?>
                <?php if ($doc['description']): ?><p class="text-sm text-gray-600 mt-2"><?= esc($doc['description']) ?></p><?php endif; ?>

                <?php if ($doc['tags']): ?>
                <div class="flex flex-wrap gap-1 mt-3">
                    <?php foreach (explode(',', $doc['tags']) as $tag): ?>
                    <span class="bg-teal-50 text-teal-700 text-xs px-2 py-0.5 rounded-md font-medium"><?= esc(trim($tag)) ?></span>
                    <?php endforeach; ?>
                </div>
                <?php endif; ?>
            </div>

            <!-- Document Preview -->
            <div class="bg-white rounded-2xl shadow-sm border border-gray-100 p-6">
                <h3 class="font-bold text-gray-800 text-sm mb-4"><i class="fas fa-eye text-brand mr-2"></i>Preview Dokumen</h3>
                <?php 
                if (file_exists($doc['file_path'])) {
                    $relativePath = $doc['file_path'];
                    if (strpos($relativePath, 'uploads/') !== false) {
                        $relativePath = substr($relativePath, strpos($relativePath, 'uploads/'));
                    }
                    $fileExtension = strtolower(pathinfo($doc['file_path'], PATHINFO_EXTENSION));
                } else {
                    $relativePath = '';
                    $fileExtension = '';
                }
                ?>

                <?php if (!empty($relativePath)): ?>
                    <?php if (in_array($fileExtension, ['jpg', 'jpeg', 'png', 'gif', 'webp'])): ?>
                        <div class="rounded-xl border border-gray-100 bg-gray-50 p-2 overflow-hidden flex justify-center">
                            <img src="<?= APP_URL ?>/<?= htmlspecialchars($relativePath) ?>" alt="Preview Dokumen" class="max-h-[500px] w-auto object-contain rounded-lg bg-white">
                        </div>
                    <?php elseif ($fileExtension === 'pdf'): ?>
                        <div class="rounded-xl border border-gray-100 bg-gray-50 overflow-hidden">
                            <iframe src="<?= APP_URL ?>/<?= htmlspecialchars($relativePath) ?>" class="w-full h-[500px]" frameborder="0"></iframe>
                        </div>
                    <?php else: ?>
                        <div class="text-center py-8 text-gray-400 text-sm bg-gray-50 rounded-xl">
                            <i class="fas fa-file-alt text-3xl mb-2 text-gray-300"></i>
                            <p>Preview tidak tersedia untuk format file ini (.<?= esc($fileExtension) ?>)</p>
                        </div>
                    <?php endif; ?>
                <?php else: ?>
                    <p class="text-gray-400 text-sm text-center py-4">File dokumen tidak ditemukan</p>
                <?php endif; ?>
            </div>
        </div>

        <!-- Sidebar Actions -->
        <div class="space-y-4">
            <div class="bg-white rounded-2xl shadow-sm border border-gray-100 p-6">
                <h3 class="font-bold text-gray-800 text-sm mb-4">Aksi</h3>
                <div class="space-y-2">
                    
                    <a href="<?= APP_URL ?>/disposition_create.php?doc_id=<?= $doc['id'] ?>" class="btn-outline w-full justify-center"><i class="fas fa-paper-plane"></i> Buat Disposisi</a>
                    <?php if ($doc['status'] === 'draft'): ?>
                    <!-- Tombol Tandai Sudah Dibaca -->
                        <form method="POST" class="w-full">
                            <input type="hidden" name="action" value="mark_completed">
                            <button type="submit" class="btn-outline w-full justify-center text-emerald-600 hover:text-emerald-700 hover:border-emerald-200">
                                <i class="fas fa-check-circle"></i> Tandai Sudah Dibaca
                            </button>
                        </form>
                    <?php endif; ?>
                    <?php if (file_exists($doc['file_path'])): ?>
                        <?php
                        $relativePath = $doc['file_path'];
                        if (strpos($relativePath, 'uploads/') !== false) {
                            $relativePath = substr($relativePath, strpos($relativePath, 'uploads/'));
                        }
                        ?>
                        <a href="<?= APP_URL ?>/<?= htmlspecialchars($relativePath) ?>" class="btn-outline w-full justify-center" download><i class="fas fa-download"></i> Download Asli</a>
                    <?php endif; ?>
                    <?php if ($doc['status'] === 'signed' || $doc['signed_pdf_path']): ?>
                    <a href="<?= APP_URL ?>/generate_certificate.php?id=<?= $doc['id'] ?>" class="btn-outline w-full justify-center" target="_blank"><i class="fas fa-certificate"></i> Download Sertifikat</a>
                    <?php endif; ?>
                    <?php if ($doc['status'] === 'signed' && !empty($doc['verification_token'])): ?>
                    <a href="<?= APP_URL ?>/generate_mini_certificate.php?id=<?= $doc['id'] ?>" class="btn-outline w-full justify-center">
                        <i class="fas fa-id-card"></i> Download Mini Certificate
                    </a>
                    <?php endif; ?>
                    <?php if ($doc['verification_token']): ?>
                    <a href="<?= APP_URL ?>/verification.php?token=<?= $doc['verification_token'] ?>" class="btn-outline w-full justify-center" target="_blank"><i class="fas fa-shield-alt"></i> Verifikasi</a>
                    <?php endif; ?>
                </div>
            </div>

            <?php if ($doc['status'] === 'signed' && !empty($doc['verification_token'])): ?>
            <!-- Mini Certificate -->
            <div class="bg-white rounded-2xl shadow-sm border border-gray-100 p-6">
                <div class="flex items-center justify-between gap-3 mb-3">
                    <div>
                        <h3 class="font-bold text-gray-800 text-sm">Mini Certificate</h3>
                        <p class="text-[10px] text-gray-400 mt-0.5">Bukti tanda tangan digital</p>
                    </div>
                    <span class="inline-flex items-center gap-1 px-2 py-1 rounded-full bg-emerald-50 text-emerald-700 text-[10px] font-semibold">
                        <i class="fas fa-check-circle"></i> SIGNED
                    </span>
                </div>

                <div class="rounded-xl border border-gray-100 bg-gray-50 p-2 overflow-hidden">
                    <img
                        src="<?= APP_URL ?>/generate_mini_certificate.php?id=<?= (int)$doc['id'] ?>&output=inline"
                        alt="Mini Certificate <?= esc($doc['document_number']) ?>"
                        class="block w-full h-auto rounded-lg bg-white"
                        loading="lazy"
                    >
                </div>

                <div class="mt-3 flex gap-2">
                    <a
                        href="<?= APP_URL ?>/generate_mini_certificate.php?id=<?= (int)$doc['id'] ?>"
                        class="btn-primary flex-1 justify-center"
                    >
                        <i class="fas fa-download"></i> Download PNG
                    </a>
                    <a
                        href="<?= APP_URL ?>/generate_mini_certificate.php?id=<?= (int)$doc['id'] ?>&output=inline"
                        target="_blank"
                        rel="noopener"
                        class="btn-outline px-3 justify-center"
                        title="Buka ukuran penuh"
                    >
                        <i class="fas fa-expand"></i>
                    </a>
                </div>

                <p class="text-[10px] text-gray-400 leading-relaxed mt-3">
                    Mini certificate dapat ditempel pada dokumen asli. QR Code mengarah ke halaman verifikasi dokumen.
                </p>
            </div>
            <?php endif; ?>

            <!-- File Info -->
            <div class="bg-white rounded-2xl shadow-sm border border-gray-100 p-6">
                <h3 class="font-bold text-gray-800 text-sm mb-3">Info File</h3>
                <div class="space-y-2 text-xs">
                    <div class="flex justify-between"><span class="text-gray-400">Format</span><span class="font-semibold uppercase"><?= esc($doc['file_type']) ?></span></div>
                    <div class="flex justify-between"><span class="text-gray-400">Ukuran</span><span class="font-semibold"><?= number_format($doc['file_size'] / 1024, 1) ?> KB</span></div>
                    <div class="flex justify-between"><span class="text-gray-400">Diupload oleh</span><span class="font-semibold"><?= esc($doc['uploader']) ?></span></div>
                    <?php if ($doc['verification_hash']): ?>
                    <div class="pt-2 border-t"><span class="text-gray-400 block mb-1">Hash SHA-256</span><code class="text-[9px] break-all text-gray-600 bg-gray-50 p-1.5 rounded block"><?= esc($doc['verification_hash']) ?></code></div>
                    <?php endif; ?>
                </div>
            </div>

            <!-- Disposition History (Pindah ke Sidebar Bawah Info File) -->
            <div class="bg-white rounded-2xl shadow-sm border border-gray-100 p-6">
                <h3 class="font-bold text-gray-800 text-sm mb-4"><i class="fas fa-exchange-alt text-brand mr-2"></i>Riwayat Disposisi</h3>
                <?php if ($dispositions): ?>
                <div class="space-y-3">
                    <?php foreach ($dispositions as $disp): ?>
                    <div class="p-3 bg-gray-50 rounded-xl">
                        <div class="flex items-center justify-between mb-1">
                            <span class="text-xs font-semibold text-gray-700"><?= esc($disp['from_name']) ?> <i class="fas fa-arrow-right text-gray-300 mx-1"></i> <?= esc($disp['to_name']) ?></span>
                            <?= statusBadge($disp['status']) ?>
                        </div>
                        <p class="text-[10px] text-gray-400"><?= formatDateShort($disp['created_at']) ?></p>
                        <?php if ($disp['notes']): ?><p class="text-xs text-gray-500 mt-1 italic">"<?= esc($disp['notes']) ?>"</p><?php endif; ?>
                    </div>
                    <?php endforeach; ?>
                </div>
                <?php else: ?>
                <p class="text-gray-400 text-sm text-center py-4">Belum ada disposisi</p>
                <?php endif; ?>
            </div>
        </div>
    </div>

</main>
</div>
<?php require_once 'includes/footer.php'; ?>