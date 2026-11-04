<?php
require_once 'config.php';
requireLogin();
$pageTitle = 'Detail Disposisi';

$id = (int)($_GET['id'] ?? 0);
$stmt = $pdo->prepare("
    SELECT d.*, doc.title, doc.document_number, doc.file_path, doc.id as doc_id,
           u1.name as from_name, u1.position as from_pos, u1.division as from_div,
           u2.name as to_name, u2.position as to_pos, u2.division as to_div
    FROM dispositions d
    JOIN documents doc ON d.document_id = doc.id
    JOIN users u1 ON d.from_user_id = u1.id
    JOIN users u2 ON d.to_user_id = u2.id
    WHERE d.id = ?
");
$stmt->execute([$id]);
$disp = $stmt->fetch();

if (!$disp) { header('Location: ' . APP_URL . '/disposition_inbox.php'); exit; }

// Cek apakah user yang login merupakan user divisi Kesekretariatan dengan role op_arsip
$stmtCurUser = $pdo->prepare("SELECT division, role, department FROM users WHERE id = ?");
$stmtCurUser->execute([$_SESSION['user_id']]);
$currentUserData = $stmtCurUser->fetch();
$isOpArsipKesekretariatan = ($currentUserData && $currentUserData['division'] === 'Kesekretariatan' && $currentUserData['role'] === 'op_arsip');

// Jika user adalah op_arsip Kesekretariatan, kita juga bisa mengambil referensi data kategori/folder/tags dari database arsip jika diperlukan untuk mengisi select options di modal
$categories = [];
$folders = [];
$tags = [];
$divisionsList = ['Keuangan','Pengadaan','Keamanan','Infokom','SDM','Direksi','IT','Legal','Kesekretariatan','JaKon','Pengangkutan & Pergudangan','Perdagangan','Energi & Migas'];

if ($isOpArsipKesekretariatan) {
    // Koneksi ke database arsip sesuai instruksi (/arsip/config/database.php)
    @include_once __DIR__ . '/arsip/config/database.php';
    if (function_exists('getDB')) {
        try {
            $dbArsip = getDB();
            $categories = $dbArsip->query("SELECT * FROM document_categories WHERE is_active = 1 ORDER BY name")->fetchAll();
            $folders    = $dbArsip->query("SELECT * FROM folders ORDER BY division, name")->fetchAll();
            $tags       = $dbArsip->query("SELECT * FROM tags ORDER BY name")->fetchAll();
        } catch (Exception $e) {
            // Fallback jika koneksi database arsip belum tersedia
        }
    }
}

// Disposition History
$stmt = $pdo->prepare("
    SELECT dh.*, u.name, u.position
    FROM disposition_history dh
    JOIN users u ON dh.user_id = u.id
    WHERE dh.disposition_id = ?
    ORDER BY dh.created_at
");
$stmt->execute([$id]);
$history = $stmt->fetchAll();

// Users for forwarding
$fwdUsers = $pdo->query("SELECT id, name, position, division FROM users WHERE is_active = 1 AND id != {$_SESSION['user_id']} ORDER BY name")->fetchAll();

// Handle Actions
if ($_SERVER['REQUEST_METHOD'] === 'POST') {
    $action = $_POST['disp_action'] ?? '';
    $notes = trim($_POST['action_notes'] ?? '');

    switch ($action) {
        case 'accept':
            $pdo->prepare("UPDATE dispositions SET status = 'accepted', action_notes = ?, updated_at = NOW() WHERE id = ?")->execute([$notes, $id]);
            $pdo->prepare("INSERT INTO disposition_history (disposition_id, user_id, action, notes) VALUES (?, ?, 'accepted', ?)")->execute([$id, $_SESSION['user_id'], $notes]);
            break;

        case 'reject':
            $pdo->prepare("UPDATE dispositions SET status = 'rejected', action_notes = ?, updated_at = NOW() WHERE id = ?")->execute([$notes, $id]);
            $pdo->prepare("INSERT INTO disposition_history (disposition_id, user_id, action, notes) VALUES (?, ?, 'rejected', ?)")->execute([$id, $_SESSION['user_id'], $notes]);
            break;

        case 'forward':
            $fwdTo = (int)($_POST['forward_to'] ?? 0);
            if ($fwdTo) {
                // Buat disposisi baru yang ter-forward
                $pdo->prepare("INSERT INTO dispositions (document_id, from_user_id, to_user_id, status, priority, nature, notes) VALUES (?, ?, ?, 'pending', ?, ?, ?)")
                    ->execute([$disp['document_id'], $_SESSION['user_id'], $fwdTo, $disp['priority'], $disp['nature'], $notes]);
                $newDispId = $pdo->lastInsertId();
                $pdo->prepare("INSERT INTO disposition_history (disposition_id, user_id, action, notes, to_user_id) VALUES (?, ?, 'forwarded', ?, ?)")
                    ->execute([$newDispId, $_SESSION['user_id'], $notes, $fwdTo]);
                // Update current disposition
                $pdo->prepare("UPDATE dispositions SET status = 'forwarded', action_notes = ?, updated_at = NOW() WHERE id = ?")->execute([$notes, $id]);
                $pdo->prepare("INSERT INTO disposition_history (disposition_id, user_id, action, notes, to_user_id) VALUES (?, ?, 'forwarded', ?, ?)")
                    ->execute([$id, $_SESSION['user_id'], $notes, $fwdTo]);
            }
            break;

        case 'return':
            $pdo->prepare("UPDATE dispositions SET status = 'returned', action_notes = ?, updated_at = NOW() WHERE id = ?")->execute([$notes, $id]);
            $pdo->prepare("INSERT INTO disposition_history (disposition_id, user_id, action, notes) VALUES (?, ?, 'returned', ?)")->execute([$id, $_SESSION['user_id'], $notes]);
            // Buat disposisi balik ke pengirim
            $pdo->prepare("INSERT INTO dispositions (document_id, from_user_id, to_user_id, status, priority, nature, notes) VALUES (?, ?, ?, 'pending', ?, ?, ?)")
                ->execute([$disp['document_id'], $_SESSION['user_id'], $disp['from_user_id'], $disp['priority'], $disp['nature'], $notes]);
            break;

        case 'complete':
            $pdo->prepare("UPDATE dispositions SET status = 'completed', action_notes = ?, completed_at = NOW(), updated_at = NOW() WHERE id = ?")->execute([$notes, $id]);
            $pdo->prepare("INSERT INTO disposition_history (disposition_id, user_id, action, notes) VALUES (?, ?, 'completed', ?)")->execute([$id, $_SESSION['user_id'], $notes]);
            // Update document status
            $pdo->prepare("UPDATE documents SET status = 'completed' WHERE id = ?")->execute([$disp['document_id']]);
            break;
    }

    logActivity($_SESSION['user_id'], $action . '_disposition', "Disposisi #$id: $action", $disp['document_id']);
    header('Location: ' . APP_URL . "/disposition_view.php?id=$id&msg=updated");
    exit;
}

require_once 'includes/header.php';
require_once 'includes/sidebar.php';
?>

<div class="lg:ml-64 pt-14 min-h-screen">
<main class="p-4 md:p-6 lg:p-8">

    <?php if (($_GET['msg'] ?? '') === 'updated'): ?><script>showToast('Disposisi berhasil diperbarui', 'success');</script><?php endif; ?>

    <a href="<?= APP_URL ?>/disposition_inbox.php" class="inline-flex items-center gap-2 text-sm text-gray-500 hover:text-brand mb-4"><i class="fas fa-arrow-left"></i> Kembali ke Inbox</a>

    <div class="grid lg:grid-cols-3 gap-6">
        <!-- Main Content -->
        <div class="lg:col-span-2 space-y-6">
            <!-- Info -->
            <div class="bg-white rounded-2xl shadow-sm border border-gray-100 p-6">
                <div class="flex items-center justify-between mb-4">
                    <h2 class="text-lg font-black text-gray-900">Detail Disposisi</h2>
                    <?= statusBadge($disp['status']) ?>
                </div>
                <div class="grid grid-cols-2 gap-4 p-4 bg-gray-50 rounded-xl mb-4">
                    <div><p class="text-[10px] text-gray-400 uppercase font-bold">Dari</p><p class="text-sm font-semibold"><?= esc($disp['from_name']) ?></p><p class="text-[10px] text-gray-400"><?= esc($disp['from_pos']) ?> - <?= esc($disp['from_div']) ?></p></div>
                    <div><p class="text-[10px] text-gray-400 uppercase font-bold">Kepada</p><p class="text-sm font-semibold"><?= esc($disp['to_name']) ?></p><p class="text-[10px] text-gray-400"><?= esc($disp['to_pos']) ?> - <?= esc($disp['to_div']) ?></p></div>
                    <div><p class="text-[10px] text-gray-400 uppercase font-bold">Prioritas</p><?= priorityBadge($disp['priority']) ?></div>
                    <div><p class="text-[10px] text-gray-400 uppercase font-bold">Sifat</p><p class="text-sm font-semibold"><?= ucwords(str_replace('_',' ',$disp['nature'])) ?></p></div>
                </div>
                <p class="text-sm font-semibold text-gray-700"><i class="fas fa-file-alt text-gray-400 mr-2"></i><?= esc($disp['title']) ?></p>
                <p class="text-[10px] text-gray-400 font-mono"><?= esc($disp['document_number']) ?></p>
                <?php if ($disp['notes']): ?>
                <div class="mt-3 p-3 bg-blue-50 rounded-xl"><p class="text-xs text-blue-700 font-semibold mb-1">Catatan Pengirim:</p><p class="text-xs text-blue-600"><?= esc($disp['notes']) ?></p></div>
                <?php endif; ?>
            </div>

            <!-- Timeline -->
            <div class="bg-white rounded-2xl shadow-sm border border-gray-100 p-6">
                <h3 class="font-bold text-gray-800 text-sm mb-4"><i class="fas fa-stream text-brand mr-2"></i>Timeline Disposisi</h3>
                <div class="space-y-0">
                    <?php foreach ($history as $h): ?>
                    <div class="relative pl-10 pb-4 timeline-item">
                        <div class="absolute left-0 top-0 w-8 h-8 rounded-full flex items-center justify-center text-xs z-10 border-2 border-white
                            <?php
                            $iconColors = ['created'=>'bg-blue-100 text-blue-600','accepted'=>'bg-emerald-100 text-emerald-600','rejected'=>'bg-red-100 text-red-600','forwarded'=>'bg-purple-100 text-purple-600','returned'=>'bg-orange-100 text-orange-600','completed'=>'bg-teal-100 text-teal-600'];
                            echo $iconColors[$h['action']] ?? 'bg-gray-100 text-gray-600';
                            ?>">
                            <?php
                            $icons = ['created'=>'fa-plus','accepted'=>'fa-check','rejected'=>'fa-times','forwarded'=>'fa-share','returned'=>'fa-undo','completed'=>'fa-flag-checkered'];
                            echo '<i class="fas ' . ($icons[$h['action']] ?? 'fa-circle') . '"></i>';
                            ?>
                        </div>
                        <div>
                            <p class="text-xs font-semibold text-gray-700">
                                <strong><?= esc($h['name']) ?></strong>
                                <?php
                                $labels = ['created'=>'membuat disposisi','accepted'=>'menerima disposisi','rejected'=>'menolak disposisi','forwarded'=>'meneruskan disposisi','returned'=>'mengembalikan disposisi','completed'=>'menyelesaikan disposisi'];
                                echo $labels[$h['action']] ?? $h['action'];
                                ?>
                            </p>
                            <?php if ($h['notes']): ?><p class="text-xs text-gray-500 mt-0.5 italic">"<?= esc($h['notes']) ?>"</p><?php endif; ?>
                            <p class="text-[10px] text-gray-400 mt-0.5"><?= formatDateShort($h['created_at']) ?></p>
                        </div>
                    </div>
                    <?php endforeach; ?>
                </div>
            </div>
        </div>

        <!-- Actions Sidebar -->
        <div class="space-y-4">
            <?php if ($disp['to_user_id'] == $_SESSION['user_id'] && $disp['status'] === 'pending'): ?>
            <!-- Action Form -->
            <div class="bg-white rounded-2xl shadow-sm border border-gray-100 p-6">
                <h3 class="font-bold text-gray-800 text-sm mb-4"><i class="fas fa-hand-pointer text-brand mr-2"></i>Aksi Disposisi</h3>
                <form method="POST" action="" id="actionForm">
                    <input type="hidden" name="disp_action" id="dispActionInput" value="">

                    <div class="mb-4">
                        <label class="block text-xs font-semibold text-gray-600 mb-1">Catatan</label>
                        <textarea name="action_notes" rows="3" class="w-full border border-gray-200 rounded-lg px-4 py-2.5 text-sm focus:ring-2 focus:ring-teal outline-none resize-none" placeholder="Tambahkan catatan..."></textarea>
                    </div>

                    <!-- Forward Section (hidden by default) -->
                    <div id="forwardSection" class="hidden mb-4">
                        <label class="block text-xs font-semibold text-gray-600 mb-1">Teruskan ke</label>
                        <select name="forward_to" class="w-full border border-gray-200 rounded-lg px-4 py-2.5 text-sm focus:ring-2 focus:ring-teal outline-none">
                            <option value="">-- Pilih User --</option>
                            <?php foreach ($fwdUsers as $u): ?>
                            <option value="<?= $u['id'] ?>"><?= esc($u['name']) ?> - <?= esc($u['position']) ?></option>
                            <?php endforeach; ?>
                        </select>
                    </div>

                    <div class="grid grid-cols-2 gap-2">
                        <button type="button" onclick="submitAction('accept')" class="bg-emerald-50 text-emerald-700 px-3 py-2.5 rounded-lg text-xs font-bold hover:bg-emerald-100 transition-colors"><i class="fas fa-check mr-1"></i>Terima</button>
                        <button type="button" onclick="submitAction('reject')" class="bg-red-50 text-red-700 px-3 py-2.5 rounded-lg text-xs font-bold hover:bg-red-100 transition-colors"><i class="fas fa-times mr-1"></i>Tolak</button>
                        <button type="button" onclick="submitAction('forward')" class="bg-purple-50 text-purple-700 px-3 py-2.5 rounded-lg text-xs font-bold hover:bg-purple-100 transition-colors"><i class="fas fa-share mr-1"></i>Teruskan</button>
                        <button type="button" onclick="submitAction('return')" class="bg-orange-50 text-orange-700 px-3 py-2.5 rounded-lg text-xs font-bold hover:bg-orange-100 transition-colors"><i class="fas fa-undo mr-1"></i>Kembalikan</button>
                        <button type="button" onclick="submitAction('complete')" class="col-span-2 bg-teal-50 text-teal-700 px-3 py-2.5 rounded-lg text-xs font-bold hover:bg-teal-100 transition-colors"><i class="fas fa-flag-checkered mr-1"></i>Selesaikan</button>
                        
                        <?php if ($isOpArsipKesekretariatan): ?>
                        <!-- Tombol Arsipkan & Selesai khusus op_arsip Kesekretariatan -->
                        <button type="button" onclick="openArchiveForm()" class="col-span-2 bg-indigo-50 text-indigo-700 px-3 py-2.5 rounded-lg text-xs font-bold hover:bg-indigo-100 transition-colors mt-1"><i class="fas fa-archive mr-1"></i>Arsipkan & Selesai</button>
                        <?php endif; ?>
                    </div>
                </form>
            </div>
            <?php endif; ?>

            <!-- Downloads -->
            <div class="bg-white rounded-2xl shadow-sm border border-gray-100 p-6">
                <h3 class="font-bold text-gray-800 text-sm mb-3">Download</h3>
                <div class="space-y-2">
                    <?php if (file_exists($disp['file_path'])): ?>
                    <a href="<?= APP_URL ?>/<?= $disp['file_path'] ?>" download class="btn-outline w-full justify-center text-xs"><i class="fas fa-download"></i> Dokumen Asli</a>
                    <?php endif; ?>
                    <a href="<?= APP_URL ?>/generate_disposition_sheet.php?id=<?= $id ?>" class="btn-outline w-full justify-center text-xs" target="_blank"><i class="fas fa-file-pdf"></i> Lembar Disposisi PDF</a>
                    <a href="<?= APP_URL ?>/document_view.php?id=<?= $disp['doc_id'] ?>" class="btn-outline w-full justify-center text-xs"><i class="fas fa-eye"></i> Lihat Dokumen</a>
                </div>
            </div>
        </div>
    </div>
</main>
</div>

<!-- Modal / Form Pengarsipan (Menggunakan koneksi & field isian persis seperti form upload.php asli) -->
<?php if ($isOpArsipKesekretariatan): ?>
<div id="archiveModal" class="fixed inset-0 bg-black bg-opacity-50 z-50 hidden flex items-center justify-center p-4">
    <div class="bg-white rounded-2xl max-w-3xl w-full max-h-[90vh] overflow-y-auto p-6 shadow-xl">
        <div class="flex justify-between items-center mb-4 border-b pb-3">
            <h3 class="font-bold text-gray-900 text-md"><i class="fas fa-archive text-indigo-600 mr-2"></i>Form Pengarsipan Dokumen Disposisi</h3>
            <button type="button" onclick="closeArchiveForm()" class="text-gray-400 hover:text-gray-600"><i class="fas fa-times"></i></button>
        </div>
        
        <!-- Form target mengarah ke modules/documents/upload.php dengan konfigurasi arsip terpisah -->
        <form action="<?= APP_URL ?>/arsip/modules/documents/upload.php" method="POST" enctype="multipart/form-data" class="space-y-4">
            <!-- Hidden inputs untuk melampirkan file disposisi secara otomatis -->
            <input type="hidden" name="disposition_id" value="<?= $id ?>">
            <input type="hidden" name="source_file_path" value="<?= esc($disp['file_path']) ?>">
            <input type="hidden" name="auto_archive_source" value="1">

            <!-- File Dokumen Info -->
            <div class="form-group">
                <label class="required block text-xs font-semibold text-gray-600 mb-1">File Dokumen (Otomatis dari Disposisi)</label>
                <div class="p-3 bg-gray-50 border rounded-lg text-sm flex items-center justify-between">
                    <span class="truncate text-gray-700"><i class="fas fa-file-alt mr-2 text-gray-400"></i><?= basename($disp['file_path']) ?></span>
                    <span class="text-xs bg-teal-100 text-teal-800 px-2 py-0.5 rounded font-bold">Terlampir Otomatis</span>
                </div>
            </div>

            <div class="grid grid-cols-1 md:grid-cols-2 gap-4">
                <div class="form-group">
                    <label class="required block text-xs font-semibold text-gray-600 mb-1">Judul Dokumen</label>
                    <input type="text" name="title" class="w-full border border-gray-200 rounded-lg px-4 py-2.5 text-sm focus:ring-2 focus:ring-teal outline-none" value="<?= esc($disp['title']) ?>" required>
                </div>
                <div class="form-group">
                    <label class="required block text-xs font-semibold text-gray-600 mb-1">Kategori</label>
                    <select name="category_id" class="w-full border border-gray-200 rounded-lg px-4 py-2.5 text-sm focus:ring-2 focus:ring-teal outline-none" required>
                        <option value="">-- Pilih Kategori --</option>
                        <?php foreach ($categories as $cat): ?>
                        <option value="<?= $cat['id'] ?>"><?= htmlspecialchars($cat['name']) ?></option>
                        <?php endforeach; ?>
                    </select>
                </div>
            </div>

            <div class="form-group">
                <label class="block text-xs font-semibold text-gray-600 mb-1">Deskripsi</label>
                <textarea name="description" rows="2" class="w-full border border-gray-200 rounded-lg px-4 py-2.5 text-sm focus:ring-2 focus:ring-teal outline-none" placeholder="Deskripsi singkat dokumen..."><?= esc($disp['notes']) ?></textarea>
            </div>

            <div class="grid grid-cols-1 md:grid-cols-3 gap-4">
                <div class="form-group">
                    <label class="block text-xs font-semibold text-gray-600 mb-1">Folder</label>
                    <select name="folder_id" class="w-full border border-gray-200 rounded-lg px-4 py-2.5 text-sm focus:ring-2 focus:ring-teal outline-none">
                        <option value="">-- Tidak ada folder --</option>
                        <?php foreach ($folders as $folder): ?>
                        <option value="<?= $folder['id'] ?>">
                            [<?= htmlspecialchars($folder['division'] ?? '') ?>] <?= htmlspecialchars($folder['name'] ?? 'Tanpa Nama Folder') ?>
                        </option>
                        <?php endforeach; ?>
                    </select>
                </div>
                <div class="form-group">
                    <label class="block text-xs font-semibold text-gray-600 mb-1">Departemen</label>
                    <select name="department" class="w-full border border-gray-200 rounded-lg px-4 py-2.5 text-sm focus:ring-2 focus:ring-teal outline-none">
                        <?php 
                        $deptList = defined('DEPARTMENTS') ? DEPARTMENTS : ['Umum', 'Sekretariat', 'Operasional'];
                        foreach ($deptList as $dept): 
                        ?>
                        <option value="<?= $dept ?>" <?= $dept == ($currentUserData['department'] ?? '') ? 'selected' : '' ?>><?= $dept ?></option>
                        <?php endforeach; ?>
                    </select>
                </div>
                <div class="form-group">
                    <label class="block text-xs font-semibold text-gray-600 mb-1">Divisi / Bidang</label>
                    <select name="division" class="w-full border border-gray-200 rounded-lg px-4 py-2.5 text-sm focus:ring-2 focus:ring-teal outline-none">
                        <?php foreach ($divisionsList as $div): ?>
                        <option value="<?= $div ?>" <?= $div == ($disp['to_div'] ?? 'Kesekretariatan') ? 'selected' : '' ?>><?= $div ?></option>
                        <?php endforeach; ?>
                    </select>
                </div>
            </div>

            <div class="grid grid-cols-1 md:grid-cols-2 gap-4">
                <div class="form-group">
                    <label class="block text-xs font-semibold text-gray-600 mb-1">Tanggal Expired</label>
                    <input type="date" name="expiry_date" class="w-full border border-gray-200 rounded-lg px-4 py-2.5 text-sm focus:ring-2 focus:ring-teal outline-none">
                    <div class="text-[10px] text-gray-400 mt-1">Kosongkan jika tidak memiliki masa berlaku</div>
                </div>
                <div class="form-group">
                    <label class="block text-xs font-semibold text-gray-600 mb-1">Alert Sebelum Expired (hari)</label>
                    <input type="number" name="expiry_alert_days" class="w-full border border-gray-200 rounded-lg px-4 py-2.5 text-sm focus:ring-2 focus:ring-teal outline-none" value="30" min="1">
                </div>
            </div>

            <div class="form-group">
                <label class="block text-xs font-semibold text-gray-600 mb-1">Tags</label>
                <div class="flex flex-wrap gap-2 p-3 bg-gray-50 border rounded-lg max-h-32 overflow-y-auto">
                    <?php foreach ($tags as $tag): ?>
                    <label class="inline-flex items-center space-x-1.5 bg-white border px-2.5 py-1 rounded-md text-xs cursor-pointer">
                        <input type="checkbox" name="tags[]" value="<?= $tag['id'] ?>" class="rounded text-teal-600">
                        <span style="color: <?= $tag['color'] ?? '#333' ?>; font-weight: 500;"><?= htmlspecialchars($tag['name']) ?></span>
                    </label>
                    <?php endforeach; ?>
                </div>
            </div>

            <div class="form-group">
                <label class="block text-xs font-semibold text-gray-600 mb-1">Catatan Perubahan</label>
                <input type="text" name="change_notes" class="w-full border border-gray-200 rounded-lg px-4 py-2.5 text-sm focus:ring-2 focus:ring-teal outline-none" value="Arsip Disposisi #<?= $id ?>">
            </div>

            <div class="flex items-center space-x-2 pt-1">
                <input type="checkbox" name="is_confidential" id="is_confidential" value="1" class="w-4 h-4 text-teal-600 border-gray-300 rounded focus:ring-teal">
                <label for="is_confidential" class="text-xs font-semibold text-gray-700 cursor-pointer"><i class="fas fa-lock mr-1 text-amber-500"></i> Dokumen Rahasia (hanya admin & pemilik yang bisa akses)</label>
            </div>

            <div class="flex justify-end gap-2 pt-4 border-t mt-4">
                <button type="button" onclick="closeArchiveForm()" class="px-4 py-2 bg-gray-100 text-gray-700 rounded-lg text-xs font-bold hover:bg-gray-200">Batal</button>
                <button type="submit" name="archive_and_complete" value="1" class="px-4 py-2 bg-indigo-600 text-white rounded-lg text-xs font-bold hover:bg-indigo-700"><i class="fas fa-save mr-1"></i>Simpan ke Arsip & Selesaikan</button>
            </div>
        </form>
    </div>
</div>
<?php endif; ?>

<script>
function submitAction(action) {
    document.getElementById('dispActionInput').value = action;
    const fwd = document.getElementById('forwardSection');
    if (action === 'forward') {
        fwd.classList.remove('hidden');
        const sel = document.querySelector('[name="forward_to"]');
        if (!sel.value) { alert('Pilih user tujuan teruskan'); return; }
    } else {
        fwd.classList.add('hidden');
    }
    document.getElementById('actionForm').submit();
}

<?php if ($isOpArsipKesekretariatan): ?>
function openArchiveForm() {
    document.getElementById('archiveModal').classList.remove('hidden');
}

function closeArchiveForm() {
    document.getElementById('archiveModal').classList.add('hidden');
}
<?php endif; ?>
</script>
<?php require_once 'includes/footer.php'; ?>