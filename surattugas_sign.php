<?php
// surattugas_sign.php
error_reporting(E_ALL);
ini_set('display_errors', 1);

require_once 'includes/mail_helper.php';
require_once 'config.php';
requireLogin();

$pageTitle = 'Penandatanganan Surat Tugas';
$currentUserId = (int)$_SESSION['user_id'];
$id = (int)($_GET['id'] ?? 0);

// Ambil data surat tugas & pastikan user saat ini adalah penandatangan (penandatangan_id)
$stmt = $pdo->prepare("
    SELECT st.*, u.name AS penandatangan_nama, u.position AS penandatangan_pos, u.division AS penandatangan_div, u.department AS penandatangan_dept
    FROM tbl_surat_tugas st
    LEFT JOIN users u ON st.penandatangan_id = u.id
    WHERE st.id = ?
");
$stmt->execute([$id]);
$surat = $stmt->fetch();

// Otorisasi Ketat: Hanya bisa diakses oleh user yang menjadi penandatangan surat tugas ini
if (!$surat || $surat['penandatangan_id'] != $currentUserId) {
    header('Location: ' . APP_URL . '/surattugas_list.php');
    exit;
}

// Ambil data tanda tangan tersimpan milik user saat ini
$stmtUser = $pdo->prepare("SELECT signature FROM users WHERE id = ?");
$stmtUser->execute([$currentUserId]);
$userSignatureFile = basename($stmtUser->fetchColumn());

// Handle Submit Form Penandatanganan
if ($_SERVER['REQUEST_METHOD'] === 'POST') {
    $signatureType = $_POST['signature_type'] ?? 'draw';
    $signatureData = '';
    $sigFile = '';
    $isManualWetSignature = ($signatureType === 'manual_wet');
    
    if (!empty($surat['signature_data'])) {
        $potentialPath = SIGNATURE_PATH . '/' . basename($surat['signature_data']);
        if (file_exists($potentialPath)) {
            $sigFile = $potentialPath;
        }
    }
    
    // Fallback ke signature default user jika signature_data kosong/tidak valid
    if (empty($sigFile) && !empty($surat['sign_sig'])) {
        $potentialDefault = SIGNATURE_PATH . '/' . basename($surat['sign_sig']);
        if (file_exists($potentialDefault)) {
            $sigFile = $potentialDefault;
        }
    }

    if (!$isManualWetSignature) {
        // Olah Tanda Tangan Digital
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
        // Validasi format gambar aman untuk FPDF (Pastikan ekstensi/tipe didukung FPDF: PNG atau JPG)
        $validSigFile = '';
        if (!empty($sigFile) && file_exists($sigFile)) {
            $imgInfo = @getimagesize($sigFile);
            if ($imgInfo !== false) {
                // FPDF mendukung tipe MIME IMAGETYPE_PNG dan IMAGETYPE_JPEG
                if ($imgInfo[2] === IMAGETYPE_PNG || $imgInfo[2] === IMAGETYPE_JPEG) {
                    $validSigFile = $sigFile;
                }
            }
        }
    }

    // Eksekusi jika tanda tangan digital tersedia ATAU user memilih tanda tangan manual (basah)
    if ($isManualWetSignature || !empty($signatureData)) {
        try {
            $sigFileName = null;
            if (!$isManualWetSignature) {
                $sigFileName = 'sig_st_' . $id . '_' . time() . '.png';
                $sigPath = SIGNATURE_PATH . '/' . $sigFileName;
                
                if (preg_match('/^data:image\/(\w+);base64,/', $signatureData, $type)) {
                    $data = substr($signatureData, strpos($signatureData, ',') + 1);
                    $data = base64_decode($data);
                    
                    if (!is_dir(SIGNATURE_PATH)) {
                        mkdir(SIGNATURE_PATH, 0755, true);
                    }
                    
                    file_put_contents($sigPath, $data);
                    
                    // Update file tanda tangan di tabel users penandatangan
                    $stmtUserSig = $pdo->prepare("UPDATE users SET signature = ? WHERE id = ?");
                    $stmtUserSig->execute([$sigFileName, $currentUserId]);
                }
            }

            // Update status surat tugas menjadi 'published', jenis tandatangan, dan signature_data
            $stmtUpdate = $pdo->prepare("
                UPDATE tbl_surat_tugas 
                SET status_surat = 'published', 
                    jenis_tandatangan = ?, 
                    signature_data = ?, 
                    signed_at = NOW() 
                WHERE id = ?
            ");
            $stmtUpdate->execute([$signatureType, $sigFileName, $id]);

            $logDesc = $isManualWetSignature ? "Menandatangani Surat Tugas #{$surat['nomor_surat']} secara Manual (Basah)" : "Menandatangani Surat Tugas #{$surat['nomor_surat']} secara Digital";
            if (function_exists('logActivity')) {
                logActivity($currentUserId, 'sign_surat_tugas', $logDesc, null);
            }
            
            // KIRIM EMAIL NOTIFIKASI KE SEMUA USER YANG DITUGASKAN
            $stmtAssigned = $pdo->prepare("
                SELECT u.id, u.name, u.email 
                FROM tbl_surat_tugas_personil tsp
                JOIN users u ON tsp.user_id = u.id
                WHERE tsp.surat_tugas_id = ?
            ");
            $stmtAssigned->execute([$id]);
            $assignedUsers = $stmtAssigned->fetchAll();

            foreach ($assignedUsers as $targetUser) {
                if (!empty($targetUser['email']) && function_exists('sendEmailNotification')) {
                    sendEmailNotification(
                        $targetUser['email'],
                        $targetUser['name'],
                        'Surat Tugas Baru: ' . $surat['nomor_surat'],
                        'surattugas', // Pastikan template email 'surattugas' tersedia di mail_helper
                        [
                            'DOC_NUMBER' => $surat['nomor_surat'],
                            'DOC_TITLE'  => 'Surat Tugas',
                            'FROM_NAME'  => $surat['penandatangan_nama'],
                            'SIGN_DATE'  => date('d-m-Y H:i'),
                            'SURAT_ID'   => $id
                        ]
                    );
                }
            }
            
            header('Location: ' . APP_URL . "/surattugas_view.php?id=$id&msg=signed");
            exit;
        } catch (Exception $e) {
            $error = 'Gagal memproses penandatanganan: ' . $e->getMessage();
        }
    } else {
        $error = 'Harap bubuhkan tanda tangan terlebih dahulu atau pilih opsi tanda tangan manual.';
    }
}

require_once 'includes/header.php';
require_once 'includes/sidebar.php';
?>

<!-- Signature Pad Library -->
<script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
<script src="https://cdn.jsdelivr.net/npm/signature_pad@4.0.0/dist/signature_pad.umd.min.js"></script>

<div class="lg:ml-64 pt-14 min-h-screen">
<main class="p-4 md:p-6 lg:p-8 max-w-4xl">

    <!-- Header Navigation -->
    <div class="flex items-center justify-between mb-6">
        <div>
            <h2 class="text-xl font-black text-gray-900 mb-1">Penandatanganan Surat Tugas</h2>
            <p class="text-gray-500 text-sm">Pilih metode penandatanganan untuk merilis surat tugas ini</p>
        </div>
        <a href="<?= APP_URL ?>/surattugas_view.php?id=<?= $id ?>" class="inline-flex items-center gap-2 text-sm text-gray-500 hover:text-brand">
            <i class="fas fa-arrow-left"></i> Batal / Kembali
        </a>
    </div>

    <?php if (isset($error)): ?>
    <div class="bg-red-50 border border-red-200 text-red-700 px-4 py-3 rounded-xl text-sm mb-4">
        <i class="fas fa-exclamation-circle mr-2"></i><?= htmlspecialchars($error) ?>
    </div>
    <?php endif; ?>

    <!-- INFORMASI DOKUMEN -->
    <div class="bg-white rounded-2xl shadow-sm border border-gray-100 p-6 mb-6">
        <h3 class="font-bold text-gray-800 text-sm mb-4 border-b border-gray-100 pb-3">
            <i class="fas fa-file-alt text-brand mr-2"></i>Informasi Dokumen Surat Tugas
        </h3>
        <div class="grid md:grid-cols-2 gap-4 text-sm">
            <div>
                <p class="text-xs text-gray-400 font-semibold uppercase">Nomor Surat</p>
                <p class="font-bold text-gray-900"><?= htmlspecialchars($surat['nomor_surat']) ?></p>
            </div>
            <div>
                <p class="text-xs text-gray-400 font-semibold uppercase">Tanggal Surat</p>
                <p class="font-semibold text-gray-700"><?= date('d/m/Y', strtotime($surat['tanggal_surat'])) ?></p>
            </div>
        </div>
    </div>

    <!-- FORM PENANDATANGANAN -->
    <form method="POST" action="" enctype="multipart/form-data" id="signForm" class="bg-white rounded-2xl shadow-sm border border-gray-100 p-6 space-y-5">
        <div>
            <label class="block text-xs font-semibold text-gray-700 mb-3">
                <i class="fas fa-signature text-brand mr-1"></i> Metode Penandatanganan oleh (<?= htmlspecialchars($surat['penandatangan_nama']) ?>) *
            </label>
            
            <div class="flex gap-2 mb-4 overflow-x-auto pb-2 flex-wrap">
                <button type="button" onclick="switchSigTab('draw')" id="tabDraw" class="px-4 py-2 rounded-lg text-xs font-semibold bg-brand text-white transition-all whitespace-nowrap">Gambar Tanda Tangan</button>
                <button type="button" onclick="switchSigTab('type')" id="tabType" class="px-4 py-2 rounded-lg text-xs font-semibold bg-gray-100 text-gray-600 transition-all whitespace-nowrap">Ketik Teks</button>
                <button type="button" onclick="switchSigTab('upload')" id="tabUpload" class="px-4 py-2 rounded-lg text-xs font-semibold bg-gray-100 text-gray-600 transition-all whitespace-nowrap">Upload Gambar</button>
                <button type="button" onclick="switchSigTab('saved')" id="tabSaved" class="px-4 py-2 rounded-lg text-xs font-semibold bg-gray-100 text-gray-600 transition-all whitespace-nowrap">Tanda Tangan Tersimpan</button>
                <button type="button" onclick="switchSigTab('manual_wet')" id="tabManual_wet" class="px-4 py-2 rounded-lg text-xs font-semibold bg-amber-100 text-amber-800 border border-amber-200 transition-all whitespace-nowrap"><i class="fas fa-pen-nib mr-1"></i> Manual (Tanda Tangan Basah)</button>
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

            <!-- Manual / Tanda Tangan Basah Tab -->
            <div id="panelManual_wet" class="hidden">
                <div class="border border-amber-200 bg-amber-50 rounded-xl p-5 text-amber-900 text-sm space-y-2">
                    <p class="font-bold flex items-center gap-2"><i class="fas fa-info-circle"></i> Mode Tanda Tangan Manual (Basah)</p>
                    <p class="text-xs leading-relaxed">Dengan memilih opsi ini, bagian gambar tanda tangan pada dokumen akan dikosongkan agar Anda dapat mencetak dan membubuhkan tanda tangan secara fisik (basah). Status dokumen akan langsung berubah menjadi <strong>Published</strong> dan QR Code verifikasi publik akan diaktifkan.</p>
                </div>
            </div>
        </div>

        <button type="submit" onclick="prepareSubmit(event)" class="btn-primary w-full justify-center py-3">
            <i class="fas fa-check-circle mr-1"></i> Tandatangani & Selesaikan Dokumen
        </button>
    </form>
</main>
</div>

<script>
let signaturePad;

$(document).ready(function() {
    const canvas = document.getElementById('signatureCanvas');
    if (canvas) {
        signaturePad = new SignaturePad(canvas, { backgroundColor: 'rgb(255, 255, 255)' });
    }
});

function switchSigTab(tab) {
    ['Draw', 'Type', 'Upload', 'Saved', 'Manual_wet'].forEach(t => {
        const panel = document.getElementById('panel' + t);
        if (panel) panel.classList.add('hidden');
    });
    
    const targetPanel = document.getElementById('panel' + tab.charAt(0).toUpperCase() + tab.slice(1));
    if (targetPanel) targetPanel.classList.remove('hidden');
    
    document.getElementById('sigTypeInput').value = tab;

    ['Draw', 'Type', 'Upload', 'Saved', 'Manual_wet'].forEach(t => {
        const btn = document.getElementById('tab' + t);
        if (!btn) return;
        if (t.toLowerCase() === tab.toLowerCase()) {
            if (t.toLowerCase() === 'manual_wet') {
                btn.className = 'px-4 py-2 rounded-lg text-xs font-semibold bg-amber-600 text-white transition-all whitespace-nowrap shadow-sm';
            } else {
                btn.className = 'px-4 py-2 rounded-lg text-xs font-semibold bg-brand text-white transition-all whitespace-nowrap';
            }
        } else {
            if (t.toLowerCase() === 'manual_wet') {
                btn.className = 'px-4 py-2 rounded-lg text-xs font-semibold bg-amber-100 text-amber-800 border border-amber-200 transition-all whitespace-nowrap';
            } else {
                btn.className = 'px-4 py-2 rounded-lg text-xs font-semibold bg-gray-100 text-gray-600 transition-all whitespace-nowrap';
            }
        }
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