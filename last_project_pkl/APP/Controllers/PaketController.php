<?php
class PaketController {
    private $paketModel;

    public function __construct(Paket $paketModel) {
        $this->paketModel = $paketModel;
    }

    // Method untuk menampilkan/memproses form tambah.php
    public function handleTambah() {
        $success_message = '';
        $error_message = '';
        $post_data = [];

        if ($_SERVER['REQUEST_METHOD'] == 'POST') {
            $post_data = $_POST;
            try {
                // 1. Cek keunikan di Model
                if (!$this->paketModel->isResiUnique($post_data['nomorResi'])) {
                    throw new Exception("Nomor resi sudah digunakan! Gunakan nomor resi yang berbeda.");
                }
                // 2. Simpan data di Model
                $this->paketModel->tambahPaket($post_data);
                $success_message = "Paket dengan nomor resi " . htmlspecialchars($post_data['nomorResi']) . " berhasil ditambahkan!";
                
            } catch (Exception $e) {
                $error_message = $e->getMessage();
            }
        }

        // Siapkan data untuk View (termasuk pesan sukses/gagal)
        $data = [
            'success_message' => $success_message,
            'error_message' => $error_message,
            'input' => $post_data // Kirim balik input jika terjadi error
        ];

        require_once 'app/Views/tambah.view.php'; // Muat View
    }

    // Method untuk menampilkan/memproses lacak.php
    public function showLacak() {
        $paket_data = null;
        $tracking_data = [];
        $error_message = '';

        if (isset($_GET['resi']) && !empty($_GET['resi'])) {
            $nomor_resi = $_GET['resi']; 
            
            // Panggil Model untuk mendapatkan data
            $result = $this->paketModel->trackByResi($nomor_resi);
            
            $paket_data = $result['paket'];
            $tracking_data = $result['tracking'];

            if (!$paket_data) {
                $error_message = "Paket dengan nomor resi <strong>" . htmlspecialchars($nomor_resi) . "</strong> tidak ditemukan!";
            }
        }
        
        // Siapkan data untuk View
        $data = [
            'paket_data' => $paket_data,
            'tracking_data' => $tracking_data,
            'error_message' => $error_message,
            'input_resi' => isset($_GET['resi']) ? htmlspecialchars($_GET['resi']) : ''
        ];
        
        require_once 'app/Views/lacak.view.php'; // Muat View
    }
}