<?php
require_once 'config.php';
require_once 'includes/mail_helper.php';
requireLogin();
$pageTitle = 'Buat Disposisi';

// Ambil daftar user untuk tujuan disposisi
$users = $pdo->query("SELECT id, name, position, division FROM users WHERE is_active = 1 AND id != {$_SESSION['user_id']} ORDER BY name")->fetchAll();

// Ambil dokumen yang sudah diupload
$docs = $pdo->query("SELECT id, document_number, title FROM documents ORDER BY created_at DESC")->fetchAll();

// Pre-select doc
$preDocId = (int)($_GET['doc_id'] ?? 0);

// Handle Submit
if ($_SERVER['REQUEST_METHOD'] === 'POST') {
    $docId = (int)($_POST['document_id'] ?? 0);
    $toUserId = (int)($_POST['to_user_id'] ?? 0);
    $priority = $_POST['priority'] ?? 'biasa';
    $nature = $_POST['nature'] ?? 'biasa';
    $notes = trim($_POST['notes'] ?? '');
    $uploadNew = isset($_POST['upload_new']);
    $newDocTitle = trim($_POST['new_title'] ?? '');
    $ccArsip = isset($_POST['cc_arsip']); // Cek apakah checkbox tembusan arsip dicentang

    // Jika upload dokumen baru
    if ($uploadNew && isset($_FILES['new_document']) && $_FILES['new_document']['error'] === UPLOAD_ERR_OK) {
        $file = $_FILES['new_document'];
        $ext = strtolower(pathinfo($file['name'], PATHINFO_EXTENSION));
        $docNumber = generateDocNumber();
        $filename = $docNumber . '_' . time() . '.' . $ext;
        $filepath = UPLOAD_PATH . '/' . $filename;
        if (move_uploaded_file($file['tmp_name'], $filepath)) {
            $stmt = $pdo->prepare("INSERT INTO documents (user_id, document_number, title, file_path, file_type, file_size, status, document_type, priority, nature) VALUES (?, ?, ?, ?, ?, ?, 'dispositioned', 'surat_internal', ?, ?)");
            $stmt->execute([$_SESSION['user_id'], $docNumber, $newDocTitle ?: 'Disposisi Baru', $filepath, $ext, $file['size'], $priority, $nature]);
            $docId = $pdo->lastInsertId();
            logActivity($_SESSION['user_id'], 'upload', "Upload dokumen baru untuk disposisi", $docId);
        }
    }

    if ($docId && $toUserId) {
        // 1. Simpan Disposisi Utama ke Tujuan
        $stmt = $pdo->prepare("INSERT INTO dispositions (document_id, from_user_id, to_user_id, status, priority, nature, notes) VALUES (?, ?, ?, 'pending', ?, ?, ?)");
        $stmt->execute([$docId, $_SESSION['user_id'], $toUserId, $priority, $nature, $notes]);
        $dispId = $pdo->lastInsertId();

        // History Utama
        $pdo->prepare("INSERT INTO disposition_history (disposition_id, user_id, action, notes) VALUES (?, ?, 'created', ?)")
            ->execute([$dispId, $_SESSION['user_id'], $notes]);

        // Update document status
        $pdo->prepare("UPDATE documents SET status = 'dispositioned' WHERE id = ?")->execute([$docId]);

        // Ambil info dokumen & pengirim untuk email
        $stmtDoc = $pdo->prepare("SELECT document_number, title FROM documents WHERE id = ?");
        $stmtDoc->execute([$docId]);
        $docInfo = $stmtDoc->fetch();

        $stmtFrom = $pdo->prepare("SELECT name FROM users WHERE id = ?");
        $stmtFrom->execute([$_SESSION['user_id']]);
        $fromUser = $stmtFrom->fetch();

        // Kirim Email ke User Tujuan Utama
        $stmtUser = $pdo->prepare("SELECT name, email FROM users WHERE id = ?");
        $stmtUser->execute([$toUserId]);
        $targetUser = $stmtUser->fetch();

        if ($targetUser && !empty($targetUser['email'])) {
            sendEmailNotification(
                $targetUser['email'],
                $targetUser['name'],
                'Disposisi Dokumen Baru: ' . $docInfo['title'],
                'disposition',
                [
                    'DOC_NUMBER' => $docInfo['document_number'],
                    'DOC_TITLE' => $docInfo['title'],
                    'FROM_NAME' => $fromUser['name'],
                    'PRIORITY' => ucwords($priority),
                    'NOTES' => $notes ?: '-',
                    'DISP_ID' => $dispId
                ]
            );
        }

        // 2. Handle Tembusan ke Arsip (Jika Checkbox Dicentang)
        if ($ccArsip) {
            // Cari user division Kesekretariatan dengan role op_arsip
            $stmtArsip = $pdo->prepare("SELECT id, name, email FROM users WHERE division = 'Kesekretariatan' AND role = 'op_arsip' AND is_active = 1 LIMIT 1");
            $stmtArsip->execute();
            $arsipUser = $stmtArsip->fetch();

            if ($arsipUser) {
                // Simpan disposisi tembusan ke arsip
                $stmtCc = $pdo->prepare("INSERT INTO dispositions (document_id, from_user_id, to_user_id, status, priority, nature, notes) VALUES (?, ?, ?, 'pending', ?, ?, ?)");
                $stmtCc->execute([$docId, $_SESSION['user_id'], $arsipUser['id'], $priority, $nature, 'Tembusan Arsip: ' . $notes]);
                $ccDispId = $pdo->lastInsertId();

                // History Tembusan Arsip
                $pdo->prepare("INSERT INTO disposition_history (disposition_id, user_id, action, notes) VALUES (?, ?, 'created', ?)")
                    ->execute([$ccDispId, $_SESSION['user_id'], 'Tembusan Arsip otomatis']);

                // Kirim Email ke User Arsip dengan template 'arsip'
                if (!empty($arsipUser['email'])) {
                    sendEmailNotification(
                        $arsipUser['email'],
                        $arsipUser['name'],
                        'Tembusan Arsip Disposisi Dokumen: ' . $docInfo['title'],
                        'arsip',
                        [
                            'DOC_NUMBER' => $docInfo['document_number'],
                            'DOC_TITLE' => $docInfo['title'],
                            'FROM_NAME' => $fromUser['name'],
                            'PRIORITY' => ucwords($priority),
                            'NOTES' => $notes ?: '-',
                            'DISP_ID' => $ccDispId
                        ]
                    );
                }
            }
        }

        logActivity($_SESSION['user_id'], 'create_disposition', "Membuat disposisi dokumen #$docId" . ($ccArsip ? " dengan tembusan arsip" : ""), $docId);
        header('Location: ' . APP_URL . "/disposition_inbox.php?msg=created");
        exit;
    } else {
        $error = 'Pilih dokumen dan tujuan disposisi';
    }
}

require_once 'includes/header.php';
require_once 'includes/sidebar.php';
?>

<div class="lg:ml-64 pt-14 min-h-screen">
<main class="p-4 md:p-6 lg:p-8 max-w-3xl">

    <h2 class="text-xl font-black text-gray-900 mb-1">Buat Disposisi Baru</h2>
    <p class="text-gray-500 text-sm mb-6">Kirim disposisi surat ke user lain</p>

    <?php if (isset($error)): ?>
    <div class="bg-red-50 border border-red-200 text-red-700 px-4 py-3 rounded-xl text-sm mb-4"><i class="fas fa-exclamation-circle mr-2"></i><?= esc($error) ?></div>
    <?php endif; ?>

    <form method="POST" action="" enctype="multipart/form-data" class="bg-white rounded-2xl shadow-sm border border-gray-100 p-6 space-y-5">
        <!-- Pilih Dokumen -->
        <div>
            <label class="block text-xs font-semibold text-gray-600 mb-1">Pilih Dokumen</label>
            <select name="document_id" id="docSelect" class="w-full border border-gray-200 rounded-lg px-4 py-2.5 text-sm focus:ring-2 focus:ring-teal outline-none" onchange="toggleNewUpload()">
                <option value="">-- Pilih Dokumen --</option>
                <?php foreach ($docs as $d): ?>
                <option value="<?= $d['id'] ?>" <?= $preDocId == $d['id'] ? 'selected' : '' ?>><?= esc($d['document_number']) ?> - <?= esc($d['title']) ?></option>
                <?php endforeach; ?>
                <option value="new">+ Upload Dokumen Baru</option>
            </select>
        </div>

        <!-- Upload Baru (hidden by default) -->
        <div id="newUploadSection" class="hidden space-y-4 p-4 bg-amber-50 rounded-xl border border-amber-100">
            <p class="text-xs font-semibold text-amber-700"><i class="fas fa-info-circle mr-1"></i>Upload dokumen baru untuk didisposisikan</p>
            <div>
                <label class="block text-xs font-semibold text-gray-600 mb-1">Judul Dokumen</label>
                <input type="text" name="new_title" class="w-full border border-gray-200 rounded-lg px-4 py-2.5 text-sm focus:ring-2 focus:ring-teal outline-none" placeholder="Judul surat/dokumen">
            </div>
            <div>
                <label class="block text-xs font-semibold text-gray-600 mb-1">File</label>
                <input type="file" name="new_document" accept=".pdf,.jpg,.jpeg,.png,.doc,.docx" class="w-full border border-gray-200 rounded-lg px-4 py-2 text-sm">
            </div>
            <input type="hidden" name="upload_new" value="1">
        </div>

        <!-- Tujuan -->
        <div>
            <label class="block text-xs font-semibold text-gray-600 mb-1">Tujuan Disposisi *</label>
            <select name="to_user_id" required class="w-full border border-gray-200 rounded-lg px-4 py-2.5 text-sm focus:ring-2 focus:ring-teal outline-none">
                <option value="">-- Pilih User --</option>
                <?php foreach ($users as $u): ?>
                <option value="<?= $u['id'] ?>"><?= esc($u['name']) ?> - <?= esc($u['position']) ?> (<?= esc($u['division']) ?>)</option>
                <?php endforeach; ?>
            </select>
        </div>

        <!-- Checkbox Tembuskan ke Arsip -->
        <div class="flex items-center space-x-2 pt-1">
            <input type="checkbox" name="cc_arsip" id="cc_arsip" value="1" class="w-4 h-4 text-teal-600 border-gray-300 rounded focus:ring-teal">
            <label for="cc_arsip" class="text-xs font-semibold text-gray-700 cursor-pointer">Tembuskan ke Arsip (Kirim salinan disposisi ke Divisi Kesekretariatan / Arsip)</label>
        </div>

        <div class="grid grid-cols-2 gap-4">
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
        </div>

        <div>
            <label class="block text-xs font-semibold text-gray-600 mb-1">Catatan Disposisi</label>
            <textarea name="notes" rows="3" class="w-full border border-gray-200 rounded-lg px-4 py-2.5 text-sm focus:ring-2 focus:ring-teal outline-none resize-none" placeholder="Instruksi atau catatan disposisi"></textarea>
        </div>

        <button type="submit" class="btn-primary w-full justify-center py-3"><i class="fas fa-paper-plane"></i> Kirim Disposisi</button>
    </form>
</main>
</div>

<script>
function toggleNewUpload() {
    const sel = document.getElementById('docSelect');
    const sec = document.getElementById('newUploadSection');
    sec.classList.toggle('hidden', sel.value !== 'new');
}
<?php if ($preDocId): ?>
document.getElementById('docSelect').value = '<?= $preDocId ?>';
<?php endif; ?>
</script>
<?php require_once 'includes/footer.php'; ?>