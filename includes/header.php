<?php if (!defined('APP_NAME')) require_once __DIR__ . '/../config.php'; ?>
<!DOCTYPE html>
<html lang="id">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title><?= esc($pageTitle ?? APP_NAME) ?> — <?= esc(APP_SUBTITLE) ?></title>
    <link rel="icon" type="image/x-icon" href="arsip/favicon.png">
    <script src="https://cdn.tailwindcss.com"></script>
    <script>
        tailwind.config = {
            theme: {
                extend: {
                    colors: {
                        brand: { DEFAULT: '<?= BRAND_PRIMARY ?>', dark: '<?= BRAND_DARK ?>', light: '<?= BRAND_LIGHT ?>', accent: '<?= BRAND_ACCENT ?>' },
                        teal: { DEFAULT: '<?= BRAND_SECONDARY ?>' }
                    }
                }
            }
        }
    </script>
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.5.1/css/all.min.css">
    <link rel="stylesheet" href="<?= APP_URL ?>/assets/css/style.css">
    <link href="https://fonts.googleapis.com/css2?family=Plus+Jakarta+Sans:wght@300;400;500;600;700;800;900&display=swap" rel="stylesheet">
</head>
<body class="bg-gray-50 font-['Plus_Jakarta_Sans']">