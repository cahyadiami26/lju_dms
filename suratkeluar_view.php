<?php
error_reporting(E_ALL);
error_reporting(-1);
ini_set('error_reporting', E_ALL);
require_once 'config.php';
requireLogin();

$pageTitle = 'Detail Surat Keluar';
$currentUserId = (int)$_SESSION['user_id'];
$id = (int)($_GET['id'] ?? 0);

// Fetch Data Surat Keluar & Pengirim / Pembuat / Penandatangan
$stmt = $pdo->prepare("
    SELECT sk.*, 
           u_kirim.name AS pengirim_name, u_kirim.position AS pengirim_pos, u_kirim.division AS pengirim_div, u_kirim.department AS pengirim_dept, u_kirim.signature AS pengirim_sig,
           u_buat.name AS creator_name, u_buat.position AS creator_pos,
           u_sign.name AS sign_name, u_sign.signature AS sign_sig
    FROM surat_keluar sk
    LEFT JOIN users u_kirim ON sk.dikirim_oleh = u_kirim.id
    LEFT JOIN users u_buat ON sk.created_by = u_buat.id
    LEFT JOIN users u_sign ON sk.penandatangan = u_sign.id
    WHERE sk.id = ?
");
$stmt->execute([$id]);
$surat = $stmt->fetch();

// Otorisasi: Hanya pembuat, pengirim, atau penandatangan yang dapat melihat
if (!$surat || ($surat['created_by'] != $currentUserId && $surat['dikirim_oleh'] != $currentUserId && $surat['penandatangan'] != $currentUserId)) {
    header('Location: ' . APP_URL . '/suratkeluar_list.php');
    exit;
}

// Konversi Format Tanggal Indonesia
function tgl_indo($tanggal){
    $bulan = array (
        1 => 'Januari', 'Februari', 'Maret', 'April', 'Mei', 'Juni',
        'Juli', 'Agustus', 'September', 'Oktober', 'November', 'Desember'
    );
    $pecahkan = explode('-', $tanggal);
    return $pecahkan[2] . ' ' . $bulan[(int)$pecahkan[1]] . ' ' . $pecahkan[0];
}

require_once 'includes/header.php';
require_once 'includes/sidebar.php';
?>

<style>
:root {
    --doc-font-family: '<?= $PDF_CONFIG['font_family'] ?? 'Times New Roman' ?>', Times, serif; 
    --doc-font-size: <?= $PDF_CONFIG['font_size'] ?? '12pt' ?>;                            
    --doc-line-height: 1.5; /* Dioptimalkan agar baris lebih rapat */
}
.letter-paper {
    position: relative;
    background: #ffffff;
    min-height: 297mm;
    /* Margin atas dikurangi menjadi 1cm, kanan/kiri/bawah tetap proporsional */
    padding: <?= $PDF_CONFIG['margin']['top'] ?? '1cm' ?> <?= $PDF_CONFIG['margin']['right'] ?? '2cm' ?> <?= $PDF_CONFIG['margin']['bottom'] ?? '2cm' ?> <?= $PDF_CONFIG['margin']['left'] ?? '2cm' ?>;
    font-family: var(--doc-font-family);
    font-size: var(--doc-font-size);
    color: #000;
    box-shadow: 0 4px 6px -1px rgba(0, 0, 0, 0.1);
    overflow: hidden;
    display: flex;
    flex-direction: column;
    justify-content: space-between;
}

.watermark-logo {
    position: absolute;
    top: 55%;
    left: 50%;
    transform: translate(-50%, -50%);
    width: 65%;
    opacity: 0.07;
    pointer-events: none;
    z-index: 0;
}

.watermark-text {
    position: absolute;
    top: 50%;
    left: 50%;
    transform: translate(-50%, -50%) rotate(-45deg);
    font-size: 8rem;
    font-weight: 900;
    color: rgba(239, 68, 68, 0.12);
    letter-spacing: 0.2em;
    user-select: none;
    pointer-events: none;
    z-index: 0;
}

.letter-content {
    position: relative;
    z-index: 10;
}

.letter-footer {
    position: relative;
    z-index: 10;
    border-top: 1px solid #000;
    padding-top: 8px;
    margin-top: 30px;
    font-size: 10px;
    line-height: 1.4;
    color: #333;
    text-align: center;
}

@media print {
    body * { visibility: hidden; }
    .letter-paper, .letter-paper * { visibility: visible; }
    .letter-paper {
        position: absolute;
        left: 0;
        top: 0;
        width: 100%;
        margin: 0;
        /* Menghilangkan border/frame dan shadow saat dicetak */
        border: none !important;
        box-shadow: none !important;
        border-radius: 0 !important;
        padding: 1cm 1.5cm 1.5cm 1.5cm;
    }
    .no-print { display: none !important; }
}
</style>

<div class="lg:ml-64 pt-14 min-h-screen">
<main class="p-4 md:p-6 lg:p-8">

    <!-- Navigation Bar -->
    <div class="flex items-center justify-between gap-4 mb-6 no-print">
        <a href="<?= APP_URL ?>/suratkeluar_list.php" class="inline-flex items-center gap-2 text-sm text-gray-500 hover:text-brand">
            <i class="fas fa-arrow-left"></i> Kembali ke Daftar Surat
        </a>
        <div class="flex items-center gap-2">
            <a href="<?= APP_URL ?>/suratkeluar_pdf.php?id=<?= $surat['id'] ?>" target="_blank" class="btn-outline px-4 py-2 text-xs font-semibold text-rose-600 hover:bg-rose-50 border-rose-200">
                <i class="fas fa-file-pdf mr-1.5"></i> Export PDF
            </a>
            <button onclick="window.print()" class="btn-outline px-4 py-2 text-xs font-semibold">
                <i class="fas fa-print mr-1.5"></i> Cetak Dokumen
            </button>

            <?php if ($surat['status'] === 'draft'): ?>
                <?php if ((int)$surat['created_by'] === $currentUserId): ?>
                    <a href="<?= APP_URL ?>/suratkeluar_edit.php?id=<?= $surat['id'] ?>" class="btn-outline px-4 py-2 text-xs font-semibold">
                        <i class="fas fa-pen mr-1.5"></i> Edit
                    </a>
                <?php endif; ?>

                <?php if ((int)$surat['penandatangan'] === $currentUserId || (int)$surat['dikirim_oleh'] === $currentUserId): ?>
                    <a href="<?= APP_URL ?>/suratkeluar_sign.php?id=<?= $surat['id'] ?>" class="btn-primary px-4 py-2 text-xs font-semibold">
                        <i class="fas fa-signature mr-1.5"></i> Sign Dokumen
                    </a>
                <?php endif; ?>
            <?php endif; ?>
        </div>
    </div>

    <div class="grid lg:grid-cols-3 gap-6">
        <!-- Tampilan Kertas Surat Keluar -->
        <div class="lg:col-span-2">
            <div class="letter-paper rounded-2xl border border-gray-100">
                
                <!-- Watermark -->
                <?php if ($surat['status'] === 'published'): ?>
                    <img src="<?= APP_URL ?>/assets/img/logo.png" class="watermark-logo" alt="Watermark Logo">
                <?php else: ?>
                    <div class="watermark-text">DRAFT</div>
                <?php endif; ?>

                <div class="letter-content space-y-6">
                    <!-- Header Logo Kop Surat -->
                    <div class="border-b-2 border-black pb-4 mb-6">
                        <img src="<?= APP_URL ?>/assets/img/lju_logo.png" alt="Logo LJU" class="h-20 object-contain">
                    </div>

                    <!-- Metadata Header Surat -->
                    <table class="w-full text-sm leading-relaxed" style="font-family: 'Times New Roman', Times, serif;">
                        <tr>
                            <td style="width: 12%;">Nomor</td>
                            <td style="width: 2%;">:</td>
                            <td style="width: 46%;"><?= htmlspecialchars($surat['nomor_surat']) ?></td>
                            <td style="width: 40%; text-align: right;"><?= tgl_indo($surat['tanggal_surat']) ?></td>
                        </tr>
                        <tr>
                            <td>Perihal</td>
                            <td>:</td>
                            <td><?= htmlspecialchars($surat['perihal']) ?></td>
                            <td></td>
                        </tr>
                        <tr>
                            <td>Lampiran</td>
                            <td>:</td>
                            <td><?= htmlspecialchars($surat['lampiran_surat']) ?></td>
                            <td></td>
                        </tr>
                    </table>

                    <!-- Penerima Surat -->
                    <div class="pt-2 text-sm leading-relaxed">
                        <p>Kepada Yth.</p>
                        <p class="font-bold"><?= htmlspecialchars($surat['penerima_surat']) ?></p>
                        <p>Di Tempat</p>
                    </div>

                    <!-- Isi Surat WYSIWYG -->
                    <div class="pt-4 text-sm leading-relaxed text-justify prose max-w-none">
                        <?= $surat['isi_surat'] ?>
                    </div>

                    <!-- Tanda Tangan & QR Code -->
                    <?php 
                    $scanUrl = APP_URL . '/suratkeluar_scan.php?id=' . urlencode($surat['id']); 
                    $isManual = ($surat['jenis_tandatangan'] === 'manual');
                    $sigFile = $surat['signature_path'];
                    ?>
                    <div class="pt-10 flex items-end justify-between" style="font-family: 'Times New Roman', Times, serif;">
                        <div class="space-y-2">
                            <?php if ($surat['status'] === 'published'): ?>
                                <img src="https://api.qrserver.com/v1/create-qr-code/?size=100x100&data=<?= urlencode($scanUrl) ?>" alt="QR Code" class="w-24 h-24 border p-1 bg-white">
                            <?php else: ?>
                                <div class="w-24 h-24 border border-dashed border-gray-300 flex items-center justify-center text-[10px] text-gray-400 bg-gray-50">
                                    [ QR Code ]
                                </div>
                            <?php endif; ?>
                            <p class="text-xs text-gray-800">
                                [Dokumen ini ditandatangani secara digital]
                            </p>
                        </div>
                    
                        <div class="text-center text-sm min-w-[240px] space-y-2">
                            <p class="font-bold">
                                <?= htmlspecialchars($surat['pengirim_pos'] ?? 'Jabatan') ?> 
                                <?= htmlspecialchars($surat['pengirim_div'] ?? '') ?>
                            </p>
                            
                            <div class="h-20 flex items-center justify-center py-1">
                                <?php if ($surat['status'] === 'published'): ?>
                                    <?php if ($isManual): ?>
                                        <!-- Jika manual, kosongkan gambar dan tampilkan keterangan tanda tangan basah -->
                                        <span class="text-xs text-gray-600 italic font-semibold">[ Tanda Tangan Basah / Manual ]</span>
                                    <?php elseif (!empty($sigFile)): ?>
                                        <!-- Jika ada file tanda tangan digital -->
                                        <img src="<?= htmlspecialchars($sigFile) ?>" class="h-16 object-contain" alt="Tanda Tangan">
                                    <?php else: ?>
                                        <span class="text-xs text-gray-400 italic">[ Menunggu Tanda Tangan ]</span>
                                    <?php endif; ?>
                                <?php else: ?>
                                    <span class="text-xs text-gray-400 italic">[ Menunggu Tanda Tangan ]</span>
                                <?php endif; ?>
                            </div>
                    
                            <p class="font-bold underline uppercase"><?= htmlspecialchars($surat['pengirim_name']) ?></p>
                        </div>
                    </div>
                </div>

                <!-- FOOTER ALAMAT & KONTAK -->
                <div class="letter-footer">
                    <p><strong>Email :</strong> lampungjasautama@gmail.com &nbsp;&nbsp;&nbsp;&nbsp; <strong>Phone :</strong> +62 812 9292 3311</p>
                    <p><strong>Alamat :</strong> Jl.Jend. Sudirman No.81, Tj.Raya, Kec. Kedamaian, Kota Bandar Lampung, Lampung 35128.</p>
                </div>

            </div>
        </div>

        <!-- Sidebar Info -->
        <div class="space-y-4 no-print">
            <div class="bg-white rounded-2xl shadow-sm border border-gray-100 p-6 text-center">
                <h3 class="font-bold text-gray-800 text-sm mb-3 text-left">Status Dokumen</h3>
                <div class="mb-4 text-left">
                    <?php if ($surat['status'] === 'published'): ?>
                        <span class="inline-flex items-center gap-1.5 px-3 py-1 rounded-full text-xs font-semibold bg-emerald-50 text-emerald-700 border border-emerald-200">
                            <span class="w-2 h-2 rounded-full bg-emerald-500"></span> Status: Published
                        </span>
                    <?php else: ?>
                        <span class="inline-flex items-center gap-1.5 px-3 py-1 rounded-full text-xs font-semibold bg-amber-50 text-amber-700 border border-amber-200">
                            <span class="w-2 h-2 rounded-full bg-amber-500"></span> Status: Draft
                        </span>
                    <?php endif; ?>
                </div>

                <?php if ($surat['status'] === 'published'): ?>
                <div class="border-t border-gray-100 pt-4 mb-4">
                    <p class="text-[11px] text-gray-400 mb-2 font-semibold">QR Code Verifikasi Publik</p>
                    <img src="https://api.qrserver.com/v1/create-qr-code/?size=150x150&data=<?= urlencode($scanUrl) ?>" alt="QR Code" class="w-32 h-32 mx-auto border p-1 rounded-lg">
                    <a href="<?= $scanUrl ?>" target="_blank" class="block text-[10px] text-teal-600 hover:underline mt-2">Buka Halaman Verifikasi</a>
                </div>
                <?php endif; ?>

                <div class="space-y-2 text-xs border-t border-gray-100 pt-3 text-left">
                    <div class="flex justify-between">
                        <span class="text-gray-400">Dibuat Oleh</span>
                        <span class="font-semibold text-gray-700"><?= htmlspecialchars($surat['creator_name'] ?? 'System') ?></span>
                    </div>
                    <div class="flex justify-between">
                        <span class="text-gray-400">Dibuat Pada</span>
                        <span class="font-semibold text-gray-700"><?= date('d/m/Y H:i', strtotime($surat['created_at'])) ?></span>
                    </div>
                </div>
            </div>
        </div>
    </div>

</main>
</div>

<?php require_once 'includes/footer.php'; ?>