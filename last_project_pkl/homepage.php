<?php
require_once 'config.php';

// Query untuk mendapatkan statistik
$query_total = "SELECT COUNT(*) as total FROM paket";
$result_total = mysqli_query($conn, $query_total);
$total_paket = mysqli_fetch_assoc($result_total)['total'];

$query_terkirim = "SELECT COUNT(*) as total FROM paket WHERE status = 'Terkirim'";
$result_terkirim = mysqli_query($conn, $query_terkirim);
$total_terkirim = mysqli_fetch_assoc($result_terkirim)['total'];

$query_proses = "SELECT COUNT(*) as total FROM paket WHERE status IN ('Diproses', 'Dalam Perjalanan', 'Sedang Diantar')";
$result_proses = mysqli_query($conn, $query_proses);
$total_proses = mysqli_fetch_assoc($result_proses)['total'];
?>
<!DOCTYPE html>
<html lang="id">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Sistem Pelacakan Paket</title>
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
            max-width: 1200px;
            margin: 0 auto;
        }

        header {
            text-align: center;
            color: white;
            padding: 40px 0;
        }

        header h1 {
            font-size: 3em;
            margin-bottom: 10px;
            text-shadow: 2px 2px 4px rgba(0,0,0,0.3);
        }

        header p {
            font-size: 1.2em;
            opacity: 0.9;
        }

        .stats-container {
            display: grid;
            grid-template-columns: repeat(auto-fit, minmax(200px, 1fr));
            gap: 20px;
            margin-bottom: 30px;
        }

        .stat-card {
            background: rgba(255, 255, 255, 0.95);
            border-radius: 15px;
            padding: 25px;
            text-align: center;
            box-shadow: 0 5px 15px rgba(0,0,0,0.2);
            transition: transform 0.3s ease;
        }

        .stat-card:hover {
            transform: translateY(-5px);
        }

        .stat-number {
            font-size: 2.5em;
            font-weight: bold;
            color: #667eea;
            margin-bottom: 5px;
        }

        .stat-label {
            color: #666;
            font-size: 1em;
        }

        .card-container {
            display: grid;
            grid-template-columns: repeat(auto-fit, minmax(300px, 1fr));
            gap: 30px;
            margin-top: 50px;
        }

        .card {
            background: white;
            border-radius: 20px;
            padding: 40px;
            box-shadow: 0 10px 30px rgba(0,0,0,0.2);
            transition: transform 0.3s ease, box-shadow 0.3s ease;
            text-align: center;
        }

        .card:hover {
            transform: translateY(-10px);
            box-shadow: 0 15px 40px rgba(0,0,0,0.3);
        }

        .card-icon {
            font-size: 4em;
            margin-bottom: 20px;
        }

        .card h2 {
            color: #333;
            margin-bottom: 15px;
            font-size: 1.8em;
        }

        .card p {
            color: #666;
            margin-bottom: 25px;
            line-height: 1.6;
        }

        .btn {
            display: inline-block;
            padding: 15px 40px;
            background: linear-gradient(135deg, #667eea 0%, #764ba2 100%);
            color: white;
            text-decoration: none;
            border-radius: 50px;
            font-weight: bold;
            transition: all 0.3s ease;
            border: none;
            cursor: pointer;
            font-size: 1em;
        }

        .btn:hover {
            transform: scale(1.05);
            box-shadow: 0 5px 15px rgba(102, 126, 234, 0.4);
        }

        .features {
            background: white;
            border-radius: 20px;
            padding: 40px;
            margin-top: 50px;
            box-shadow: 0 10px 30px rgba(0,0,0,0.2);
        }

        .features h2 {
            text-align: center;
            color: #333;
            margin-bottom: 30px;
            font-size: 2em;
        }

        .feature-list {
            display: grid;
            grid-template-columns: repeat(auto-fit, minmax(250px, 1fr));
            gap: 20px;
        }

        .feature-item {
            padding: 20px;
            background: #f8f9fa;
            border-radius: 10px;
            border-left: 4px solid #667eea;
        }

        .feature-item h3 {
            color: #667eea;
            margin-bottom: 10px;
        }

        .feature-item p {
            color: #666;
            line-height: 1.6;
        }

        @media (max-width: 768px) {
            header h1 {
                font-size: 2em;
            }
            
            .card-container {
                grid-template-columns: 1fr;
            }
        }
    </style>
</head>
<body>
    <div class="container">
        <header>
            <h1>📦 Sistem Pelacakan Paket</h1>
            <p>Lacak paket Anda dengan mudah dan cepat</p>
        </header>

        <div class="stats-container">
            <div class="stat-card">
                <div class="stat-number"><?php echo $total_paket; ?></div>
                <div class="stat-label">Total Paket</div>
            </div>
            <div class="stat-card">
                <div class="stat-number"><?php echo $total_proses; ?></div>
                <div class="stat-label">Dalam Proses</div>
            </div>
            <div class="stat-card">
                <div class="stat-number"><?php echo $total_terkirim; ?></div>
                <div class="stat-label">Terkirim</div>
            </div>
        </div>

        <div class="card-container">
            <div class="card">
                <div class="card-icon">➕</div>
                <h2>Tambah Paket</h2>
                <p>Daftarkan paket baru dengan detail lengkap untuk mulai pelacakan</p>
                <a href="tambah.php" class="btn">Tambah Paket Baru</a>
            </div>

            <div class="card">
                <div class="card-icon">🔍</div>
                <h2>Lacak Paket</h2>
                <p>Cari dan lacak status paket Anda menggunakan nomor resi</p>
                <a href="lacak.php" class="btn">Lacak Sekarang</a>
            </div>
        </div>

        <div class="features">
            <h2>Fitur Unggulan</h2>
            <div class="feature-list">
                <div class="feature-item">
                    <h3>🚀 Real-time Tracking</h3>
                    <p>Pantau perjalanan paket Anda secara real-time dengan update status terkini</p>
                </div>
                <div class="feature-item">
                    <h3>📱 Responsif</h3>
                    <p>Akses dari perangkat apapun - desktop, tablet, atau smartphone</p>
                </div>
                <div class="feature-item">
                    <h3>🔒 Aman</h3>
                    <p>Data paket Anda tersimpan dengan aman dan terenkripsi</p>
                </div>
                <div class="feature-item">
                    <h3>⚡ Cepat</h3>
                    <p>Interface yang cepat dan mudah digunakan untuk pengalaman terbaik</p>
                </div>
            </div>
        </div>
    </div>
</body>
</html>
<?php mysqli_close($conn); ?>