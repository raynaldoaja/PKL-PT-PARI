-- Database: sistem_pelacakan_paket

CREATE DATABASE IF NOT EXISTS sistem_pelacakan_paket;
USE sistem_pelacakan_paket;

-- Tabel paket
CREATE TABLE IF NOT EXISTS paket (
    id INT AUTO_INCREMENT PRIMARY KEY,
    nomor_resi VARCHAR(50) UNIQUE NOT NULL,
    nama_pengirim VARCHAR(100) NOT NULL,
    nama_penerima VARCHAR(100) NOT NULL,
    alamat_asal TEXT NOT NULL,
    alamat_tujuan TEXT NOT NULL,
    berat DECIMAL(10,2) NOT NULL,
    layanan ENUM('Regular', 'Express', 'Same Day') NOT NULL,
    status ENUM('Pending', 'Diproses', 'Dalam Perjalanan', 'Tiba di Kota Tujuan', 'Sedang Diantar', 'Terkirim') NOT NULL DEFAULT 'Pending',
    tanggal_kirim DATE NOT NULL,
    catatan TEXT,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
    INDEX idx_nomor_resi (nomor_resi),
    INDEX idx_status (status),
    INDEX idx_tanggal_kirim (tanggal_kirim)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- Tabel tracking history
CREATE TABLE IF NOT EXISTS tracking_history (
    id INT AUTO_INCREMENT PRIMARY KEY,
    paket_id INT NOT NULL,
    tanggal_waktu DATETIME NOT NULL,
    status_tracking VARCHAR(100) NOT NULL,
    lokasi VARCHAR(200) NOT NULL,
    keterangan TEXT,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    FOREIGN KEY (paket_id) REFERENCES paket(id) ON DELETE CASCADE,
    INDEX idx_paket_id (paket_id),
    INDEX idx_tanggal_waktu (tanggal_waktu)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- Insert data sample untuk paket
INSERT INTO paket (nomor_resi, nama_pengirim, nama_penerima, alamat_asal, alamat_tujuan, berat, layanan, status, tanggal_kirim, catatan) VALUES
('PKG123456789', 'John Doe', 'Jane Smith', 'Jl. Sudirman No. 123, Jakarta Pusat, DKI Jakarta', 'Jl. Ahmad Yani No. 456, Bandung, Jawa Barat', 2.50, 'Express', 'Sedang Diantar', '2024-12-01', 'Barang elektronik - hati-hati'),
('PKG987654321', 'Toko ABC', 'Budi Santoso', 'Jl. Gatot Subroto No. 789, Surabaya, Jawa Timur', 'Jl. Diponegoro No. 321, Yogyakarta, DIY', 1.20, 'Regular', 'Terkirim', '2024-11-28', 'Buku dan alat tulis'),
('PKG456789123', 'Siti Nurhaliza', 'Ahmad Wijaya', 'Jl. Merdeka No. 45, Medan, Sumatera Utara', 'Jl. Pahlawan No. 67, Palembang, Sumatera Selatan', 3.75, 'Express', 'Dalam Perjalanan', '2024-12-02', 'Pakaian dan aksesoris'),
('PKG789123456', 'CV Maju Jaya', 'Dewi Lestari', 'Jl. Raya Bogor No. 234, Depok, Jawa Barat', 'Jl. Veteran No. 89, Semarang, Jawa Tengah', 5.00, 'Regular', 'Diproses', '2024-12-03', 'Spare part mesin'),
('PKG321654987', 'Rina Wati', 'Hendra Gunawan', 'Jl. Kaliurang No. 12, Yogyakarta, DIY', 'Jl. Dieng No. 78, Malang, Jawa Timur', 1.80, 'Same Day', 'Tiba di Kota Tujuan', '2024-12-03', 'Dokumen penting - express');

-- Insert tracking history untuk PKG123456789
INSERT INTO tracking_history (paket_id, tanggal_waktu, status_tracking, lokasi, keterangan) VALUES
(1, '2024-12-01 08:00:00', 'Paket diterima di gudang', 'Jakarta Pusat', 'Paket telah diterima dan diverifikasi'),
(1, '2024-12-01 14:30:00', 'Paket dalam proses sorting', 'Jakarta Hub', 'Paket sedang disortir untuk pengiriman'),
(1, '2024-12-02 06:00:00', 'Paket dalam perjalanan', 'Menuju Bandung', 'Paket dalam perjalanan menggunakan armada express'),
(1, '2024-12-02 18:45:00', 'Paket tiba di kota tujuan', 'Bandung Hub', 'Paket telah sampai di hub Bandung'),
(1, '2024-12-03 09:15:00', 'Paket sedang diantar kurir', 'Bandung', 'Paket sedang dalam pengiriman oleh kurir ke alamat tujuan');

-- Insert tracking history untuk PKG987654321
INSERT INTO tracking_history (paket_id, tanggal_waktu, status_tracking, lokasi, keterangan) VALUES
(2, '2024-11-28 10:00:00', 'Paket diterima di gudang', 'Surabaya', 'Paket diterima dan siap diproses'),
(2, '2024-11-29 07:30:00', 'Paket dalam perjalanan', 'Menuju Yogyakarta', 'Paket dalam perjalanan ke Yogyakarta'),
(2, '2024-11-30 16:20:00', 'Paket tiba di kota tujuan', 'Yogyakarta Hub', 'Paket telah tiba di hub Yogyakarta'),
(2, '2024-12-01 11:45:00', 'Paket sedang diantar kurir', 'Yogyakarta', 'Kurir menuju lokasi pengiriman'),
(2, '2024-12-01 14:30:00', 'Paket berhasil diterima', 'Yogyakarta', 'Paket diterima oleh Budi Santoso - Tanda tangan digital tersimpan');

-- Insert tracking history untuk PKG456789123
INSERT INTO tracking_history (paket_id, tanggal_waktu, status_tracking, lokasi, keterangan) VALUES
(3, '2024-12-02 09:00:00', 'Paket diterima di gudang', 'Medan', 'Paket diterima untuk pengiriman express'),
(3, '2024-12-02 15:00:00', 'Paket dalam proses sorting', 'Medan Hub', 'Sedang diproses untuk pengiriman'),
(3, '2024-12-03 05:30:00', 'Paket dalam perjalanan', 'Menuju Palembang', 'Dalam perjalanan via jalur darat');

-- Insert tracking history untuk PKG789123456
INSERT INTO tracking_history (paket_id, tanggal_waktu, status_tracking, lokasi, keterangan) VALUES
(4, '2024-12-03 08:00:00', 'Paket diterima di gudang', 'Depok', 'Paket diterima dan menunggu proses'),
(4, '2024-12-03 10:30:00', 'Paket dalam proses verifikasi', 'Depok', 'Sedang dilakukan verifikasi berat dan dimensi');

-- Insert tracking history untuk PKG321654987
INSERT INTO tracking_history (paket_id, tanggal_waktu, status_tracking, lokasi, keterangan) VALUES
(5, '2024-12-03 07:00:00', 'Paket diterima di gudang', 'Yogyakarta', 'Paket same day service diterima'),
(5, '2024-12-03 08:30:00', 'Paket dalam perjalanan', 'Menuju Malang', 'Express delivery - same day'),
(5, '2024-12-03 14:45:00', 'Paket tiba di kota tujuan', 'Malang Hub', 'Paket tiba dan siap diantar');

-- View untuk melihat paket dengan tracking terbaru
CREATE OR REPLACE VIEW v_paket_tracking AS
SELECT 
    p.id,
    p.nomor_resi,
    p.nama_pengirim,
    p.nama_penerima,
    p.alamat_asal,
    p.alamat_tujuan,
    p.berat,
    p.layanan,
    p.status,
    p.tanggal_kirim,
    p.catatan,
    th.tanggal_waktu AS tracking_terakhir,
    th.status_tracking AS status_tracking_terakhir,
    th.lokasi AS lokasi_terakhir
FROM paket p
LEFT JOIN (
    SELECT paket_id, tanggal_waktu, status_tracking, lokasi
    FROM tracking_history th1
    WHERE tanggal_waktu = (
        SELECT MAX(tanggal_waktu) 
        FROM tracking_history th2 
        WHERE th2.paket_id = th1.paket_id
    )
) th ON p.id = th.paket_id
ORDER BY p.created_at DESC;

-- Stored Procedure untuk menambah paket baru
DELIMITER //

CREATE PROCEDURE sp_tambah_paket(
    IN p_nomor_resi VARCHAR(50),
    IN p_nama_pengirim VARCHAR(100),
    IN p_nama_penerima VARCHAR(100),
    IN p_alamat_asal TEXT,
    IN p_alamat_tujuan TEXT,
    IN p_berat DECIMAL(10, 2),
    IN p_layanan VARCHAR(50),
    IN p_status VARCHAR(50),
    IN p_tanggal_kirim DATE,
    IN p_catatan TEXT
)
BEGIN
    DECLARE v_paket_id INT;

    -- Insert paket baru
    INSERT INTO paket (
        nomor_resi, 
        nama_pengirim, 
        nama_penerima, 
        alamat_asal, 
        alamat_tujuan, 
        berat, 
        layanan, 
        status, 
        tanggal_kirim, 
        catatan
    ) VALUES (
        p_nomor_resi, 
        p_nama_pengirim, 
        p_nama_penerima, 
        p_alamat_asal, 
        p_alamat_tujuan, 
        p_berat, 
        p_layanan, 
        p_status, 
        p_tanggal_kirim, 
        p_catatan
    );
    
    -- Dapatkan ID paket yang baru ditambahkan
    SET v_paket_id = LAST_INSERT_ID();
    
    -- Tambahkan tracking history pertama
    INSERT INTO tracking_history (
        paket_id, 
        tanggal_waktu, 
        status_tracking, 
        lokasi, 
        keterangan
    ) VALUES (
        v_paket_id, 
        NOW(), 
        CONCAT('Status: ', p_status), 
        'Gudang Asal', 
        'Paket baru ditambahkan ke sistem'
    );
    
    -- Return paket_id
    SELECT 
        v_paket_id AS paket_id, 
        'Paket berhasil ditambahkan' AS message;
END //

DELIMITER ;

-- Stored Procedure untuk menambah tracking history
DELIMITER //

CREATE PROCEDURE sp_tambah_tracking(
    IN p_nomor_resi VARCHAR(50),
    IN p_status_tracking VARCHAR(100),
    IN p_lokasi VARCHAR(200),
    IN p_keterangan TEXT
)
BEGIN
    DECLARE v_paket_id INT;
    
    -- Cari paket_id berdasarkan nomor resi
    SELECT 
        id 
    INTO 
        v_paket_id 
    FROM 
        paket 
    WHERE 
        nomor_resi = p_nomor_resi;
    
    IF v_paket_id IS NOT NULL THEN
        -- Tambahkan tracking history
        INSERT INTO tracking_history (
            paket_id, 
            tanggal_waktu, 
            status_tracking, 
            lokasi, 
            keterangan
        ) VALUES (
            v_paket_id, 
            NOW(), 
            p_status_tracking, 
            p_lokasi, 
            p_keterangan
        );
        
        SELECT 
            'Tracking berhasil ditambahkan' AS message;
    ELSE
        SELECT 
            'Paket tidak ditemukan' AS message;
    END IF;
END //

DELIMITER ;

-- Function untuk mendapatkan total paket berdasarkan status
DELIMITER //

CREATE FUNCTION fn_count_paket_by_status(p_status VARCHAR(50))
RETURNS INT
DETERMINISTIC
BEGIN
    DECLARE v_count INT;
    SELECT 
        COUNT(*) 
    INTO 
        v_count 
    FROM 
        paket 
    WHERE 
        status = p_status;
    RETURN v_count;
END //

DELIMITER ;

-- Contoh Query untuk mengambil data paket dengan tracking lengkap
-- SELECT * FROM v_paket_tracking WHERE nomor_resi = 'PKG123456789';

-- Contoh Query untuk mendapatkan semua tracking history suatu paket
-- SELECT th.* FROM tracking_history th
-- JOIN paket p ON th.paket_id = p.id
-- WHERE p.nomor_resi = 'PKG123456789'
-- ORDER BY th.tanggal_waktu DESC;
