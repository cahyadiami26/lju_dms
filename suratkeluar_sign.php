<?php
error_reporting(E_ALL);
error_reporting(-1);
ini_set('error_reporting', E_ALL);
require_once 'includes/mail_helper.php';
require_once 'config.php';
requireLogin();

$pageTitle = 'Penandatanganan Surat Keluar';
$currentUserId = (int)$_SESSION['user_id'];
$id = (int)($_GET['id'] ?? 0);

// Ambil data surat keluar & pastikan user saat ini adalah penandatangan atau dikirim_oleh
$stmt = $pdo->prepare("
    SELECT sk.*, u.name AS pengirim_nama, u.position AS pengirim_pos, u.division AS pengirim_div, u.department AS pengirim_dept, u.signature AS user_saved_sig
    FROM surat_keluar sk
    LEFT JOIN users u ON sk.penandatangan = u.id
    WHERE sk.id = ?
");
$stmt->execute([$id]);
$surat = $stmt->fetch();

// Otorisasi: Hanya bisa diakses oleh user yang menjadi penandatangan / pengirim dan status masih draft
if (!$surat || ($surat['penandatangan'] != $currentUserId && $surat['dikirim_oleh'] != $currentUserId) || $surat['status'] !== 'draft') {
    header('Location: ' . APP_URL . '/suratkeluar_list.php');
    exit;
}

// Ambil data tanda tangan tersimpan milik user saat ini dari profil
$userSignatureFile = $surat['user_saved_sig'] ? basename($surat['user_saved_sig']) : '';

// Handle Submit Form Penandatanganan
if ($_SERVER['REQUEST_METHOD'] === 'POST') {
    $signatureType = $_POST['signature_type'] ?? 'draw';
    $signatureData = '';
    $isManual = ($signatureType === 'manual'); // Sesuai permintaan: manual dikosongkan

    // Pastikan direktori SIGNATURE_PATH ada
    if (!is_dir(SIGNATURE_PATH)) {
        mkdir(SIGNATURE_PATH, 0777, true);
    }

    $sigFileName = null;

    if (!$isManual) {
        // Proses berdasarkan metode tanda tangan yang dipilih
        if ($signatureType === 'draw') {
            $signatureData = $_POST['drawn_signature'] ?? '';
        } elseif ($signatureType === 'type') {
            $typedText = trim($_POST['typed_signature'] ?? '');
            if (!empty($typedText)) {
                $img = imagecreatetruecolor(300, 80);
                $white = imagecolorallocate($img, 255, 255, 255);
                $blue = imagecolorallocate($img, 15, 76, 117);
                imagefill($img, 0, 0, $white);
                // Menggunakan font bawaan GD, posisikan teks dengan baik
                imagestring($img, 5, 20, 30, $typedText, $blue);
                ob_start();
                imagepng($img);
                $signatureData = 'data:image/png;base64,' . base64_encode(ob_get_clean());
                imagedestroy($img);
            }
        } elseif ($signatureType === 'upload') {
            if (isset($_FILES['signature_file']) && $_FILES['signature_file']['error'] === UPLOAD_ERR_OK) {
                $fileTmp = $_FILES['signature_file']['tmp_name'];
                $data = file_get_contents($fileTmp);
                $signatureData = 'data:image/png;base64,' . base64_encode($data);
            }
        } elseif ($signatureType === 'saved') {
            if (!empty($userSignatureFile) && file_exists(SIGNATURE_PATH . '/' . $userSignatureFile)) {
                $data = file_get_contents(SIGNATURE_PATH . '/' . $userSignatureFile);
                $ext = pathinfo($userSignatureFile, PATHINFO_EXTENSION);
                $signatureData = 'data:image/' . ($ext === 'jpg' ? 'jpeg' : $ext) . ';base64,' . base64_encode($data);
            }
        }

        // Simpan data gambar base64 ke file fisik di SIGNATURE_PATH
        if (!empty($signatureData)) {
            $sigFileName = 'sig_sk_' . $id . '_' . time() . '.png';
            $sigFullPath = SIGNATURE_PATH . '/' . $sigFileName;
            
            if (preg_match('/^data:image\/(\w+);base64,/', $signatureData, $type)) {
                $dataDecoded = substr($signatureData, strpos($signatureData, ',') + 1);
                $dataDecoded = base64_decode($dataDecoded);
                file_put_contents($sigFullPath, $dataDecoded);
                
                // Simpan juga ke profil user jika belum memilikinya
                if (empty($surat['user_saved_sig'])) {
                    $stmtUserSig = $pdo->prepare("UPDATE users SET signature = ? WHERE id = ?");
                    $stmtUserSig->execute([$sigFileName, $currentUserId]);
                }
            }
        }
    }

            // Tentukan path tanda tangan yang akan disimpan ke tabel surat_keluar (relatif atau absolut ke folder uploads)
        $dbSignaturePath = $isManual ? null : ($sigFileName ? APP_URL . '/uploads/signatures/' . $sigFileName : null);
    if ($isManual || !empty($dbSignaturePath)) {
        try {
            // Update status surat keluar menjadi 'published', set penandatangan, jenis tanda tangan, dan path
            $stmtUpdate = $pdo->prepare("
                UPDATE surat_keluar 
                SET status = 'published', 
                    penandatangan = ?,
                    jenis_tandatangan = ?,
                    signature_path = ?,
                    signed_at = NOW(),
                    modified_at = NOW() 
                WHERE id = ?
            ");
            $stmtUpdate->execute([
                $currentUserId,
                $signatureType,
                $dbSignaturePath, // Akan bernilai NULL jika manual
                $id
            ]);

            $logDesc = $isManual 
                ? "Menandatangani Surat Keluar #{$surat['nomor_surat']} secara Manual (Tanpa Tanda Tangan Digital)" 
                : "Menandatangani Surat Keluar #{$surat['nomor_surat']} menggunakan metode: $signatureType";
            
            logActivity($currentUserId, 'sign_surat_keluar', $logDesc, null);
            
            header('Location: ' . APP_URL . "/suratkeluar_view.php?id=$id&msg=signed");
            exit;
        } catch (Exception $e) {
            $error = 'Gagal memproses penandatanganan: ' . $e->getMessage();
        }
    } else {
        $error = 'Harap bubuhkan atau pilih tanda tangan yang valid terlebih dahulu.';
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
            <h2 class="text-xl font-black text-gray-900 mb-1">Penandatanganan Surat Keluar</h2>
            <p class="text-gray-500 text-sm">Pilih metode penandatanganan untuk mempublikasikan surat keluar ini</p>
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

    <!-- INFORMASI DOKUMEN -->
    <div class="bg-white rounded-2xl shadow-sm border border-gray-100 p-6 mb-6">
        <h3 class="font-bold text-gray-800 text-sm mb-4 border-b border-gray-100 pb-3">
            <i class="fas fa-file-alt text-brand mr-2"></i>Informasi Dokumen Surat Keluar
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
            <div>
                <p class="text-xs text-gray-400 font-semibold uppercase">Penerima / Tujuan</p>
                <p class="font-semibold text-gray-700"><?= htmlspecialchars($surat['penerima_surat']) ?></p>
            </div>
            <div>
                <p class="text-xs text-gray-400 font-semibold uppercase">Perihal</p>
                <p class="font-semibold text-gray-700"><?= htmlspecialchars($surat['perihal']) ?></p>
            </div>
        </div>
    </div>

    <!-- FORM PENANDATANGANAN -->
    <form method="POST" action="" enctype="multipart/form-data" id="signForm" class="bg-white rounded-2xl shadow-sm border border-gray-100 p-6 space-y-5">
        <div>
            <label class="block text-xs font-semibold text-gray-700 mb-3">
                <i class="fas fa-signature text-brand mr-1"></i> Metode Penandatanganan oleh (<strong><?= htmlspecialchars($surat['pengirim_nama'] ?? 'User') ?></strong>) *
            </label>
            
            <!-- Tab Pilihan Metode -->
            <div class="flex gap-2 mb-4 overflow-x-auto pb-2 flex-wrap">
                <button type="button" onclick="switchSigTab('draw')" id="tabDraw" class="px-4 py-2 rounded-lg text-xs font-semibold bg-brand text-white transition-all whitespace-nowrap">Gambar di Canvas</button>
                <button type="button" onclick="switchSigTab('type')" id="tabType" class="px-4 py-2 rounded-lg text-xs font-semibold bg-gray-100 text-gray-600 transition-all whitespace-nowrap">Input Teks</button>
                <button type="button" onclick="switchSigTab('upload')" id="tabUpload" class="px-4 py-2 rounded-lg text-xs font-semibold bg-gray-100 text-gray-600 transition-all whitespace-nowrap">Upload Gambar</button>
                <button type="button" onclick="switchSigTab('saved')" id="tabSaved" class="px-4 py-2 rounded-lg text-xs font-semibold bg-gray-100 text-gray-600 transition-all whitespace-nowrap">Tersimpan di Database</button>
                <button type="button" onclick="switchSigTab('manual')" id="tabManual" class="px-4 py-2 rounded-lg text-xs font-semibold bg-amber-100 text-amber-800 border border-amber-200 transition-all whitespace-nowrap"><i class="fas fa-hand-paper mr-1"></i> Manual (Dikosongkan)</button>
            </div>

            <input type="hidden" name="signature_type" id="sigTypeInput" value="draw">
            <input type="hidden" name="drawn_signature" id="drawnSigInput" value="">

            <!-- 1. Draw Tab -->
            <div id="panelDraw">
                <canvas id="signatureCanvas" width="600" height="180" class="w-full h-44 border border-gray-200 rounded-lg bg-gray-50"></canvas>
                <div class="flex gap-2 mt-2">
                    <button type="button" onclick="clearCanvas()" class="btn-outline text-xs py-1.5"><i class="fas fa-eraser mr-1"></i> Hapus Gambar</button>
                </div>
            </div>

            <!-- 2. Type Tab -->
            <div id="panelType" class="hidden">
                <input type="text" name="typed_signature" id="typedSig" placeholder="Ketik nama / tanda tangan teks Anda" class="w-full border border-gray-200 rounded-lg px-4 py-3 text-lg font-bold focus:ring-2 focus:ring-teal outline-none">
            </div>

            <!-- 3. Upload Tab -->
            <div id="panelUpload" class="hidden">
                <div class="border-2 border-dashed border-gray-200 rounded-xl p-6 text-center">
                    <i class="fas fa-cloud-upload-alt text-3xl text-gray-300 mb-2"></i>
                    <p class="text-sm text-gray-500">Upload file tanda tangan gambar (PNG/JPG)</p>
                    <input type="file" name="signature_file" accept="image/*" class="mt-3 text-sm">
                </div>
            </div>

            <!-- 4. Saved Tab -->
            <div id="panelSaved" class="hidden">
                <div class="border border-gray-200 rounded-xl p-5 text-center bg-gray-50">
                    <?php if (!empty($userSignatureFile) && file_exists(SIGNATURE_PATH . '/' . $userSignatureFile)): ?>
                        <p class="text-xs text-gray-500 mb-2">Tanda tangan tersimpan di profil database Anda:</p>
                        <img src="<?= APP_URL ?>/uploads/signatures/<?= htmlspecialchars($userSignatureFile) ?>" alt="Saved Signature" class="mx-auto h-20 object-contain bg-white p-2 border rounded">
                    <?php else: ?>
                        <p class="text-xs text-red-500">Belum ada tanda tangan tersimpan di profil database Anda. Silakan gunakan metode lain.</p>
                    <?php endif; ?>
                </div>
            </div>

            <!-- 5. Manual Tab (Dikosongkan) -->
            <div id="panelManual" class="hidden">
                <div class="border border-amber-200 bg-amber-50 rounded-xl p-5 text-amber-900 text-sm space-y-2">
                    <p class="font-bold flex items-center gap-2"><i class="fas fa-info-circle"></i> Mode Penandatanganan Manual</p>
                    <p class="text-xs leading-relaxed">Dengan memilih opsi ini, bagian gambar tanda tangan pada dokumen akan <strong>dikosongkan (tidak ada teks/gambar tanda tangan)</strong>. Dokumen akan langsung dipublikasikan dan Anda dapat membubuhkan tanda tangan fisik secara manual setelah dicetak.</p>
                </div>
            </div>
        </div>

        <button type="submit" onclick="prepareSubmit(event)" class="btn-primary w-full justify-center py-3">
            <i class="fas fa-check-circle mr-1"></i> Proses Penandatanganan & Publikasikan
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
    ['Draw', 'Type', 'Upload', 'Saved', 'Manual'].forEach(t => {
        const panel = document.getElementById('panel' + t);
        if (panel) panel.classList.add('hidden');
    });
    
    const targetPanel = document.getElementById('panel' + tab.charAt(0).toUpperCase() + tab.slice(1));
    if (targetPanel) targetPanel.classList.remove('hidden');
    
    document.getElementById('sigTypeInput').value = tab;

    ['Draw', 'Type', 'Upload', 'Saved', 'Manual'].forEach(t => {
        const btn = document.getElementById('tab' + t);
        if (!btn) return;
        if (t.toLowerCase() === tab.toLowerCase()) {
            if (t.toLowerCase() === 'manual') {
                btn.className = 'px-4 py-2 rounded-lg text-xs font-semibold bg-amber-600 text-white transition-all whitespace-nowrap shadow-sm';
            } else {
                btn.className = 'px-4 py-2 rounded-lg text-xs font-semibold bg-brand text-white transition-all whitespace-nowrap';
            }
        } else {
            if (t.toLowerCase() === 'manual') {
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
            alert('Silakan gambar tanda tangan Anda di canvas terlebih dahulu.');
            event.preventDefault();
            return;
        }
        document.getElementById('drawnSigInput').value = signaturePad.toDataURL();
    }
}
</script>

<?php require_once 'includes/footer.php'; ?>