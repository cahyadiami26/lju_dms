<?php
error_reporting(E_ALL);
error_reporting(-1);
ini_set('error_reporting', E_ALL);
require_once 'includes/mail_helper.php';
require_once 'config.php';
requireLogin();
$pageTitle = 'Buat Nota Dinas';

// Ambil daftar user untuk tujuan nota dinas
$stmt = $pdo->prepare("SELECT id, name, email, position, division FROM users WHERE is_active = 1 AND id != ? ORDER BY name");
$stmt->execute([$_SESSION['user_id']]);
$users = $stmt->fetchAll();

// Ambil data tanda tangan tersimpan milik user saat ini
$stmtUser = $pdo->prepare("SELECT signature FROM users WHERE id = ?");
$stmtUser->execute([$_SESSION['user_id']]);
$userSignatureFile = basename($stmtUser->fetchColumn());

// Handle Submit Form
if ($_SERVER['REQUEST_METHOD'] === 'POST') {
    $nomorNota     = trim($_POST['nomor_nota_dinas'] ?? '');
    $toUserId      = (int)($_POST['to_user_id'] ?? 0);
    $tanggal       = $_POST['tanggal'] ?? date('Y-m-d');
    $perihal       = trim($_POST['perihal'] ?? '');
    $signatureType = $_POST['signature_type'] ?? 'draw';
    $signatureData = '';
    $ccArsip       = isset($_POST['cc_arsip']); // Cek apakah checkbox tembusan arsip dicentang[cite: 5]

    // Olah Tanda Tangan
    if ($signatureType === 'draw') {
        $signatureData = $_POST['drawn_signature'] ?? '';
    } elseif ($signatureType === 'type') {
        $typedText = $_POST['typed_signature'] ?? '';
        if (!empty($typedText)) {
            $img = imagecreatetruecolor(300, 80);
            $white = imagecolorallocate($img, 255, 255, 255);
            $blue = imagecolorallocate($img, 15, 76, 117);
            imagefill($img, 0, 0, $white);
            imagestring($img, 4, 10, 30, $typedText, $blue);
            ob_start();
            imagepng($img);
            $signatureData = 'data:image/png;base64,' . base64_encode(ob_get_clean());
            imagedestroy($img);
        }
    } elseif ($signatureType === 'upload') {
        if (isset($_FILES['signature_file']) && $_FILES['signature_file']['error'] === UPLOAD_ERR_OK) {
            $data = file_get_contents($_FILES['signature_file']['tmp_name']);
            $signatureData = 'data:image/png;base64,' . base64_encode($data);
        }
    } elseif ($signatureType === 'saved') {
        if ($userSignatureFile && file_exists(SIGNATURE_PATH . '/' . $userSignatureFile)) {
            $data = file_get_contents(SIGNATURE_PATH . '/' . $userSignatureFile);
            $ext = pathinfo($userSignatureFile, PATHINFO_EXTENSION);
            $signatureData = 'data:image/' . ($ext === 'jpg' ? 'jpeg' : $ext) . ';base64,' . base64_encode($data);
        }
    }

    if (!empty($nomorNota) && $toUserId > 0 && !empty($perihal) && !empty($signatureData)) {
        $vToken = bin2hex(random_bytes(16));
        
        // 1. Simpan Nota Dinas Utama ke Tujuan
        $stmt = $pdo->prepare("
            INSERT INTO nota_dinas 
            (nomor_nota_dinas, from_user_id, to_user_id, tanggal, perihal, status, signature_type, signature_data, signed_at, verification_token, created_at)
            VALUES (?, ?, ?, ?, ?, 'sent', ?, ?, NOW(), ?, NOW())
        ");
        $stmt->execute([$nomorNota, $_SESSION['user_id'], $toUserId, $tanggal, $perihal, $signatureType, $signatureData, $vToken]);
        $notaId = $pdo->lastInsertId();
        
        // Ambil data user tujuan & info dokumen untuk email
        $stmtUser = $pdo->prepare("SELECT name, email FROM users WHERE id = ?");
        $stmtUser->execute([$toUserId]);
        $targetUser = $stmtUser->fetch();

        $stmtDoc = $pdo->prepare("SELECT * FROM nota_dinas WHERE id = ?");
        $stmtDoc->execute([$notaId]);
        $docInfo = $stmtDoc->fetch();

        $stmtFrom = $pdo->prepare("SELECT name FROM users WHERE id = ?");
        $stmtFrom->execute([$_SESSION['user_id']]);
        $fromUser = $stmtFrom->fetch();

        // Kirim Email ke User Tujuan Utama
        if ($targetUser && !empty($targetUser['email'])) {
            sendEmailNotification(
                $targetUser['email'],
                $targetUser['name'],
                'Nota Dinas Baru: ' . $docInfo['nomor_nota_dinas'],
                'notadinas',
                [
                    'DOC_NUMBER' => $docInfo['nomor_nota_dinas'],
                    'FROM_NAME' => $fromUser['name'],
                    'BERITA' => $docInfo['perihal']
                ]
            );
        }

        // 2. Handle Tembusan ke Arsip (Jika Checkbox Dicentang)[cite: 5]
        if ($ccArsip) {
            $stmtArsip = $pdo->prepare("SELECT id, name, email FROM users WHERE division = 'Kesekretariatan' AND role = 'op_arsip' AND is_active = 1 LIMIT 1");
            $stmtArsip->execute();
            $arsipUser = $stmtArsip->fetch();

            if ($arsipUser) {
                $stmtCc = $pdo->prepare("
                    INSERT INTO nota_dinas 
                    (nomor_nota_dinas, from_user_id, to_user_id, tanggal, perihal, status, signature_type, signature_data, signed_at, verification_token, created_at)
                    VALUES (?, ?, ?, ?, ?, 'sent', ?, ?, NOW(), ?, NOW())
                ");
                $stmtCc->execute([$nomorNota . ' (Tembusan Arsip)', $_SESSION['user_id'], $arsipUser['id'], $tanggal, $perihal, $signatureType, $signatureData, bin2hex(random_bytes(16))]);
                $ccNotaId = $pdo->lastInsertId();

                if (!empty($arsipUser['email'])) {
                    sendEmailNotification(
                        $arsipUser['email'],
                        $arsipUser['name'],
                        'Tembusan Arsip Nota Dinas: ' . $nomorNota,
                        'arsipnd',
                        [
                            'DOC_NUMBER' => $nomorNota,
                            'DOC_TITLE' => $perihal,
                            'FROM_NAME' => $fromUser['name'],
                            'NOTES' => 'Tembusan Arsip Nota Dinas',
                            'DISP_ID' => $ccNotaId
                        ]
                    );
                }
            }
        }

        logActivity($_SESSION['user_id'], 'create_nota_dinas', "Membuat Nota Dinas #$nomorNota" . ($ccArsip ? " dengan tembusan arsip" : ""), null);
        header('Location: ' . APP_URL . "/notadinas_inbox.php?msg=sent&tab=sent");
        exit;
    } else {
        $error = 'Harap isi semua kolom wajib dan pastikan tanda tangan telah dibubuhkan.';
    }
}

require_once 'includes/header.php';
require_once 'includes/sidebar.php';
?>

<!-- Summernote & Signature Libraries -->
<script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
<link href="https://cdn.jsdelivr.net/npm/summernote@0.8.18/dist/summernote-lite.min.css" rel="stylesheet">
<script src="https://cdn.jsdelivr.net/npm/summernote@0.8.18/dist/summernote-lite.min.js"></script>
<script src="https://cdn.jsdelivr.net/npm/signature_pad@4.0.0/dist/signature_pad.umd.min.js"></script>

<style>
.note-editor.note-frame { border: 1px solid #e5e7eb !important; border-radius: 0.5rem !important; overflow: hidden; }
.note-toolbar { background-color: #f9fafb !important; border-bottom: 1px solid #e5e7eb !important; }
</style>

<div class="lg:ml-64 pt-14 min-h-screen">
<main class="p-4 md:p-6 lg:p-8 max-w-4xl">

    <h2 class="text-xl font-black text-gray-900 mb-1">Buat Nota Dinas Baru</h2>
    <p class="text-gray-500 text-sm mb-6">Kirim catatan atau berita ke pengguna lain</p>

    <?php if (isset($error)): ?>
    <div class="bg-red-50 border border-red-200 text-red-700 px-4 py-3 rounded-xl text-sm mb-4">
        <i class="fas fa-exclamation-circle mr-2"></i><?= esc($error) ?>
    </div>
    <?php endif; ?>

    <form method="POST" action="" enctype="multipart/form-data" id="notaForm" class="bg-white rounded-2xl shadow-sm border border-gray-100 p-6 space-y-5">
        <div class="grid md:grid-cols-2 gap-4">
            <div>
                <label class="block text-xs font-semibold text-gray-600 mb-1">Nomor Nota Dinas *</label>
                <input type="text" name="nomor_nota_dinas" required class="w-full border border-gray-200 rounded-lg px-4 py-2.5 text-sm focus:ring-2 focus:ring-teal outline-none" placeholder="Contoh: ND/001/IX/2026">
            </div>

            <div>
                <label class="block text-xs font-semibold text-gray-600 mb-1">Tanggal *</label>
                <input type="date" name="tanggal" value="<?= date('Y-m-d') ?>" required class="w-full border border-gray-200 rounded-lg px-4 py-2.5 text-sm focus:ring-2 focus:ring-teal outline-none">
            </div>
        </div>

        <div>
            <label class="block text-xs font-semibold text-gray-600 mb-1">Penerima (Tujuan) *</label>
            <select name="to_user_id" required class="w-full border border-gray-200 rounded-lg px-4 py-2.5 text-sm focus:ring-2 focus:ring-teal outline-none">
                <option value="">-- Pilih User Tujuan --</option>
                <?php foreach ($users as $u): ?>
                <option value="<?= $u['id'] ?>"><?= esc($u['name']) ?> - <?= esc($u['position']) ?> (<?= esc($u['division']) ?>)</option>
                <?php endforeach; ?>
            </select>
        </div>

        <!-- Checkbox Tembuskan ke Arsip -->
        <div class="flex items-center space-x-2 pt-1">
            <input type="checkbox" name="cc_arsip" id="cc_arsip" value="1" class="w-4 h-4 text-teal-600 border-gray-300 rounded focus:ring-teal">
            <label for="cc_arsip" class="text-xs font-semibold text-gray-700 cursor-pointer">Tembuskan ke Arsip (Kirim salinan nota dinas ke Divisi Kesekretariatan / Arsip)</label>
        </div>

        <div>
            <label class="block text-xs font-semibold text-gray-600 mb-1">Perihal / Catatan *</label>
            <textarea id="summernote" name="perihal" required></textarea>
        </div>

        <!-- TANDA TANGAN SECTION -->
        <div class="border-t border-gray-100 pt-5">
            <label class="block text-xs font-semibold text-gray-700 mb-3"><i class="fas fa-signature text-brand mr-1"></i> Tanda Tangan Pengirim *</label>
            
            <div class="flex gap-2 mb-4 overflow-x-auto pb-2">
                <button type="button" onclick="switchSigTab('draw')" id="tabDraw" class="px-4 py-2 rounded-lg text-xs font-semibold bg-brand text-white transition-all whitespace-nowrap">Gambar</button>
                <button type="button" onclick="switchSigTab('type')" id="tabType" class="px-4 py-2 rounded-lg text-xs font-semibold bg-gray-100 text-gray-600 transition-all whitespace-nowrap">Ketik</button>
                <button type="button" onclick="switchSigTab('upload')" id="tabUpload" class="px-4 py-2 rounded-lg text-xs font-semibold bg-gray-100 text-gray-600 transition-all whitespace-nowrap">Upload</button>
                <button type="button" onclick="switchSigTab('saved')" id="tabSaved" class="px-4 py-2 rounded-lg text-xs font-semibold bg-gray-100 text-gray-600 transition-all whitespace-nowrap">Tersimpan</button>
            </div>

            <input type="hidden" name="signature_type" id="sigTypeInput" value="draw">
            <input type="hidden" name="drawn_signature" id="drawnSigInput" value="">

            <!-- Draw Tab -->
            <div id="panelDraw">
                <canvas id="signatureCanvas" width="600" height="180" class="w-full h-44 border border-gray-200 rounded-lg bg-gray-50"></canvas>
                <div class="flex gap-2 mt-2">
                    <button type="button" onclick="clearCanvas()" class="btn-outline text-xs py-1.5"><i class="fas fa-eraser"></i> Hapus Gambar</button>
                </div>
            </div>

            <!-- Type Tab -->
            <div id="panelType" class="hidden">
                <input type="text" name="typed_signature" id="typedSig" placeholder="Ketik nama tanda tangan Anda" class="w-full border border-gray-200 rounded-lg px-4 py-3 text-lg font-bold focus:ring-2 focus:ring-teal outline-none">
            </div>

            <!-- Upload Tab -->
            <div id="panelUpload" class="hidden">
                <div class="border-2 border-dashed border-gray-200 rounded-xl p-6 text-center">
                    <i class="fas fa-cloud-upload-alt text-3xl text-gray-300 mb-2"></i>
                    <p class="text-sm text-gray-500">Upload file tanda tangan (PNG/JPG)</p>
                    <input type="file" name="signature_file" accept="image/*" class="mt-3 text-sm">
                </div>
            </div>

            <!-- Saved Tab -->
            <div id="panelSaved" class="hidden">
                <div class="border border-gray-200 rounded-xl p-5 text-center bg-gray-50">
                    <?php if (!empty($userSignatureFile) && file_exists(SIGNATURE_PATH . '/' . $userSignatureFile)): ?>
                        <p class="text-xs text-gray-500 mb-2">Tanda tangan tersimpan di profil Anda:</p>
                        <img src="<?= APP_URL ?>/uploads/signatures/<?= htmlspecialchars($userSignatureFile) ?>" alt="Saved Signature" class="mx-auto h-20 object-contain bg-white p-2 border rounded">
                    <?php else: ?>
                        <p class="text-xs text-gray-400">Belum ada tanda tangan tersimpan di profil.</p>
                    <?php endif; ?>
                </div>
            </div>
        </div>

        <button type="submit" onclick="prepareSubmit(event)" class="btn-primary w-full justify-center py-3">
            <i class="fas fa-paper-plane mr-1"></i> Kirim Nota Dinas
        </button>
    </form>
</main>
</div>

<script>
let signaturePad;

$(document).ready(function() {
    $('#summernote').summernote({
        placeholder: 'Tuliskan isi pesan, catatan, atau berita di sini...',
        tabsize: 2,
        height: 200,
        toolbar: [
          ['style', ['style', 'bold', 'italic', 'underline', 'clear']],
          ['para', ['ul', 'ol', 'paragraph']],
          ['table', ['table']],
          ['view', ['fullscreen', 'codeview']]
        ]
    });

    const canvas = document.getElementById('signatureCanvas');
    if (canvas) {
        signaturePad = new SignaturePad(canvas, { backgroundColor: 'rgb(255, 255, 255)' });
    }
});

function switchSigTab(tab) {
    ['Draw', 'Type', 'Upload', 'Saved'].forEach(t => {
        document.getElementById('panel' + t).classList.add('hidden');
    });
    document.getElementById('panel' + tab.charAt(0).toUpperCase() + tab.slice(1)).classList.remove('hidden');
    document.getElementById('sigTypeInput').value = tab;

    ['Draw','Type','Upload','Saved'].forEach(t => {
        document.getElementById('tab' + t).className = 'px-4 py-2 rounded-lg text-xs font-semibold transition-all whitespace-nowrap ' +
            (t.toLowerCase() === tab ? 'bg-brand text-white' : 'bg-gray-100 text-gray-600');
    });
}

function clearCanvas() {
    if (signaturePad) signaturePad.clear();
}

function prepareSubmit(event) {
    const type = document.getElementById('sigTypeInput').value;
    if (type === 'draw') {
        if (signaturePad.isEmpty()) {
            alert('Silakan gambar tanda tangan Anda terlebih dahulu.');
            event.preventDefault();
            return;
        }
        document.getElementById('drawnSigInput').value = signaturePad.toDataURL();
    }
}
</script>

<?php require_once 'includes/footer.php'; ?>