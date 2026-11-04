<?php if (!defined('APP_NAME')) require_once __DIR__ . '/../config.php'; ?>
<!-- Main Content Padding -->
<div class="lg:ml-64 pt-14 min-h-screen">
    <main class="p-4 md:p-6 lg:p-8">
        <!-- Page content goes here -->
    </main>
</div>

<!-- Toast Container -->
<div id="toastContainer" class="fixed top-20 right-4 z-[100] space-y-2"></div>

<script src="<?= APP_URL ?>/assets/js/app.js"></script>
<?php if (isset($extraScripts)) echo $extraScripts; ?>
</body>
</html>