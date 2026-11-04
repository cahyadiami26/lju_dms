<?php
// surattugas_view.php
error_reporting(E_ALL);
ini_set('display_errors', 1);

require_once 'config.php';
requireLogin();

$pageTitle = 'Detail Surat Tugas';
$currentUserId = (int)$_SESSION['user_id'];
$id = (int)($_GET['id'] ?? 0);

// 1. Fetch Data Surat Tugas & Info Penandatangan / Pembuat menggunakan struktur tabel baru (tbl_surat_tugas)
$stmt = $pdo->prepare("
    SELECT st.*, 
           u_sign.name AS sign_name, u_sign.position AS sign_pos, u_sign.division AS sign_div, u_sign.department AS sign_dept, u_sign.signature AS sign_sig,
           u_buat.name AS creator_name, u_buat.position AS creator_pos
    FROM tbl_surat_tugas st
    LEFT JOIN users u_sign ON st.penandatangan_id = u_sign.id
    LEFT JOIN users u_buat ON st.created_by = u_buat.id
    WHERE st.id = ?
");
$stmt->execute([$id]);
$surat = $stmt->fetch();

if (!$surat) {
    die("Surat tugas tidak ditemukan.");
}

// 2. Cek apakah user yang login termasuk ke dalam daftar personil yang ditugaskan (tbl_surat_tugas_personil)
$stmtCheckAssign = $pdo->prepare("SELECT COUNT(*) FROM tbl_surat_tugas_personil WHERE surat_tugas_id = ? AND user_id = ?");
$stmtCheckAssign->execute([$id, $currentUserId]);
$isAssigned = $stmtCheckAssign->fetchColumn() > 0;

$isCreator  = ($surat['created_by'] == $currentUserId);
$isSigner   = ($surat['penandatangan_id'] == $currentUserId);
$isSecretariat = ($userDivision === 'kesekretariatan' || $userRole === 'op-arsip');

// 3. Otorisasi Akses: Hanya Pembuat, Penandatangan, atau User yang Ditugaskan
if (!$isCreator && !$isSigner && !$isAssigned && !$isSecretariat) {
    header('Location: ' . APP_URL . '/surattugas_list.php');
    exit;
}

// 4. Ambil daftar personil yang ditugaskan dari tabel relasi baru dengan penyesuaian nomenklatur
$stmtAssignedUsers = $pdo->prepare("
    SELECT u.name, u.position, u.division, u.department 
    FROM tbl_surat_tugas_personil stp
    JOIN users u ON stp.user_id = u.id
    WHERE stp.surat_tugas_id = ?
    ORDER BY u.name ASC
");
$stmtAssignedUsers->execute([$id]);
$assignedList = $stmtAssignedUsers->fetchAll();

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
/* ==========================================================
   PENGATURAN VARIABEL FONT STANDAR DOKUMEN (Dari Config)
   ========================================================== */
:root {
    --doc-font-family: '<?= $PDF_CONFIG['font_family'] ?? 'Times New Roman' ?>', Times, serif; 
    --doc-font-size: <?= $PDF_CONFIG['font_size'] ?? '12pt' ?>;                            
    --doc-line-height: 1.5; /* Dioptimalkan agar baris lebih rapat */
}

.letter-paper {
    position: relative;
    background: #ffffff;
    min-height: 297mm;
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

.standard-doc-text, 
.standard-doc-text * {
    font-family: var(--doc-font-family) !important;
    font-size: var(--doc-font-size) !important;
    line-height: var(--doc-line-height) !important;
    color: #000 !important;
}

.standard-doc-text ul {
    list-style-type: disc !important;
    padding-left: 30px !important;
    margin-bottom: 6px !important; /* Dirapatkan */
}
.standard-doc-text ol {
    list-style-type: decimal !important;
    padding-left: 30px !important;
    margin-bottom: 6px !important; /* Dirapatkan */
}
.standard-doc-text p {
    margin-bottom: 6px !important; /* Dirapatkan agar tidak terlalu renggang */
    text-align: justify;
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
    /* Mengurangi jarak kosong berlebih di dalam konten utama */
    display: flex;
    flex-direction: column;
    gap: 12px; 
}

.letter-footer {
    position: relative;
    z-index: 10;
    border-top: 1px solid #000;
    padding-top: 6px;
    margin-top: 15px; /* Dirapatkan dari 30px */
    font-size: 10px;
    line-height: 1.4;
    color: #333;
    text-align: center;
}

/* ==========================================================
   PENGATURAN CETAK / PRINT (MENGHILANGKAN FRAME & MENYESUAIKAN MARGIN)
   ========================================================== */
@media print {
    body * { 
        visibility: hidden; 
    }
    .letter-paper, .letter-paper * { 
        visibility: visible; 
    }
    .letter-paper {
        position: absolute;
        left: 0;
        top: 0;
        width: 100%;
        margin: 0;
        box-shadow: none !important;
        border: none !important;
        border-radius: 0 !important;
        /* Mengurangi margin atas cetak menjadi lebih tipis (0.5cm) */
        padding: 0.5cm 1.5cm 1.5cm 1.5cm !important; 
    }
    .no-print { 
        display: none !important; 
    }
}
</style>

<div class="lg:ml-64 pt-14 min-h-screen">
<main class="p-4 md:p-6 lg:p-8">

    <!-- Navigation Bar -->
    <div class="flex items-center justify-between gap-4 mb-6 no-print">
        <a href="<?= APP_URL ?>/surattugas_list.php" class="inline-flex items-center gap-2 text-sm text-gray-500 hover:text-brand">
            <i class="fas fa-arrow-left"></i> Kembali ke Daftar Surat Tugas
        </a>
        <div class="flex items-center gap-2">
            <a href="<?= APP_URL ?>/surattugas_pdf.php?id=<?= $surat['id'] ?>" target="_blank" class="btn-outline px-4 py-2 text-xs font-semibold text-rose-600 hover:bg-rose-50 border-rose-200">
                <i class="fas fa-file-pdf mr-1.5"></i> Export PDF
            </a>
            <button onclick="window.print()" class="btn-outline px-4 py-2 text-xs font-semibold">
                <i class="fas fa-print mr-1.5"></i> Cetak Dokumen
            </button>
            <?php if ($surat['status_surat'] === 'draft' && $isSigner): ?>
            <a href="<?= APP_URL ?>/surattugas_sign.php?id=<?= $surat['id'] ?>" class="btn-primary px-4 py-2 text-xs font-semibold">
                <i class="fas fa-signature mr-1.5"></i> Sign Dokumen
            </a>
            <?php endif; ?>
            <?php if ($surat['status_surat'] === 'draft' && $isCreator): ?>
            <a href="<?= APP_URL ?>/surattugas_edit.php?id=<?= $surat['id'] ?>" class="btn-outline px-4 py-2 text-xs font-semibold">
                <i class="fas fa-pen mr-1.5"></i> Edit
            </a>
            <?php endif; ?>
        </div>
    </div>

    <div class="grid lg:grid-cols-3 gap-6">
        <!-- Tampilan Lembar Surat Tugas -->
        <div class="lg:col-span-2">
            <div class="letter-paper rounded-2xl border border-gray-100">
                
                <!-- Watermark -->
                <?php if ($surat['status_surat'] === 'published' || $surat['status_surat'] === 'complete'): ?>
                    <img src="<?= APP_URL ?>/assets/img/logo.png" class="watermark-logo" alt="Watermark Logo">
                <?php else: ?>
                    <div class="watermark-text">DRAFT</div>
                <?php endif; ?>

                <div class="letter-content space-y-5">
                    <!-- Header Logo Kop Surat -->
                    <div class="border-b-2 border-black pb-4 mb-6">
                        <img src="<?= APP_URL ?>/assets/img/lju_logo.png" alt="Logo LJU" class="h-20 object-contain">
                    </div>

                    <!-- Judul Dokumen -->
                    <div class="text-center space-y-1 mb-4">
                        <h3 class="font-bold uppercase" style="font-size: 14pt;">SURAT TUGAS</h3>
                        <p>Nomor : <?= htmlspecialchars($surat['nomor_surat']) ?></p>
                    </div>

                    <!-- Teks Pembuka (Konsiderans / Dasar Penugasan) -->
                    <div class="standard-doc-text">
                        <?= $surat['teks_pembuka'] ?>
                    </div>

                    <!-- Pemberi Tugas & Daftar Personel Ditugaskan (Dengan Nomenklatur Bidang & Divisi) -->
                    <div class="standard-doc-text space-y-2">
                        <p>Dengan ini memberikan tugas kepada:</p>
                        <ol class="list-decimal pl-6 space-y-2">
                            <?php foreach ($assignedList as $person): ?>
                                <?php 
                                    // Aturan Nomenklatur Jabatan:
                                    // - Kepala bidang: nama | jabatan | division (Nama Bidang)
                                    // - Kepala divisi: nama | jabatan | department (Nama Divisi)
                                    // - Staff: nama | jabatan | bidang
                                    // - Selain dari itu cukup tampilkan jabatan
                                    $posLower = strtolower(trim($person['position'] ?? ''));
                                    $detailLabel = '';

                                    if (strpos($posLower, 'kepala bidang') !== false) {
                                        $detailLabel = $person['division'] ?? '-'; // division = Nama Bidang
                                    } elseif (strpos($posLower, 'kepala divisi') !== false) {
                                        $detailLabel = $person['department'] ?? '-'; // department = Nama Divisi
                                    } elseif (strpos($posLower, 'staff') !== false) {
                                        $detailLabel = $person['division'] ?? '-';
                                    } else {
                                        $detailLabel = $person['position'];
                                    }
                                ?>
                                <li>
                                    <table class="w-full border-collapse" style="font-family: var(--doc-font-family); font-size: var(--doc-font-size);">
                                        <tr>
                                            <td style="width: 12%; vertical-align: top;">Nama</td>
                                            <td style="width: 2%; vertical-align: top;">:</td>
                                            <td style="width: 86%; vertical-align: top;" class="font-bold"><?= htmlspecialchars($person['name']) ?></td>
                                        </tr>
                                        <tr>
                                            <td style="vertical-align: top;">Jabatan</td>
                                            <td style="vertical-align: top;">:</td>
                                            <td style="vertical-align: top;"><?= htmlspecialchars($detailLabel) ?></td>
                                        </tr>
                                    </table>
                                </li>
                            <?php endforeach; ?>
                        </ol>
                    </div>

                    <!-- Berita Penugasan (Isi / Maksud & Tujuan) -->
                    <div class="standard-doc-text pt-1">
                        <?= $surat['berita_penugasan'] ?>
                    </div>

                    <!-- Paragraf Penutup -->
                    <div class="standard-doc-text space-y-2 pt-2">
                        <p>Surat tugas ini berlaku pada tanggal ditetapkan dan dinyatakan berakhir sampai adanya perubahan, penyelesaian tugas, dan/atau pencabutan.</p>
                        <p>Demikian surat tugas ini dibuat untuk dapat dipergunakan sebagaimana mestinya dengan penuh tanggung jawab.</p>
                    </div>

                    <!-- Tanda Tangan & QR Code -->
                    <?php $scanUrl = APP_URL . '/surattugas_scan.php?id=' . urlencode($surat['id']); ?>
                    <div class="pt-8 flex items-end justify-between" style="font-family: var(--doc-font-family);">
                        <div class="space-y-2">
                            <?php if ($surat['status_surat'] === 'published' || $surat['status_surat'] === 'complete'): ?>
                                <img src="https://api.qrserver.com/v1/create-qr-code/?size=100x100&data=<?= urlencode($scanUrl) ?>" alt="QR Code" class="w-24 h-24 border p-1 bg-white">
                            <?php else: ?>
                                <div class="w-24 h-24 border border-dashed border-gray-300 flex items-center justify-center text-[10px] text-gray-400 bg-gray-50">
                                    [ QR Code ]
                                </div>
                            <?php endif; ?>
                            <p class="text-xs text-gray-800" style="font-family: sans-serif !important;">
                                [Dokumen ini ditandatangani secara digital]
                            </p>
                        </div>

                        <div class="text-center min-w-[260px] space-y-3" style="font-family: var(--doc-font-family); font-size: var(--doc-font-size);">
                            <!-- Tabel Format "Dikeluarkan di" dan "Tanggal" -->
                            <table class="w-full text-left border-collapse mb-3" style="font-family: var(--doc-font-family); font-size: var(--doc-font-size);">
                                <tr>
                                    <td style="width: 45%; vertical-align: top;">Dikeluarkan di</td>
                                    <td style="width: 5%; vertical-align: top;">:</td>
                                    <td style="width: 50%; vertical-align: top;">Bandar Lampung</td>
                                </tr>
                                <tr>
                                    <td style="vertical-align: top;">Tanggal</td>
                                    <td style="vertical-align: top;">:</td>
                                    <td style="vertical-align: top;"><?= tgl_indo($surat['tanggal_surat']) ?></td>
                                </tr>
                            </table>
                            
                            <p class="font-bold">
                                <?= htmlspecialchars($surat['sign_pos'] ?? 'Pejabat Penandatangan') ?>
                            </p>
                            
                            <div class="h-20 flex items-center justify-center py-1">
                                <?php if (($surat['status_surat'] == 'published' || $surat['status_surat'] == 'complete') && $surat['jenis_tandatangan'] !== 'manual'): ?>
                                    <?php if (!empty($surat['signature_data']) && file_exists(SIGNATURE_PATH . '/' . basename($surat['signature_data']))): ?>
                                        <img src="<?= APP_URL ?>/uploads/signatures/<?= htmlspecialchars(basename($surat['signature_data'])) ?>" class="h-16 object-contain" alt="Tanda Tangan">
                                    <?php elseif (!empty($surat['sign_sig']) && file_exists(SIGNATURE_PATH . '/' . basename($surat['sign_sig']))): ?>
                                        <img src="<?= APP_URL ?>/uploads/signatures/<?= htmlspecialchars(basename($surat['sign_sig'])) ?>" class="h-16 object-contain" alt="Tanda Tangan Default">
                                    <?php endif; ?>
                                <?php elseif ($surat['jenis_tandatangan'] === 'manual'): ?>
                                    <!-- Jika manual, pastikan tidak ada gambar yang muncul -->
                                    <span class="text-xs text-gray-500 italic" style="font-family: sans-serif;">[ Tanda Tangan Basah / Manual ]</span>
                                <?php else: ?>
                                    <span class="text-xs text-gray-400 italic" style="font-family: sans-serif;">[ Menunggu Tanda Tangan ]</span>
                                <?php endif; ?>
                            </div>

                            <p class="font-bold underline uppercase"><?= htmlspecialchars($surat['sign_name']) ?></p>
                        </div>
                    </div>
                </div>

                <!-- FOOTER ALAMAT & KONTAK -->
                <div class="letter-footer" style="font-family: sans-serif;">
                    <p><strong>Email :</strong> lampungjasautama@gmail.com &nbsp;&nbsp;&nbsp;&nbsp; <strong>Phone :</strong> +62 812 9292 3311</p>
                    <p><strong>Alamat :</strong> Jl.Jend. Sudirman No.81, Tj.Raya, Kec. Kedamaian, Kota Bandar Lampung, Lampung 35128.</p>
                </div>

            </div>
        </div>

        <!-- Sidebar Info & Role Status -->
        <div class="space-y-4 no-print" style="font-family: sans-serif;">
            <div class="bg-white rounded-2xl shadow-sm border border-gray-100 p-6">
                <h3 class="font-bold text-gray-800 text-sm mb-3">Informasi & Hak Akses</h3>
                
                <div class="mb-4">
                    <?php if ($surat['status_surat'] === 'published' || $surat['status_surat'] === 'complete'): ?>
                        <span class="inline-flex items-center gap-1.5 px-3 py-1 rounded-full text-xs font-semibold bg-emerald-50 text-emerald-700 border border-emerald-200">
                            <span class="w-2 h-2 rounded-full bg-emerald-500"></span> Status: Published
                        </span>
                    <?php else: ?>
                        <span class="inline-flex items-center gap-1.5 px-3 py-1 rounded-full text-xs font-semibold bg-amber-50 text-amber-700 border border-amber-200">
                            <span class="w-2 h-2 rounded-full bg-amber-500"></span> Status: Draft
                        </span>
                    <?php endif; ?>
                </div>

                <div class="space-y-2 text-xs border-t border-gray-100 pt-3 mb-4">
                    <div class="flex justify-between">
                        <span class="text-gray-400">Dibuat Oleh</span>
                        <span class="font-semibold text-gray-700"><?= htmlspecialchars($surat['creator_name'] ?? 'System') ?></span>
                    </div>
                    <div class="flex justify-between">
                        <span class="text-gray-400">Dibuat Pada</span>
                        <span class="font-semibold text-gray-700"><?= date('d/m/Y H:i', strtotime($surat['created_at'])) ?></span>
                    </div>
                    <?php if (!empty($surat['signed_at'])): ?>
                    <div class="flex justify-between">
                        <span class="text-gray-400">Ditandatangani</span>
                        <span class="font-semibold text-gray-700"><?= date('d/m/Y H:i', strtotime($surat['signed_at'])) ?></span>
                    </div>
                    <?php endif; ?>
                </div>

                <div class="border-t border-gray-100 pt-3">
                    <p class="text-[11px] text-gray-400 font-semibold mb-2">Peran Anda pada Surat Ini:</p>
                    <div class="space-y-1 text-xs">
                        <?php if ($isCreator): ?>
                            <span class="inline-block bg-blue-50 text-blue-700 px-2 py-0.5 rounded font-medium mr-1">Pembuat Surat</span>
                        <?php endif; ?>
                        <?php if ($isSigner): ?>
                            <span class="inline-block bg-purple-50 text-purple-700 px-2 py-0.5 rounded font-medium mr-1">Penandatangan</span>
                        <?php endif; ?>
                        <?php if ($isAssigned): ?>
                            <span class="inline-block bg-emerald-50 text-emerald-700 px-2 py-0.5 rounded font-medium">Personel Ditugaskan</span>
                        <?php endif; ?>
                    </div>
                </div>
            </div>
        </div>
    </div>

</main>
</div>

<?php require_once 'includes/footer.php'; ?>