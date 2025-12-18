<?php
require_once 'config.php';

$success_message = '';
$error_message = '';

// Proses form ketika disubmit
if ($_SERVER['REQUEST_METHOD'] == 'POST') {
    $nomor_resi = clean_input($_POST['nomorResi']);
    $nama_pengirim = clean_input($_POST['namaPengirim']);
    $nama_penerima = clean_input($_POST['namaPenerima']);
    $alamat_asal = clean_input($_POST['alamatAsal']);
    $alamat_tujuan = clean_input($_POST['alamatTujuan']);
    $berat = clean_input($_POST['berat']);
    $layanan = clean_input($_POST['layanan']);
    $status = clean_input($_POST['status']);
    $tanggal = clean_input($_POST['tanggal']);
    $catatan = clean_input($_POST['catatan']);

    // Validasi nomor resi unik
    $check_resi = "SELECT id FROM paket WHERE nomor_resi = '$nomor_resi'";
    $result_check = mysqli_query($conn, $check_resi);
    
    if (mysqli_num_rows($result_check) > 0) {
        $error_message = "Nomor resi sudah digunakan! Gunakan nomor resi yang berbeda.";
    } else {
        $query = "CALL sp_tambah_paket('$nomor_resi', '$nama_pengirim', '$nama_penerima', '$alamat_asal', '$alamat_tujuan', $berat, '$layanan', '$status', '$tanggal', '$catatan')";
        
        if (mysqli_query($conn, $query)) {
            $success_message = "Paket dengan nomor resi $nomor_resi berhasil ditambahkan!";
            mysqli_next_result($conn);
        } else {
            $error_message = "Gagal menambahkan paket: " . mysqli_error($conn);
        }
    }
}
?>
<!DOCTYPE html>
<html lang="id">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Tambah Paket - Sistem Pelacakan</title>
    <style>
        * {
            margin: 0;
            padding: 0;
            box-sizing: border-box;
        }

        body {
            font-family: 'Segoe UI', Tahoma, Geneva, Verdana, sans-serif;
            background: linear-gradient(135deg, #667eea 0%, #764ba2 100%);
            min-height: 100vh;
            padding: 20px;
        }

        .container {
            max-width: 800px;
            margin: 0 auto;
        }

        .header {
            text-align: center;
            color: white;
            padding: 30px 0;
        }

        .header h1 {
            font-size: 2.5em;
            margin-bottom: 10px;
            text-shadow: 2px 2px 4px rgba(0,0,0,0.3);
        }

        .back-btn {
            display: inline-block;
            color: white;
            text-decoration: none;
            margin-bottom: 20px;
            padding: 10px 20px;
            background: rgba(255,255,255,0.2);
            border-radius: 20px;
            transition: all 0.3s ease;
        }

        .back-btn:hover {
            background: rgba(255,255,255,0.3);
            transform: translateX(-5px);
        }

        .form-card {
            background: white;
            border-radius: 20px;
            padding: 40px;
            box-shadow: 0 10px 30px rgba(0,0,0,0.2);
        }

        .form-group {
            margin-bottom: 25px;
        }

        .form-group label {
            display: block;
            margin-bottom: 8px;
            color: #333;
            font-weight: 600;
            font-size: 1em;
        }

        .form-group input,
        .form-group select,
        .form-group textarea {
            width: 100%;
            padding: 12px 15px;
            border: 2px solid #e0e0e0;
            border-radius: 10px;
            font-size: 1em;
            transition: all 0.3s ease;
            font-family: inherit;
        }

        .form-group input:focus,
        .form-group select:focus,
        .form-group textarea:focus {
            outline: none;
            border-color: #667eea;
            box-shadow: 0 0 0 3px rgba(102, 126, 234, 0.1);
        }

        .form-group textarea {
            resize: vertical;
            min-height: 100px;
        }

        .form-row {
            display: grid;
            grid-template-columns: 1fr 1fr;
            gap: 20px;
        }

        .submit-btn {
            width: 100%;
            padding: 15px;
            background: linear-gradient(135deg, #667eea 0%, #764ba2 100%);
            color: white;
            border: none;
            border-radius: 10px;
            font-size: 1.1em;
            font-weight: bold;
            cursor: pointer;
            transition: all 0.3s ease;
            margin-top: 10px;
        }

        .submit-btn:hover {
            transform: translateY(-2px);
            box-shadow: 0 5px 15px rgba(102, 126, 234, 0.4);
        }

        .submit-btn:active {
            transform: translateY(0);
        }

        .success-message,
        .error-message {
            padding: 15px;
            border-radius: 10px;
            margin-bottom: 20px;
        }

        .success-message {
            background: #d4edda;
            color: #155724;
            border: 1px solid #c3e6cb;
        }

        .error-message {
            background: #f8d7da;
            color: #721c24;
            border: 1px solid #f5c6cb;
        }

        .required {
            color: #e74c3c;
        }

        @media (max-width: 768px) {
            .form-row {
                grid-template-columns: 1fr;
            }
            
            .header h1 {
                font-size: 2em;
            }
        }
    </style>
</head>
<body>
    <div class="container">
        <a href="homepage.php" class="back-btn">← Kembali ke Beranda</a>
        
        <div class="header">
            <h1>📦 Tambah Paket Baru</h1>
            <p>Lengkapi detail paket untuk memulai pelacakan</p>
        </div>

        <div class="form-card">
            <?php if ($success_message): ?>
                <div class="success-message"><?php echo $success_message; ?></div>
            <?php endif; ?>
            
            <?php if ($error_message): ?>
                <div class="error-message"><?php echo $error_message; ?></div>
            <?php endif; ?>

            <form method="POST" action="">
                <div class="form-group">
                    <label for="nomorResi">Nomor Resi <span class="required">*</span></label>
                    <input type="text" id="nomorResi" name="nomorResi" required placeholder="Contoh: PKG123456789">
                </div>

                <div class="form-row">
                    <div class="form-group">
                        <label for="namaPengirim">Nama Pengirim <span class="required">*</span></label>
                        <input type="text" id="namaPengirim" name="namaPengirim" required placeholder="Nama lengkap pengirim">
                    </div>

                    <div class="form-group">
                        <label for="namaPenerima">Nama Penerima <span class="required">*</span></label>
                        <input type="text" id="namaPenerima" name="namaPenerima" required placeholder="Nama lengkap penerima">
                    </div>
                </div>

                <div class="form-group">
                    <label for="alamatAsal">Alamat Asal <span class="required">*</span></label>
                    <textarea id="alamatAsal" name="alamatAsal" required placeholder="Alamat lengkap pengirim"></textarea>
                </div>

                <div class="form-group">
                    <label for="alamatTujuan">Alamat Tujuan <span class="required">*</span></label>
                    <textarea id="alamatTujuan" name="alamatTujuan" required placeholder="Alamat lengkap penerima"></textarea>
                </div>

                <div class="form-row">
                    <div class="form-group">
                        <label for="berat">Berat (kg) <span class="required">*</span></label>
                        <input type="number" id="berat" name="berat" step="0.1" required placeholder="0.0">
                    </div>

                    <div class="form-group">
                        <label for="layanan">Layanan <span class="required">*</span></label>
                        <select id="layanan" name="layanan" required>
                            <option value="">Pilih Layanan</option>
                            <option value="Regular">Regular (3-4 hari)</option>
                            <option value="Express">Express (1-2 hari)</option>
                            <option value="Same Day">Same Day</option>
                        </select>
                    </div>
                </div>

                <div class="form-row">
                    <div class="form-group">
                        <label for="status">Status <span class="required">*</span></label>
                        <select id="status" name="status" required>
                            <option value="">Pilih Status</option>
                            <option value="Pending">Pending</option>
                            <option value="Diproses">Diproses</option>
                            <option value="Dalam Perjalanan">Dalam Perjalanan</option>
                            <option value="Tiba di Kota Tujuan">Tiba di Kota Tujuan</option>
                            <option value="Sedang Diantar">Sedang Diantar</option>
                            <option value="Terkirim">Terkirim</option>
                        </select>
                    </div>

                    <div class="form-group">
                        <label for="tanggal">Tanggal Kirim <span class="required">*</span></label>
                        <input type="date" id="tanggal" name="tanggal" required value="<?php echo date('Y-m-d'); ?>">
                    </div>
                </div>

                <div class="form-group">
                    <label for="catatan">Catatan</label>
                    <textarea id="catatan" name="catatan" placeholder="Catatan tambahan (opsional)"></textarea>
                </div>

                <button type="submit" class="submit-btn">Simpan Paket</button>
            </form>
        </div>
    </div>

    <script>
        // Validasi real-time
        document.getElementById('berat').addEventListener('input', function() {
            if (this.value < 0) {
                this.value = 0;
            }
        });

        document.getElementById('nomorResi').addEventListener('input', function() {
            this.value = this.value.toUpperCase();
        });
    </script>
</body>
</html>
<?php mysqli_close($conn); ?>