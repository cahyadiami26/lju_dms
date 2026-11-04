<?php
require_once 'config.php';

// TIDAK MENGGUNAKAN requireLogin() agar dapat diakses publik tanpa login

$id = (int)($_GET['id'] ?? 0);
$surat = null;

if ($id > 0) {
    // Sesuaikan status menjadi 'published' dan ambil relasi penandatangan (u_sign)
    $stmt = $pdo->prepare("
        SELECT sk.*, 
               u_kirim.name AS pengirim_name, u_kirim.position AS pengirim_pos, u_kirim.division AS pengirim_div, u_kirim.department AS pengirim_dept, u_kirim.signature AS pengirim_sig,
               u_sign.name AS sign_name, u_sign.position AS sign_pos,
               u_buat.name AS creator_name, u_buat.position AS creator_pos
        FROM surat_keluar sk
        LEFT JOIN users u_kirim ON sk.dikirim_oleh = u_kirim.id
        LEFT JOIN users u_sign ON sk.penandatangan = u_sign.id
        LEFT JOIN users u_buat ON sk.created_by = u_buat.id
        WHERE sk.id = ? AND sk.status = 'published'
    ");
    $stmt->execute([$id]);
    $surat = $stmt->fetch();
}

$pageTitle = 'Verifikasi Surat Keluar';
?>
<!DOCTYPE html>
<html lang="id">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title><?= htmlspecialchars($pageTitle) ?> - <?= defined('APP_NAME') ? APP_NAME : 'DMS' ?></title>
    <script src="https://cdn.tailwindcss.com"></script>
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css">
    <style>
        body { 
            background-color: #f8fafc; 
            font-family: ui-sans-serif, system-ui, -apple-system, BlinkMacSystemFont, "Segoe UI", Roboto, "Helvetica Neue", Arial, sans-serif; 
        }
    </style>
</head>
<body class="p-4 md:p-8 min-h-screen flex items-center justify-center">

    <div class="max-w-2xl w-full bg-white rounded-2xl shadow-xl border border-gray-100 overflow-hidden">
        <?php if ($surat): ?>
            <!-- Header Status Validasi -->
            <div class="bg-emerald-600 p-6 text-white text-center">
                <div class="w-16 h-16 bg-white/20 rounded-full flex items-center justify-center mx-auto mb-3 text-2xl backdrop-blur-sm">
                    <i class="fas fa-check-circle"></i>
                </div>
                <h1 class="text-xl font-black">Dokumen Surat Keluar Valid</h1>
                <p class="text-xs text-emerald-100 mt-1">
                    Terverifikasi Resmi oleh Sistem Manajemen Dokumen <?= defined('COMPANY_NAME') ? COMPANY_NAME : '' ?>
                </p>
            </div>

            <div class="p-6 space-y-6">
                <!-- Metadata Dokumen -->
                <div class="grid grid-cols-2 gap-4 p-4 bg-gray-50 rounded-xl text-xs">
                    <div>
                        <p class="text-gray-400 font-bold uppercase">Nomor Surat</p>
                        <p class="font-mono font-bold text-gray-800 text-sm mt-0.5"><?= htmlspecialchars($surat['nomor_surat']) ?></p>
                    </div>
                    <div>
                        <p class="text-gray-400 font-bold uppercase">Tanggal Surat</p>
                        <p class="font-semibold text-gray-800 mt-0.5"><?= date('d/m/Y', strtotime($surat['tanggal_surat'])) ?></p>
                    </div>
                    <div>
                        <p class="text-gray-400 font-bold uppercase">Pengirim / Penandatangan</p>
                        <p class="font-semibold text-gray-800 mt-0.5"><?= htmlspecialchars($surat['sign_name'] ?? $surat['pengirim_name']) ?></p>
                        <p class="text-[10px] text-gray-500">
                            <?= htmlspecialchars($surat['sign_pos'] ?? $surat['pengirim_pos'] ?? '-') ?> ¡¤ <?= htmlspecialchars($surat['pengirim_div'] ?? '-') ?>
                        </p>
                    </div>
                    <div>
                        <p class="text-gray-400 font-bold uppercase">Penerima / Tujuan</p>
                        <p class="font-semibold text-gray-800 mt-0.5"><?= htmlspecialchars($surat['penerima_surat']) ?></p>
                    </div>
                </div>

                <!-- Perihal -->
                <div>
                    <p class="text-xs font-semibold text-gray-600 mb-1">Perihal / Judul Surat:</p>
                    <p class="p-3 bg-gray-50 rounded-xl border border-gray-100 text-sm font-semibold text-gray-800">
                        <?= htmlspecialchars($surat['perihal']) ?>
                    </p>
                </div>

                <!-- Isi Surat -->
                <div>
                    <p class="text-xs font-semibold text-gray-600 mb-2">Isi Ringkasan Surat:</p>
                    <div class="p-4 bg-gray-50 rounded-xl border border-gray-100 text-sm text-gray-800 leading-relaxed prose max-w-none">
                        <?= $surat['isi_surat'] ?>
                    </div>
                </div>

                <!-- Informasi Tanda Tangan & Status -->
                <div class="pt-4 border-t border-gray-100 flex justify-between items-center">
                    <div>
                        <p class="text-[11px] text-gray-400">Status Dokumen:</p>
                        <span class="inline-block px-2.5 py-1 rounded-full text-[10px] font-bold uppercase tracking-wider bg-emerald-100 text-emerald-700 mt-1">
                            Published
                        </span>
                    </div>

                    <div class="text-center w-48">
                        <p class="text-xs text-gray-400 mb-1">Tanda Tangan Dokumen</p>
                        
                        <?php 
                        $isManual = ($surat['jenis_tandatangan'] === 'manual');
                        $sigPath = $surat['signature_path'];
                        // Ubah URL absolute/relative ke file fisik jika diperlukan
                        $sigFileRelative = str_replace(APP_URL, '', $sigPath ?? '');
                        $sigFileRelative = ltrim($sigFileRelative, '/');
                        $sigFilePhysical = APP_PATH . '/' . $sigFileRelative;
                        ?>

                        <?php if ($isManual): ?>
                            <div class="h-12 flex items-center justify-center bg-amber-50 border border-amber-200 rounded-lg text-[11px] text-amber-800 font-semibold italic">
                                [ Tanda Tangan Basah ]
                            </div>
                        <?php elseif (!empty($sigPath) && file_exists($sigFilePhysical)): ?>
                            <img src="<?= htmlspecialchars($sigPath) ?>" alt="Signature" class="h-16 mx-auto object-contain bg-white p-1 border rounded-lg">
                        <?php else: ?>
                            <div class="h-12 flex items-center justify-center bg-gray-50 border rounded-lg text-xs text-gray-400 italic">
                                Terverifikasi Digital
                            </div>
                        <?php endif; ?>

                        <p class="text-xs font-bold text-gray-800 mt-1"><?= htmlspecialchars($surat['sign_name'] ?? $surat['pengirim_name']) ?></p>
                        <p class="text-[10px] text-gray-400">
                            <?= date('d/m/Y H:i', strtotime($surat['signed_at'] ?? $surat['modified_at'] ?? $surat['created_at'])) ?> WIB
                        </p>
                    </div>
                </div>
            </div>

        <?php else: ?>
            <!-- State Tidak Ditemukan / Belum Published -->
            <div class="p-8 text-center">
                <div class="w-16 h-16 bg-red-100 text-red-600 rounded-full flex items-center justify-center mx-auto mb-4 text-2xl">
                    <i class="fas fa-exclamation-triangle"></i>
                </div>
                <h2 class="text-lg font-bold text-gray-800">Dokumen Tidak Ditemukan atau Belum Dipublikasikan</h2>
                <p class="text-xs text-gray-500 mt-2">
                    Surat keluar dengan ID tersebut tidak terdaftar di sistem kami atau belum selesai ditandatangani.
                </p>
            </div>
        <?php endif; ?>

        <div class="bg-gray-50 p-4 border-t border-gray-100 text-center text-[11px] text-gray-400">
            &copy; <?= date('Y') ?> <?= defined('COMPANY_NAME') ? COMPANY_NAME : 'Company' ?>. All rights reserved.
        </div>
    </div>

</body>
</html>