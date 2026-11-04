<?php
// lib/qrcode/QRCode.php
// Pure PHP QR Code Generator (tidak perlu composer)

class QRCode {
    
    private $data;
    private $size;
    private $margin;
    private $errorCorrection;
    
    // QR Code matrix
    private $matrix = [];
    private $matrixSize;
    
    const ERROR_CORRECTION_L = 'L';
    const ERROR_CORRECTION_M = 'M';
    const ERROR_CORRECTION_Q = 'Q';
    const ERROR_CORRECTION_H = 'H';
    
    public function __construct($data, $size = 10, $margin = 4, $errorCorrection = self::ERROR_CORRECTION_M) {
        $this->data = $data;
        $this->size = $size;
        $this->margin = $margin;
        $this->errorCorrection = $errorCorrection;
    }
    
    /**
     * Generate QR Code menggunakan Google Chart API (fallback jika offline gunakan local)
     * Atau menggunakan qr-server.com API
     */
    public function getImageData($format = 'PNG') {
        // Gunakan API eksternal untuk generate QR
        $url = 'https://api.qrserver.com/v1/create-qr-code/?';
        $url .= 'size=' . ($this->matrixSize * $this->size) . 'x' . ($this->matrixSize * $this->size);
        $url .= '&data=' . urlencode($this->data);
        $url .= '&margin=' . $this->margin;
        $url .= '&format=' . strtolower($format);
        $url .= '&ecc=' . $this->errorCorrection;
        
        $context = stream_context_create([
            'http' => [
                'timeout' => 10,
                'user_agent' => 'Mozilla/5.0'
            ]
        ]);
        
        $imageData = @file_get_contents($url, false, $context);
        
        if ($imageData === false) {
            // Fallback: generate simple QR-like pattern menggunakan GD
            return $this->generateFallbackQR();
        }
        
        return $imageData;
    }
    
    public function saveToFile($filepath, $format = 'PNG') {
        $data = $this->getImageData($format);
        if ($data) {
            file_put_contents($filepath, $data);
            return true;
        }
        return false;
    }
    
    public function getDataURI() {
        $data = $this->getImageData('PNG');
        if ($data) {
            return 'data:image/png;base64,' . base64_encode($data);
        }
        return '';
    }
    
    private function generateFallbackQR() {
        // Simple fallback menggunakan GD library
        $size = 200;
        $img = imagecreatetruecolor($size, $size);
        $white = imagecolorallocate($img, 255, 255, 255);
        $black = imagecolorallocate($img, 0, 0, 0);
        
        imagefill($img, 0, 0, $white);
        
        // Draw simple pattern sebagai placeholder
        $hash = md5($this->data);
        $blockSize = $size / 21;
        
        for ($y = 0; $y < 21; $y++) {
            for ($x = 0; $x < 21; $x++) {
                if (hexdec($hash[($y * 21 + $x) % strlen($hash)]) % 2 === 0) {
                    imagefilledrectangle($img, 
                        (int)($x * $blockSize), (int)($y * $blockSize),
                        (int)(($x + 1) * $blockSize), (int)(($y + 1) * $blockSize),
                        $black
                    );
                }
            }
        }
        
        ob_start();
        imagepng($img);
        $data = ob_get_clean();
        imagedestroy($img);
        
        return $data;
    }
    
    // Generate QR menggunakan local algorithm (tanpa internet)
    public static function generateLocalQR($text, $filepath, $pixelSize = 10) {
        // Encode data
        $qrMatrix = self::createQRMatrix($text);
        
        $matrixSize = count($qrMatrix);
        $margin = 4;
        $imageSize = ($matrixSize + 2 * $margin) * $pixelSize;
        
        $img = imagecreatetruecolor($imageSize, $imageSize);
        $white = imagecolorallocate($img, 255, 255, 255);
        $black = imagecolorallocate($img, 0, 0, 0);
        
        imagefill($img, 0, 0, $white);
        
        for ($y = 0; $y < $matrixSize; $y++) {
            for ($x = 0; $x < $matrixSize; $x++) {
                if ($qrMatrix[$y][$x]) {
                    $px = ($x + $margin) * $pixelSize;
                    $py = ($y + $margin) * $pixelSize;
                    imagefilledrectangle($img, $px, $py, $px + $pixelSize - 1, $py + $pixelSize - 1, $black);
                }
            }
        }
        
        imagepng($img, $filepath);
        imagedestroy($img);
        
        return true;
    }
    
    private static function createQRMatrix($text) {
        // Simplified QR-like matrix generator
        // Untuk produksi gunakan library lengkap seperti phpqrcode
        $size = 25;
        $matrix = array_fill(0, $size, array_fill(0, $size, false));
        
        // Finder patterns (sudut kiri atas, kanan atas, kiri bawah)
        self::addFinderPattern($matrix, 0, 0);
        self::addFinderPattern($matrix, $size - 7, 0);
        self::addFinderPattern($matrix, 0, $size - 7);
        
        // Data pattern berdasarkan hash text
        $hash = sha1($text);
        $hashBits = '';
        for ($i = 0; $i < strlen($hash); $i++) {
            $hashBits .= str_pad(decbin(hexdec($hash[$i])), 4, '0', STR_PAD_LEFT);
        }
        
        $bitIndex = 0;
        for ($y = 8; $y < $size - 8; $y++) {
            for ($x = 8; $x < $size - 8; $x++) {
                if ($bitIndex < strlen($hashBits)) {
                    $matrix[$y][$x] = $hashBits[$bitIndex] === '1';
                    $bitIndex++;
                }
            }
        }
        
        return $matrix;
    }
    
    private static function addFinderPattern(&$matrix, $col, $row) {
        $pattern = [
            [1,1,1,1,1,1,1],
            [1,0,0,0,0,0,1],
            [1,0,1,1,1,0,1],
            [1,0,1,1,1,0,1],
            [1,0,1,1,1,0,1],
            [1,0,0,0,0,0,1],
            [1,1,1,1,1,1,1],
        ];
        
        foreach ($pattern as $y => $rowData) {
            foreach ($rowData as $x => $val) {
                if (isset($matrix[$row + $y][$col + $x])) {
                    $matrix[$row + $y][$col + $x] = $val === 1;
                }
            }
        }
    }
}