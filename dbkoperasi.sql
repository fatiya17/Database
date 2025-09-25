-- SOAL 3.1
-- 1. Produk asset > 20jt
SELECT * FROM produk WHERE harga_beli * stok > 20000000;

-- 2. Data produk + selisih stok
SELECT id, nama, stok, min_stok, (stok - min_stok) AS selisih FROM produk;

-- 3. Total asset semua produk
SELECT SUM(harga_beli * stok) AS total_asset FROM produk;

-- 4. Pelanggan lahir 1980–1990
SELECT * FROM pelanggan WHERE YEAR(tgl_lahir) BETWEEN 1980 AND 1990;

-- 5. Pelanggan lahir 1998
SELECT * FROM pelanggan WHERE YEAR(tgl_lahir) = 1998;

-- 6. Pelanggan lahir bulan Agustus
SELECT * FROM pelanggan WHERE MONTH(tgl_lahir) = 8;

-- 7. Pelanggan + umur
SELECT nama, tmp_lahir, tgl_lahir, (YEAR(CURDATE()) - YEAR(tgl_lahir)) AS umur FROM pelanggan;


-- SOAL 3.2
-- 1. Jumlah pelanggan lahir 1998
SELECT COUNT(*) AS jumlah_pelanggan FROM pelanggan WHERE YEAR(tgl_lahir) = 1998;

-- 2. Jumlah pelanggan perempuan dari Jakarta
SELECT COUNT(*) AS jumlah_pelanggan FROM pelanggan WHERE jk = 'P' AND tmp_lahir = 'Jakarta';

-- 3. Total stok produk harga jual < 10rb
SELECT SUM(stok) AS total_stok FROM produk WHERE harga_jual < 10000;

-- 4. Jumlah produk kode awal 'K'
SELECT COUNT(*) AS jumlah_produk FROM produk WHERE kode LIKE 'K%';

-- 5. Rata-rata harga jual > 1jt
SELECT AVG(harga_jual) AS rata_rata_harga FROM produk WHERE harga_jual > 1000000;

-- 6. Stok terbesar
SELECT MAX(stok) AS stok_terbesar FROM produk;

-- 7. Jumlah produk stok < min_stok
SELECT COUNT(*) AS jumlah_produk FROM produk WHERE stok < min_stok;

-- 8. Total asset semua produk
SELECT SUM(harga_beli * stok) AS total_asset FROM produk;


-- SOAL 3.3
-- 1. Produk + status stok
SELECT id, nama, stok,
       CASE WHEN stok <= min_stok THEN 'Segera belanja'
            ELSE 'Stok aman' END AS status_stok
FROM produk;

-- 2. Pelanggan + umur + kategori umur
SELECT id, nama,
       (YEAR(CURDATE()) - YEAR(tgl_lahir)) AS umur,
       CASE
           WHEN (YEAR(CURDATE()) - YEAR(tgl_lahir)) < 17 THEN 'Muda'
           WHEN (YEAR(CURDATE()) - YEAR(tgl_lahir)) BETWEEN 17 AND 55 THEN 'Dewasa'
           ELSE 'Tua' END AS kategori_umur
FROM pelanggan;

-- 3. Produk + bonus
SELECT id, kode, nama,
       CASE
           WHEN kode = 'TV01' THEN 'DVD Player'
           WHEN kode = 'K001' THEN 'Rice Cooker'
           ELSE 'Tidak Ada' END AS bonus
FROM produk;


-- SOAL 3.4
-- 1. Statistik tempat lahir pelanggan
SELECT tmp_lahir, COUNT(*) AS jumlah_pelanggan FROM pelanggan GROUP BY tmp_lahir;

-- 2. Statistik produk per jenis
SELECT jp.nama AS jenis_produk, COUNT(p.id) AS jumlah_produk
FROM produk p
JOIN jenis_produk jp ON p.jenis_produk_id = jp.id
GROUP BY jp.nama;

-- 3. Pelanggan usia < rata-rata
SELECT id, nama, (YEAR(CURDATE()) - YEAR(tgl_lahir)) AS umur
FROM pelanggan
WHERE (YEAR(CURDATE()) - YEAR(tgl_lahir)) < (
    SELECT AVG(YEAR(CURDATE()) - YEAR(tgl_lahir)) FROM pelanggan
);

-- 4. Produk harga > rata-rata
SELECT id, nama, harga_jual
FROM produk
WHERE harga_jual > (SELECT AVG(harga_jual) FROM produk);

-- 5. Pelanggan dengan kartu iuran > 90rb
SELECT p.id, p.nama, k.nama AS kartu, k.iuran
FROM pelanggan p
JOIN kartu k ON p.kartu_id = k.id
WHERE k.iuran > 90000;

-- 6. Statistik produk harga < rata-rata
SELECT COUNT(*) AS jumlah_produk_bawah_rata
FROM produk
WHERE harga_jual < (SELECT AVG(harga_jual) FROM produk);

-- 7. Pelanggan dengan diskon kartu > 3%
SELECT p.id, p.nama, k.nama AS kartu, k.diskon
FROM pelanggan p
JOIN kartu k ON p.kartu_id = k.id
WHERE k.diskon > 3;
