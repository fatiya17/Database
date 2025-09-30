-- Function 3
MariaDB [dbpos]> DELIMITER $$
MariaDB [dbpos]> CREATE FUNCTION kategori_harga(p_harga DOUBLE)
    -> RETURNS VARCHAR(20)
    -> DETERMINISTIC
    -> BEGIN
    -> DECLARE hasil VARCHAR(20);
    -> IF p_harga <= 500000 THEN
    -> SET hasil = 'murah';
    -> ELSEIF p_harga <= 3000000 THEN
    -> SET hasil = 'sedang';
    -> ELSEIF p_harga <= 10000000 THEN
    -> SET hasil = 'mahal';
    -> ELSE
    -> SET hasil = 'sangat mahal';
    -> END IF;
    -> RETURN hasil;
    -> END $$
Query OK, 0 rows affected (0.013 sec)

MariaDB [dbpos]> DELIMITER ;
MariaDB [dbpos]> SELECT kategori_harga(750000);
+------------------------+
| kategori_harga(750000) |
+------------------------+
| sedang                 |
+------------------------+
1 row in set (0.003 sec)

MariaDB [dbpos]> DELIMITER ;

-- Trigger 2
MariaDB [dbpos]> DELIMITER $$
MariaDB [dbpos]> CREATE PROCEDURE kurangi_stok(
    -> IN p_produk_id INT,
    -> IN p_qty INT)
    -> BEGIN
    -> DECLARE v_stok INT;
    -> SELECT stok INTO v_stok FROM produk WHERE id = p_produk_id FOR UPDATE;
    -> IF v_stok IS NULL THEN
    -> SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'Produk tidak ditemukan';
    -> ELSEIF v_stok < p_qty THEN
    -> SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'Stok tidak cukup';
    -> ELSE
    -> UPDATE produk
    -> SET stok = stok - p_qty
    -> WHERE id = p_produk_id;
    -> END IF;
    -> END $$
Query OK, 0 rows affected (0.012 sec)

-- Trigger 3
MariaDB [dbpos]> DELIMITER $$
MariaDB [dbpos]> CREATE TRIGGER trig_kurangi_stok_after_insert AFTER INSERT ON pesanan_items
    -> FOR EACH ROW
    -> BEGIN
    -> CALL kurangi_stok(NEW.produk_id, NEW.qty);
    -> END $$
Query OK, 0 rows affected (0.016 sec)

MariaDB [dbpos]> DELIMITER ;
