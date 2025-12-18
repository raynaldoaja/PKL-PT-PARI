<?php
require_once 'config.php';

$paket_data = null;
$tracking_data = array();
$error_message = '';

// Proses pencarian jika ada input
if (isset($_GET['resi']) && !empty($_GET['resi'])) {
    $nomor_resi = clean_input($_GET['resi']);
    
    $query_paket = "SELECT * FROM paket WHERE nomor_resi = '$nomor_resi'";
    $result_paket = mysqli_query($conn, $query_paket);
    
    if (mysqli_num_rows($result_paket) > 0) {
        $paket_data = mysqli_fetch_assoc($result_paket);
        
        $query_tracking = "SELECT * FROM tracking_history WHERE paket_id = " . $paket_data['id'] . " ORDER BY tanggal_waktu DESC";
        $result_tracking = mysqli_query($conn, $query_tracking);
        
        while ($row = mysqli_fetch_assoc($result_tracking)) {
            $tracking_data[] = $row;
        }
    } else {
        $error_message = "Paket dengan nomor resi <strong>$nomor_resi</strong> tidak ditemukan!";
    }
}
?>
<!DOCTYPE html>
<html lang="id">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Lacak Paket - Sistem Pelacakan</title>
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
            max-width: 900px;
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

        .search-card {
            background: white;
            border-radius: 20px;
            padding: 40px;
            box-shadow: 0 10px 30px rgba(0,0,0,0.2);
            margin-bottom: 30px;
        }

        .search-box {
            display: flex;
            gap: 10px;
        }

        .search-input {
            flex: 1;
            padding: 15px 20px;
            border: 2px solid #e0e0e0;
            border-radius: 50px;
            font-size: 1em;
            transition: all 0.3s ease;
        }

        .search-input:focus {
            outline: none;
            border-color: #667eea;
            box-shadow: 0 0 0 3px rgba(102, 126, 234, 0.1);
        }

        .search-btn {
            padding: 15px 40px;
            background: linear-gradient(135deg, #667eea 0%, #764ba2 100%);
            color: white;
            border: none;
            border-radius: 50px;
            font-weight: bold;
            cursor: pointer;
            transition: all 0.3s ease;
            font-size: 1em;
        }

        .search-btn:hover {
            transform: scale(1.05);
            box-shadow: 0 5px 15px rgba(102, 126, 234, 0.4);
        }

        .result-card {
            background: white;
            border-radius: 20px;
            padding: 40px;
            box-shadow: 0 10px 30px rgba(0,0,0,0.2);
            animation: slideIn 0.5s ease;
        }

        @keyframes slideIn {
            from {
                opacity: 0;
                transform: translateY(20px);
            }
            to {
                opacity: 1;
                transform: translateY(0);
            }
        }

        .result-header {
            display: flex;
            justify-content: space-between;
            align-items: center;
            margin-bottom: 30px;
            padding-bottom: 20px;
            border-bottom: 2px solid #f0f0f0;
        }

        .result-header h2 {
            color: #333;
            font-size: 1.8em;
        }

        .status-badge {
            padding: 10px 20px;
            border-radius: 20px;
            font-weight: bold;
            font-size: 0.9em;
        }

        .status-Pending { background: #fff3cd; color: #856404; }
        .status-Diproses { background: #cce5ff; color: #004085; }
        .status-Dalam.Perjalanan { background: #d1ecf1; color: #0c5460; }
        .status-Tiba.di.Kota.Tujuan { background: #d4edda; color: #155724; }
        .status-Sedang.Diantar { background: #d1ecf1; color: #0c5460; }
        .status-Terkirim { background: #d4edda; color: #155724; }

        .info-grid {
            display: grid;
            grid-template-columns: repeat(auto-fit, minmax(250px, 1fr));
            gap: 20px;
            margin-bottom: 30px;
        }

        .info-item {
            padding: 20px;
            background: #f8f9fa;
            border-radius: 10px;
            border-left: 4px solid #667eea;
        }

        .info-label {
            font-size: 0.9em;
            color: #666;
            margin-bottom: 5px;
        }

        .info-value {
            font-size: 1.1em;
            color: #333;
            font-weight: 600;
        }

        .timeline {
            margin-top: 30px;
        }

        .timeline h3 {
            color: #333;
            margin-bottom: 20px;
            font-size: 1.5em;
        }

        .timeline-item {
            position: relative;
            padding-left: 40px;
            padding-bottom: 30px;
            border-left: 3px solid #e0e0e0;
        }

        .timeline-item:last-child {
            border-left-color: transparent;
        }

        .timeline-item::before {
            content: '';
            position: absolute;
            left: -8px;
            top: 0;
            width: 14px;
            height: 14px;
            border-radius: 50%;
            background: #667eea;
            border: 3px solid white;
            box-shadow: 0 0 0 2px #667eea;
        }

        .timeline-item:first-child::before {
            background: #28a745;
            box-shadow: 0 0 0 2px #28a745;
            animation: pulse 2s infinite;
        }

        @keyframes pulse {
            0%, 100% { box-shadow: 0 0 0 2px #28a745; }
            50% { box-shadow: 0 0 0 6px rgba(40, 167, 69, 0.3); }
        }

        .timeline-content {
            background: #f8f9fa;
            padding: 15px;
            border-radius: 10px;
        }

        .timeline-time {
            font-size: 0.9em;
            color: #666;
            margin-bottom: 5px;
        }

        .timeline-text {
            color: #333;
            font-weight: 600;
        }

        .timeline-location {
            font-size: 0.9em;
            color: #667eea;
            margin-top: 5px;
        }

        .no-result {
            background: #fff3cd;
            color: #856404;
            padding: 20px;
            border-radius: 10px;
            text-align: center;
            margin-top: 20px;
        }

        @media (max-width: 768px) {
            .header h1 {
                font-size: 2em;
            }
            
            .search-box {
                flex-direction: column;
            }
            
            .search-btn {
                width: 100%;
            }
            
            .result-header {
                flex-direction: column;
                gap: 15px;
                text-align: center;
            }
        }
    </style>
</head>
<body>
    <div class="container">
        <a href="homepage.php" class="back-btn">← Kembali ke Beranda</a>
        
        <div class="header">
            <h1>🔍 Lacak Paket</h1>
            <p>Masukkan nomor resi untuk melacak paket Anda</p>
        </div>

        <div class="search-card">
            <form method="GET" action="" class="search-box">
                <input type="text" name="resi" class="search-input" placeholder="Masukkan nomor resi (contoh: PKG123456789)" value="<?php echo isset($_GET['resi']) ? htmlspecialchars($_GET['resi']) : ''; ?>" required>
                <button type="submit" class="search-btn">Lacak</button>
            </form>
        </div>

        <?php if ($error_message): ?>
            <div class="no-result">
                <?php echo $error_message; ?><br>
                Pastikan nomor resi yang Anda masukkan benar.
            </div>
        <?php endif; ?>

        <?php if ($paket_data): ?>
        <div class="result-card">
            <div class="result-header">
                <h2><?php echo htmlspecialchars($paket_data['nomor_resi']); ?></h2>
                <span class="status-badge status-<?php echo str_replace(' ', '.', $paket_data['status']); ?>">
                    <?php echo htmlspecialchars($paket_data['status']); ?>
                </span>
            </div>

            <div class="info-grid">
                <div class="info-item">
                    <div class="info-label">Pengirim</div>
                    <div class="info-value"><?php echo htmlspecialchars($paket_data['nama_pengirim']); ?></div>
                </div>
                <div class="info-item">
                    <div class="info-label">Penerima</div>
                    <div class="info-value"><?php echo htmlspecialchars($paket_data['nama_penerima']); ?></div>
                </div>
                <div class="info-item">
                    <div class="info-label">Layanan</div>
                    <div class="info-value"><?php echo htmlspecialchars($paket_data['layanan']); ?></div>
                </div>
                <div class="info-item">
                    <div class="info-label">Berat</div>
                    <div class="info-value"><?php echo htmlspecialchars($paket_data['berat']); ?> kg</div>
                </div>
            </div>

            <div class="info-item">
                <div class="info-label">Alamat Asal</div>
                <div class="info-value"><?php echo htmlspecialchars($paket_data['alamat_asal']); ?></div>
            </div>

            <div class="info-item" style="margin-top: 15px;">
                <div class="info-label">Alamat Tujuan</div>
                <div class="info-value"><?php echo htmlspecialchars($paket_data['alamat_tujuan']); ?></div>
            </div>

            <?php if ($paket_data['catatan']): ?>
            <div class="info-item" style="margin-top: 15px;">
                <div class="info-label">Catatan</div>
                <div class="info-value"><?php echo htmlspecialchars($paket_data['catatan']); ?></div>
            </div>
            <?php endif; ?>

            <div class="timeline">
                <h3>📍 Riwayat Pelacakan</h3>
                <?php if (count($tracking_data) > 0): ?>
                    <?php foreach ($tracking_data as $tracking): ?>
                    <div class="timeline-item">
                        <div class="timeline-content">
                            <div class="timeline-time">
                                <?php echo date('d M Y, H:i', strtotime($tracking['tanggal_waktu'])); ?>
                            </div>
                            <div class="timeline-text"><?php echo htmlspecialchars($tracking['status_tracking']); ?></div>
                            <div class="timeline-location">📍 <?php echo htmlspecialchars($tracking['lokasi']); ?></div>
                            <?php if ($tracking['keterangan']): ?>
                            <div style="font-size: 0.85em; color: #888; margin-top: 5px;">
                                <?php echo htmlspecialchars($tracking['keterangan']); ?>
                            </div>
                            <?php endif; ?>
                        </div>
                    </div>
                    <?php endforeach; ?>
                <?php else: ?>
                    <p style="color: #666;">Belum ada riwayat pelacakan.</p>
                <?php endif; ?>
            </div>
        </div>
        <?php endif; ?>
    </div>

    <script>
        document.querySelector('.search-input').addEventListener('input', function() {
            this.value = this.value.toUpperCase();
        });
    </script>
</body>
</html>
<?php mysqli_close($conn); ?>