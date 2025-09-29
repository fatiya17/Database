== VIEW PESANAN PELANGGAN KARTU ==
CREATE VIEW pesanan_pelanggan_kartu AS
    -> SELECT pesanan.id, pesanan.total, pesanan.tanggal, pelanggan.kode, pelanggan.nama, kartu.nama AS nama_kartu, kartu.diskon
    -> FROM pesanan
    -> INNER JOIN pelanggan ON pesanan.pelanggan_id = pelanggan.id
    -> INNER JOIN kartu ON pelanggan.kartu_id = kartu.id;

== VIEW PEMBELIAN PRODUK VENDOR ==
CREATE VIEW pembelian_produk_vendor AS
    -> SELECT pembelian.id, pembelian.tanggal, pembelian.nomor, pembelian.jumlah, pembelian.harga, produk.nama AS produk, vendor.nama AS vendor, vendor.kontak FROM pembelian
    -> INNER JOIN produk ON pembelian.produk_id = produk.id
    -> INNER JOIN vendor ON pembelian.vendor_id = vendor.id;

== VIEW PESANAN PELANGGAN PRODUK ==
CREATE VIEW pesanan_pelanggan_produk AS
    ->  SELECT pesanan.id, pesanan.tanggal, pesanan.total,
    -> produk.kode, produk.nama AS produk, jenis_produk.nama AS jenis,
    -> pelanggan.nama AS pelanggan, pesanan_items.qty, pesanan_items.harga FROM pesanan
    -> INNER JOIN pelanggan ON pesanan.pelanggan_id = pelanggan.id
    -> INNER JOIN pesanan_items ON pesanan_items.pesanan_id = pesanan.id
    ->  INNER JOIN produk ON produk.id = pesanan_items.produk_id
    -> INNER JOIN jenis_produk ON produk.jenis_produk_id = produk.id;
