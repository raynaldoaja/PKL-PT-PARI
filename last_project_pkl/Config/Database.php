<?php
class Database {
    // Properti (Attributes)
    private $host = 'localhost';
    private $user = 'root';
    private $pass = '';
    private $db_name = 'paket'; // Ganti ke 'sistem_pelacakan_paket' jika perlu
    private $conn; 

    public function __construct() {
        $this->connect();
    }

    private function connect() {
        $this->conn = mysqli_connect($this->host, $this->user, $this->pass, $this->db_name);

        if (!$this->conn) {
            die("Koneksi database gagal: " . mysqli_connect_error());
        }
        mysqli_set_charset($this->conn, "utf8mb4");
    }

    // Method publik untuk mendapatkan objek koneksi
    public function getConnection() {
        return $this->conn;
    }
    
    // Method untuk membersihkan input (dipindahkan dari config.php)
    public function cleanInput($data) {
        // Menggunakan koneksi objek ($this->conn)
        return mysqli_real_escape_string($this->conn, trim(htmlspecialchars($data)));
    }

    // Tutup koneksi (dipanggil saat aplikasi selesai)
    public function closeConnection() {
        if ($this->conn) {
            mysqli_close($this->conn);
        }
    }
}

// Fungsi response JSON tetap bisa dijadikan fungsi global atau static helper,
// karena ini lebih ke utility daripada database.
function json_response($success, $message, $data = null) {
    header('Content-Type: application/json');
    echo json_encode([
        'success' => $success,
        'message' => $message,
        'data' => $data
    ]);
    exit;
}