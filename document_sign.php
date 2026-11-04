<?php
require_once 'config.php';
requireLogin();
$pageTitle = 'Tanda Tangan Digital';

$id = (int)($_GET['id'] ?? 0);
$stmt = $pdo->prepare("SELECT d.*, u.name as uploader FROM documents d JOIN users u ON d.user_id = u.id WHERE d.id = ?");
$stmt->execute([$id]);
$doc = $stmt->fetch();

if (!$doc) { header('Location: ' . APP_URL . '/documents.php'); exit; }

// Ambil daftar user untuk multi-signer
$users = $pdo->query("SELECT id, name, position, division FROM users WHERE is_active = 1 AND id != {$_SESSION['user_id']} ORDER BY name")->fetchAll();

// Existing signatures
$stmt = $pdo->prepare("SELECT s.*, u.name, u.position FROM signatures s JOIN users u ON s.user_id = u.id WHERE s.document_id = ?");
$stmt->execute([$id]);
$existingSigs = $stmt->fetchAll();

// Ambil data tanda tangan tersimpan milik user saat ini (asumsi kolom bernama 'signature')
$stmtUser = $pdo->prepare("SELECT signature FROM users WHERE id = ?");
$stmtUser->execute([$_SESSION['user_id']]);
$userSignatureFile = basename($stmtUser->fetchColumn());

// Handle Signature Submission
if ($_SERVER['REQUEST_METHOD'] === 'POST') {
    $action = $_POST['form_action'] ?? '';

    if ($action === 'add_signers') {
        // Tambah signer
        $signerIds = $_POST['signers'] ?? [];
        foreach ($signerIds as $sid) {
            $sid = (int)$sid;
            // Cek duplikat
            $chk = $pdo->prepare("SELECT id FROM signatures WHERE document_id = ? AND user_id = ? AND status = 'pending'");
            $chk->execute([$id, $sid]);
            if (!$chk->fetch()) {
                $u = $pdo->prepare("SELECT name, position FROM users WHERE id = ?");
                $u->execute([$sid]);
                $ur = $u->fetch();
                $ins = $pdo->prepare("INSERT INTO signatures (document_id, user_id, signer_name, signer_position, status) VALUES (?, ?, ?, ?, 'pending')");
                $ins->execute([$id, $sid, $ur['name'], $ur['position']]);
            }
        }
        // Update doc status
        $pdo->prepare("UPDATE documents SET status = 'pending_signature' WHERE id = ?")->execute([$id]);
        logActivity($_SESSION['user_id'], 'add_signer', "Tambah signer ke dokumen: " . $doc['title'], $id);
        header('Location: ' . APP_URL . "/document_sign.php?id=$id&msg=signers_added");
        exit;
    }

    if ($action === 'sign') {
        $signatureType = $_POST['signature_type'] ?? 'draw';
        $signatureData = '';

        if ($signatureType === 'draw') {
            $signatureData = $_POST['drawn_signature'] ?? '';
        } elseif ($signatureType === 'type') {
            $typedText = $_POST['typed_signature'] ?? '';
            // Buat gambar dari teks menggunakan GD
            $img = imagecreatetruecolor(300, 80);
            $white = imagecolorallocate($img, 255, 255, 255);
            $blue = imagecolorallocate($img, 15, 76, 117);
            imagefill($img, 0, 0, $white);
            $font = 4; // built-in font
            imagestring($img, $font, 10, 30, $typedText, $blue);
            ob_start();
            imagepng($img);
            $signatureData = 'data:image/png;base64,' . base64_encode(ob_get_clean());
            imagedestroy($img);
        } elseif ($signatureType === 'upload') {
            if (isset($_FILES['signature_file']) && $_FILES['signature_file']['error'] === UPLOAD_ERR_OK) {
                $tmp = $_FILES['signature_file']['tmp_name'];
                $data = file_get_contents($tmp);
                $signatureData = 'data:image/png;base64,' . base64_encode($data);
            }
        } elseif ($signatureType === 'saved') {
            // Proses untuk tanda tangan yang tersimpan di DB & Folder
            if ($userSignatureFile && file_exists(SIGNATURE_PATH . '/' . $userSignatureFile)) {
                $tmp = SIGNATURE_PATH . '/' . $userSignatureFile;
                $data = file_get_contents($tmp);
                $ext = pathinfo($userSignatureFile, PATHINFO_EXTENSION);
                $signatureData = 'data:image/' . ($ext === 'jpg' ? 'jpeg' : $ext) . ';base64,' . base64_encode($data);
            }
        }

        if ($signatureData) {
            // Generate hash
            $hashData = $doc['document_number'] . $_SESSION['user_id'] . time() . $signatureData;
            $sigHash = hash('sha256', $hashData);

            // Cek apakah user sudah punya signature pending
            $chk = $pdo->prepare("SELECT id FROM signatures WHERE document_id = ? AND user_id = ? AND status = 'pending'");
            $chk->execute([$id, $_SESSION['user_id']]);

            if ($chk->fetch()) {
                $pdo->prepare("UPDATE signatures SET signature_type = ?, signature_data = ?, hash = ?, status = 'signed', signed_at = NOW() WHERE document_id = ? AND user_id = ? AND status = 'pending'")
                    ->execute([$signatureType, $signatureData, $sigHash, $id, $_SESSION['user_id']]);
            } else {
                $user = currentUser();
                $pdo->prepare("INSERT INTO signatures (document_id, user_id, signer_name, signer_position, signature_type, signature_data, hash, status) VALUES (?, ?, ?, ?, ?, ?, ?, 'signed')")
                    ->execute([$id, $_SESSION['user_id'], $user['name'], $user['position'], $signatureType, $signatureData, $sigHash]);
            }

            // Cek apakah semua signer sudah sign
            $pending = $pdo->prepare("SELECT COUNT(*) FROM signatures WHERE document_id = ? AND status = 'pending'");
            $pending->execute([$id]);
            $pendingCount = $pending->fetchColumn();

            if ($pendingCount == 0) {
                // Semua sudah sign → generate verification
                $token = generateToken();
                $allHashes = '';
                $sigs = $pdo->prepare("SELECT hash FROM signatures WHERE document_id = ? AND status = 'signed'");
                $sigs->execute([$id]);
                foreach ($sigs->fetchAll() as $s) $allHashes .= $s['hash'];
                $docHash = hash('sha256', $doc['document_number'] . $allHashes . time());

                $pdo->prepare("UPDATE documents SET status = 'signed', verification_token = ?, verification_hash = ? WHERE id = ?")
                    ->execute([$token, $docHash, $id]);
            
        // Setelah tanda tangan berhasil, arahkan langsung ke detail dokumen.
        header('Location: ' . APP_URL . '/document_view.php?id=' . $document_id);
        exit;
} else {
                $pdo->prepare("UPDATE documents SET status = 'pending_signature' WHERE id = ?")->execute([$id]);
            }

            logActivity($_SESSION['user_id'], 'sign', "Menandatangani dokumen: " . $doc['title'], $id);
            header('Location: ' . APP_URL . "/document_sign.php?id=$id&msg=signed");
            exit;
        }
    }
}

$msg = $_GET['msg'] ?? '';
require_once 'includes/header.php';
require_once 'includes/sidebar.php';

$extraScripts = '<script src="https://cdn.jsdelivr.net/npm/signature_pad@4.0.0/dist/signature_pad.umd.min.js"></script>';
?>

<div class="lg:ml-64 pt-14 min-h-screen">
<main class="p-4 md:p-6 lg:p-8">

    <?php if ($msg === 'signed'): ?><script>showToast('Dokumen berhasil ditandatangani', 'success');</script><?php endif; ?>
    <?php if ($msg === 'signers_added'): ?><script>showToast('Signer berhasil ditambahkan', 'success');</script><?php endif; ?>

    <a href="<?= APP_URL ?>/document_view.php?id=<?= $id ?>" class="inline-flex items-center gap-2 text-sm text-gray-500 hover:text-brand mb-4"><i class="fas fa-arrow-left"></i> Kembali</a>

    <div class="grid lg:grid-cols-3 gap-6">
        <!-- Signature Pad -->
        <div class="lg:col-span-2">
            <div class="bg-white rounded-2xl shadow-sm border border-gray-100 p-6">
                <div class="mb-6 border-b border-gray-100 pb-4">
                <h2 class="text-xl font-black text-gray-900 mb-2">Tandatangani Dokumen</h2>
    
                <div class="grid md:grid-cols-2 gap-4">
                    <div>
                        <p class="text-xs text-gray-400 font-bold uppercase">Judul Dokumen</p>
                        <p class="text-sm font-semibold text-gray-800"><?= esc($doc['title']) ?></p>
                    </div>
                <div>
                    <p class="text-xs text-gray-400 font-bold uppercase">Nomor Dokumen</p>
                    <p class="text-sm font-semibold text-gray-800"><?= esc($doc['document_number'] ?? '-') ?></p>
                </div>
                <div>
                    <p class="text-xs text-gray-400 font-bold uppercase">Diunggah Oleh</p>
                    <p class="text-sm font-semibold text-gray-800"><?= esc($doc['uploader']) ?></p>
                </div>
                <div>
                    <p class="text-xs text-gray-400 font-bold uppercase">Tanggal</p>
                    <p class="text-sm font-semibold text-gray-800"><?= date('d M Y', strtotime($doc['created_at'])) ?></p>
                </div>
            </div>
        </div>

                <!-- Tab: Draw / Type / Upload / Saved -->
                <div class="flex gap-2 mb-4 overflow-x-auto pb-2">
                    <button type="button" onclick="switchSigTab('draw')" id="tabDraw" class="px-4 py-2 rounded-lg text-xs font-semibold bg-brand text-white transition-all whitespace-nowrap">Gambar</button>
                    <button type="button" onclick="switchSigTab('type')" id="tabType" class="px-4 py-2 rounded-lg text-xs font-semibold bg-gray-100 text-gray-600 transition-all whitespace-nowrap">Ketik</button>
                    <button type="button" onclick="switchSigTab('upload')" id="tabUpload" class="px-4 py-2 rounded-lg text-xs font-semibold bg-gray-100 text-gray-600 transition-all whitespace-nowrap">Upload</button>
                    <button type="button" onclick="switchSigTab('saved')" id="tabSaved" class="px-4 py-2 rounded-lg text-xs font-semibold bg-gray-100 text-gray-600 transition-all whitespace-nowrap">Tersimpan</button>
                </div>

                <form method="POST" action="" id="signForm" enctype="multipart/form-data">
                    <input type="hidden" name="form_action" value="sign">
                    <input type="hidden" name="signature_type" id="sigTypeInput" value="draw">
                    <input type="hidden" name="drawn_signature" id="drawnSigInput" value="">

                    <!-- Draw Tab -->
                    <div id="panelDraw">
                        <canvas id="signatureCanvas" width="600" height="200" class="w-full h-48 border border-gray-200 rounded-lg"></canvas>
                        <div class="flex gap-2 mt-2">
                            <button type="button" onclick="clearSignature()" class="btn-outline text-xs py-1.5"><i class="fas fa-eraser"></i> Hapus</button>
                        </div>
                    </div>

                    <!-- Type Tab -->
                    <div id="panelType" class="hidden">
                        <input type="text" name="typed_signature" id="typedSig" placeholder="Ketik nama tanda tangan Anda" class="w-full border border-gray-200 rounded-lg px-4 py-3 text-lg font-bold focus:ring-2 focus:ring-teal outline-none" style="font-family: 'Dancing Script', cursive, serif;">
                        <div class="mt-3 p-4 bg-gray-50 rounded-xl">
                            <p class="text-gray-400 text-xs mb-1">Preview:</p>
                            <p id="typedPreview" class="text-2xl font-bold text-brand" style="font-family: 'Dancing Script', cursive;"></p>
                        </div>
                    </div>

                    <!-- Upload Tab -->
                    <div id="panelUpload" class="hidden">
                        <div class="border-2 border-dashed border-gray-200 rounded-xl p-8 text-center">
                            <i class="fas fa-cloud-upload-alt text-3xl text-gray-300 mb-2"></i>
                            <p class="text-sm text-gray-500">Upload gambar tanda tangan</p>
                            <input type="file" name="signature_file" accept="image/*" class="mt-3 text-sm">
                        </div>
                    </div>

                    <!-- Saved Tab (Tanda Tangan Tersimpan) -->
                    <div id="panelSaved" class="hidden">
                        <div class="border border-gray-200 rounded-xl p-6 text-center bg-gray-50">
                            <?php if (!empty($userSignatureFile) && file_exists(SIGNATURE_PATH . '/' . $userSignatureFile)): ?>
                                <p class="text-sm text-gray-500 mb-4">Tanda tangan Anda yang tersimpan di profil:</p>
                                <img src="<?= APP_URL ?>/uploads/signatures/<?= htmlspecialchars($userSignatureFile) ?>" alt="Saved Signature" class="mx-auto h-24 object-contain mb-3 bg-white p-2 border border-gray-200 rounded">
                                <p class="text-xs text-brand font-semibold"><i class="fas fa-check-circle"></i> Siap digunakan</p>
                            <?php else: ?>
                                <i class="fas fa-file-signature text-4xl text-gray-300 mb-3 block"></i>
                                <p class="text-sm text-gray-500">Belum ada tanda tangan yang tersimpan di database.</p>
                                <p class="text-xs text-gray-400 mt-1">Silakan gunakan metode lain atau perbarui profil Anda.</p>
                            <?php endif; ?>
                        </div>
                    </div>

                    <button type="submit" class="btn-primary mt-4 w-full justify-center py-3" onclick="prepareSignature(event)">
                        <i class="fas fa-pen-nib"></i> Tandatangani Dokumen
                    </button>
                </form>
            </div>
        </div>

        <!-- Sidebar: Info & Signers -->
        <div class="space-y-4">
            <!-- Add Signers -->
            <div class="bg-white rounded-2xl shadow-sm border border-gray-100 p-6">
                <h3 class="font-bold text-gray-800 text-sm mb-3"><i class="fas fa-users text-brand mr-2"></i>Tambah Signer Lain</h3>
                <form method="POST" action="">
                    <input type="hidden" name="form_action" value="add_signers">
                    <div class="space-y-2 max-h-48 overflow-y-auto">
                        <?php foreach ($users as $u): ?>
                        <label class="flex items-center gap-2 p-2 rounded-lg hover:bg-gray-50 cursor-pointer">
                            <input type="checkbox" name="signers[]" value="<?= $u['id'] ?>" class="rounded text-teal">
                            <div>
                                <p class="text-xs font-semibold text-gray-700"><?= esc($u['name']) ?></p>
                                <p class="text-[10px] text-gray-400"><?= esc($u['position']) ?> - <?= esc($u['division']) ?></p>
                            </div>
                        </label>
                        <?php endforeach; ?>
                    </div>
                    <button type="submit" class="btn-outline w-full mt-3 justify-center text-xs"><i class="fas fa-plus"></i> Tambah Signer</button>
                </form>
            </div>

            <!-- Current Signers -->
            <div class="bg-white rounded-2xl shadow-sm border border-gray-100 p-6">
                <h3 class="font-bold text-gray-800 text-sm mb-3"><i class="fas fa-list-check text-brand mr-2"></i>Daftar Signer</h3>
                <div class="space-y-2">
                    <?php foreach ($existingSigs as $sig): ?>
                    <div class="flex items-center gap-3 p-2 bg-gray-50 rounded-lg">
                        <div class="w-8 h-8 rounded-full flex items-center justify-center text-xs font-bold flex-shrink-0 <?= $sig['status'] === 'signed' ? 'bg-emerald-100 text-emerald-700' : 'bg-amber-100 text-amber-700' ?>">
                            <?= strtoupper(substr($sig['name'], 0, 1)) ?>
                        </div>
                        <div class="flex-1 min-w-0">
                            <p class="text-xs font-semibold text-gray-700 truncate"><?= esc($sig['name']) ?></p>
                            <p class="text-[10px] text-gray-400 truncate"><?= esc($sig['position']) ?></p>
                        </div>
                        <?= statusBadge($sig['status']) ?>
                    </div>
                    <?php endforeach; ?>
                    <?php if (empty($existingSigs)): ?>
                    <p class="text-gray-400 text-xs text-center py-3">Belum ada signer</p>
                    <?php endif; ?>
                </div>
            </div>
        </div>
    </div>

</main>
</div>

<script>
function switchSigTab(tab) {
    // Sembunyikan semua panel
    ['Draw', 'Type', 'Upload', 'Saved'].forEach(t => {
        document.getElementById('panel' + t).classList.add('hidden');
    });
    
    // Tampilkan panel yang aktif
    document.getElementById('panel' + tab.charAt(0).toUpperCase() + tab.slice(1)).classList.remove('hidden');
    document.getElementById('sigTypeInput').value = tab;

    // Ubah styling tombol tab
    ['Draw','Type','Upload','Saved'].forEach(t => {
        document.getElementById('tab' + t).className = 'px-4 py-2 rounded-lg text-xs font-semibold transition-all whitespace-nowrap ' +
            (t.toLowerCase() === tab ? 'bg-brand text-white' : 'bg-gray-100 text-gray-600');
    });
}

function prepareSignature(event) {
    const type = document.getElementById('sigTypeInput').value;
    if (type === 'draw') {
        const data = getSignatureData();
        if (!data) {
            alert('Silakan gambar tanda tangan terlebih dahulu');
            if (event) event.preventDefault();
            return;
        }
        document.getElementById('drawnSigInput').value = data;
    } else if (type === 'saved') {
        // Pengecekan optional: Jika user pilih 'saved' tapi mereka tidak punya signature
        <?php if (empty($userSignatureFile) || !file_exists(SIGNATURE_PATH . '/' . $userSignatureFile)): ?>
            alert('Anda tidak memiliki tanda tangan yang tersimpan. Silakan gunakan metode lain.');
            if (event) event.preventDefault();
            return;
        <?php endif; ?>
    }

    // Peringatan / Konfirmasi sebelum menandatangani dokumen
    if (!confirm("Anda akan menandatangani dokumen ini, Pastikan anda sudah membacanya dengan seksama")) {
        if (event) event.preventDefault();
        return;
    }
}

// Typed signature preview
const typedSig = document.getElementById('typedSig');
const typedPreview = document.getElementById('typedPreview');
if (typedSig && typedPreview) {
    typedSig.addEventListener('input', function() {
        typedPreview.textContent = this.value;
    });
}
</script>
<?php require_once 'includes/footer.php'; ?>