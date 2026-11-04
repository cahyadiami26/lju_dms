<?php
require_once 'config.php';
require_once 'includes/mail_helper.php';
requireLogin();
$pageTitle = 'Data Surat Masuk/Keluar';

$currentUserId = (int)$_SESSION['user_id'];

// Ambil data user yang sedang login untuk memeriksa divisi dan role
$stmtUser = $pdo->prepare("SELECT division, role FROM users WHERE id = ?");
$stmtUser->execute([$currentUserId]);
$currentUser = $stmtUser->fetch();

$userDivision  = strtolower(trim($currentUser['division'] ?? ''));
$userRole      = strtolower(trim($currentUser['role'] ?? ''));
$isSecretariat = ($userDivision === 'kesekretariatan' || $userRole === 'op-arsip');

// Ambil daftar user untuk dropdown 'User Tujuan' dan 'Filter'
// Asumsi ada kolom 'division' pada tabel users
$stmtUsers = $pdo->query("SELECT id, name FROM users ORDER BY name ASC");
$userList = $stmtUsers->fetchAll();

// Handle Upload
if ($_SERVER['REQUEST_METHOD'] === 'POST' && isset($_POST['action']) && $_POST['action'] === 'upload') {
    $title = trim($_POST['title'] ?? '');
    $docType = $_POST['document_type'] ?? 'surat_masuk';
    $recipientId = !empty($_POST['recipient_id']) ? $_POST['recipient_id'] : null;
    $priority = $_POST['priority'] ?? 'biasa';
    $nature = $_POST['nature'] ?? 'biasa';
    $category = trim($_POST['category'] ?? '');
    $tags = trim($_POST['tags'] ?? '');
    $description = trim($_POST['description'] ?? '');
    $sender = trim($_POST['sender'] ?? '');
    $mailNumber = trim($_POST['mail_number'] ?? '');
    $mailDate = $_POST['mail_date'] ?? null;

    if (isset($_FILES['document']) && $_FILES['document']['error'] === UPLOAD_ERR_OK) {
        $file = $_FILES['document'];
        $ext = strtolower(pathinfo($file['name'], PATHINFO_EXTENSION));

        if (!in_array($ext, ALLOWED_EXTENSIONS)) {
            $uploadError = 'Format file tidak didukung';
        } elseif ($file['size'] > MAX_FILE_SIZE) {
            $uploadError = 'Ukuran file maksimal 20MB';
        } else {
            $docNumber = generateDocNumber();
            $company = APP_LOGO_TEXT;
            $year = date('Y');
            $month = date('m');

            $relativeDir = "uploads/documents/$company/$year/$month";
            $absoluteDir = APP_PATH . '/' . $relativeDir;

            if (!is_dir($absoluteDir)) {
                mkdir($absoluteDir, 0755, true);
            }

            $fileName = uniqid('DOC_', true) . '.' . $ext;
            $absolutePath = $absoluteDir . '/' . $fileName;
            $relativePath = $relativeDir . '/' . $fileName;

            if (move_uploaded_file($file['tmp_name'], $absolutePath)) {
                $stmt = $pdo->prepare("
                    INSERT INTO documents
                    (user_id, recipient_id, document_number, title, description, file_path, file_type, file_size, category, tags, document_type, priority, nature, sender, mail_number, mail_date)
                    VALUES (?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?)
                ");
                $stmt->execute([
                    $_SESSION['user_id'], $recipientId, $docNumber, $title, $description, $relativePath, $ext, $file['size'], $category, $tags, $docType, $priority, $nature, $sender, $mailNumber, $mailDate ?: null
                ]);
                $docId = $pdo->lastInsertId();
                logActivity($_SESSION['user_id'], 'upload', "Upload dokumen: $title", $docId);
                if ($recipientId) {
                    $stmtRec = $pdo->prepare("SELECT name, email FROM users WHERE id = ?");
                    $stmtRec->execute([$recipientId]);
                    $recUser = $stmtRec->fetch();

                    if ($recUser && !empty($recUser['email'])) {
                        sendEmailNotification(
                            $recUser['email'],
                            $recUser['name'],
                            'Surat Masuk: ' . $title,
                            'suratmasuk',
                            [
                                'DOC_NUMBER' => $docNumber,
                                'DOC_TITLE' => $title,
                                'DOC_ID' => $docId,
                                'DOC_PENGIRIM' => $sender
                            ]
                        );
                    }
                }
                header('Location: ' . APP_URL . '/documents.php?msg=uploaded');
                exit;
            } else {
                $errorDetail = error_get_last();
                $pesanSistem = $errorDetail ? $errorDetail['message'] : 'Izin ditolak atau direktori tidak ditemukan.';
                $uploadError = 'Gagal mengupload file: ' . $pesanSistem;
            }
        }
    } else {
        $uploadError = 'Pilih file untuk diupload';
    }
}

// Handle Delete
if (isset($_GET['delete'])) {
    $id = (int)$_GET['delete'];
    $stmt = $pdo->prepare("SELECT * FROM documents WHERE id = ?");
    $stmt->execute([$id]);
    $doc = $stmt->fetch();
    if ($doc && ($doc['user_id'] == $_SESSION['user_id'] || $_SESSION['role'] === 'admin')) {
        if (file_exists($doc['file_path'])) unlink($doc['file_path']);
        if ($doc['signed_pdf_path'] && file_exists($doc['signed_pdf_path'])) unlink($doc['signed_pdf_path']);
        $pdo->prepare("DELETE FROM documents WHERE id = ?")->execute([$id]);
        logActivity($_SESSION['user_id'], 'delete', "Hapus dokumen: " . $doc['title']);
        header('Location: ' . APP_URL . '/documents.php?msg=deleted');
        exit;
    }
}

// Variables for Filter & Search
$search = $_GET['search'] ?? '';
$filterStatus = $_GET['status'] ?? '';
$filterType = $_GET['type'] ?? '';
$filterPriority = $_GET['priority'] ?? '';
$filterUploader = $_GET['filter_uploader'] ?? '';
$filterRecipient = $_GET['filter_recipient'] ?? '';
$action = $_GET['action'] ?? '';
$showUpload = $action === 'upload';

// Query Utama (Join dengan tabel users 2x untuk mendapat uploader dan recipient)
$query = "
    SELECT d.*, 
           u.name as uploader, 
           r.name as recipient_name, 
           r.division as recipient_division 
    FROM documents d 
    JOIN users u ON d.user_id = u.id 
    LEFT JOIN users r ON d.recipient_id = r.id 
    WHERE 1=1
";
$params = [];

// Filter Hak Akses Role & Divisi
if ($_SESSION['role'] !== 'admin' && !$isSecretariat) {
    $query .= " AND (d.user_id = ? OR d.recipient_id = ?)";
    $params[] = $currentUserId;
    $params[] = $currentUserId;
}

// Filter Pencarian
if ($search) { $query .= " AND (d.title LIKE ? OR d.document_number LIKE ? OR d.tags LIKE ?)"; $params[] = "%$search%"; $params[] = "%$search%"; $params[] = "%$search%"; }
if ($filterStatus) { $query .= " AND d.status = ?"; $params[] = $filterStatus; }
if ($filterType) { $query .= " AND d.document_type = ?"; $params[] = $filterType; }
if ($filterPriority) { $query .= " AND d.priority = ?"; $params[] = $filterPriority; }
if ($filterUploader) { $query .= " AND d.user_id = ?"; $params[] = $filterUploader; }
if ($filterRecipient) { $query .= " AND d.recipient_id = ?"; $params[] = $filterRecipient; }

if (isset($_GET['filter']) && $_GET['filter'] === 'pending_signature') {
    $query .= " AND d.status IN ('draft','pending_signature')";
}

$query .= " ORDER BY d.created_at DESC";

$stmt = $pdo->prepare($query);
$stmt->execute($params);
$documents = $stmt->fetchAll();

$msg = $_GET['msg'] ?? '';

require_once 'includes/header.php';
require_once 'includes/sidebar.php';
?>

<div class="lg:ml-64 pt-14 min-h-screen">
<main class="p-4 md:p-6 lg:p-8">

    <?php if ($msg === 'uploaded' || $msg === 'deleted' || isset($uploadError)): ?>
    <script>
        document.addEventListener('DOMContentLoaded', function() {
            <?php if ($msg === 'uploaded'): ?>showToast('Dokumen berhasil diupload', 'success');<?php endif; ?>
            <?php if ($msg === 'deleted'): ?>showToast('Dokumen berhasil dihapus', 'success');<?php endif; ?>
            <?php if (isset($uploadError)): ?>showToast('<?= esc($uploadError) ?>', 'error');<?php endif; ?>
        });
    </script>
    <?php endif; ?>

    <!-- Header -->
    <div class="flex flex-col sm:flex-row sm:items-center justify-between gap-4 mb-6">
        <div>
            <h2 class="text-xl font-black text-gray-900">Data Surat Masuk/Keluar</h2>
            <p class="text-gray-500 text-sm">Kelola semua dokumen surat masuk dan internal</p>
        </div>
        <button onclick="toggleUploadForm()" class="btn-primary">
            <i class="fas fa-plus"></i> Upload Dokumen
        </button>
    </div>

    <!-- Upload Form (toggle) -->
    <div id="uploadForm" class="<?= $showUpload ? '' : 'hidden' ?> bg-white rounded-2xl shadow-sm border border-gray-100 p-6 mb-6">
        <h3 class="font-bold text-gray-800 mb-4"><i class="fas fa-cloud-upload-alt text-brand mr-2"></i>Upload Dokumen Baru</h3>
        <form method="POST" action="" enctype="multipart/form-data">
            <input type="hidden" name="action" value="upload">
            <div class="grid md:grid-cols-2 gap-4">
                <div class="md:col-span-2">
                    <label class="block text-xs font-semibold text-gray-600 mb-1">Judul Dokumen *</label>
                    <input type="text" name="title" required class="w-full border border-gray-200 rounded-lg px-4 py-2.5 text-sm focus:ring-2 focus:ring-teal focus:border-teal outline-none" placeholder="Judul surat/dokumen">
                </div>
                <div>
                    <label class="block text-xs font-semibold text-gray-600 mb-1">File Dokumen *</label>
                    <input type="file" name="document" required accept=".pdf,.jpg,.jpeg,.png,.doc,.docx,.xls,.xlsx" class="w-full border border-gray-200 rounded-lg px-4 py-2 text-sm file:mr-3 file:py-1 file:px-3 file:rounded-md file:border-0 file:text-xs file:font-semibold file:bg-teal-50 file:text-teal-700">
                </div>
                <div>
                    <label class="block text-xs font-semibold text-gray-600 mb-1">User Tujuan *</label>
                    <select name="recipient_id" required class="w-full border border-gray-200 rounded-lg px-4 py-2.5 text-sm focus:ring-2 focus:ring-teal outline-none">
                        <option value="">Pilih User Tujuan</option>
                        <?php foreach ($userList as $user): ?>
                            <option value="<?= $user['id'] ?>"><?= esc($user['name']) ?></option>
                        <?php endforeach; ?>
                    </select>
                </div>
                <div>
                    <label class="block text-xs font-semibold text-gray-600 mb-1">Jenis Dokumen</label>
                    <select name="document_type" class="w-full border border-gray-200 rounded-lg px-4 py-2.5 text-sm focus:ring-2 focus:ring-teal outline-none">
                        <option value="surat_masuk">Surat Masuk</option>
                        <option value="surat_internal">Surat Internal</option>
                        <option value="surat_keluar">Surat Keluar</option>
                    </select>
                </div>
                <div>
                    <label class="block text-xs font-semibold text-gray-600 mb-1">Prioritas</label>
                    <select name="priority" class="w-full border border-gray-200 rounded-lg px-4 py-2.5 text-sm focus:ring-2 focus:ring-teal outline-none">
                        <option value="biasa">Biasa</option>
                        <option value="segera">Segera</option>
                        <option value="sangat_segera">Sangat Segera</option>
                    </select>
                </div>
                <div>
                    <label class="block text-xs font-semibold text-gray-600 mb-1">Sifat</label>
                    <select name="nature" class="w-full border border-gray-200 rounded-lg px-4 py-2.5 text-sm focus:ring-2 focus:ring-teal outline-none">
                        <option value="biasa">Biasa</option>
                        <option value="rahasia">Rahasia</option>
                        <option value="sangat_rahasia">Sangat Rahasia</option>
                    </select>
                </div>
                <div>
                    <label class="block text-xs font-semibold text-gray-600 mb-1">Pengirim</label>
                    <input type="text" name="sender" class="w-full border border-gray-200 rounded-lg px-4 py-2.5 text-sm focus:ring-2 focus:ring-teal outline-none" placeholder="Nama pengirim surat">
                </div>
                <div>
                    <label class="block text-xs font-semibold text-gray-600 mb-1">Nomor Surat</label>
                    <input type="text" name="mail_number" class="w-full border border-gray-200 rounded-lg px-4 py-2.5 text-sm focus:ring-2 focus:ring-teal outline-none" placeholder="No. surat asli">
                </div>
                <div>
                    <label class="block text-xs font-semibold text-gray-600 mb-1">Tanggal Surat</label>
                    <input type="date" name="mail_date" class="w-full border border-gray-200 rounded-lg px-4 py-2.5 text-sm focus:ring-2 focus:ring-teal outline-none">
                </div>
                <div>
                    <label class="block text-xs font-semibold text-gray-600 mb-1">Kategori</label>
                    <input type="text" name="category" class="w-full border border-gray-200 rounded-lg px-4 py-2.5 text-sm focus:ring-2 focus:ring-teal outline-none" placeholder="Contoh: Undangan, SK, Laporan">
                </div>
                <div>
                    <label class="block text-xs font-semibold text-gray-600 mb-1">Tags</label>
                    <div id="tagContainer" class="flex flex-wrap gap-1 border border-gray-200 rounded-lg px-3 py-2 min-h-[42px] items-center focus-within:ring-2 focus-within:ring-teal">
                        <input type="text" id="tagInput" placeholder="Ketik + Enter" class="flex-1 min-w-[80px] outline-none text-sm border-none p-0">
                        <input type="hidden" name="tags" id="tagsHidden" value="">
                    </div>
                </div>
                <div class="md:col-span-2">
                    <label class="block text-xs font-semibold text-gray-600 mb-1">Keterangan</label>
                    <textarea name="description" rows="2" class="w-full border border-gray-200 rounded-lg px-4 py-2.5 text-sm focus:ring-2 focus:ring-teal outline-none resize-none" placeholder="Deskripsi singkat dokumen"></textarea>
                </div>
            </div>
            <div class="flex gap-3 mt-4">
                <button type="submit" class="btn-primary"><i class="fas fa-upload"></i> Upload</button>
                <button type="button" onclick="toggleUploadForm()" class="btn-outline">Batal</button>
            </div>
        </form>
    </div>

    <!-- Search & Filter -->
    <div class="bg-white rounded-2xl shadow-sm border border-gray-100 p-4 mb-6">
        <form method="GET" action="" class="flex flex-wrap gap-3 items-end">
            <div class="flex-1 min-w-[200px]">
                <div class="relative">
                    <i class="fas fa-search absolute left-3 top-1/2 -translate-y-1/2 text-gray-400 text-sm"></i>
                    <input type="text" name="search" value="<?= esc($search) ?>" placeholder="Cari dokumen..." class="w-full border border-gray-200 rounded-lg pl-9 pr-4 py-2 text-sm focus:ring-2 focus:ring-teal outline-none">
                </div>
            </div>
            
            <select name="filter_uploader" class="border border-gray-200 rounded-lg px-3 py-2 text-sm focus:ring-2 focus:ring-teal outline-none">
                <option value="">Semua Pengupload</option>
                <?php foreach ($userList as $user): ?>
                    <option value="<?= $user['id'] ?>" <?= $filterUploader == $user['id'] ? 'selected' : '' ?>><?= esc($user['name']) ?></option>
                <?php endforeach; ?>
            </select>

            <select name="filter_recipient" class="border border-gray-200 rounded-lg px-3 py-2 text-sm focus:ring-2 focus:ring-teal outline-none">
                <option value="">Semua Tujuan</option>
                <?php foreach ($userList as $user): ?>
                    <option value="<?= $user['id'] ?>" <?= $filterRecipient == $user['id'] ? 'selected' : '' ?>><?= esc($user['name']) ?></option>
                <?php endforeach; ?>
            </select>

            <select name="type" class="border border-gray-200 rounded-lg px-3 py-2 text-sm focus:ring-2 focus:ring-teal outline-none">
                <option value="">Semua Jenis</option>
                <option value="surat_masuk" <?= $filterType === 'surat_masuk' ? 'selected' : '' ?>>Surat Masuk</option>
                <option value="surat_internal" <?= $filterType === 'surat_internal' ? 'selected' : '' ?>>Surat Internal</option>
                <option value="surat_keluar" <?= $filterType === 'surat_keluar' ? 'selected' : '' ?>>Surat Keluar</option>
            </select>
            
            <button type="submit" class="btn-primary text-xs py-2"><i class="fas fa-filter"></i> Filter</button>
            <a href="<?= APP_URL ?>/documents.php" class="btn-outline text-xs py-2">Reset</a>
        </form>
    </div>

    <!-- Document Table -->
    <div class="bg-white rounded-2xl shadow-sm border border-gray-100 overflow-hidden">
        <div class="overflow-x-auto">
            <table class="table-modern w-full">
                <thead>
                    <tr>
                        <th class="text-left px-4 py-3">No. Dokumen</th>
                        <th class="text-left px-4 py-3">Judul & Pengupload</th>
                        <th class="text-left px-4 py-3">Tujuan</th>
                        <th class="text-left px-4 py-3">Jenis</th>
                        <th class="text-left px-4 py-3">Status</th>
                        <th class="text-left px-4 py-3">Diupload</th>
                        <th class="text-left px-4 py-3">Aksi</th>
                    </tr>
                </thead>
                <tbody>
                    <?php foreach ($documents as $doc): ?>
                    <tr class="border-t border-gray-100 hover:bg-gray-50">
                        <td class="px-4 py-3 font-mono text-xs text-gray-600"><?= esc($doc['document_number']) ?></td>
                        <td class="px-4 py-3">
                            <div class="font-semibold text-gray-800"><?= esc($doc['title']) ?></div>
                            <div class="text-[10px] text-gray-400 mt-0.5"><i class="fas fa-user-upload mr-1"></i><?= esc($doc['uploader']) ?></div>
                            <?php if ($doc['tags']): ?>
                            <div class="flex flex-wrap gap-1 mt-1">
                                <?php foreach (explode(',', $doc['tags']) as $tag): ?>
                                <span class="bg-teal-50 text-teal-600 text-[10px] px-1.5 py-0.5 rounded font-medium"><?= esc(trim($tag)) ?></span>
                                <?php endforeach; ?>
                            </div>
                            <?php endif; ?>
                        </td>
                        <td class="px-4 py-3">
                            <?php if ($doc['recipient_name']): ?>
                                <div class="font-semibold text-gray-800 text-xs"><?= esc($doc['recipient_name']) ?></div>
                                <div class="text-[10px] text-gray-500 mt-0.5"><i class="fas fa-sitemap mr-1"></i><?= esc($doc['recipient_division'] ?? '-') ?></div>
                            <?php else: ?>
                                <span class="text-gray-400 text-xs">-</span>
                            <?php endif; ?>
                        </td>
                        <td class="px-4 py-3 text-xs text-gray-600"><?= ucwords(str_replace('_', ' ', $doc['document_type'])) ?></td>
                        <td class="px-4 py-3">
                            <div class="mb-1"><?= priorityBadge($doc['priority']) ?></div>
                            <div><?= statusBadge($doc['status']) ?></div>
                        </td>
                        <td class="px-4 py-3 text-xs text-gray-500"><?= formatDateShort($doc['created_at']) ?></td>
                        <td class="px-4 py-3">
                            <div class="flex items-center gap-2">
                                <a href="<?= APP_URL ?>/document_view.php?id=<?= $doc['id'] ?>" class="p-1.5 text-gray-400 hover:text-teal-600 transition-colors" title="Lihat"><i class="fas fa-eye"></i></a>
                                <a href="<?= APP_URL ?>/disposition_create.php?doc_id=<?= $doc['id'] ?>" class="p-1.5 text-gray-400 hover:text-orange-600 transition-colors" title="Disposisi"><i class="fas fa-paper-plane"></i></a>
                                <?php if ($doc['user_id'] == $_SESSION['user_id'] || $_SESSION['role'] === 'admin'): ?>
                                <a href="javascript:void(0)" onclick="deleteItem('<?= APP_URL ?>/documents.php?delete=<?= $doc['id'] ?>', 'Hapus dokumen ini?')" class="p-1.5 text-gray-400 hover:text-red-600 transition-colors" title="Hapus"><i class="fas fa-trash"></i></a>
                                <?php endif; ?>
                            </div>
                        </td>
                    </tr>
                    <?php endforeach; ?>
                    <?php if (empty($documents)): ?>
                    <tr><td colspan="7" class="text-center py-8 text-gray-400 text-sm">Tidak ada dokumen ditemukan</td></tr>
                    <?php endif; ?>
                </tbody>
            </table>
        </div>
    </div>

</main>
</div>

<script>
function toggleUploadForm() {
    document.getElementById('uploadForm').classList.toggle('hidden');
}
<?php if ($showUpload): ?>document.getElementById('uploadForm').classList.remove('hidden');<?php endif; ?>
</script>
<?php require_once 'includes/footer.php'; ?>