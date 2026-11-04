<?php
error_reporting(E_ALL);
error_reporting(-1);
ini_set('error_reporting', E_ALL);
require_once 'includes/mail_helper.php';
require_once 'config.php';
requireLogin();
$pageTitle = 'Buat Surat Keluar';

// Ambil daftar user aktif untuk pilihan Dikirim Oleh
$stmtUsers = $pdo->query("SELECT id, name, position, division, department FROM users WHERE is_active = 1 ORDER BY name ASC");
$users = $stmtUsers->fetchAll();

// Handle Submit Form
if ($_SERVER['REQUEST_METHOD'] === 'POST') {
    $nomorSurat    = trim($_POST['nomor_surat'] ?? '');
    $tanggalSurat  = $_POST['tanggal_surat'] ?? date('Y-m-d');
    $dikirimOleh   = (int)($_POST['dikirim_oleh'] ?? 0);
    $createdBy     = (int)$_SESSION['user_id']; // ID User yang sedang login & membuat dokumen
    $penerimaSurat = trim($_POST['penerima_surat'] ?? '');
    $perihal       = trim($_POST['perihal'] ?? '');
    $isiSurat      = trim($_POST['isi_surat'] ?? '');
    $status        = 'draft';

    // Validasi Lampiran (Upload multiple file/single file)
    $lampiranText = '-';
    if (isset($_FILES['lampiran_files']) && !empty($_FILES['lampiran_files']['name'][0])) {
        $uploadedCount = 0;
        $totalFiles = count($_FILES['lampiran_files']['name']);

        // Pastikan direktori upload ada
        if (!is_dir(UPLOAD_PATH)) {
            mkdir(UPLOAD_PATH, 0777, true);
        }

        for ($i = 0; $i < $totalFiles; $i++) {
            if ($_FILES['lampiran_files']['error'][$i] === UPLOAD_ERR_OK) {
                $tmpName = $_FILES['lampiran_files']['tmp_name'][$i];
                $fileName = time() . '_' . basename($_FILES['lampiran_files']['name'][$i]);
                move_uploaded_file($tmpName, UPLOAD_PATH . '/' . $fileName);
                $uploadedCount++;
            }
        }

        if ($uploadedCount > 0) {
            $lampiranText = $uploadedCount . ' File';
        }
    }

    // Eksekusi Simpan ke Database
    if (!empty($nomorSurat) && $dikirimOleh > 0 && !empty($penerimaSurat) && !empty($perihal) && !empty($isiSurat)) {
        try {
            $stmt = $pdo->prepare("
                INSERT INTO surat_keluar 
                (nomor_surat, tanggal_surat, dikirim_oleh, penandatangan, created_by, penerima_surat, perihal, lampiran_surat, isi_surat, status, created_at)
                VALUES (?, ?, ?, ?, ?, ?, ?, ?, ?, ?, NOW())
            ");
            $stmt->execute([
                $nomorSurat,
                $tanggalSurat,
                $dikirimOleh,
                $dikirimOleh, // Penandatangan diset otomatis sama dengan dikirim_oleh
                $createdBy,
                $penerimaSurat,
                $perihal,
                $lampiranText,
                $isiSurat,
                $status
            ]);
    
            logActivity($createdBy, 'create_surat_keluar', "Membuat Draft Surat Keluar #$nomorSurat", null);
            header('Location: ' . APP_URL . "/suratkeluar_list.php?msg=draft_created");
            exit;
        } catch (PDOException $e) {
            $error = 'Gagal menyimpan data: ' . $e->getMessage();
        }
    }
}

require_once 'includes/header.php';
require_once 'includes/sidebar.php';
?>

<!-- Summernote 0.9.0 Dependencies -->
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
.note-editable ul { list-style-type: disc !important; padding-left: 40px !important; }
.note-editable ol { list-style-type: decimal !important; padding-left: 40px !important; }
</style>

<div class="lg:ml-64 pt-14 min-h-screen">
<main class="p-4 md:p-6 lg:p-8 max-w-6xl mx-auto">

    <div class="flex items-center justify-between mb-6">
        <div>
            <h2 class="text-xl font-black text-gray-900 mb-1">Buat Surat Keluar Baru</h2>
            <p class="text-gray-500 text-sm">Tambahkan data pencatatan surat keluar ke dalam sistem</p>
        </div>
        <span class="inline-flex items-center gap-1.5 px-3 py-1.5 rounded-full text-xs font-semibold bg-amber-50 text-amber-700 border border-amber-200">
            <span class="w-2 h-2 rounded-full bg-amber-500"></span> Status Awal: Draft
        </span>
    </div>

    <?php if (isset($error)): ?>
    <div class="bg-red-50 border border-red-200 text-red-700 px-4 py-3 rounded-xl text-sm mb-4">
        <i class="fas fa-exclamation-circle mr-2"></i><?= htmlspecialchars($error) ?>
    </div>
    <?php endif; ?>

    <form method="POST" action="" enctype="multipart/form-data" class="bg-white rounded-2xl shadow-sm border border-gray-100 p-6 space-y-6">
        <div class="grid md:grid-cols-2 gap-4">
            <div>
                <label class="block text-xs font-semibold text-gray-600 mb-1">Nomor Surat *</label>
                <input type="text" name="nomor_surat" required class="w-full border border-gray-200 rounded-lg px-4 py-2.5 text-sm focus:ring-2 focus:ring-teal outline-none" placeholder="Contoh: 005/SK/IX/2026">
            </div>
            <div>
                <label class="block text-xs font-semibold text-gray-600 mb-1">Tanggal Surat *</label>
                <input type="date" name="tanggal_surat" value="<?= date('Y-m-d') ?>" required class="w-full border border-gray-200 rounded-lg px-4 py-2.5 text-sm focus:ring-2 focus:ring-teal outline-none">
            </div>
        </div>

        <div>
            <label class="block text-xs font-semibold text-gray-600 mb-1">Dikirim Oleh *</label>
            <select name="dikirim_oleh" required class="w-full border border-gray-200 rounded-lg px-4 py-2.5 text-sm focus:ring-2 focus:ring-teal outline-none">
                <option value="">-- Pilih Pengirim --</option>
                <?php foreach ($users as $u): ?>
                    <option value="<?= $u['id'] ?>" <?= ($_SESSION['user_id'] == $u['id']) ? 'selected' : '' ?>>
                        <?= htmlspecialchars($u['name']) ?> | <?= htmlspecialchars($u['position'] ?? '-') ?> | <?= htmlspecialchars($u['division'] ?? '-') ?>
                    </option>
                <?php endforeach; ?>
            </select>
        </div>

        <div class="grid md:grid-cols-2 gap-4">
            <div>
                <label class="block text-xs font-semibold text-gray-600 mb-1">Penerima Surat *</label>
                <input type="text" name="penerima_surat" required class="w-full border border-gray-200 rounded-lg px-4 py-2.5 text-sm focus:ring-2 focus:ring-teal outline-none" placeholder="Masukkan instansi / nama penerima">
            </div>
            <div>
                <label class="block text-xs font-semibold text-gray-600 mb-1">Lampiran File (Opsional)</label>
                <input type="file" name="lampiran_files[]" multiple class="w-full border border-gray-200 rounded-lg px-3 py-2 text-sm text-gray-500 focus:ring-2 focus:ring-teal outline-none">
            </div>
        </div>

        <div>
            <label class="block text-xs font-semibold text-gray-600 mb-1">Perihal *</label>
            <input type="text" name="perihal" required class="w-full border border-gray-200 rounded-lg px-4 py-2.5 text-sm focus:ring-2 focus:ring-teal outline-none" placeholder="Ringkasan atau judul surat">
        </div>

        <div>
            <label class="block text-xs font-semibold text-gray-600 mb-1 mb-2">Isi Surat *</label>
            <textarea id="summernote" name="isi_surat" required></textarea>
        </div>

        <button type="submit" class="w-full bg-teal-600 text-white font-bold py-3.5 rounded-xl hover:bg-teal-700 transition flex items-center justify-center text-sm">
            <i class="fas fa-save mr-1.5"></i> Simpan Sebagai Draft
        </button>
    </form>
</main>
</div>

<script>
$(document).ready(function() {
    $('#summernote').summernote({
        placeholder: 'Tuliskan isi detail surat di sini...',
        tabsize: 2,
        height: 450, 
        toolbar: [
          ['style', ['style']],
          ['font', ['bold', 'italic', 'underline', 'clear']],
          ['color', ['color']],
          ['para', ['ul', 'ol', 'paragraph']],
          ['height', ['height']],
          ['table', ['table']],
          ['insert', ['link', 'picture', 'video', 'hr']],
          ['view', ['fullscreen', 'codeview', 'help']]
        ]
    });
});
</script>

<?php require_once 'includes/footer.php'; ?>