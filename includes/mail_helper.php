<?php
// includes/mail_helper.php
require_once __DIR__ . '/../config.php';

function sendEmailNotification($toEmail, $toName, $subject, $templateName, $replacements = []) {
    $templatePath = __DIR__ . '/../templates/email/' . $templateName . '.html';
    
    if (!file_exists($templatePath)) {
        return false;
    }
    
    $htmlContent = file_get_contents($templatePath);
    
    // Default replacements untuk branding perusahaan
    $replacements['COMPANY_NAME'] = COMPANY_NAME;
    $replacements['APP_NAME'] = APP_NAME;
    $replacements['APP_URL'] = APP_URL;
    $replacements['USER_NAME'] = $toName;
    
    // Ganti placeholder template (contoh: {{USER_NAME}}, {{TITLE}}, dll)
    foreach ($replacements as $key => $value) {
        $htmlContent = str_replace('{{' . $key . '}}', $value, $htmlContent);
    }
    
    $headers = "MIME-Version: 1.0" . "\r\n";
    $headers .= "Content-type:text/html;charset=UTF-8" . "\r\n";
    $headers .= "From: " . SMTP_FROM_NAME . " <" . SMTP_FROM . ">" . "\r\n";
    
    // Catatan: Untuk produksi, disarankan menggunakan PHPMailer / SMTP Wrapper yang mendukung port & auth aman (SSL/TLS).
    // Implementasi mail() standar server:
    return mail($toEmail, $subject, $htmlContent, $headers);
}