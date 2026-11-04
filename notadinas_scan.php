<?php
require_once 'config.php';

// TIDAK MENGGUNAKAN requireLogin() agar bisa diakses publik tanpa login

$token = trim($_GET['token'] ?? '');
$id    = (int)($_GET['id'] ?? 0);

$nota = null;

if (!empty($token)) {
    $stmt = $pdo->prepare("
        SELECT nd.*, 
               u1.name as from_name, u1.position as from_pos, u1.division as from_div,
               u2.name as to_name, u2.position as to_pos, u2.division as to_div
        FROM nota_dinas nd
        JOIN users u1 ON nd.from_user_id = u1.id
        JOIN users u2 ON nd.to_user_id = u2.id
        WHERE nd.verification_token = ?
    ");
    $stmt->execute([$token]);
    $nota = $stmt->fetch();
} elseif ($id > 0) {
    $stmt = $pdo->prepare("
        SELECT nd.*, 
               u1.name as from_name, u1.position as from_pos, u1.division as from_div,
               u2.name as to_name, u2.position as to_pos, u2.division as to_div
        FROM nota_dinas nd
        JOIN users u1 ON nd.from_user_id = u1.id
        JOIN users u2 ON nd.to_user_id = u2.id
        WHERE nd.id = ?
    ");
    $stmt->execute([$id]);
    $nota = $stmt->fetch();
}

$pageTitle = 'Verifikasi Nota Dinas';
?>
<!DOCTYPE html>
<html lang="id">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title><?= esc($pageTitle) ?> - <?= APP_NAME ?></title>
    <script src="https://cdn.tailwindcss.com"></script>
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css">
    <style>
        body { background-color: #f8fafc; font-family: ui-sans-serif, system-ui, -apple-system, BlinkMacSystemFont, "Segoe UI", Roboto, "Helvetica Neue", Arial, sans-serif; }
    </style>
</head>
<body class="p-4 md:p-8 min-h-screen flex items-center justify-center">

    <div class="max-w-2xl w-full bg-white rounded-2xl shadow-xl border border-gray-100 overflow-hidden">
        <?php if ($nota): ?>
            <!-- Header Validasi -->
            <div class="bg-emerald-600 p-6 text-white text-center">
                <div class="w-16 h-16 bg-white/20 rounded-full flex items-center justify-center mx-auto mb-3 text-2xl backdrop-blur-sm">
                    <i class="fas fa-check-circle"></i>
                </div>
                <h1 class="text-xl font-black">Dokumen Nota Dinas Valid</h1>
                <p class="text-xs text-emerald-100 mt-1">Terverifikasi oleh Sistem Manajemen Dokumen <?= APP_NAME ?></p>
            </div>

            <div class="p-6 space-y-6">
                <!-- Metadata Dokumen -->
                <div class="grid grid-cols-2 gap-4 p-4 bg-gray-50 rounded-xl text-xs">
                    <div>
                        <p class="text-gray-400 font-bold uppercase">Nomor Nota Dinas</p>
                        <p class="font-mono font-bold text-gray-800 text-sm mt-0.5"><?= esc($nota['nomor_nota_dinas']) ?></p>
                    </div>
                    <div>
                        <p class="text-gray-400 font-bold uppercase">Tanggal Nota Dinas</p>
                        <p class="font-semibold text-gray-800 mt-0.5"><?= date('d/m/Y', strtotime($nota['tanggal'])) ?></p>
                    </div>
                    <div>
                        <p class="text-gray-400 font-bold uppercase">Pengirim</p>
                        <p class="font-semibold text-gray-800 mt-0.5"><?= esc($nota['from_name']) ?></p>
                        <p class="text-[10px] text-gray-500"><?= esc($nota['from_pos']) ?> - <?= esc($nota['from_div']) ?></p>
                    </div>
                    <div>
                        <p class="text-gray-400 font-bold uppercase">Penerima</p>
                        <p class="font-semibold text-gray-800 mt-0.5"><?= esc($nota['to_name']) ?></p>
                        <p class="text-[10px] text-gray-500"><?= esc($nota['to_pos']) ?> - <?= esc($nota['to_div']) ?></p>
                    </div>
                </div>

                <!-- Isi Perihal/Catatan -->
                <div>
                    <p class="text-xs font-semibold text-gray-600 mb-2">Isi Catatan / Perihal:</p>
                    <div class="p-4 bg-gray-50 rounded-xl border border-gray-100 text-sm text-gray-800 leading-relaxed prose max-w-none">
                        <?= $nota['perihal'] ?>
                    </div>
                </div>

                <!-- Visual Tanda Tangan -->
                <?php if (!empty($nota['signature_data'])): ?>
                <div class="pt-4 border-t border-gray-100 flex justify-between items-center">
                    <div>
                        <p class="text-[11px] text-gray-400">Status Dokumen:</p>
                        <span class="inline-block px-2.5 py-1 rounded-full text-[10px] font-bold uppercase tracking-wider bg-emerald-100 text-emerald-700 mt-1">
                            <?= esc($nota['status']) ?>
                        </span>
                    </div>
                    <div class="text-center w-48">
                        <p class="text-xs text-gray-400 mb-1">Tanda Tangan Digital</p>
                        <img src="<?= $nota['signature_data'] ?>" alt="Signature" class="h-16 mx-auto object-contain bg-white p-1 border rounded-lg">
                        <p class="text-xs font-bold text-gray-800 mt-1"><?= esc($nota['from_name']) ?></p>
                        <p class="text-[10px] text-gray-400"><?= date('d/m/Y H:i', strtotime($nota['signed_at'] ?? $nota['created_at'])) ?> WIB</p>
                    </div>
                </div>
                <?php endif; ?>
            </div>

        <?php else: ?>
            <!-- State Tidak Ditemukan -->
            <div class="p-8 text-center">
                <div class="w-16 h-16 bg-red-100 text-red-600 rounded-full flex items-center justify-center mx-auto mb-4 text-2xl">
                    <i class="fas fa-exclamation-triangle"></i>
                </div>
                <h2 class="text-lg font-bold text-gray-800">Dokumen Tidak Ditemukan</h2>
                <p class="text-xs text-gray-500 mt-2">Nota dinas dengan informasi atau token verifikasi tersebut tidak terdaftar di sistem kami.</p>
            </div>
        <?php endif; ?>

        <div class="bg-gray-50 p-4 border-t border-gray-100 text-center text-[11px] text-gray-400">
            &copy; <?= date('Y') ?> <?= COMPANY_NAME ?>. All rights reserved.
        </div>
    </div>

</body>
</html>