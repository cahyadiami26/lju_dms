<?php
// surattugas_edit.php
error_reporting(E_ALL);
ini_set('display_errors', 1);

require_once 'includes/mail_helper.php';
require_once 'config.php';
requireLogin();

$pageTitle = 'Edit Surat Tugas';
$currentUserId = (int)$_SESSION['user_id'];
$id = (int)($_GET['id'] ?? 0);

// 1. Ambil data surat tugas yang akan diedit
$stmt = $pdo->prepare("SELECT * FROM tbl_surat_tugas WHERE id = ?");
$stmt->execute([$id]);
$surat = $stmt->fetch();

if (!$surat) {
    die("Surat tugas tidak ditemukan.");
}

// 2. Otorisasi: Hanya pembuat dokumen dan status harus 'draft' yang boleh mengedit
if ($surat['created_by'] != $currentUserId || $surat['status_surat'] !== 'draft') {
    header('Location: ' . APP_URL . '/surattugas_view.php?id=' . $id . '&msg=unauthorized_edit');
    exit;
}

// 3. Ambil daftar user penandatangan: HANYA yang division (Nama Bidang) atau department (Nama Divisi) bernilai 'direksi'
$stmtSigners = $pdo->query("
    SELECT id, name, position, division, department 
    FROM users 
    WHERE is_active = 1 
      AND (LOWER(division) = 'direksi' OR LOWER(department) = 'direksi') 
    ORDER BY name ASC
");
$signers = $stmtSigners->fetchAll();

// 4. Ambil daftar seluruh user aktif untuk pilihan User yang Ditugaskan
$stmtUsers = $pdo->query("SELECT id, name, position, division, department FROM users WHERE is_active = 1 AND id != 1 ORDER BY name ASC");
$users = $stmtUsers->fetchAll();

// 5. Ambil daftar ID user yang sebelumnya sudah ditugaskan pada surat ini
$stmtAssignedCurrent = $pdo->prepare("SELECT user_id FROM tbl_surat_tugas_personil WHERE surat_tugas_id = ?");
$stmtAssignedCurrent->execute([$id]);
$currentAssignedIds = $stmtAssignedCurrent->fetchAll(PDO::FETCH_COLUMN);

// Handle Submit Form Update
if ($_SERVER['REQUEST_METHOD'] === 'POST') {
    $nomorSurat         = trim($_POST['nomor_surat'] ?? '');
    $tanggalSurat       = $_POST['tanggal_surat'] ?? date('Y-m-d');
    $ditandatanganiOleh = (int)($_POST['ditandatangani_oleh'] ?? 0);
    $assignedUsers      = $_POST['assigned_users'] ?? []; // Array ID user yang ditugaskan
    $teksPembuka        = trim($_POST['teks_pembuka'] ?? '');
    $beritaPenugasan    = trim($_POST['berita_penugasan'] ?? '');

    // Validasi Input Wajib
    if (!empty($nomorSurat) && $ditandatanganiOleh > 0 && !empty($assignedUsers) && !empty($teksPembuka) && !empty($beritaPenugasan)) {
        try {
            $pdo->beginTransaction();

            // 1. Update tabel tbl_surat_tugas
            $stmtUpdate = $pdo->prepare("
                UPDATE tbl_surat_tugas 
                SET nomor_surat = ?, 
                    tanggal_surat = ?, 
                    penandatangan_id = ?, 
                    teks_pembuka = ?, 
                    berita_penugasan = ?, 
                    modified_at = NOW() 
                WHERE id = ?
            ");
            $stmtUpdate->execute([
                $nomorSurat,
                $tanggalSurat,
                $ditandatanganiOleh,
                $teksPembuka,
                $beritaPenugasan,
                $id
            ]);

            // 2. Refresh relasi personil: Hapus data lama, lalu masukkan yang baru
            $stmtDeleteAssign = $pdo->prepare("DELETE FROM tbl_surat_tugas_personil WHERE surat_tugas_id = ?");
            $stmtDeleteAssign->execute([$id]);

            $stmtAssign = $pdo->prepare("INSERT INTO tbl_surat_tugas_personil (surat_tugas_id, user_id) VALUES (?, ?)");
            foreach ($assignedUsers as $userId) {
                $stmtAssign->execute([$id, (int)$userId]);
            }

            $pdo->commit();

            if (function_exists('logActivity')) {
                logActivity($currentUserId, 'update_surat_tugas', "Memperbarui Draft Surat Tugas #$nomorSurat", null);
            }
            header('Location: ' . APP_URL . "/surattugas_view.php?id=" . $id . "&msg=updated");
            exit;
        } catch (PDOException $e) {
            $pdo->rollBack();
            $error = 'Gagal memperbarui data: ' . $e->getMessage();
        }
    } else {
        $error = 'Harap isi semua kolom wajib, termasuk minimal pilih satu user yang ditugaskan.';
    }
}

require_once 'includes/header.php';
require_once 'includes/sidebar.php';
?>

<!-- Summernote Dependencies -->
<script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
<link href="https://cdn.jsdelivr.net/npm/summernote@0.9.0/dist/summernote-lite.min.css" rel="stylesheet">
<script src="https://cdn.jsdelivr.net/npm/summernote@0.9.0/dist/summernote-lite.min.js"></script>

<style>
.note-editor.note-frame { 
    border: 1px solid #e5e7eb !important; 
    border-radius: 0.75rem !important; 
    overflow: hidden;
    background-color: #f3f4f6 !important; 
}
.note-toolbar { 
    background-color: #ffffff !important; 
    border-bottom: 1px solid #e5e7eb !important; 
    padding: 8px 12px !important;
    position: sticky;
    top: 0;
    z-index: 10;
}
.note-editing-area { padding: 20px 0; }
.note-editable { 
    background-color: #ffffff !important; 
    max-width: 800px; 
    margin: 0 auto !important; 
    padding: <?= $PDF_CONFIG['margin']['top'] ?> <?= $PDF_CONFIG['margin']['right'] ?> <?= $PDF_CONFIG['margin']['bottom'] ?> <?= $PDF_CONFIG['margin']['left'] ?> !important; 
    min-height: 250px !important; 
    box-shadow: 0 4px 6px -1px rgba(0, 0, 0, 0.1) !important;
    border-radius: 4px;
    font-family: '<?= $PDF_CONFIG['font_family'] ?>', Times, serif;
    font-size: <?= $PDF_CONFIG['font_size'] ?>;
    line-height: 1.6;
}
.note-editable ul { list-style-type: disc !important; padding-left: 40px !important; margin-bottom: 10px !important; }
.note-editable ol { list-style-type: decimal !important; padding-left: 40px !important; margin-bottom: 10px !important; }
.note-editable li { display: list-item !important; list-style: inherit !important; }
</style>

<div class="lg:ml-64 pt-14 min-h-screen">
<main class="p-4 md:p-6 lg:p-8 max-w-6xl mx-auto">

    <div class="flex items-center justify-between mb-6">
        <div>
            <h2 class="text-xl font-black text-gray-900 mb-1">Edit Surat Tugas</h2>
            <p class="text-gray-500 text-sm">Perbarui informasi dan rincian dokumen surat tugas perusahaan</p>
        </div>
        <div class="flex items-center gap-3">
            <a href="surattugas_view.php?id=<?= $id ?>" class="text-xs font-semibold text-gray-600 hover:text-gray-900">
                <i class="fas fa-arrow-left mr-1"></i> Kembali ke Detail
            </a>
            <span class="inline-flex items-center gap-1.5 px-3 py-1.5 rounded-full text-xs font-semibold bg-amber-50 text-amber-700 border border-amber-200">
                <span class="w-2 h-2 rounded-full bg-amber-500"></span> Status: Draft
            </span>
        </div>
    </div>

    <?php if (isset($error)): ?>
    <div class="bg-red-50 border border-red-200 text-red-700 px-4 py-3 rounded-xl text-sm mb-4">
        <i class="fas fa-exclamation-circle mr-2"></i><?= htmlspecialchars($error) ?>
    </div>
    <?php endif; ?>

    <form method="POST" action="" class="bg-white rounded-2xl shadow-sm border border-gray-100 p-6 space-y-6">
        
        <!-- Informasi Header Surat -->
        <div class="grid md:grid-cols-2 gap-4">
            <div>
                <label class="block text-xs font-semibold text-gray-600 mb-1">Nomor Surat Tugas *</label>
                <input type="text" name="nomor_surat" value="<?= htmlspecialchars($surat['nomor_surat']) ?>" required class="w-full border border-gray-200 rounded-lg px-4 py-2.5 text-sm focus:ring-2 focus:ring-teal outline-none">
            </div>
            <div>
                <label class="block text-xs font-semibold text-gray-600 mb-1">Tanggal Surat *</label>
                <input type="date" name="tanggal_surat" value="<?= htmlspecialchars($surat['tanggal_surat']) ?>" required class="w-full border border-gray-200 rounded-lg px-4 py-2.5 text-sm focus:ring-2 focus:ring-teal outline-none">
            </div>
        </div>

        <!-- Penandatangan -->
        <div>
            <label class="block text-xs font-semibold text-gray-600 mb-1">Ditandatangani Oleh (Direksi) *</label>
            <select name="ditandatangani_oleh" required class="w-full border border-gray-200 rounded-lg px-4 py-2.5 text-sm focus:ring-2 focus:ring-teal outline-none">
                <option value="">-- Pilih Pejabat Direksi --</option>
                <?php foreach ($signers as $s): ?>
                    <option value="<?= $s['id'] ?>" <?= ($surat['penandatangan_id'] == $s['id']) ? 'selected' : '' ?>>
                        <?= htmlspecialchars($s['name']) ?> | <?= htmlspecialchars($s['position'] ?? '-') ?> | <?= htmlspecialchars($s['division'] ?? $s['department'] ?? '-') ?>
                    </option>
                <?php endforeach; ?>
            </select>
        </div>

        <!-- User yang Ditugaskan (Multiple Selection dengan Kriteria Jabatan & Nomenklatur Baru) -->
        <div>
            <label class="block text-xs font-semibold text-gray-600 mb-1">User yang Ditugaskan (Pilih satu atau lebih) *</label>
            <div class="border border-gray-200 rounded-lg p-3 max-h-52 overflow-y-auto space-y-2 bg-gray-50">
                <?php foreach ($users as $u): ?>
                    <?php 
                        // Aturan Nomenklatur Jabatan:
                        // - Kepala bidang: nama | jabatan | division (Nama Bidang)
                        // - Kepala divisi: nama | jabatan | department (Nama Divisi)
                        // - Staff: nama | jabatan | bidang
                        // - Selain dari itu cukup tampilkan jabatan
                        $posLower = strtolower(trim($u['position'] ?? ''));
                        $detailLabel = '';

                        if (strpos($posLower, 'kepala bidang') !== false) {
                            $detailLabel = $u['division'] ?? '-';
                        } elseif (strpos($posLower, 'kepala divisi') !== false) {
                            $detailLabel = $u['department'] ?? '-';
                        } elseif (strpos($posLower, 'staff') !== false) {
                            $detailLabel = $u['division'] ?? '-';
                        } else {
                            $detailLabel = $u['position'];
                        }

                        $formattedDisplay = $u['name'] . ' | ' . ($u['position'] ?? '-') . ' | ' . $detailLabel;
                        $isChecked = in_array($u['id'], $currentAssignedIds) ? 'checked' : '';
                    ?>
                    <label class="flex items-center gap-2 text-sm text-gray-700 cursor-pointer hover:bg-white p-2 rounded transition border border-transparent hover:border-gray-200">
                        <input type="checkbox" name="assigned_users[]" value="<?= $u['id'] ?>" <?= $isChecked ?> class="rounded border-gray-300 text-teal-600 focus:ring-teal">
                        <span class="font-medium"><?= htmlspecialchars($formattedDisplay) ?></span>
                    </label>
                <?php endforeach; ?>
            </div>
            <p class="text-[11px] text-gray-400 mt-1"><i class="fas fa-info-circle mr-1"></i>Centang pegawai yang akan dilampirkan ke dalam daftar penugasan surat.</p>
        </div>

        <!-- WYSIWYG Editor: Teks Pembuka -->
        <div>
            <div class="flex items-center justify-between mb-2">
                <label class="block text-xs font-semibold text-gray-600">Teks Pembuka (Konsiderans / Alasan Penugasan) *</label>
                <span class="text-[11px] text-gray-400">Standar Font: <?= $PDF_CONFIG['font_family'] ?></span>
            </div>
            <textarea id="summernote_pembuka" name="teks_pembuka" required><?= htmlspecialchars($surat['teks_pembuka']) ?></textarea>
        </div>

        <!-- WYSIWYG Editor: Berita Penugasan -->
        <div>
            <div class="flex items-center justify-between mb-2">
                <label class="block text-xs font-semibold text-gray-600">Berita Penugasan / Rincian Instruksi *</label>
                <span class="text-[11px] text-gray-400">Mendukung list & numbering otomatis</span>
            </div>
            <textarea id="summernote_berita" name="berita_penugasan" required><?= htmlspecialchars($surat['berita_penugasan']) ?></textarea>
        </div>

        <button type="submit" class="w-full bg-teal-600 hover:bg-teal-700 text-white font-bold py-3.5 px-4 rounded-xl transition flex items-center justify-center gap-2 shadow-sm">
            <i class="fas fa-save"></i> Perbarui Draft Surat Tugas
        </button>
    </form>
</main>
</div>

<script>
$(document).ready(function() {
    $('#summernote_pembuka, #summernote_berita').summernote({
        placeholder: 'Tuliskan isi dokumen di sini...',
        tabsize: 2,
        height: 250, 
        toolbar: [
          ['style', ['style']],
          ['font', ['bold', 'italic', 'underline', 'clear']],
          ['fontname', ['fontname']],
          ['fontsize', ['fontsize']],
          ['color', ['color']],
          ['para', ['ul', 'ol', 'paragraph']],
          ['height', ['height']],
          ['table', ['table']],
          ['insert', ['link', 'picture', 'hr']],
          ['view', ['fullscreen', 'codeview']]
        ],
        fontNames: ['Times New Roman', 'Verdana', 'Arial']
    });
});
</script>

<?php require_once 'includes/footer.php'; ?>