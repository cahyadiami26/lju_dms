<?php
error_reporting(E_ALL);
error_reporting(-1);
ini_set('error_reporting', E_ALL);
require_once 'includes/mail_helper.php';
require_once 'config.php';
requireLogin();

$pageTitle = 'Edit Surat Keluar';
$currentUserId = $_SESSION['user_id'];
$id = (int)($_GET['id'] ?? 0);

// Ambil data surat keluar berdasarkan ID
$stmt = $pdo->prepare("SELECT * FROM surat_keluar WHERE id = ?");
$stmt->execute([$id]);
$surat = $stmt->fetch();

// Otorisasi: Hanya pembuat atau pengirim yang diizinkan mengedit
if (!$surat || ($surat['created_by'] != $currentUserId && $surat['dikirim_oleh'] != $currentUserId)) {
    header('Location: ' . APP_URL . '/suratkeluar_list.php');
    exit;
}

// Ambil daftar user aktif untuk pilihan Dikirim Oleh
$stmtUsers = $pdo->query("SELECT id, name, position, division, department FROM users WHERE is_active = 1 ORDER BY name ASC");
$users = $stmtUsers->fetchAll();

// Handle Submit Form Update
if ($_SERVER['REQUEST_METHOD'] === 'POST') {
    $nomorSurat    = trim($_POST['nomor_surat'] ?? '');
    $tanggalSurat  = $_POST['tanggal_surat'] ?? date('Y-m-d');
    $dikirimOleh   = (int)($_POST['dikirim_oleh'] ?? 0);
    $penerimaSurat = trim($_POST['penerima_surat'] ?? '');
    $perihal       = trim($_POST['perihal'] ?? '');
    $isiSurat       = trim($_POST['isi_surat'] ?? '');

    // Pertahankan teks lampiran lama jika tidak ada unggahan file baru
    $lampiranText = $surat['lampiran_surat'];

    if (isset($_FILES['lampiran_files']) && !empty($_FILES['lampiran_files']['name'][0])) {
        $uploadedCount = 0;
        $totalFiles = count($_FILES['lampiran_files']['name']);

        for ($i = 0; $i < $totalFiles; $i++) {
            if ($_FILES['lampiran_files']['error'][$i] === UPLOAD_ERR_OK) {
                $uploadedCount++;
            }
        }

        if ($uploadedCount > 0) {
            $lampiranText = $uploadedCount . ' File';
        }
    }

    // Eksekusi Update Data ke Database
    if (!empty($nomorSurat) && $dikirimOleh > 0 && !empty($penerimaSurat) && !empty($perihal) && !empty($isiSurat)) {
        try {
            $stmtUpdate = $pdo->prepare("
                UPDATE surat_keluar 
                SET nomor_surat = ?, 
                    tanggal_surat = ?, 
                    dikirim_oleh = ?, 
                    penerima_surat = ?, 
                    perihal = ?, 
                    lampiran_surat = ?, 
                    isi_surat = ?, 
                    modified_at = NOW()
                WHERE id = ?
            ");
            $stmtUpdate->execute([
                $nomorSurat,
                $tanggalSurat,
                $dikirimOleh,
                $penerimaSurat,
                $perihal,
                $lampiranText,
                $isiSurat,
                $id
            ]);

            logActivity($currentUserId, 'update_surat_keluar', "Mengubah Surat Keluar #$nomorSurat", null);
            header('Location: ' . APP_URL . "/suratkeluar_list.php?msg=updated");
            exit;
        } catch (PDOException $e) {
            $error = 'Gagal memperbarui data: ' . $e->getMessage();
        }
    } else {
        $error = 'Harap isi semua kolom wajib.';
    }
}

require_once 'includes/header.php';
require_once 'includes/sidebar.php';
?>

<!-- Summernote Dependencies -->
<script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
<link href="https://cdn.jsdelivr.net/npm/summernote@0.8.18/dist/summernote-lite.min.css" rel="stylesheet">
<script src="https://cdn.jsdelivr.net/npm/summernote@0.8.18/dist/summernote-lite.min.js"></script>

<style>
.note-editor.note-frame { border: 1px solid #e5e7eb !important; border-radius: 0.5rem !important; overflow: hidden; }
.note-toolbar { background-color: #f9fafb !important; border-bottom: 1px solid #e5e7eb !important; }
/* Memperbaiki Unordered List (ul) dan Ordered List (ol) agar muncul kembali bullet & nomornya */
.note-editable ul {
    list-style-type: disc !important;
    list-style: disc !important;
    padding-left: 40px !important;
    margin-bottom: 10px !important;
}

.note-editable ol {
    list-style-type: decimal !important;
    list-style: decimal !important;
    padding-left: 40px !important;
    margin-bottom: 10px !important;
}

.note-editable li {
    display: list-item !important;
    list-style: inherit !important;
}

/* Kustomisasi Frame Summernote agar Mirip Layout Dokumen (Word / Google Docs) */
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

/* Lembar Kerja (Paper View) */
.note-editing-area {
    padding: 20px 0;
}
.note-editable { 
    background-color: #ffffff !important; 
    max-width: 800px; 
    margin: 0 auto !important; 
    padding: 2.5cm 2cm !important; 
    min-height: 500px !important; 
    box-shadow: 0 4px 6px -1px rgba(0, 0, 0, 0.1), 0 2px 4px -1px rgba(0, 0, 0, 0.06) !important;
    border-radius: 4px;
    font-family: "Times New Roman", Times, serif;
    font-size: 14px;
    line-height: 1.6;
}
</style>

<div class="lg:ml-64 pt-14 min-h-screen">
<main class="p-4 md:p-6 lg:p-8 max-w-4xl">

    <!-- Header & Navigation -->
    <div class="flex items-center justify-between mb-6">
        <div>
            <h2 class="text-xl font-black text-gray-900 mb-1">Edit Surat Keluar</h2>
            <p class="text-gray-500 text-sm">Perbarui informasi pencatatan surat keluar</p>
        </div>
        <a href="<?= APP_URL ?>/suratkeluar_list.php" class="inline-flex items-center gap-2 text-sm text-gray-500 hover:text-brand">
            <i class="fas fa-arrow-left"></i> Batal / Kembali
        </a>
    </div>

    <?php if (isset($error)): ?>
    <div class="bg-red-50 border border-red-200 text-red-700 px-4 py-3 rounded-xl text-sm mb-4">
        <i class="fas fa-exclamation-circle mr-2"></i><?= htmlspecialchars($error) ?>
    </div>
    <?php endif; ?>

    <form method="POST" action="" enctype="multipart/form-data" class="bg-white rounded-2xl shadow-sm border border-gray-100 p-6 space-y-5">
        <div class="grid md:grid-cols-2 gap-4">
            <div>
                <label class="block text-xs font-semibold text-gray-600 mb-1">Nomor Surat *</label>
                <input type="text" name="nomor_surat" value="<?= htmlspecialchars($surat['nomor_surat']) ?>" required class="w-full border border-gray-200 rounded-lg px-4 py-2.5 text-sm focus:ring-2 focus:ring-teal outline-none" placeholder="Contoh: 005/SK/IX/2026">
            </div>

            <div>
                <label class="block text-xs font-semibold text-gray-600 mb-1">Tanggal Surat *</label>
                <input type="date" name="tanggal_surat" value="<?= htmlspecialchars($surat['tanggal_surat']) ?>" required class="w-full border border-gray-200 rounded-lg px-4 py-2.5 text-sm focus:ring-2 focus:ring-teal outline-none">
            </div>
        </div>

        <div>
            <label class="block text-xs font-semibold text-gray-600 mb-1">Dikirim Oleh *</label>
            <select name="dikirim_oleh" required class="w-full border border-gray-200 rounded-lg px-4 py-2.5 text-sm focus:ring-2 focus:ring-teal outline-none">
                <option value="">-- Pilih Pengirim --</option>
                <?php foreach ($users as $u): ?>
                    <option value="<?= $u['id'] ?>" <?= ($surat['dikirim_oleh'] == $u['id']) ? 'selected' : '' ?>>
                        <?= htmlspecialchars($u['name']) ?> | <?= htmlspecialchars($u['position'] ?? '-') ?> | <?= htmlspecialchars($u['division'] ?? '-') ?> | <?= htmlspecialchars($u['department'] ?? '-') ?>
                    </option>
                <?php endforeach; ?>
            </select>
        </div>

        <div class="grid md:grid-cols-2 gap-4">
            <div>
                <label class="block text-xs font-semibold text-gray-600 mb-1">Penerima Surat *</label>
                <input type="text" name="penerima_surat" value="<?= htmlspecialchars($surat['penerima_surat']) ?>" required class="w-full border border-gray-200 rounded-lg px-4 py-2.5 text-sm focus:ring-2 focus:ring-teal outline-none" placeholder="Masukkan instansi / nama penerima">
            </div>

            <div>
                <label class="block text-xs font-semibold text-gray-600 mb-1">Lampiran File (Opsional)</label>
                <input type="file" name="lampiran_files[]" multiple class="w-full border border-gray-200 rounded-lg px-3 py-2 text-sm text-gray-500 focus:ring-2 focus:ring-teal outline-none">
                <p class="text-[10px] text-gray-400 mt-1">Status lampiran saat ini: <strong><?= htmlspecialchars($surat['lampiran_surat']) ?></strong> (Biarkan kosong jika tidak mengubah lampiran)</p>
            </div>
        </div>

        <div>
            <label class="block text-xs font-semibold text-gray-600 mb-1">Perihal *</label>
            <input type="text" name="perihal" value="<?= htmlspecialchars($surat['perihal']) ?>" required class="w-full border border-gray-200 rounded-lg px-4 py-2.5 text-sm focus:ring-2 focus:ring-teal outline-none" placeholder="Ringkasan atau judul surat">
        </div>

        <div>
            <label class="block text-xs font-semibold text-gray-600 mb-1">Isi Surat *</label>
            <textarea id="summernote" name="isi_surat" required><?= htmlspecialchars($surat['isi_surat']) ?></textarea>
        </div>

        <div class="flex items-center gap-3 pt-2">
            <button type="submit" class="btn-primary flex-1 justify-center py-3">
                <i class="fas fa-save mr-1"></i> Simpan Perubahan
            </button>
            <a href="<?= APP_URL ?>/suratkeluar_list.php" class="btn-outline px-6 py-3 text-center">
                Batal
            </a>
        </div>
    </form>
</main>
</div>

<script>
$(document).ready(function() {
    $('#summernote').summernote({
        placeholder: 'Tuliskan isi detail surat di sini...',
        tabsize: 2, // Mengaktifkan fungsi tab (indentasi)
        height: 450, 
        toolbar: [
          ['style', ['style']],
          ['font', ['bold', 'italic', 'underline', 'clear']], // Tombol italic dikembalikan
          ['fontname', ['fontname']], // Memunculkan pilihan jenis font (Arial, Times New Roman, dll)
          ['fontsize', ['fontsize']],
          ['color', ['color']],       // Memunculkan pilihan warna teks/background
          ['para', ['ul', 'ol', 'paragraph']], // Tombol list (unordered & ordered)
          ['height', ['height']],
          ['table', ['table']],
          ['insert', ['link', 'picture', 'video', 'hr']], // Memunculkan insert gambar & video
          ['view', ['fullscreen', 'codeview', 'help']]   // Memunculkan tombol bantuan (?)
        ],
        fontNames: ['Arial', 'Arial Black', 'Comic Sans MS', 'Courier New', 'Merriweather', 'Georgia', 'Impact', 'Tahoma', 'Times New Roman', 'Verdana'],
        fontNamesIgnoreCheck: ['Merriweather']
    });
});
</script>

<?php require_once 'includes/footer.php'; ?>