<?php
require_once 'config.php';
$pageTitle = 'Verifikasi Dokumen';

$token = $_GET['token'] ?? '';
$doc = null;
$signatures = [];
$verified = false;
$searchMode = !$token;

// Jika ada token, cek verifikasi
if ($token) {
    $stmt = $pdo->prepare("SELECT d.*, u.name as uploader FROM documents d JOIN users u ON d.user_id = u.id WHERE d.verification_token = ?");
    $stmt->execute([$token]);
    $doc = $stmt->fetch();

    if ($doc) {
        $verified = ($doc['status'] === 'signed');
        $stmt = $pdo->prepare("SELECT s.*, u.name, u.position FROM signatures s JOIN users u ON s.user_id = u.id WHERE s.document_id = ? AND s.status = 'signed' ORDER BY s.signed_at");
        $stmt->execute([$doc['id']]);
        $signatures = $stmt->fetchAll();
    }
}

// Handle search by doc number
if ($_SERVER['REQUEST_METHOD'] === 'POST' && isset($_POST['search_token'])) {
    $searchToken = trim($_POST['search_token']);
    header('Location: ' . APP_URL . '/verification.php?token=' . urlencode($searchToken));
    exit;
}
?>
<!DOCTYPE html>
<html lang="id">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Verifikasi Dokumen — <?= esc(APP_NAME) ?></title>
    <script src="https://cdn.tailwindcss.com"></script>
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.5.1/css/all.min.css">
    <link href="https://fonts.googleapis.com/css2?family=Plus+Jakarta+Sans:wght@300;400;500;600;700;800;900&display=swap" rel="stylesheet">
    <style>body { font-family: 'Plus Jakarta Sans', sans-serif; }</style>
</head>
<body class="bg-gray-50 min-h-screen">
    <!-- Header -->
    <header class="bg-white border-b border-gray-200 py-4 px-6">
        <div class="max-w-4xl mx-auto flex items-center justify-between">
            <div class="flex items-center gap-3">
                <div class="w-10 h-10 rounded-lg bg-gradient-to-br from-teal-500 to-emerald-400 flex items-center justify-center">
                    <span class="text-white font-black text-sm"><?= APP_LOGO_TEXT ?></span>
                </div>
                <div>
                    <h1 class="text-sm font-bold text-gray-800"><?= esc(APP_NAME) ?></h1>
                    <p class="text-[10px] text-gray-400">Verifikasi Keaslian Dokumen</p>
                </div>
            </div>
            <a href="<?= APP_URL ?>/index.php" class="text-xs text-gray-500 hover:text-brand"><i class="fas fa-sign-in-alt mr-1"></i>Login</a>
        </div>
    </header>

    <main class="max-w-4xl mx-auto py-8 px-4">
        <?php if ($searchMode && !$doc): ?>
        <!-- Search Form -->
        <div class="text-center mb-8">
            <div class="w-20 h-20 rounded-full bg-teal-50 flex items-center justify-center mx-auto mb-4">
                <i class="fas fa-shield-alt text-3xl text-teal"></i>
            </div>
            <h2 class="text-2xl font-black text-gray-900">Verifikasi Dokumen Digital</h2>
            <p class="text-gray-500 text-sm mt-1">Masukkan token verifikasi untuk memeriksa keaslian dokumen</p>
        </div>

        <form method="POST" action="" class="max-w-md mx-auto">
            <div class="flex gap-2">
                <input type="text" name="search_token" placeholder="Masukkan token verifikasi" required
                    class="flex-1 border border-gray-200 rounded-lg px-4 py-3 text-sm focus:ring-2 focus:ring-teal outline-none" value="<?= esc($token) ?>">
                <button type="submit" class="btn-primary px-6"><i class="fas fa-search"></i></button>
            </div>
        </form>
        <?php endif; ?>

        <?php if ($token && !$doc): ?>
        <!-- Not Found -->
        <div class="text-center py-12">
            <div class="w-20 h-20 rounded-full bg-red-50 flex items-center justify-center mx-auto mb-4">
                <i class="fas fa-times-circle text-3xl text-red-400"></i>
            </div>
            <h2 class="text-xl font-black text-gray-900">Dokumen Tidak Ditemukan</h2>
            <p class="text-gray-500 text-sm mt-1">Token verifikasi tidak valid atau dokumen tidak terdaftar</p>
            <a href="<?= APP_URL ?>/verification.php" class="btn-primary mt-4 inline-flex"><i class="fas fa-arrow-left"></i>Coba Lagi</a>
        </div>
        <?php endif; ?>

        <?php if ($doc): ?>
        <!-- Verification Result -->
        <div class="text-center mb-6">
            <div class="w-20 h-20 rounded-full <?= $verified ? 'bg-emerald-50' : 'bg-amber-50' ?> flex items-center justify-center mx-auto mb-4">
                <i class="fas fa-<?= $verified ? 'check-circle' : 'hourglass-half' ?> text-3xl <?= $verified ? 'text-emerald-500' : 'text-amber-500' ?>"></i>
            </div>
            <h2 class="text-xl font-black text-gray-900"><?= $verified ? 'Dokumen Terverifikasi' : 'Dokumen Belum Selesai' ?></h2>
            <p class="text-sm <?= $verified ? 'text-emerald-600' : 'text-amber-600' ?> font-semibold mt-1">
                <?= $verified ? 'Dokumen ini telah ditandatangani secara digital dan sah' : 'Dokumen ini masih dalam proses' ?>
            </p>
        </div>

        <div class="bg-white rounded-2xl shadow-sm border border-gray-100 p-6 space-y-4">
            <div class="grid md:grid-cols-2 gap-4">
                <div class="p-4 bg-gray-50 rounded-xl">
                    <p class="text-[10px] text-gray-400 uppercase font-bold">No. Dokumen</p>
                    <p class="text-sm font-bold text-gray-800 font-mono"><?= esc($doc['document_number']) ?></p>
                </div>
                <div class="p-4 bg-gray-50 rounded-xl">
                    <p class="text-[10px] text-gray-400 uppercase font-bold">Judul</p>
                    <p class="text-sm font-bold text-gray-800"><?= esc($doc['title']) ?></p>
                </div>
                <div class="p-4 bg-gray-50 rounded-xl">
                    <p class="text-[10px] text-gray-400 uppercase font-bold">Diupload oleh</p>
                    <p class="text-sm font-bold text-gray-800"><?= esc($doc['uploader']) ?></p>
                </div>
                <div class="p-4 bg-gray-50 rounded-xl">
                    <p class="text-[10px] text-gray-400 uppercase font-bold">Status</p>
                    <?= statusBadge($doc['status']) ?>
                </div>
            </div>

            <!-- Signers -->
            <?php if ($signatures): ?>
            <div>
                <p class="text-xs font-bold text-gray-600 mb-2">Penandatangan:</p>
                <div class="space-y-2">
                    <?php foreach ($signatures as $sig): ?>
                    <div class="flex items-center gap-3 p-3 bg-emerald-50 rounded-xl">
                        <div class="w-10 h-10 bg-white rounded-lg border flex items-center justify-center overflow-hidden">
                            <?php if ($sig['signature_data']): ?>
                            <img src="<?= esc($sig['signature_data']) ?>" class="w-full h-full object-contain" alt="TTD">
                            <?php endif; ?>
                        </div>
                        <div class="flex-1">
                            <p class="text-xs font-bold text-gray-800"><?= esc($sig['name']) ?></p>
                            <p class="text-[10px] text-gray-400"><?= esc($sig['position']) ?> · <?= formatDateShort($sig['signed_at']) ?></p>
                        </div>
                        <i class="fas fa-check-circle text-emerald-500"></i>
                    </div>
                    <?php endforeach; ?>
                </div>
            </div>
            <?php endif; ?>

            <!-- Hash -->
            <?php if ($doc['verification_hash']): ?>
            <div class="p-4 bg-gray-50 rounded-xl">
                <p class="text-[10px] text-gray-400 uppercase font-bold mb-1">Hash SHA-256</p>
                <code class="text-[10px] break-all text-gray-600"><?= esc($doc['verification_hash']) ?></code>
            </div>
            <?php endif; ?>

            <!-- Verification Footer -->
            <div class="p-3 bg-brand rounded-xl text-white text-center">
                <p class="text-xs font-semibold">Dokumen ini telah ditandatangani secara digital menggunakan <?= esc(APP_NAME) ?></p>
                <p class="text-[10px] text-white/60 mt-0.5"><?= esc(COMPANY_NAME) ?> · <?= esc(COMPANY_WEBSITE) ?></p>
            </div>
        </div>
        <?php endif; ?>
    </main>

    <footer class="py-4 text-center text-gray-400 text-xs border-t mt-8">
        &copy; <?= date('Y') ?> <?= esc(COMPANY_NAME) ?> — <?= esc(APP_NAME) ?> v<?= APP_VERSION ?>
    </footer>
</body>
</html>