<?php
/**
 * ============================================================
 * generate_disposition_sheet.php
 * Sistem Manajemen Dokumen
 * Generate Lembar Disposisi PDF
 * ============================================================
 */

require_once __DIR__ . '/config.php';
require_once __DIR__ . '/lib/fpdf/fpdf.php';

// Proteksi sesi login
requireLogin();

$documentId = isset($_GET['id']) ? (int)$_GET['id'] : 0;

if ($documentId <= 0) {
    exit('ID dokumen tidak valid.');
}

/* ============================================================
 * Ambil Data Dokumen
 * ============================================================
 */
$sql = "
SELECT
    d.*,
    dc.*,
    u.name        AS creator_name,
    u.position    AS creator_position,
    u.division    AS creator_division
FROM dispositions d
LEFT JOIN users u ON u.id = d.from_user_id
LEFT JOIN documents dc ON dc.id = d.document_id
WHERE d.id = ?
LIMIT 1
";

$stmt = $pdo->prepare($sql);
$stmt->execute([$documentId]);
$document = $stmt->fetch();

if (!$document) {
    exit('Dokumen tidak ditemukan.');
}

/* ============================================================
 * Ambil Riwayat Disposisi (Serta Kolom Signature Pengirim/User)
 * ============================================================
 */
$sql = "
SELECT
    dp.*,
    fu.name        AS from_name,
    fu.position    AS from_position,
    fu.division    AS from_division,
    fu.signature   AS from_signature,
    tu.name        AS to_name,
    tu.position    AS to_position,
    tu.division    AS to_division
FROM dispositions dp
LEFT JOIN users fu ON fu.id = dp.from_user_id
LEFT JOIN users tu ON tu.id = dp.to_user_id
WHERE dp.id = ?
ORDER BY dp.created_at ASC
";

$stmt = $pdo->prepare($sql);
$stmt->execute([$documentId]);
$dispositions = $stmt->fetchAll();

/* ============================================================
 * Label Mapping
 * ============================================================
 */
$priorityLabels = [
    'biasa'         => 'Biasa',
    'segera'        => 'Segera',
    'sangat_segera' => 'Sangat Segera'
];

$statusLabels = [
    'draft'             => 'Draft',
    'pending'           => 'Menunggu',
    'accepted'          => 'Diterima',
    'forwarded'         => 'Diteruskan',
    'completed'         => 'Selesai',
    'returned'          => 'Dikembalikan',
    'rejected'          => 'Ditolak',
    'pending_signature' => 'Menunggu TTD',
    'signed'            => 'Sudah Ditandatangani',
    'dispositioned'     => 'Didisposisikan'
];

/* ============================================================
 * Helper Functions
 * ============================================================
 */
function value($val) {
    return empty($val) ? '-' : $val;
}

function indoDate($date) {
    if (empty($date)) {
        return '-';
    }
    return formatDate($date);
}

function priorityColor($priority) {
    switch ($priority) {
        case 'sangat_segera':
            return [220, 38, 38]; // Red
        case 'segera':
            return [217, 119, 6]; // Amber/Orange
        case 'biasa':
        default:
            return [70, 70, 70];  // Neutral Gray
    }
}

/* ============================================================
 * Class PDF (FPDF Wrapper)
 * ============================================================
 */
class DispositionPDF extends FPDF
{
    public $logo;

    function Header()
    {
        // Header Background Brand Primary (#0f4c75)
        $this->SetFillColor(15, 76, 117);
        $this->Rect(0, 0, 210, 22, 'F');

        if ($this->logo && file_exists($this->logo)) {
            $this->Image($this->logo, 10, 3, 16);
            $this->SetXY(30, 3);
        } else {
            $this->SetXY(10, 3);
        }

        $this->SetTextColor(255, 255, 255);
        $this->SetFont('Arial', 'B', 11);
        $this->Cell(0, 5, COMPANY_NAME, 0, 1);

        $this->SetFont('Arial', '', 8);
        $this->SetX($this->logo && file_exists($this->logo) ? 30 : 10);
        $this->Cell(0, 4, APP_NAME . ' - ' . APP_SUBTITLE, 0, 1);

        $this->SetFont('Arial', '', 7);
        $this->SetX($this->logo && file_exists($this->logo) ? 30 : 10);
        $this->Cell(0, 4, COMPANY_ADDRESS . ' | Telp: ' . COMPANY_PHONE . ' | Email: ' . COMPANY_EMAIL, 0, 1);

        // Teks "LEMBAR DISPOSISI DOKUMEN" di bawah header biru
        $this->SetXY(0, 25);
        $this->SetTextColor(15, 76, 117);
        $this->SetFont('Arial', 'B', 12);
        $this->Cell(210, 6, 'LEMBAR DISPOSISI DOKUMEN', 0, 1, 'C');

        $this->Ln(3);
    }

    function Footer()
    {
        $this->SetY(-15);
        $this->SetDrawColor(200, 200, 200);
        $this->Line(10, $this->GetY(), 200, $this->GetY());

        $this->SetFont('Arial', 'I', 7);
        $this->SetTextColor(100, 100, 100);
        $this->Ln(2);

        $this->Cell(95, 4, APP_NAME . ' - ' . COMPANY_NAME, 0, 0, 'L');
        $this->Cell(95, 4, 'Halaman ' . $this->PageNo() . '/{nb}', 0, 0, 'R');
    }
}

/* ============================================================
 * Inisialisasi PDF
 * ============================================================
 */
$pdf = new DispositionPDF();
$pdf->AliasNbPages();
$pdf->SetAutoPageBreak(true, 20);
$pdf->logo = __DIR__ . '/assets/img/logo.png';
$pdf->AddPage();
$pdf->SetMargins(10, 10, 10);

/* ============================================================
 * INFORMASI DOKUMEN
 * ============================================================
 */
$pdf->SetFont('Arial', 'B', 10);
$pdf->SetTextColor(15, 76, 117);
$pdf->Cell(0, 6, 'INFORMASI DOKUMEN', 0, 1);

$pdf->SetDrawColor(15, 76, 117);
$pdf->Line(10, $pdf->GetY(), 200, $pdf->GetY());
$pdf->Ln(4);

$boxX = 10;
$boxY = $pdf->GetY();
$boxW = 190;
$boxH = 58;

$pdf->SetFillColor(248, 250, 252);
$pdf->SetDrawColor(210, 220, 230);
$pdf->Rect($boxX, $boxY, $boxW, $boxH, 'DF');

/* Data Dokumen */
$mailNumber   = value($document['mail_number'] ?? '');
$mailDate     = indoDate($document['mail_date'] ?? '');
$sender       = value($document['sender'] ?? '');
$title        = value($document['title'] ?? '');
$category     = value($document['category'] ?? '');
$priority     = strtolower($document['priority'] ?? 'biasa');
$nature       = value(ucwords($document['nature'] ?? 'biasa'));
$status       = strtolower($document['status'] ?? 'draft');
$creator      = value($document['creator_name'] ?? '-');

$priorityText = $priorityLabels[$priority] ?? ucfirst($priority);
$statusText   = $statusLabels[$status] ?? ucfirst($status);
$pc           = priorityColor($priority);

/* Kolom Kiri */
$y = $boxY + 4;

function infoRow($pdf, $label, $val, &$y, $x = 15) {
    $pdf->SetXY($x, $y);
    $pdf->SetFont('Arial', 'B', 8);
    $pdf->SetTextColor(80, 80, 80);
    $pdf->Cell(34, 5, $label, 0, 0);

    $pdf->SetFont('Arial', '', 8);
    $pdf->SetTextColor(30, 30, 30);
    $pdf->MultiCell(48, 5, $val, 0, 'L');
    $y = $pdf->GetY();
}

infoRow($pdf, 'Nomor Surat', $mailNumber, $y);
infoRow($pdf, 'Tanggal Surat', $mailDate, $y);
infoRow($pdf, 'Pengirim', $sender, $y);
infoRow($pdf, 'Dibuat Oleh', $creator, $y);

/* Kolom Kanan */
$x2 = 108;
$y2 = $boxY + 4;

$pdf->SetXY($x2, $y2);
$pdf->SetFont('Arial', 'B', 8);
$pdf->SetTextColor(80, 80, 80);
$pdf->Cell(30, 5, 'Kategori', 0, 0);
$pdf->SetFont('Arial', '', 8);
$pdf->SetTextColor(30, 30, 30);
$pdf->Cell(45, 5, $category, 0, 1);
$y2 += 5;

/* Prioritas */
$pdf->SetXY($x2, $y2);
$pdf->SetFont('Arial', 'B', 8);
$pdf->SetTextColor(80, 80, 80);
$pdf->Cell(30, 5, 'Prioritas', 0, 0);
$pdf->SetFont('Arial', 'B', 8);
$pdf->SetTextColor($pc[0], $pc[1], $pc[2]);
$pdf->Cell(45, 5, strtoupper($priorityText), 0, 1);
$y2 += 5;

/* Sifat Surat */
$pdf->SetXY($x2, $y2);
$pdf->SetFont('Arial', 'B', 8);
$pdf->SetTextColor(80, 80, 80);
$pdf->Cell(30, 5, 'Sifat Dokumen', 0, 0);
$pdf->SetFont('Arial', '', 8);
$pdf->SetTextColor(30, 30, 30);
$pdf->Cell(45, 5, $nature, 0, 1);
$y2 += 5;

/* Status */
$pdf->SetXY($x2, $y2);
$pdf->SetFont('Arial', 'B', 8);
$pdf->SetTextColor(80, 80, 80);
$pdf->Cell(30, 5, 'Status', 0, 0);

switch ($status) {
    case 'completed':
    case 'signed':
        $pdf->SetTextColor(22, 163, 74);
        break;
    case 'pending':
    case 'pending_signature':
        $pdf->SetTextColor(245, 158, 11);
        break;
    case 'rejected':
        $pdf->SetTextColor(220, 38, 38);
        break;
    default:
        $pdf->SetTextColor(15, 76, 117);
}

$pdf->SetFont('Arial', 'B', 8);
$pdf->Cell(50, 5, strtoupper($statusText), 0, 1);

/* Perihal */
$pdf->SetXY(15, $boxY + 32);
$pdf->SetFont('Arial', 'B', 8);
$pdf->SetTextColor(80, 80, 80);
$pdf->Cell(0, 4, 'PERIHAL DOKUMEN', 0, 1);

$pdf->SetX(15);
$pdf->SetFont('Arial', '', 8);
$pdf->SetTextColor(30, 30, 30);
$pdf->MultiCell(180, 4, $title);

/* ============================================================
 * KETERANGAN DOKUMEN
 * ============================================================
 */
$pdf->SetY($boxY + $boxH + 6);
$pdf->SetFont('Arial', 'B', 10);
$pdf->SetTextColor(15, 76, 117);
$pdf->Cell(0, 6, 'KETERANGAN', 0, 1);

$pdf->SetDrawColor(15, 76, 117);
$pdf->Line(10, $pdf->GetY(), 200, $pdf->GetY());
$pdf->Ln(3);

$descY = $pdf->GetY();
$pdf->SetFillColor(252, 252, 252);
$pdf->SetDrawColor(225, 225, 225);
$pdf->Rect(10, $descY, 190, 20, 'DF');

$pdf->SetXY(13, $descY + 3);
$pdf->SetFont('Arial', '', 8);
$pdf->SetTextColor(60, 60, 60);

$description = trim($document['description'] ?? '');
if ($description == '') {
    $description = 'Tidak terdapat deskripsi tambahan pada dokumen.';
}
$pdf->MultiCell(184, 4, $description);

$pdf->SetY($descY + 24);

/* ============================================================
 * RIWAYAT DISPOSISI
 * ============================================================
 */
$pdf->SetFont('Arial', 'B', 10);
$pdf->SetTextColor(15, 76, 117);
$pdf->Cell(0, 6, 'RIWAYAT DISPOSISI', 0, 1);

$pdf->SetDrawColor(15, 76, 117);
$pdf->Line(10, $pdf->GetY(), 200, $pdf->GetY());
$pdf->Ln(4);

$col = [
    'no'      => 8,
    'from'    => 38,
    'to'      => 38,
    'status'  => 28,
    'date'    => 32,
    'note'    => 46
];

$drawHeader = function() use ($pdf, $col) {
    $pdf->SetFillColor(15, 76, 117);
    $pdf->SetTextColor(255, 255, 255);
    $pdf->SetFont('Arial', 'B', 8);

    $pdf->Cell($col['no'], 7, 'No', 1, 0, 'C', true);
    $pdf->Cell($col['from'], 7, 'Dari', 1, 0, 'C', true);
    $pdf->Cell($col['to'], 7, 'Kepada', 1, 0, 'C', true);
    $pdf->Cell($col['status'], 7, 'Status', 1, 0, 'C', true);
    $pdf->Cell($col['date'], 7, 'Tanggal', 1, 0, 'C', true);
    $pdf->Cell($col['note'], 7, 'Catatan', 1, 1, 'C', true);
};

$drawHeader();

if (empty($dispositions)) {
    $pdf->SetFont('Arial', 'I', 8);
    $pdf->SetFillColor(250, 250, 250);
    $pdf->SetTextColor(120, 120, 120);
    $pdf->Cell(190, 10, 'Belum ada riwayat disposisi untuk dokumen ini.', 1, 1, 'C', true);
} else {
    foreach ($dispositions as $i => $disp) {
        $from = trim(value($disp['from_name']) . "\n" . value($disp['from_position']));
        $to   = trim(value($disp['to_name']) . "\n" . value($disp['to_position']));

        $dispStatus = strtolower($disp['status'] ?? 'pending');
        $statusText = $statusLabels[$dispStatus] ?? ucfirst($dispStatus);

        $note = trim($disp['notes'] ?? '');
        if ($note == '') $note = '-';

        $date = indoDate($disp['created_at']);

        $lineHeight = 4.5;
        $nbFrom = ceil($pdf->GetStringWidth(str_replace("\n", ' ', $from)) / ($col['from'] - 2));
        $nbTo   = ceil($pdf->GetStringWidth(str_replace("\n", ' ', $to)) / ($col['to'] - 2));
        $nbNote = ceil($pdf->GetStringWidth($note) / ($col['note'] - 2));
        
        $nbFrom = max($nbFrom, substr_count($from, "\n") + 1);
        $nbTo   = max($nbTo, substr_count($to, "\n") + 1);

        $maxLines  = max(1, $nbFrom, $nbTo, $nbNote);
        $rowHeight = max(10, $maxLines * $lineHeight + 2);

        if ($pdf->GetY() + $rowHeight > 260) {
            $pdf->AddPage();
            $pdf->SetFont('Arial', 'B', 10);
            $pdf->SetTextColor(15, 76, 117);
            $pdf->Cell(0, 6, 'RIWAYAT DISPOSISI (Lanjutan)', 0, 1);
            $pdf->Ln(2);
            $drawHeader();
        }

        $statusColor = [70, 70, 70];
        switch ($dispStatus) {
            case 'completed':
            case 'accepted':
                $statusColor = [34, 197, 94];
                break;
            case 'pending':
                $statusColor = [245, 158, 11];
                break;
            case 'forwarded':
                $statusColor = [37, 99, 235];
                break;
            case 'returned':
                $statusColor = [249, 115, 22];
                break;
            case 'rejected':
                $statusColor = [220, 38, 38];
                break;
        }

        $startX = $pdf->GetX();
        $startY = $pdf->GetY();
        $bgFill = ($i % 2 == 0) ? [255, 255, 255] : [248, 250, 252];

        $pdf->SetFillColor($bgFill[0], $bgFill[1], $bgFill[2]);
        $pdf->SetDrawColor(200, 200, 200);

        $xTmp = $startX;
        foreach ($col as $width) {
            $pdf->Rect($xTmp, $startY, $width, $rowHeight, 'DF');
            $xTmp += $width;
        }

        $pdf->SetTextColor(30, 30, 30);
        $pdf->SetFont('Arial', '', 7);

        // No
        $pdf->SetXY($startX, $startY);
        $pdf->Cell($col['no'], $rowHeight, $i + 1, 0, 0, 'C');

        // Dari
        $xCurr = $startX + $col['no'];
        $pdf->SetXY($xCurr + 1, $startY + 1.5);
        $pdf->MultiCell($col['from'] - 2, $lineHeight, $from, 0, 'L');

        // Kepada
        $xCurr += $col['from'];
        $pdf->SetXY($xCurr + 1, $startY + 1.5);
        $pdf->MultiCell($col['to'] - 2, $lineHeight, $to, 0, 'L');

        // Status
        $xCurr += $col['to'];
        $pdf->SetXY($xCurr, $startY);
        $pdf->SetTextColor($statusColor[0], $statusColor[1], $statusColor[2]);
        $pdf->SetFont('Arial', 'B', 7);
        $pdf->Cell($col['status'], $rowHeight, strtoupper($statusText), 0, 0, 'C');

        // Tanggal
        $xCurr += $col['status'];
        $pdf->SetXY($xCurr, $startY);
        $pdf->SetTextColor(60, 60, 60);
        $pdf->SetFont('Arial', '', 7);
        $pdf->Cell($col['date'], $rowHeight, $date, 0, 0, 'C');

        // Catatan
        $xCurr += $col['date'];
        $pdf->SetXY($xCurr + 1, $startY + 1.5);
        $pdf->SetTextColor(40, 40, 40);
        $pdf->MultiCell($col['note'] - 2, $lineHeight, $note, 0, 'L');

        $pdf->SetY($startY + $rowHeight);
    }
}

/* ============================================================
 * TANDA TANGAN PENGIRIM (Menggunakan Signature dari Tabel Users)
 * ============================================================
 */
if ($pdf->GetY() > 200) {
    $pdf->AddPage();
}

$pdf->Ln(6);
$pdf->SetFont('Arial', 'B', 10);
$pdf->SetTextColor(15, 76, 117);
$pdf->Cell(0, 6, 'TANDA TANGAN PENGIRIM', 0, 1);

$pdf->SetDrawColor(15, 76, 117);
$pdf->Line(10, $pdf->GetY(), 200, $pdf->GetY());
$pdf->Ln(6);

// Ambil Pengirim Unik (Dari kolom from_user_id)
$senders = [];
foreach ($dispositions as $d) {
    if (empty($d['from_user_id'])) continue;
    if (!isset($senders[$d['from_user_id']])) {
        $senders[$d['from_user_id']] = [
            'name'      => $d['from_name'],
            'position'  => $d['from_position'],
            'division'  => $d['from_division'],
            'signature' => $d['from_signature'] ?? ''
        ];
    }
}

if (!empty($senders)) {
    $boxWidth  = 42;
    $boxHeight = 42; // Sedikit diperbesar agar cukup untuk gambar tanda tangan
    $gap       = 6;
    $startX    = 10;
    $baseY     = $pdf->GetY();

    $i = 0;
    foreach ($senders as $senderData) {
        $col = $i % 4;
        $row = floor($i / 4);

        $x = $startX + ($boxWidth + $gap) * $col;
        $y = $baseY + ($row * ($boxHeight + 6));

        if ($y + $boxHeight > 265) {
            $pdf->AddPage();
            $baseY = $pdf->GetY();
            $y = $baseY;
        }

        $pdf->SetDrawColor(180, 180, 180);
        $pdf->Rect($x, $y, $boxWidth, $boxHeight);

        // Nama Pengirim
        $pdf->SetXY($x + 2, $y + 2);
        $pdf->SetFont('Arial', 'B', 7);
        $pdf->SetTextColor(40, 40, 40);
        $pdf->MultiCell($boxWidth - 4, 3, value($senderData['name']), 0, 'C');

        // Posisi / Jabatan
        $pdf->SetFont('Arial', '', 6);
        $pdf->SetTextColor(90, 90, 90);
        $pdf->MultiCell($boxWidth - 4, 2.5, value($senderData['position']), 0, 'C');

        // Render Tanda Tangan dari SIGNATURE_PATH jika file tersedia
        $sigFile = trim($senderData['signature'] ?? '');
        $sigPath = SIGNATURE_PATH . '/' . $sigFile;
        if (!empty($sigFile) && file_exists($sigPath)) {
            // Tampilkan gambar tanda tangan di tengah kotak
            $pdf->Image($sigPath, $x + 11, $y + 16, 20, 10);
        }

        // Garis Bawah Tanda Tangan
        $pdf->SetXY($x + 5, $y + 30);
        $pdf->SetDrawColor(150, 150, 150);
        $pdf->Line($x + 5, $y + 30, $x + $boxWidth - 5, $y + 30);

        // Label Keterangan di bawah garis
        $pdf->SetXY($x, $y + 31);
        $pdf->SetFont('Arial', '', 6);
        $pdf->Cell($boxWidth, 4, 'Tanda Tangan Pengirim', 0, 0, 'C');

        $i++;
    }

    $totalRows = ceil(count($senders) / 4);
    $pdf->SetY($baseY + ($totalRows * ($boxHeight + 6)));
} else {
    $pdf->SetFont('Arial', 'I', 8);
    $pdf->SetTextColor(120, 120, 120);
    $pdf->Cell(0, 6, 'Belum ada data pengirim disposisi.', 0, 1);
}

/* ============================================================
 * RINGKASAN
 * ============================================================
 */
if ($pdf->GetY() > 230) {
    $pdf->AddPage();
}

$pdf->Ln(4);
$pdf->SetFont('Arial', 'B', 10);
$pdf->SetTextColor(15, 76, 117);
$pdf->Cell(0, 6, 'RINGKASAN DOKUMEN', 0, 1);

$pdf->SetDrawColor(15, 76, 117);
$pdf->Line(10, $pdf->GetY(), 200, $pdf->GetY());
$pdf->Ln(4);

$summaryY = $pdf->GetY();
$pdf->SetFillColor(250, 250, 250);
$pdf->SetDrawColor(220, 220, 220);
$pdf->Rect(10, $summaryY, 190, 18, 'DF');

$pdf->SetXY(14, $summaryY + 3);
$pdf->SetFont('Arial', '', 8);
$pdf->SetTextColor(60, 60, 60);

$printedAt = formatDate(date('Y-m-d H:i:s'));
$pdf->MultiCell(
    182,
    4,
    "Dokumen ini dicetak dari " . APP_NAME . " pada " . $printedAt . ".\n" .
    "Total Riwayat Disposisi: " . count($dispositions) . " record | Status Terakhir Dokumen: " . strtoupper($statusText)
);

// Output PDF
$pdf->Output('I', 'Lembar_Disposisi_' . $documentId . '.pdf');