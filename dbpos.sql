-- 1. Buat database
CREATE DATABASE dbpos;

-- 2. Gunakan Database dbpos
USE dbpos;

-- 3. Buat table kartu
CREATE TABLE kartu (
    id INT AUTO_INCREMENT PRIMARY KEY,
    kode VARCHAR(6) UNIQUE,
    nama VARCHAR(30) NOT NULL,
    diskon DOUBLE,
    iuran DOUBLE
);

-- 4. Buat table pelanggan
CREATE TABLE pelanggan (
    id INT AUTO_INCREMENT PRIMARY KEY,
    kode VARCHAR(10) UNIQUE,
    nama VARCHAR(45),
    jk CHAR(1),
    tmp_lahir VARCHAR(30),
    tgl_lahir DATE,
    email VARCHAR(45),
    kartu_id INT NOT NULL REFERENCES kartu(id)
);

-- 5. Buat table pesanan
CREATE TABLE pesanan (
    id INT NOT NULL AUTO_INCREMENT PRIMARY KEY,
    tanggal DATE,
    total DOUBLE,
    pelanggan_id INT NOT NULL REFERENCES pelanggan(id)
);

-- 6. Buat table pembayaran
CREATE TABLE pembayaran (
    id INT NOT NULL AUTO_INCREMENT PRIMARY KEY,
    nokuitansi VARCHAR(10) UNIQUE,
    tanggal DATE,
    jumlah DOUBLE,
    ke INT,
    pesanan_id INT NOT NULL REFERENCES pesanan(id)
);

-- 7. Buat table jenis_produk
CREATE TABLE jenis_produk (
    id INT NOT NULL AUTO_INCREMENT PRIMARY KEY,
    nama VARCHAR(45)
);

-- 8. Buat table vendor
CREATE TABLE vendor (
    id INT NOT NULL AUTO_INCREMENT PRIMARY KEY,
    kode VARCHAR(4) UNIQUE,
    nama VARCHAR(40) NOT NULL,
    kota VARCHAR(30),
    kontak VARCHAR(30)
);

-- 9. Buat table produk
CREATE TABLE produk (
    id INT NOT NULL AUTO_INCREMENT PRIMARY KEY,
    kode VARCHAR(10) UNIQUE,
    nama VARCHAR(45) NOT NULL,
    harga_beli DOUBLE NOT NULL,
    harga_jual DOUBLE NOT NULL,
    stok INT DEFAULT 0,
    min_stok INT,
    jenis_produk_id INT NOT NULL,
    FOREIGN KEY (jenis_produk_id) REFERENCES jenis_produk(id)
);

-- 10. Buat table pesanan
CREATE TABLE pesanan (
    id INT NOT NULL AUTO_INCREMENT PRIMARY KEY,
    tanggal DATE NOT NULL,
    total DOUBLE NOT NULL,
    pelanggan_id INT NOT NULL,
    FOREIGN KEY (pelanggan_id) REFERENCES pelanggan(id)
);

-- 11. Buat table pesanan_items
CREATE TABLE pesanan_items (
    id INT NOT NULL AUTO_INCREMENT PRIMARY KEY,
    produk_id INT NOT NULL,
    pesanan_id INT NOT NULL,
    qty INT NOT NULL,
    harga DOUBLE NOT NULL,
    FOREIGN KEY (produk_id) REFERENCES produk(id),
    FOREIGN KEY (pesanan_id) REFERENCES pesanan(id)
);

-- 12. Buat table pembelian
CREATE TABLE pembelian (
    id INT AUTO_INCREMENT PRIMARY KEY,
    tanggal VARCHAR(45),
    nomor VARCHAR(10),
    produk_id INT NOT NULL,
    jumlah INT NOT NULL,
    harga DOUBLE NOT NULL,
    vendor_id INT NOT NULL,
    FOREIGN KEY (vendor_id) REFERENCES vendor(id),
    FOREIGN KEY (produk_id) REFERENCES produk(id)
);

-- 13. Menampilkan daftar table
SHOW TABLES;
