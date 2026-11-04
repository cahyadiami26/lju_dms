<?php
if (!defined('APP_NAME')) require_once __DIR__ . '/../config.php';
$currentPage = basename($_SERVER['PHP_SELF']);
$notifCount = getNotifications();
$notadinasCount = getNotifNotaDinas();
$notifterimaST = getNotifTerimaST();
$notifttdST = getNotifttdST();
$notifTTDSK = getNotifttdSK();
$notifSurat = getNotifSurat();
$user = currentUser();
?>
<!-- Script Alpine.js untuk penanganan interaksi dropdown (opsional jika belum di-include di main layout) -->
<script defer src="https://cdn.jsdelivr.net/npm/alpinejs@3.x.x/dist/cdn.min.js"></script>

<!-- Sidebar Overlay (mobile) -->
<div id="sidebarOverlay" class="fixed inset-0 bg-black/50 z-40 hidden lg:hidden" onclick="toggleSidebar()"></div>

<!-- Sidebar -->
<aside id="sidebar" class="fixed left-0 top-0 h-full w-64 bg-brand-dark z-50 transform -translate-x-full lg:translate-x-0 transition-transform duration-300 flex flex-col">
    
    <!-- Logo & App Switcher Area -->
    <div class="p-4 border-b border-white/10 relative" x-data="{ open: false }">
        <button @click="open = !open" @click.away="open = false" 
                class="w-full flex items-center justify-between p-2 rounded-xl bg-white/5 hover:bg-white/10 border border-white/10 transition-all duration-200 group">
            <div class="flex items-center gap-3 min-w-0">
                <!-- Logo Perusahaan -->
                <img src="<?= APP_URL . APP_LOGO ?>" alt="Logo" class="w-9 h-9 object-contain flex-shrink-0 group-hover:scale-105 transition-transform">
                
                <div class="text-left min-w-0">
                    <div class="flex items-center gap-1.5">
                        <h1 class="text-white font-bold text-xs truncate">Aplikasi Naskah Dinas</h1>
                        <span class="bg-blue-500/20 text-blue-300 text-[9px] px-1.5 py-0.5 rounded-full border border-blue-400/30">Aktif</span>
                    </div>
                    <p class="text-gray-400 text-[10px] truncate"><?= esc(APP_NAME) ?></p>
                </div>
            </div>
            <i class="fas fa-chevron-down text-xs text-gray-400 group-hover:text-white transition-transform duration-200" :class="{ 'rotate-180': open }"></i>
        </button>

        <!-- Dropdown Menu Switcher -->
        <div x-show="open" 
             x-transition:enter="transition ease-out duration-150"
             x-transition:enter-start="opacity-0 scale-95 -translate-y-1"
             x-transition:enter-end="opacity-100 scale-100 translate-y-0"
             x-transition:leave="transition ease-in duration-100"
             x-transition:leave-start="opacity-100 scale-100 translate-y-0"
             x-transition:leave-end="opacity-0 scale-95 -translate-y-1"
             class="absolute left-4 right-4 mt-2 py-2 bg-slate-900 border border-white/15 rounded-xl shadow-2xl z-50 backdrop-blur-lg" 
             style="display: none;">
            
            <p class="px-3 py-1 text-[10px] font-semibold text-gray-400 uppercase tracking-wider">Pilih Aplikasi</p>

            <!-- Current App (Disposisi) -->
            <a href="https://dms.lju.co.id" class="flex items-center gap-3 px-3 py-2 bg-white/10 text-white border-l-2 border-blue-500">
                <div class="w-7 h-7 rounded-md bg-blue-600/30 text-blue-400 flex items-center justify-center text-xs">
                    <i class="fas fa-paper-plane"></i>
                </div>
                <div class="min-w-0 flex-1">
                    <p class="text-xs font-medium truncate">Aplikasi Naskah Dinas</p>
                    <p class="text-[9px] text-gray-400">Sistem Surat & Disposisi</p>
                </div>
                <i class="fas fa-check text-xs text-blue-400"></i>
            </a>

            <!-- Target App (Arsip) -->
            <a href="https://dms.lju.co.id/arsip" class="flex items-center gap-3 px-3 py-2 hover:bg-white/5 text-gray-300 hover:text-white transition-colors group">
                <div class="w-7 h-7 rounded-md bg-emerald-600/20 group-hover:bg-emerald-600/40 text-emerald-400 flex items-center justify-center text-xs transition-colors">
                    <i class="fas fa-archive"></i>
                </div>
                <div class="min-w-0 flex-1">
                    <p class="text-xs font-medium truncate">Aplikasi Arsip</p>
                    <p class="text-[9px] text-gray-400">Sistem E-Arsip</p>
                </div>
                <i class="fas fa-external-link-alt text-[10px] text-gray-500 group-hover:text-gray-300"></i>
            </a>
        </div>
    </div>

    <!-- Navigation -->
    <nav class="flex-1 overflow-y-auto py-4 px-3 space-y-1">
        <p class="text-gray-500 text-[10px] uppercase tracking-wider font-bold px-3 mb-2">Menu Utama</p>

        <a href="<?= APP_URL ?>/dashboard.php" class="sidebar-link <?= $currentPage === 'dashboard.php' ? 'active' : '' ?>">
            <i class="fas fa-chart-pie w-5 text-center"></i>
            <span>Dashboard</span>
        </a>

        <p class="text-gray-500 text-[10px] uppercase tracking-wider font-bold px-3 mt-4 mb-2">Dokumen</p>

        <a href="<?= APP_URL ?>/documents.php?action=upload" class="sidebar-link <?= ($currentPage === 'documents.php' && ($_GET['action'] ?? '') === 'upload') ? 'active' : '' ?>">
            <i class="fas fa-cloud-upload-alt w-5 text-center"></i>
            <span>Upload Dokumen</span>
        </a>

        <a href="<?= APP_URL ?>/documents.php" class="sidebar-link <?= $currentPage === 'documents.php' ? 'active' : '' ?>">
            <i class="fas fa-folder-open w-5 text-center"></i>
            <span>Data Surat Masuk</span>
            <?php if ($notifSurat> 0): ?>
                <span class="ml-auto bg-red-500 text-white text-[10px] font-bold rounded-full w-5 h-5 flex items-center justify-center"><?= $notifSurat ?></span>
            <?php endif; ?>
        </a>

        <a href="<?= APP_URL ?>/surattugas_list.php" class="sidebar-link <?= $currentPage === 'surattugas_list.php' ? 'active' : '' ?>">
            <i class="fas fa-inbox w-5 text-center"></i>
            <span>Surat Tugas</span>
            <?php if ($notifterimaST > 0): ?>
                <span class="ml-auto bg-red-500 text-white text-[10px] font-bold rounded-full w-5 h-5 flex items-center justify-center"><?= $notifterimaST ?></span>
            <?php endif; ?>
        </a>
        
        <!--
        <p class="text-gray-500 text-[10px] uppercase tracking-wider font-bold px-3 mt-4 mb-2">Tanda Tangan</p>

        <a href="<?= APP_URL ?>/documents.php?filter=pending_signature" class="sidebar-link">
            <i class="fas fa-signature w-5 text-center"></i>
            <span>Tanda Tangan Digital</span>
        </a>
        -->


        <p class="text-gray-500 text-[10px] uppercase tracking-wider font-bold px-3 mt-4 mb-2">Disposisi</p>

        <a href="<?= APP_URL ?>/disposition_inbox.php" class="sidebar-link <?= $currentPage === 'disposition_inbox.php' ? 'active' : '' ?>">
            <i class="fas fa-inbox w-5 text-center"></i>
            <span>Inbox Disposisi</span>
            <?php if ($notifCount > 0): ?>
                <span class="ml-auto bg-red-500 text-white text-[10px] font-bold rounded-full w-5 h-5 flex items-center justify-center"><?= $notifCount ?></span>
            <?php endif; ?>
        </a>
        
        <!--
        <a href="<?= APP_URL ?>/disposition_create.php" class="sidebar-link <?= $currentPage === 'disposition_create.php' ? 'active' : '' ?>">
            <i class="fas fa-paper-plane w-5 text-center"></i>
            <span>Buat Disposisi</span>
        </a>
        -->

        <a href="<?= APP_URL ?>/dispositions.php" class="sidebar-link <?= $currentPage === 'dispositions.php' ? 'active' : '' ?>">
            <i class="fas fa-history w-5 text-center"></i>
            <span>Riwayat Disposisi</span>
        </a>
        
        <p class="text-gray-500 text-[10px] uppercase tracking-wider font-bold px-3 mt-4 mb-2">Nota Dinas</p>

        <a href="<?= APP_URL ?>/notadinas_inbox.php" class="sidebar-link <?= $currentPage === 'notadinas_inbox.php' ? 'active' : '' ?>">
            <i class="fas fa-solid fa-envelope w-5 text-center"></i>
            <span>Inbox Nota Dinas</span>
            <?php if ($notadinasCount > 0): ?>
                <span class="ml-auto bg-red-500 text-white text-[10px] font-bold rounded-full w-5 h-5 flex items-center justify-center"><?= $notadinasCount ?></span>
            <?php endif; ?>
        </a>
        
        <a href="<?= APP_URL ?>/notadinas_create.php" class="sidebar-link <?= $currentPage === 'notadinas_create.php' ? 'active' : '' ?>">
            <i class="fas fa-pen-clip w-5 text-center"></i>
            <span>Buat Nota Dinas</span>
        </a>

        <p class="text-gray-500 text-[10px] uppercase tracking-wider font-bold px-3 mt-4 mb-2">Lainnya</p>

        <a href="<?= APP_URL ?>/verification.php" class="sidebar-link <?= $currentPage === 'verification.php' ? 'active' : '' ?>">
            <i class="fas fa-shield-alt w-5 text-center"></i>
            <span>Verifikasi Dokumen</span>
        </a>
        
        <a href="<?= APP_URL ?>/user_profile.php" class="sidebar-link <?= $currentPage === 'user_profile.php' ? 'active' : '' ?>">
            <i class="fas fa-user-pen w-5 text-center"></i>
            <span>Profil Saya</span>
        </a>

        <?php if (($_SESSION['role'] ?? '') === 'admin'): ?>
        <a href="<?= APP_URL ?>/users.php"
            class="sidebar-link <?= $currentPage === 'users.php' ? 'active' : '' ?>">
            <i class="fas fa-users-cog w-5 text-center"></i>
            <span>Manajemen User</span>
        </a>
        <?php endif; ?>
    </nav>

    <!-- User Info -->
    <div class="p-4 border-t border-white/10">
        <div class="flex items-center gap-3 mb-3">
            <?php 
            $avatarUrl = function_exists('getUserAvatar') ? getUserAvatar() : '';
            $hasAvatar = !empty($user['avatar']) && file_exists(AVATAR_PATH . '/' . $user['avatar']);
            ?>
        
            <?php if ($hasAvatar): ?>
                <img src="<?= esc($avatarUrl) ?>" alt="<?= esc($user['name'] ?? 'User') ?>" class="w-9 h-9 rounded-full object-cover flex-shrink-0">
            <?php else: ?>
                <div class="w-9 h-9 rounded-full bg-teal flex items-center justify-center text-white font-bold text-sm flex-shrink-0">
                    <?= strtoupper(substr($user['name'] ?? 'U', 0, 1)) ?>
                </div>
            <?php endif; ?>

            <div class="min-w-0">
                <p class="text-white text-sm font-semibold truncate"><?= esc($user['name'] ?? '') ?></p>
                <p class="text-gray-400 text-[11px] truncate"><?= esc($user['position'] ?? '') ?></p>
            </div>
        </div>
        <a href="https://lju.co.id/dashboard" class="flex items-center gap-2 text-gray-400 hover:text-red-400 text-sm transition-colors">
           <i class="fas fa-sign-out-alt"></i>
           <span>Dashboard</span>
        </a>
    </div>
</aside>

<!-- Top Bar -->
<header class="fixed top-0 left-0 lg:left-64 right-0 h-14 bg-white border-b border-gray-200 z-30 flex items-center px-4 gap-3">
    <button onclick="toggleSidebar()" class="lg:hidden text-gray-600 hover:text-gray-900 p-1">
        <i class="fas fa-bars text-xl"></i>
    </button>
    <div class="flex-1">
        <h2 class="text-sm font-semibold text-gray-800"><?= esc($pageTitle ?? 'Dashboard') ?></h2>
    </div>
    <div class="flex items-center gap-3">
        <a href="<?= APP_URL ?>/disposition_inbox.php" class="relative p-2 text-gray-500 hover:text-brand transition-colors">
            <i class="fas fa-inbox"></i>
            <?php if ($notifCount > 0): ?>
                <span class="absolute -top-0.5 -right-0.5 bg-red-500 text-white text-[9px] font-bold rounded-full w-4 h-4 flex items-center justify-center"><?= $notifCount ?></span>
            <?php endif; ?>
        </a>
        
        <a href="<?= APP_URL ?>/notadinas_inbox.php" class="relative p-2 text-gray-500 hover:text-brand transition-colors">
            <i class="fas fa-envelope "></i>
            <?php if ($notifCount > 0): ?>
                <span class="absolute -top-0.5 -right-0.5 bg-red-500 text-white text-[9px] font-bold rounded-full w-4 h-4 flex items-center justify-center"><?= $notadinasCount ?></span>
            <?php endif; ?>
        </a>
        
        <?php if ($hasAvatar): ?>
            <img src="<?= esc($avatarUrl) ?>" alt="Avatar" class="w-8 h-8 rounded-full object-cover">
        <?php else: ?>
            <div class="w-8 h-8 rounded-full bg-brand flex items-center justify-center text-white font-bold text-xs">
               <?= strtoupper(substr($user['name'] ?? 'U', 0, 1)) ?>
            </div>
        <?php endif; ?>
    </div>
</header>

<script>
function toggleSidebar() {
    const sidebar = document.getElementById('sidebar');
    const overlay = document.getElementById('sidebarOverlay');
    sidebar.classList.toggle('-translate-x-full');
    overlay.classList.toggle('hidden');
}
</script>