---
layout: post
title: "Bài tập chương 3 - Trần Nhật Sang - 24410347"
date: 2026-02-14 10:00:00 +0700
categories: concept-base university semester01 IE103_information-management practice
tags: ["sql"]
source_path: "Evergreen/concept-base/university/semester01/IE103_information-management/practice/Bài tập chương 3 - Trần Nhật Sang - 24410347.md"
---
## Bài tập 1

### 1. Ngôn ngữ định nghĩa dữ liệu (Data Definition Language)

1. Tạo các quan hệ và khai báo các khóa chính, khóa ngoại của quan hệ.
2. Thêm vào thuộc tính GHICHU có kiểu dữ liệu varchar(20) cho quan hệ SANPHAM.
3. Thêm vào thuộc tính LOAIKH có kiểu dữ liệu là tinyint cho quan hệ KHACHHANG.
4. Sửa kiểu dữ liệu của thuộc tính GHICHU trong quan hệ SANPHAM thành varchar(100).
5. Xóa thuộc tính GHICHU trong quan hệ SANPHAM.
6. Làm thế nào để thuộc tính LOAIKH trong quan hệ KHACHHANG có thể lưu các giá trị là: “Vang lai”, “Thuong xuyen”, “Vip”, …
7. Đơn vị tính của sản phẩm chỉ có thể là (“cay”,”hop”,”cai”,”quyen”,”chuc”)
8. Giá bán của sản phẩm từ 500 đồng trở lên.
9. Mỗi lần mua hàng, khách hàng phải mua ít nhất 1 sản phẩm.
10. Ngày khách hàng đăng ký là khách hàng thành viên phải lớn hơn ngày sinh của người đó.
11. Ngày mua hàng (NGHD) của một khách hàng thành viên sẽ lớn hơn hoặc bằng ngày khách hàng đó
đăng ký thành viên (NGDK).
12. Ngày bán hàng (NGHD) của một nhân viên phải lớn hơn hoặc bằng ngày nhân viên đó vào làm.
13. Mỗi một hóa đơn phải có ít nhất một chi tiết hóa đơn.
14. Trị giá của một hóa đơn là tổng thành tiền (số lượng*đơn giá) của các chi tiết thuộc hóa đơn đó.
15. Doanh số của một khách hàng là tổng trị giá các hóa đơn mà khách hàng thành viên đó đã mua.

```sql

-- Tạo bảng KHACHHANG
CREATE TABLE KHACHHANG (
    MAKH CHAR(4) PRIMARY KEY,
    HOTEN VARCHAR(40),
    DCHI VARCHAR(50),
    SODT VARCHAR(20),
    NGSINH SMALLDATETIME,
    NGDK SMALLDATETIME,
    DOANHSO MONEY
);

-- Tạo bảng NHANVIEN
CREATE TABLE NHANVIEN (
    MANV CHAR(4) PRIMARY KEY,
    HOTEN VARCHAR(40),
    SODT VARCHAR(20),
    NGVL SMALLDATETIME
);

-- Tạo bảng SANPHAM
CREATE TABLE SANPHAM (
    MASP CHAR(4) PRIMARY KEY,
    TENSP VARCHAR(40),
    DVT VARCHAR(20),
    NUOCSX VARCHAR(40),
    GIA MONEY
);

-- Tạo bảng HOADON
CREATE TABLE HOADON (
    SOHD INT PRIMARY KEY,
    NGHD SMALLDATETIME,
    MAKH CHAR(4),
    MANV CHAR(4),
    TRIGIA MONEY,
    FOREIGN KEY (MAKH) REFERENCES KHACHHANG(MAKH),
    FOREIGN KEY (MANV) REFERENCES NHANVIEN(MANV)
);

-- Tạo bảng CTHD
CREATE TABLE CTHD (
    SOHD INT,
    MASP CHAR(4),
    SL INT,
    PRIMARY KEY (SOHD, MASP),
    FOREIGN KEY (SOHD) REFERENCES HOADON(SOHD),
    FOREIGN KEY (MASP) REFERENCES SANPHAM(MASP)
);


-- 2
ALTER TABLE SANPHAM
ADD GHICHU VARCHAR(20);

-- 3
ALTER TABLE KHACHHANG
ADD LOAIKH TINYINT;

-- 4 Sửa kiểu dữ liệu của GHICHU trong SANPHAM
ALTER TABLE SANPHAM
ALTER COLUMN GHICHU VARCHAR(100);

-- 5 Xóa thuộc tính GHICHU trong SANPHAM
ALTER TABLE SANPHAM
DROP COLUMN GHICHU;


-- 6 Sửa thuộc tính LOAIKH để lưu các giá trị string
ALTER TABLE KHACHHANG
DROP COLUMN LOAIKH;

ALTER TABLE KHACHHANG
ADD LOAIKH VARCHAR(25);

-- 7. Ràng buộc cho đơn vị tính của sản phẩm
ALTER TABLE SANPHAM
ADD CONSTRAINT CHK_DVT CHECK (DVT IN ('cay', 'hop', 'cai', 'quyen', 'chuc'));

-- 8. Ràng buộc giá bán sản phẩm
ALTER TABLE SANPHAM
ADD CONSTRAINT CHK_GIA CHECK (GIA >= 500);

-- 9. Ràng buộc mỗi lần mua hàng phải mua ít nhất 1 sản phẩm
ALTER TABLE CTHD
ADD CONSTRAINT CHK_SL CHECK (SL >= 1);

-- 10. Ràng buộc ngày đăng ký > ngày sinh
ALTER TABLE KHACHHANG
ADD CONSTRAINT CHK_NGDK_NGSINH CHECK (NGDK > NGSINH);

-- 11. Ràng buộc ngày mua hàng >= ngày đăng ký thành viên
-- Xóa trigger cũ nếu đã tồn tại
IF EXISTS (SELECT * FROM sys.triggers WHERE name = 'trg_HOADON_CheckNGHD_NGDK')
DROP TRIGGER trg_HOADON_CheckNGHD_NGDK;
GO

-- Tạo trigger kiểm tra ngày mua hàng >= ngày đăng ký
CREATE TRIGGER trg_HOADON_CheckNGHD_NGDK
ON HOADON
AFTER INSERT, UPDATE
AS
BEGIN
    IF EXISTS (
        SELECT * 
        FROM inserted i
        JOIN KHACHHANG k ON i.MAKH = k.MAKH
        WHERE i.MAKH IS NOT NULL AND i.NGHD < k.NGDK
    )
    BEGIN
        RAISERROR('Ngày mua hàng phải lớn hơn hoặc bằng ngày đăng ký thành viên', 16, 1);
        ROLLBACK TRANSACTION;
    END
END;

-- 12 Ràng buộc ngày bán hàng >= ngày nhân viên vào làm
-- Xóa trigger cũ nếu đã tồn tại
IF EXISTS (SELECT * FROM sys.triggers WHERE name = 'trg_HOADON_CheckNGHD_NGVL')
DROP TRIGGER trg_HOADON_CheckNGHD_NGVL;
GO

-- Tạo trigger kiểm tra ngày bán hàng >= ngày nhân viên vào làm
CREATE TRIGGER trg_HOADON_CheckNGHD_NGVL
ON HOADON
AFTER INSERT, UPDATE
AS
BEGIN
    IF EXISTS (
        SELECT * 
        FROM inserted i
        JOIN NHANVIEN n ON i.MANV = n.MANV
        WHERE i.NGHD < n.NGVL
    )
    BEGIN
        RAISERROR('Ngày bán hàng phải lớn hơn hoặc bằng ngày nhân viên vào làm', 16, 1);
        ROLLBACK TRANSACTION;
    END
END;

-- 13. Ràng buộc mỗi hóa đơn phải có ít nhất 1 chi tiết hóa đơn
-- Trigger đảm bảo mỗi hóa đơn phải có ít nhất 1 chi tiết
CREATE TRIGGER trg_HoaDon_CheckCTHD
ON HOADON
AFTER INSERT, UPDATE
AS
BEGIN
    IF EXISTS (
        SELECT * FROM inserted i
        WHERE NOT EXISTS (
            SELECT 1 FROM CTHD
            WHERE SOHD = i.SOHD
        )
    )
    BEGIN
        RAISERROR('Mỗi hóa đơn phải có ít nhất 1 chi tiết hóa đơn', 16, 1)
        ROLLBACK TRANSACTION
    END
END;

-- 14-15. Cập nhật tự động trị giá hóa đơn và doanh số

-- Trigger cập nhật trị giá hóa đơn và doanh số
CREATE TRIGGER trg_CTHD_UpdateTriGia
ON CTHD
AFTER INSERT, UPDATE, DELETE
AS
BEGIN
    -- Cập nhật TRIGIA trong HOADON
    UPDATE h
    SET TRIGIA = (
        SELECT SUM(c.SL * s.GIA)
        FROM CTHD c
        JOIN SANPHAM s ON c.MASP = s.MASP
        WHERE c.SOHD = h.SOHD
    )
    FROM HOADON h
    WHERE EXISTS (
        SELECT 1 FROM inserted i WHERE i.SOHD = h.SOHD
    ) OR EXISTS (
        SELECT 1 FROM deleted d WHERE d.SOHD = h.SOHD
    );
    
    -- Cập nhật DOANHSO trong KHACHHANG
    UPDATE k
    SET DOANHSO = (
        SELECT SUM(TRIGIA)
        FROM HOADON
        WHERE MAKH = k.MAKH
    )
    FROM KHACHHANG k
    WHERE EXISTS (
        SELECT 1 FROM HOADON h
        JOIN inserted i ON h.SOHD = i.SOHD
        WHERE h.MAKH = k.MAKH
    ) OR EXISTS (
        SELECT 1 FROM HOADON h
        JOIN deleted d ON h.SOHD = d.SOHD
        WHERE h.MAKH = k.MAKH
    );
END;

```

### 2. Ngôn ngữ thao tác dữ liệu (Data Manipulation Language)

1. Nhập dữ liệu cho các quan hệ trên.

```sql
-- Nhập dữ liệu cho bảng KHACHHANG
INSERT INTO KHACHHANG VALUES ('KH01', 'Nguyen Van A', '731 Tran Hung Dao, Q5, TpHCM', '08823451', '1960-10-22', '2006-07-22', 13060000, NULL);
INSERT INTO KHACHHANG VALUES ('KH02', 'Tran Ngoc Han', '23/5 Nguyen Trai, Q5, TpHCM', '0908256478', '1974-04-03', '2006-07-30', 280000, NULL);
INSERT INTO KHACHHANG VALUES ('KH03', 'Tran Ngoc Linh', '45 Nguyen Canh Chan, Q1, TpHCM', '0938776266', '1980-06-12', '2006-08-05', 3860000, NULL);
INSERT INTO KHACHHANG VALUES ('KH04', 'Tran Minh Long', '50/34 Le Dai Hanh, Q10, TpHCM', '0917325476', '1965-03-09', '2006-10-02', 250000, NULL);
INSERT INTO KHACHHANG VALUES ('KH05', 'Le Nhat Minh', '34 Truong Dinh, Q3, TpHCM', '08246108', '1950-03-10', '2006-10-28', 21000, NULL);
INSERT INTO KHACHHANG VALUES ('KH06', 'Le Hoai Thuong', '227 Nguyen Van Cu, Q5, TpHCM', '08631738', '1981-12-31', '2006-11-24', 915000, NULL);
INSERT INTO KHACHHANG VALUES ('KH07', 'Nguyen Van Tam', '32/3 Tran Binh Trong, Q5, TpHCM', '0916783565', '1971-04-06', '2006-12-01', 12500, NULL);
INSERT INTO KHACHHANG VALUES ('KH08', 'Phan Thi Thanh', '45/2 An Duong Vuong, Q5, TpHCM', '0938435756', '1971-01-10', '2006-12-13', 365000, NULL);
INSERT INTO KHACHHANG VALUES ('KH09', 'Le Ha Vinh', '873 Le Hong Phong, Q5, TpHCM', '08654763', '1979-09-03', '2007-01-14', 70000, NULL);
INSERT INTO KHACHHANG VALUES ('KH10', 'Ha Duy Lap', '34/34B Nguyen Trai, Q1, TpHCM', '08768904', '1983-05-02', '2007-01-16', 67500, NULL);

-- Nhập dữ liệu cho bảng NHANVIEN
INSERT INTO NHANVIEN VALUES ('NV01', 'Nguyen Nhu Nhut', '0927345678', '2006-04-13');
INSERT INTO NHANVIEN VALUES ('NV02', 'Le Thi Phi Yen', '0987567390', '2006-04-21');
INSERT INTO NHANVIEN VALUES ('NV03', 'Nguyen Van B', '0997047382', '2006-04-27');
INSERT INTO NHANVIEN VALUES ('NV04', 'Ngo Thanh Tuan', '0913758498', '2006-06-24');
INSERT INTO NHANVIEN VALUES ('NV05', 'Nguyen Thi Truc Thanh', '0918590387', '2006-07-20');

-- Nhập dữ liệu cho bảng SANPHAM
INSERT INTO SANPHAM VALUES ('BC01', 'But chi', 'cay', 'Singapore', 3000);
INSERT INTO SANPHAM VALUES ('BC02', 'But chi', 'cay', 'Singapore', 5000);
INSERT INTO SANPHAM VALUES ('BC03', 'But chi', 'cay', 'Viet Nam', 3500);
INSERT INTO SANPHAM VALUES ('BC04', 'But chi', 'hop', 'Viet Nam', 30000);
INSERT INTO SANPHAM VALUES ('BB01', 'But bi', 'cay', 'Viet Nam', 5000);
INSERT INTO SANPHAM VALUES ('BB02', 'But bi', 'cay', 'Trung Quoc', 7000);
INSERT INTO SANPHAM VALUES ('BB03', 'But bi', 'hop', 'Thai Lan', 100000);
INSERT INTO SANPHAM VALUES ('TV01', 'Tap 100 giay mong', 'quyen', 'Trung Quoc', 2500);
INSERT INTO SANPHAM VALUES ('TV02', 'Tap 200 giay mong', 'quyen', 'Trung Quoc', 4500);
INSERT INTO SANPHAM VALUES ('TV03', 'Tap 100 giay tot', 'quyen', 'Viet Nam', 3000);
INSERT INTO SANPHAM VALUES ('TV04', 'Tap 200 giay tot', 'quyen', 'Viet Nam', 5500);
INSERT INTO SANPHAM VALUES ('TV05', 'Tap 100 trang', 'chuc', 'Viet Nam', 23000);
INSERT INTO SANPHAM VALUES ('TV06', 'Tap 200 trang', 'chuc', 'Viet Nam', 53000);
INSERT INTO SANPHAM VALUES ('TV07', 'Tap 100 trang', 'chuc', 'Trung Quoc', 34000);
INSERT INTO SANPHAM VALUES ('ST01', 'So tay 500 trang', 'quyen', 'Trung Quoc', 40000);
INSERT INTO SANPHAM VALUES ('ST02', 'So tay loai 1', 'quyen', 'Viet Nam', 55000);
INSERT INTO SANPHAM VALUES ('ST03', 'So tay loai 2', 'quyen', 'Viet Nam', 51000);
INSERT INTO SANPHAM VALUES ('ST04', 'So tay', 'quyen', 'Thai Lan', 55000);
INSERT INTO SANPHAM VALUES ('ST05', 'So tay mong', 'quyen', 'Thai Lan', 20000);
INSERT INTO SANPHAM VALUES ('ST06', 'Phan viet bang', 'hop', 'Viet Nam', 5000);
INSERT INTO SANPHAM VALUES ('ST07', 'Phan khong bui', 'hop', 'Viet Nam', 7000);
INSERT INTO SANPHAM VALUES ('ST08', 'Bong bang', 'cai', 'Viet Nam', 1000);
INSERT INTO SANPHAM VALUES ('ST09', 'But long', 'cay', 'Viet Nam', 5000);
INSERT INTO SANPHAM VALUES ('ST10', 'But long', 'cay', 'Trung Quoc', 7000);

-- Nhập dữ liệu cho bảng HOADON
INSERT INTO HOADON VALUES (1001, '2006-07-23', 'KH01', 'NV01', 320000);
INSERT INTO HOADON VALUES (1002, '2006-08-12', 'KH01', 'NV02', 840000);
INSERT INTO HOADON VALUES (1003, '2006-08-23', 'KH02', 'NV01', 100000);
INSERT INTO HOADON VALUES (1004, '2006-09-01', 'KH02', 'NV01', 180000);
INSERT INTO HOADON VALUES (1005, '2006-10-20', 'KH01', 'NV02', 3800000);
INSERT INTO HOADON VALUES (1006, '2006-10-16', 'KH01', 'NV03', 2430000);
INSERT INTO HOADON VALUES (1007, '2006-10-28', 'KH03', 'NV03', 510000);
INSERT INTO HOADON VALUES (1008, '2006-10-28', 'KH01', 'NV03', 440000);
INSERT INTO HOADON VALUES (1009, '2006-10-28', 'KH03', 'NV04', 200000);
INSERT INTO HOADON VALUES (1010, '2006-11-01', 'KH01', 'NV01', 5200000);
INSERT INTO HOADON VALUES (1011, '2006-11-04', 'KH04', 'NV03', 250000);
INSERT INTO HOADON VALUES (1012, '2006-11-30', 'KH05', 'NV03', 21000);
INSERT INTO HOADON VALUES (1013, '2006-12-12', 'KH06', 'NV01', 5000);
INSERT INTO HOADON VALUES (1014, '2006-12-31', 'KH03', 'NV02', 3150000);
INSERT INTO HOADON VALUES (1015, '2007-01-01', 'KH06', 'NV01', 910000);
INSERT INTO HOADON VALUES (1016, '2007-01-01', 'KH07', 'NV02', 12500);
INSERT INTO HOADON VALUES (1017, '2007-01-02', 'KH08', 'NV03', 35000);
INSERT INTO HOADON VALUES (1018, '2007-01-13', 'KH08', 'NV03', 330000);
INSERT INTO HOADON VALUES (1019, '2007-01-13', 'KH01', 'NV03', 30000);
INSERT INTO HOADON VALUES (1020, '2007-01-14', 'KH09', 'NV04', 70000);
INSERT INTO HOADON VALUES (1021, '2007-01-16', 'KH10', 'NV03', 67500);
INSERT INTO HOADON VALUES (1022, '2007-01-16', NULL, 'NV03', 7000);
INSERT INTO HOADON VALUES (1023, '2007-01-17', NULL, 'NV01', 330000);

-- Nhập dữ liệu cho bảng CTHD
INSERT INTO CTHD VALUES (1001, 'TV02', 10);
INSERT INTO CTHD VALUES (1001, 'ST01', 5);
INSERT INTO CTHD VALUES (1001, 'BC01', 5);
INSERT INTO CTHD VALUES (1001, 'BC02', 10);
INSERT INTO CTHD VALUES (1001, 'ST08', 10);
INSERT INTO CTHD VALUES (1002, 'BC04', 20);
INSERT INTO CTHD VALUES (1002, 'BB01', 20);
INSERT INTO CTHD VALUES (1002, 'BB02', 20);
INSERT INTO CTHD VALUES (1003, 'BB03', 10);
INSERT INTO CTHD VALUES (1004, 'TV01', 20);
INSERT INTO CTHD VALUES (1004, 'TV02', 10);
INSERT INTO CTHD VALUES (1004, 'TV03', 10);
INSERT INTO CTHD VALUES (1004, 'TV04', 10);
INSERT INTO CTHD VALUES (1005, 'TV05', 50);
INSERT INTO CTHD VALUES (1005, 'TV06', 50);
INSERT INTO CTHD VALUES (1006, 'TV07', 20);
INSERT INTO CTHD VALUES (1006, 'ST01', 30);
INSERT INTO CTHD VALUES (1006, 'ST02', 10);
INSERT INTO CTHD VALUES (1007, 'ST03', 10);
INSERT INTO CTHD VALUES (1008, 'ST04', 8);
INSERT INTO CTHD VALUES (1009, 'ST05', 10);
INSERT INTO CTHD VALUES (1010, 'TV07', 50);
INSERT INTO CTHD VALUES (1010, 'ST07', 50);
INSERT INTO CTHD VALUES (1010, 'ST08', 100);
INSERT INTO CTHD VALUES (1010, 'ST04', 50);
INSERT INTO CTHD VALUES (1010, 'TV03', 100);
INSERT INTO CTHD VALUES (1011, 'ST06', 50);
INSERT INTO CTHD VALUES (1012, 'ST07', 3);
INSERT INTO CTHD VALUES (1013, 'ST08', 5);
INSERT INTO CTHD VALUES (1014, 'BC02', 80);
INSERT INTO CTHD VALUES (1014, 'BB02', 100);
INSERT INTO CTHD VALUES (1014, 'BC04', 60);
INSERT INTO CTHD VALUES (1014, 'BB01', 50);
INSERT INTO CTHD VALUES (1015, 'BB02', 30);
INSERT INTO CTHD VALUES (1015, 'BB03', 7);
INSERT INTO CTHD VALUES (1016, 'TV01', 5);
INSERT INTO CTHD VALUES (1017, 'TV02', 1);
INSERT INTO CTHD VALUES (1017, 'TV03', 1);
INSERT INTO CTHD VALUES (1017, 'TV04', 5);
INSERT INTO CTHD VALUES (1018, 'ST04', 6);
INSERT INTO CTHD VALUES (1019, 'ST05', 1);
INSERT INTO CTHD VALUES (1019, 'ST06', 2);
INSERT INTO CTHD VALUES (1020, 'ST07', 10);
INSERT INTO CTHD VALUES (1021, 'ST08', 5);
INSERT INTO CTHD VALUES (1021, 'TV01', 7);
INSERT INTO CTHD VALUES (1021, 'TV02', 10);
INSERT INTO CTHD VALUES (1022, 'ST07', 1);
INSERT INTO CTHD VALUES (1023, 'ST04', 6);

```

2. Tạo quan hệ SANPHAM1 chứa toàn bộ dữ liệu của quan hệ SANPHAM. Tạo quan hệ
KHACHHANG1 chứa toàn bộ dữ liệu của quan hệ KHACHHANG.
3. Cập nhật giá tăng 5% đối với những sản phẩm do “Thai Lan” sản xuất (cho quan hệ SANPHAM1)
4. Cập nhật giá giảm 5% đối với những sản phẩm do “Trung Quoc” sản xuất có giá từ 10.000 trở xuống
(cho quan hệ SANPHAM1).
5. Cập nhật giá trị LOAIKH là “Vip” đối với những khách hàng đăng ký thành viên trước ngày
1/1/2007 có doanh số từ 10.000.000 trở lên hoặc khách hàng đăng ký thành viên từ 1/1/2007 trở về sau có doanh số từ 2.000.000 trở lên (cho quan hệ KHACHHANG1).

```sql

-- 2. Tạo quan hệ SANPHAM1 chứa toàn bộ dữ liệu của quan hệ SANPHAM. Tạo quan hệ
-- KHACHHANG1 chứa toàn bộ dữ liệu của quan hệ KHACHHANG.
SELECT * INTO SANPHAM1 FROM SANPHAM;
SELECT * INTO KHACHHANG1 FROM KHACHHANG;

-- 3. Cập nhật giá tăng 5% đối với những sản phẩm do “Thai Lan” sản xuất (cho quan hệ SANPHAM1)
UPDATE SANPHAM1
SET GIA = GIA * 1.05
WHERE NUOCSX = 'Thai Lan';

-- 4. Cập nhật giá giảm 5% đối với những sản phẩm do “Trung Quoc” sản xuất có giá từ 10.000 trở xuống
-- (cho quan hệ SANPHAM1).
UPDATE SANPHAM1
SET GIA = GIA * 0.95
WHERE NUOCSX = 'Trung Quoc' AND GIA <= 10000;

-- 5. Cập nhật giá trị LOAIKH là “Vip” đối với những khách hàng đăng ký thành viên trước ngày
-- 1/1/2007 có doanh số từ 10.000.000 trở lên hoặc khách hàng đăng ký thành viên từ 1/1/2007 trở về
-- sau có doanh số từ 2.000.000 trở lên (cho quan hệ KHACHHANG1).
UPDATE KHACHHANG1
SET LOAIKH = 'Vip'
WHERE (NGDK < '2007-01-01' AND DOANHSO >= 10000000)
   OR (NGDK >= '2007-01-01' AND DOANHSO >= 2000000);

```

### 3. Ngôn ngữ truy vấn dữ liệu có cấu trúc

1. In ra danh sách các sản phẩm (MASP,TENSP) do “Trung Quoc” sản xuất.
!![](assets/images/obsidian/Pasted image 20250330112248.png)

2. In ra danh sách các sản phẩm (MASP, TENSP) có đơn vị tính là “cay”, ”quyen”.
!![](assets/images/obsidian/Pasted image 20250330194147.png)
3. In ra danh sách các sản phẩm (MASP,TENSP) có mã sản phẩm bắt đầu là “B” và kết thúc là “01”.
!![](assets/images/obsidian/Pasted image 20250330194225.png)
4. In ra danh sách các sản phẩm (MASP,TENSP) do “Trung Quốc” sản xuất có giá từ 30.000 đến 40.000.
!![](assets/images/obsidian/Pasted image 20250330194240.png)
5. In ra danh sách các sản phẩm (MASP,TENSP) do “Trung Quoc” hoặc “Thai Lan” sản xuất có giá từ 30.000 đến 40.000.
!![](assets/images/obsidian/Pasted image 20250330194256.png)
6. In ra các số hóa đơn, trị giá hóa đơn bán ra trong ngày 1/1/2007 và ngày 2/1/2007.
!![](assets/images/obsidian/Pasted image 20250330194312.png)
7. In ra các số hóa đơn, trị giá hóa đơn trong tháng 1/2007, sắp xếp theo ngày (tăng dần) và trị giá của hóa đơn (giảm dần).
!![](assets/images/obsidian/Pasted image 20250330194409.png)

8. In ra danh sách các khách hàng (MAKH, HOTEN) đã mua hàng trong ngày 1/1/2007.
!![](assets/images/obsidian/Pasted image 20250330194422.png)
9. In ra số hóa đơn, trị giá các hóa đơn do nhân viên có tên “Nguyen Van B” lập trong ngày
28/10/2006.
!![](assets/images/obsidian/Pasted image 20250330194445.png)
10. In ra danh sách các sản phẩm (MASP,TENSP) được khách hàng có tên “Nguyen Van A” mua trong tháng 10/2006.
!![](assets/images/obsidian/Pasted image 20250330194459.png)
11. Tìm các số hóa đơn đã mua sản phẩm có mã số “BB01” hoặc “BB02”.
!![](assets/images/obsidian/Pasted image 20250330194515.png)
12. Tìm các số hóa đơn đã mua sản phẩm có mã số “BB01” hoặc “BB02”, mỗi sản phẩm mua với số lượng từ 10 đến 20.
!![](assets/images/obsidian/Pasted image 20250330194541.png)
13. Tìm các số hóa đơn mua cùng lúc 2 sản phẩm có mã số “BB01” và “BB02”, mỗi sản phẩm mua với số lượng từ 10 đến 20
!![](assets/images/obsidian/Pasted image 20250330194552.png)
14. In ra danh sách các sản phẩm (MASP,TENSP) do “Trung Quoc” sản xuất hoặc các sản phẩm được bán ra trong ngày 1/1/2007.
!![](assets/images/obsidian/Pasted image 20250330194605.png)
15. In ra danh sách các sản phẩm (MASP,TENSP) không bán được.
!![](assets/images/obsidian/Pasted image 20250330194621.png)
16. In ra danh sách các sản phẩm (MASP,TENSP) không bán được trong năm 2006.
!![](assets/images/obsidian/Pasted image 20250330194636.png)
17. In ra danh sách các sản phẩm (MASP,TENSP) do “Trung Quoc” sản xuất không bán được trong năm 2006.
!![](assets/images/obsidian/Pasted image 20250330194652.png)
18. Tìm số hóa đơn đã mua tất cả các sản phẩm do Singapore sản xuất.
!![](assets/images/obsidian/Pasted image 20250330194703.png)
19. Tìm số hóa đơn trong năm 2006 đã mua ít nhất tất cả các sản phẩm do Singapore sản xuất.
!![](assets/images/obsidian/Pasted image 20250330194717.png)
20. Có bao nhiêu hóa đơn không phải của khách hàng đăng ký thành viên mua?
!![](assets/images/obsidian/Pasted image 20250330194728.png)
21. Có bao nhiêu sản phẩm khác nhau được bán ra trong năm 2006.
!![](assets/images/obsidian/Pasted image 20250330194747.png)
22. Cho biết trị giá hóa đơn cao nhất, thấp nhất là bao nhiêu ?
!![](assets/images/obsidian/Pasted image 20250330194806.png)
23. Trị giá trung bình của tất cả các hóa đơn được bán ra trong năm 2006 là bao nhiêu?
!![](assets/images/obsidian/Pasted image 20250330194817.png)
24. Tính doanh thu bán hàng trong năm 2006.
!![](assets/images/obsidian/Pasted image 20250330194830.png)
25. Tìm số hóa đơn có trị giá cao nhất trong năm 2006.
!![](assets/images/obsidian/Pasted image 20250330194841.png)
26. Tìm họ tên khách hàng đã mua hóa đơn có trị giá cao nhất trong năm 2006.
!![](assets/images/obsidian/Pasted image 20250330194854.png)
27. In ra danh sách 3 khách hàng (MAKH, HOTEN) có doanh số cao nhất.
!![](assets/images/obsidian/Pasted image 20250330194934.png)

28. In ra danh sách các sản phẩm (MASP, TENSP) có giá bán bằng 1 trong 3 mức giá cao nhất.
!![](assets/images/obsidian/Pasted image 20250330112845.png)
29. In ra danh sách các sản phẩm (MASP, TENSP) do “Thai Lan” sản xuất có giá bằng 1 trong 3 mức giá cao nhất (của tất cả các sản phẩm).
!![](assets/images/obsidian/Pasted image 20250330112920.png)
30. In ra danh sách các sản phẩm (MASP, TENSP) do “Trung Quoc” sản xuất có giá bằng 1 trong 3 mức giá cao nhất (của sản phẩm do “Trung Quoc” sản xuất).
!![](assets/images/obsidian/Pasted image 20250330113852.png)
31. * In ra danh sách 3 khách hàng có doanh số cao nhất (sắp xếp theo kiểu xếp hạng).
!![](assets/images/obsidian/Pasted image 20250330114154.png)
32. Tính tổng số sản phẩm do “Trung Quoc” sản xuất.
!![](assets/images/obsidian/Pasted image 20250330195007.png)
33. Tính tổng số sản phẩm của từng nước sản xuất.
!![](assets/images/obsidian/Pasted image 20250330195026.png)
34. Với từng nước sản xuất, tìm giá bán cao nhất, thấp nhất, trung bình của các sản phẩm.
!![](assets/images/obsidian/Pasted image 20250330195048.png)
35. Tính doanh thu bán hàng mỗi ngày.
!![](assets/images/obsidian/Pasted image 20250330195059.png)
36. Tính tổng số lượng của từng sản phẩm bán ra trong tháng 10/2006.
!![](assets/images/obsidian/Pasted image 20250330195112.png)
37. Tính doanh thu bán hàng của từng tháng trong năm 2006.
!![](assets/images/obsidian/Pasted image 20250330195249.png)
38. Tìm hóa đơn có mua ít nhất 4 sản phẩm khác nhau.
!![](assets/images/obsidian/Pasted image 20250330195300.png)
39. Tìm hóa đơn có mua 3 sản phẩm do “Viet Nam” sản xuất (3 sản phẩm khác nhau).
!![](assets/images/obsidian/Pasted image 20250330195852.png)
40. Tìm khách hàng (MAKH, HOTEN) có số lần mua hàng nhiều nhất.
!![](assets/images/obsidian/Pasted image 20250330200016.png)
41. Tháng mấy trong năm 2006, doanh số bán hàng cao nhất ?
!![](assets/images/obsidian/Pasted image 20250330202304.png)
42. Tìm sản phẩm (MASP, TENSP) có tổng số lượng bán ra thấp nhất trong năm 2006.
!![](assets/images/obsidian/Pasted image 20250330202419.png)
43. *Mỗi nước sản xuất, tìm sản phẩm (MASP,TENSP) có giá bán cao nhất.
!![](assets/images/obsidian/Pasted image 20250330202924.png)
44. Tìm nước sản xuất sản xuất ít nhất 3 sản phẩm có giá bán khác nhau.
!![](assets/images/obsidian/Pasted image 20250330203104.png)
45. *Trong 10 khách hàng có doanh số cao nhất, tìm khách hàng có số lần mua hàng nhiều nhất
!![](assets/images/obsidian/Pasted image 20250330204531.png)

## Bài tập 2

### 1. Ngôn ngữ định nghĩa dữ liệu (Data Definition Language)

1. Tạo quan hệ và khai báo tất cả các ràng buộc khóa chính, khóa ngoại. Thêm vào 3 thuộc tính
GHICHU, DIEMTB, XEPLOAI cho quan hệ HOCVIEN.
2. Mã học viên là một chuỗi 5 ký tự, 3 ký tự đầu là mã lớp, 2 ký tự cuối cùng là số thứ tự học
viên trong lớp. VD: “K1101”
3. Thuộc tính GIOITINH chỉ có giá trị là “Nam” hoặc “Nu”.
4. Điểm số của một lần thi có giá trị từ 0 đến 10 và cần lưu đến 2 số lẽ (VD: 6.22).
5. Kết quả thi là “Dat” nếu điểm từ 5 đến 10 và “Khong dat” nếu điểm nhỏ hơn 5.
6. Học viên thi một môn tối đa 3 lần.
7. Học kỳ chỉ có giá trị từ 1 đến 3.
8. Học vị của giáo viên chỉ có thể là “CN”, “KS”, “Ths”, ”TS”, ”PTS”.
9. Lớp trưởng của một lớp phải là học viên của lớp đó.
10. Trưởng khoa phải là giáo viên thuộc khoa và có học vị “TS” hoặc “PTS”.
11. Học viên ít nhất là 18 tuổi.
12. Giảng dạy một môn học ngày bắt đầu (TUNGAY) phải nhỏ hơn ngày kết thúc
(DENNGAY).
13. Giáo viên khi vào làm ít nhất là 22 tuổi.
14. Tất cả các môn học đều có số tín chỉ lý thuyết và tín chỉ thực hành chênh lệch nhau không
quá 3.
15. Học viên chỉ được thi một môn học nào đó khi lớp của học viên đã học xong môn học này.
16. Mỗi học kỳ của một năm học, một lớp chỉ được học tối đa 3 môn.
17. Sỉ số của một lớp bằng với số lượng học viên thuộc lớp đó.
18. Trong quan hệ DIEUKIEN giá trị của thuộc tính MAMH và MAMH_TRUOC trong cùng
một bộ không được giống nhau (“A”,”A”) và cũng không tồn tại hai bộ (“A”,”B”) và
(“B”,”A”).
19. Các giáo viên có cùng học vị, học hàm, hệ số lương thì mức lương bằng nhau.
20. Học viên chỉ được thi lại (lần thi >1) khi điểm của lần thi trước đó dưới 5.
21. Ngày thi của lần thi sau phải lớn hơn ngày thi của lần thi trước (cùng học viên, cùng môn
học).
22. Học viên chỉ được thi những môn mà lớp của học viên đó đã học xong.
23. Khi phân công giảng dạy một môn học, phải xét đến thứ tự trước sau giữa các môn học (sau
khi học xong những môn học phải học trước mới được học những môn liền sau).
24. Giáo viên chỉ được phân công dạy những môn thuộc khoa giáo viên đó phụ trách.


```sql

-- Tạo bảng KHOA
CREATE TABLE KHOA (
    MAKHOA VARCHAR(4) PRIMARY KEY,
    TENKHOA VARCHAR(40),
    NGTLAP SMALLDATETIME,
    TRGKHOA CHAR(4)
);

-- Tạo bảng GIAOVIEN
CREATE TABLE GIAOVIEN (
    MAGV CHAR(4) PRIMARY KEY,
    HOTEN VARCHAR(40),
    HOCVI VARCHAR(10),
    HOCHAM VARCHAR(10),
    GIOITINH VARCHAR(3),
    NGSINH SMALLDATETIME,
    NGVL SMALLDATETIME,
    HESO NUMERIC(4,2),
    MUCLUONG MONEY,
    MAKHOA VARCHAR(4),
    CONSTRAINT FK_GIAOVIEN_KHOA FOREIGN KEY (MAKHOA) REFERENCES KHOA(MAKHOA)
);

-- Thêm ràng buộc khóa ngoại cho bảng KHOA sau khi tạo bảng GIAOVIEN
ALTER TABLE KHOA
ADD CONSTRAINT FK_KHOA_GIAOVIEN FOREIGN KEY (TRGKHOA) REFERENCES GIAOVIEN(MAGV);

-- Tạo bảng MONHOC
CREATE TABLE MONHOC (
    MAMH VARCHAR(10) PRIMARY KEY,
    TENMH VARCHAR(40),
    TCLT TINYINT,
    TCTH TINYINT,
    MAKHOA VARCHAR(4),
    CONSTRAINT FK_MONHOC_KHOA FOREIGN KEY (MAKHOA) REFERENCES KHOA(MAKHOA)
);

-- Tạo bảng DIEUKIEN
CREATE TABLE DIEUKIEN (
    MAMH VARCHAR(10),
    MAMH_TRUOC VARCHAR(10),
    CONSTRAINT PK_DIEUKIEN PRIMARY KEY (MAMH, MAMH_TRUOC),
    CONSTRAINT FK_DIEUKIEN_MONHOC1 FOREIGN KEY (MAMH) REFERENCES MONHOC(MAMH),
    CONSTRAINT FK_DIEUKIEN_MONHOC2 FOREIGN KEY (MAMH_TRUOC) REFERENCES MONHOC(MAMH)
);

-- Tạo bảng LOP
CREATE TABLE LOP (
    MALOP CHAR(3) PRIMARY KEY,
    TENLOP VARCHAR(40),
    TRGLOP CHAR(5),
    SISO TINYINT,
    MAGVCN CHAR(4),
    CONSTRAINT FK_LOP_GIAOVIEN FOREIGN KEY (MAGVCN) REFERENCES GIAOVIEN(MAGV)
);

-- Tạo bảng HOCVIEN
CREATE TABLE HOCVIEN (
    MAHV CHAR(5) PRIMARY KEY,
    HO VARCHAR(40),
    TEN VARCHAR(10),
    NGSINH SMALLDATETIME,
    GIOITINH VARCHAR(3),
    NOISINH VARCHAR(40),
    MALOP CHAR(3),
    GHICHU VARCHAR(100),
    DIEMTB NUMERIC(4,2),
    XEPLOAI VARCHAR(10),
    CONSTRAINT FK_HOCVIEN_LOP FOREIGN KEY (MALOP) REFERENCES LOP(MALOP)
);

-- Thêm ràng buộc khóa ngoại cho bảng LOP sau khi tạo bảng HOCVIEN
ALTER TABLE LOP
ADD CONSTRAINT FK_LOP_HOCVIEN FOREIGN KEY (TRGLOP) REFERENCES HOCVIEN(MAHV);

-- Tạo bảng GIANGDAY
CREATE TABLE GIANGDAY (
    MALOP CHAR(3),
    MAMH VARCHAR(10),
    MAGV CHAR(4),
    HOCKY TINYINT,
    NAM SMALLINT,
    TUNGAY SMALLDATETIME,
    DENNGAY SMALLDATETIME,
    CONSTRAINT PK_GIANGDAY PRIMARY KEY (MALOP, MAMH, HOCKY, NAM),
    CONSTRAINT FK_GIANGDAY_LOP FOREIGN KEY (MALOP) REFERENCES LOP(MALOP),
    CONSTRAINT FK_GIANGDAY_MONHOC FOREIGN KEY (MAMH) REFERENCES MONHOC(MAMH),
    CONSTRAINT FK_GIANGDAY_GIAOVIEN FOREIGN KEY (MAGV) REFERENCES GIAOVIEN(MAGV)
);

-- Tạo bảng KETQUATHI
CREATE TABLE KETQUATHI (
    MAHV CHAR(5),
    MAMH VARCHAR(10),
    LANTHI TINYINT,
    NGTHI SMALLDATETIME,
    DIEM NUMERIC(4,2),
    KQUA VARCHAR(10),
    CONSTRAINT PK_KETQUATHI PRIMARY KEY (MAHV, MAMH, LANTHI),
    CONSTRAINT FK_KETQUATHI_HOCVIEN FOREIGN KEY (MAHV) REFERENCES HOCVIEN(MAHV),
    CONSTRAINT FK_KETQUATHI_MONHOC FOREIGN KEY (MAMH) REFERENCES MONHOC(MAMH)
);

-- 2. Mã học viên là một chuỗi 5 ký tự, 3 ký tự đầu là mã lớp, 2 ký tự cuối cùng là số thứ tự học viên trong lớp
ALTER TABLE HOCVIEN
ADD CONSTRAINT CHK_MAHV CHECK (MAHV LIKE '___%__' AND LEFT(MAHV, 3) = MALOP);

-- Các ràng buộc theo yêu cầu
-- 3. Thuộc tính GIOITINH chỉ có giá trị là "Nam" hoặc "Nu"
ALTER TABLE HOCVIEN
ADD CONSTRAINT CHK_GIOITINH_HV CHECK (GIOITINH IN ('Nam', 'Nu'));

ALTER TABLE GIAOVIEN
ADD CONSTRAINT CHK_GIOITINH_GV CHECK (GIOITINH IN ('Nam', 'Nu'));

-- 4. Điểm số từ 0 đến 10 và lưu đến 2 số lẻ
ALTER TABLE KETQUATHI
ADD CONSTRAINT CHK_DIEM CHECK (DIEM BETWEEN 0 AND 10);

-- 5. Kết quả thi là "Dat" nếu điểm từ 5 đến 10 và "Khong dat" nếu điểm nhỏ hơn 5
ALTER TABLE KETQUATHI
ADD CONSTRAINT CHK_KQUA CHECK (
    (DIEM >= 5 AND KQUA = 'Dat') OR
    (DIEM < 5 AND KQUA = 'Khong dat')
);

-- 6. Học viên thi một môn tối đa 3 lần
ALTER TABLE KETQUATHI
ADD CONSTRAINT CHK_LANTHI CHECK (LANTHI BETWEEN 1 AND 3);

-- 7. Học kỳ chỉ có giá trị từ 1 đến 3
ALTER TABLE GIANGDAY
ADD CONSTRAINT CHK_HOCKY CHECK (HOCKY BETWEEN 1 AND 3);

-- 8. Học vị của giáo viên chỉ có thể là "CN", "KS", "Ths", "TS", "PTS"
ALTER TABLE GIAOVIEN
ADD CONSTRAINT CHK_HOCVI CHECK (HOCVI IN ('CN', 'KS', 'Ths', 'TS', 'PTS'));

-- 9. Lớp trưởng của một lớp phải là học viên của lớp đó
-- 9. Lớp trưởng của một lớp phải là học viên của lớp đó (sử dụng trigger)
CREATE TRIGGER TRG_TRGLOP_CHECK
ON LOP
AFTER INSERT, UPDATE
AS
BEGIN
    IF EXISTS (
        SELECT * FROM inserted
        WHERE TRGLOP IS NOT NULL
          AND NOT EXISTS (
            SELECT * FROM HOCVIEN HV
            WHERE HV.MAHV = inserted.TRGLOP
              AND HV.MALOP = inserted.MALOP
          )
    )
    BEGIN
        RAISERROR('Lớp trưởng phải là học viên của lớp đó', 16, 1)
        ROLLBACK TRANSACTION
    END
END

-- 10. Trưởng khoa phải là giáo viên thuộc khoa và có học vị "TS" hoặc "PTS"
CREATE TRIGGER TRG_TRGKHOA_CHECK
ON KHOA
AFTER INSERT, UPDATE
AS
BEGIN
    IF EXISTS (
        SELECT * FROM inserted I
        WHERE I.TRGKHOA IS NOT NULL
          AND NOT EXISTS (
            SELECT * FROM GIAOVIEN GV
            WHERE GV.MAGV = I.TRGKHOA
              AND GV.MAKHOA = I.MAKHOA
              AND GV.HOCVI IN ('TS', 'PTS')
          )
    )
    BEGIN
        RAISERROR('Trưởng khoa phải là giáo viên thuộc khoa và có học vị TS hoặc PTS', 16, 1)
        ROLLBACK TRANSACTION
    END
END

-- 11. Học viên ít nhất là 18 tuổi
ALTER TABLE HOCVIEN
ADD CONSTRAINT CHK_TUOI_HV CHECK (DATEDIFF(YEAR, NGSINH, GETDATE()) >= 18);

-- 12. Giảng dạy một môn học ngày bắt đầu (TUNGAY) phải nhỏ hơn ngày kết thúc (DENNGAY)
ALTER TABLE GIANGDAY
ADD CONSTRAINT CHK_NGAYDAY CHECK (TUNGAY < DENNGAY);

-- 13. Giáo viên khi vào làm ít nhất là 22 tuổi
ALTER TABLE GIAOVIEN
ADD CONSTRAINT CHK_TUOI_GV CHECK (DATEDIFF(YEAR, NGSINH, NGVL) >= 22);

-- 14. Tất cả các môn học có số tín chỉ lý thuyết và tín chỉ thực hành chênh lệch không quá 3
ALTER TABLE MONHOC
ADD CONSTRAINT CHK_TINCHI CHECK (ABS(TCLT - TCTH) <= 3);

-- 15. Học viên chỉ được thi một môn học nào đó khi lớp của học viên đã học xong môn học này
CREATE TRIGGER TRG_KT_DADAYHOC
ON KETQUATHI
AFTER INSERT, UPDATE
AS
BEGIN
    IF EXISTS (
        SELECT * FROM inserted i
        WHERE NOT EXISTS (
            SELECT * FROM GIANGDAY GD
            WHERE GD.MAMH = i.MAMH
              AND GD.MALOP = (SELECT MALOP FROM HOCVIEN WHERE MAHV = i.MAHV)
              AND GD.DENNGAY <= i.NGTHI
        )
    )
    BEGIN
        RAISERROR('Học viên chỉ được thi môn học khi lớp đã học xong môn đó', 16, 1)
        ROLLBACK TRANSACTION
    END
END

-- 16. Mỗi học kỳ của một năm học, một lớp chỉ được học tối đa 3 môn
CREATE TRIGGER TRG_MAX_3_MON
ON GIANGDAY
AFTER INSERT, UPDATE
AS
BEGIN
    IF EXISTS (
        SELECT MALOP, HOCKY, NAM
        FROM GIANGDAY
        WHERE MALOP IN (SELECT MALOP FROM inserted)
          AND HOCKY IN (SELECT HOCKY FROM inserted)
          AND NAM IN (SELECT NAM FROM inserted)
        GROUP BY MALOP, HOCKY, NAM
        HAVING COUNT(MAMH) > 3
    )
    BEGIN
        RAISERROR('Mỗi học kỳ của một năm học, một lớp chỉ được học tối đa 3 môn', 16, 1)
        ROLLBACK TRANSACTION
    END
END

-- 17. Sỉ số của một lớp bằng với số lượng học viên thuộc lớp đó
CREATE TRIGGER TRG_SISO_LOP
ON HOCVIEN
AFTER INSERT, UPDATE, DELETE
AS
BEGIN
    UPDATE LOP
    SET SISO = (SELECT COUNT(*) FROM HOCVIEN WHERE HOCVIEN.MALOP = LOP.MALOP)
    WHERE MALOP IN (
        SELECT MALOP FROM inserted
        UNION
        SELECT MALOP FROM deleted
    )
END

-- 18. Trong quan hệ DIEUKIEN, MAMH và MAMH_TRUOC không được giống nhau
ALTER TABLE DIEUKIEN
ADD CONSTRAINT CHK_MAMH_KHACNHAU CHECK (MAMH <> MAMH_TRUOC);

-- 19. Các giáo viên có cùng học vị, học hàm, hệ số lương thì mức lương bằng nhau
CREATE TRIGGER TRG_LUONG_GIONG_NHAU
ON GIAOVIEN
AFTER INSERT, UPDATE
AS
BEGIN
    IF EXISTS (
        SELECT GV1.HOCVI, GV1.HOCHAM, GV1.HESO
        FROM GIAOVIEN GV1, GIAOVIEN GV2
        WHERE GV1.HOCVI = GV2.HOCVI
          AND GV1.HOCHAM = GV2.HOCHAM
          AND GV1.HESO = GV2.HESO
          AND GV1.MUCLUONG <> GV2.MUCLUONG
    )
    BEGIN
        RAISERROR('Các giáo viên có cùng học vị, học hàm, hệ số lương thì mức lương phải bằng nhau', 16, 1)
        ROLLBACK TRANSACTION
    END
END

-- 20. Học viên chỉ được thi lại (lần thi >1) khi điểm của lần thi trước đó dưới 5
CREATE TRIGGER TRG_THI_LAI
ON KETQUATHI
AFTER INSERT, UPDATE
AS
BEGIN
    IF EXISTS (
        SELECT * FROM inserted i
        WHERE i.LANTHI > 1
          AND NOT EXISTS (
            SELECT * FROM KETQUATHI KQ
            WHERE KQ.MAHV = i.MAHV
              AND KQ.MAMH = i.MAMH
              AND KQ.LANTHI = i.LANTHI - 1
              AND KQ.DIEM < 5
        )
    )
    BEGIN
        RAISERROR('Học viên chỉ được thi lại khi điểm của lần thi trước đó dưới 5', 16, 1)
        ROLLBACK TRANSACTION
    END
END

-- 21. Ngày thi của lần thi sau phải lớn hơn ngày thi của lần thi trước
CREATE TRIGGER TRG_NGAYTHI_AFTER
ON KETQUATHI
AFTER INSERT, UPDATE
AS
BEGIN
    IF EXISTS (
        SELECT * FROM inserted i
        WHERE i.LANTHI > 1
          AND EXISTS (
            SELECT * FROM KETQUATHI KQ
            WHERE KQ.MAHV = i.MAHV
              AND KQ.MAMH = i.MAMH
              AND KQ.LANTHI = i.LANTHI - 1
              AND i.NGTHI <= KQ.NGTHI
        )
    )
    BEGIN
        RAISERROR('Ngày thi của lần thi sau phải lớn hơn ngày thi của lần thi trước', 16, 1)
        ROLLBACK TRANSACTION
    END
END

-- 15 & 22. Học viên chỉ được thi những môn mà lớp của học viên đó đã học xong
CREATE TRIGGER TRG_KT_DADAYHOC
ON KETQUATHI
AFTER INSERT, UPDATE
AS
BEGIN
    IF EXISTS (
        SELECT * FROM inserted i
        WHERE NOT EXISTS (
            SELECT * FROM GIANGDAY GD
            WHERE GD.MAMH = i.MAMH
              AND GD.MALOP = (SELECT MALOP FROM HOCVIEN WHERE MAHV = i.MAHV)
              AND GD.DENNGAY <= i.NGTHI
        )
    )
    BEGIN
        RAISERROR('Học viên chỉ được thi môn học khi lớp đã học xong môn đó', 16, 1)
        ROLLBACK TRANSACTION
    END
END

-- 23. Khi phân công giảng dạy một môn học, phải xét đến thứ tự trước sau giữa các môn học
CREATE TRIGGER TRG_THU_TU_MON_HOC
ON GIANGDAY
AFTER INSERT, UPDATE
AS
BEGIN
    IF EXISTS (
        SELECT * FROM inserted i
        JOIN DIEUKIEN DK ON i.MAMH = DK.MAMH
        WHERE NOT EXISTS (
            SELECT * FROM GIANGDAY GD
            WHERE GD.MALOP = i.MALOP
              AND GD.MAMH = DK.MAMH_TRUOC
              AND (GD.NAM < i.NAM 
                  OR (GD.NAM = i.NAM AND GD.HOCKY < i.HOCKY)
                  OR (GD.NAM = i.NAM AND GD.HOCKY = i.HOCKY AND GD.DENNGAY < i.TUNGAY)
              )
        )
    )
    BEGIN
        RAISERROR('Phải dạy môn học tiên quyết trước khi dạy môn học này', 16, 1)
        ROLLBACK TRANSACTION
    END
END

-- 24. Giáo viên chỉ được phân công dạy những môn thuộc khoa giáo viên đó phụ trách
CREATE TRIGGER TRG_PHAN_CONG_DAY
ON GIANGDAY
AFTER INSERT, UPDATE
AS
BEGIN
    IF EXISTS (
        SELECT * FROM inserted i
        JOIN GIAOVIEN GV ON i.MAGV = GV.MAGV
        JOIN MONHOC MH ON i.MAMH = MH.MAMH
        WHERE GV.MAKHOA <> MH.MAKHOA
    )
    BEGIN
        RAISERROR('Giáo viên chỉ được phân công dạy những môn thuộc khoa giáo viên đó phụ trách', 16, 1)
        ROLLBACK TRANSACTION
    END
END

```

### 2. Ngôn ngữ thao tác dữ liệu (Data Manipulation Language)

1. Tăng hệ số lương thêm 0.2 cho những giáo viên là trưởng khoa.
2. Cập nhật giá trị điểm trung bình tất cả các môn học (DIEMTB) của mỗi học viên (tất cả các
môn học đều có hệ số 1 và nếu học viên thi một môn nhiều lần, chỉ lấy điểm của lần thi sau
cùng).
3. Cập nhật giá trị cho cột GHICHU là “Cam thi” đối với trường hợp: học viên có một môn bất
kỳ thi lần thứ 3 dưới 5 điểm.
4. Cập nhật giá trị cho cột XEPLOAI trong quan hệ HOCVIEN như sau:
+ Nếu DIEMTB >= 9 thì XEPLOAI =”XS”
+  Nếu 8 <= DIEMTB < 9 thì XEPLOAI = “G”
+  Nếu 6.5 <= DIEMTB < 8 thì XEPLOAI = “K”
+  Nếu 5 <= DIEMTB < 6.5 thì XEPLOAI = “TB”
+  Nếu DIEMTB < 5 thì XEPLOAI = ”Y”


```sql

-- 1. Tăng hệ số lương thêm 0.2 cho những giáo viên là trưởng khoa
UPDATE GIAOVIEN
SET HESO = HESO + 0.2
WHERE MAGV IN (SELECT TRGKHOA FROM KHOA WHERE TRGKHOA IS NOT NULL);

-- 2. Cập nhật giá trị điểm trung bình tất cả các môn học của mỗi học viên
UPDATE HOCVIEN
SET DIEMTB = (
    SELECT AVG(DIEM)
    FROM KETQUATHI KQ
    WHERE KQ.MAHV = HOCVIEN.MAHV
    AND KQ.LANTHI = (
        SELECT MAX(LANTHI)
        FROM KETQUATHI
        WHERE MAHV = KQ.MAHV AND MAMH = KQ.MAMH
    )
);

-- 3. Cập nhật giá trị cho cột GHICHU là "Cam thi" đối với học viên có môn thi lần 3 dưới 5 điểm
UPDATE HOCVIEN
SET GHICHU = 'Cam thi'
WHERE MAHV IN (
    SELECT MAHV
    FROM KETQUATHI
    WHERE LANTHI = 3 AND DIEM < 5
);

-- 4. Cập nhật giá trị cho cột XEPLOAI
UPDATE HOCVIEN
SET XEPLOAI = 
    CASE
        WHEN DIEMTB >= 9 THEN 'XS'
        WHEN DIEMTB >= 8 AND DIEMTB < 9 THEN 'G'
        WHEN DIEMTB >= 6.5 AND DIEMTB < 8 THEN 'K'
        WHEN DIEMTB >= 5 AND DIEMTB < 6.5 THEN 'TB'
        WHEN DIEMTB < 5 THEN 'Y'
    END;

```

### 3. Ngôn ngữ truy vấn dữ liệu có cấu trúc

1. In ra danh sách (mã học viên, họ tên, ngày sinh, mã lớp) lớp trưởng của các lớp.
!![](assets/images/obsidian/Pasted image 20250331214328.png)

2. In ra bảng điểm khi thi (mã học viên, họ tên , lần thi, điểm số) môn CTRR của lớp “K12”,
sắp xếp theo tên, họ học viên.
Thay thế bằng môn CSDL
!![](assets/images/obsidian/Pasted image 20250419101205.png)

3. In ra danh sách những học viên (mã học viên, họ tên) và những môn học mà học viên đó thi
lần thứ nhất đã đạt.
!![](assets/images/obsidian/Pasted image 20250331214407.png)
4. In ra danh sách học viên (mã học viên, họ tên) của lớp “K11” thi môn CTRR không đạt (ở
lần thi 1).
Thay thế bằng môn CSDL
!![](assets/images/obsidian/Pasted image 20250419101253.png)
5. * Danh sách học viên (mã học viên, họ tên) của lớp “K” thi môn CTRR không đạt (ở tất cả
các lần thi).
!![](assets/images/obsidian/Pasted image 20250419101604.png)
6. Tìm tên những môn học mà giáo viên có tên “Tran Tam Thanh” dạy trong học kỳ 1 năm
2006.
!![](assets/images/obsidian/Pasted image 20250331214505.png)
7. Tìm những môn học (mã môn học, tên môn học) mà giáo viên chủ nhiệm lớp “K11” dạy
trong học kỳ 1 năm 2006.
!![](assets/images/obsidian/Pasted image 20250331214940.png)
8. Tìm họ tên lớp trưởng của các lớp mà giáo viên có tên “Nguyen To Lan” dạy môn “Co So
Du Lieu”.
!![](assets/images/obsidian/Pasted image 20250331214956.png)
9. In ra danh sách những môn học (mã môn học, tên môn học) phải học liền trước môn “Co So
Du Lieu”.
!![](assets/images/obsidian/Pasted image 20250331215008.png)

10. Môn “Cau Truc Roi Rac” là môn bắt buộc phải học liền trước những môn học (mã môn học,
tên môn học) nào.
!![](assets/images/obsidian/Pasted image 20250331215059.png)
11. Tìm họ tên giáo viên dạy môn CTRR cho cả hai lớp “K11” và “K12” trong cùng học kỳ 1
năm 2006
!![](assets/images/obsidian/Pasted image 20250401211513.png)
12. Tìm những học viên (mã học viên, họ tên) thi không đạt môn CSDL ở lần thi thứ 1 nhưng
chưa thi lại môn này.
!![](assets/images/obsidian/Pasted image 20250401212026.png)
13. Tìm giáo viên (mã giáo viên, họ tên) không được phân công giảng dạy bất kỳ môn học nào.
!![](assets/images/obsidian/Pasted image 20250401221747.png)
14. Tìm giáo viên (mã giáo viên, họ tên) không được phân công giảng dạy bất kỳ môn học nào
thuộc khoa giáo viên đó phụ trách.
!![](assets/images/obsidian/Pasted image 20250401221857.png)
15. Tìm họ tên các học viên thuộc lớp “K11” thi một môn bất kỳ quá 3 lần vẫn “Khong dat”
hoặc thi lần thứ 2 môn CTRR được 5 điểm.
!![](assets/images/obsidian/Pasted image 20250419102232.png)
16. Tìm họ tên giáo viên dạy môn CTRR cho ít nhất hai lớp trong cùng một học kỳ của một năm
học.
!![](assets/images/obsidian/Pasted image 20250419102657.png)
17. Danh sách học viên và điểm thi môn CSDL (chỉ lấy điểm của lần thi sau cùng).
!![](assets/images/obsidian/Pasted image 20250419103150.png)
18. Danh sách học viên và điểm thi môn “Co So Du Lieu” (chỉ lấy điểm cao nhất của các lần
thi).
!![](assets/images/obsidian/Pasted image 20250419103324.png)
19. Khoa nào (mã khoa, tên khoa) được thành lập sớm nhất.
!![](assets/images/obsidian/Pasted image 20250401222030.png)
20. Có bao nhiêu giáo viên có học hàm là “GS” hoặc “PGS”.
!![](assets/images/obsidian/Pasted image 20250401222100.png)
21. Thống kê có bao nhiêu giáo viên có học vị là “CN”, “KS”, “Ths”, “TS”, “PTS” trong mỗi
khoa.
!![](assets/images/obsidian/Pasted image 20250419103418.png)
22. Mỗi môn học thống kê số lượng học viên theo kết quả (đạt và không đạt).
!![](assets/images/obsidian/Pasted image 20250419103524.png)
23. Tìm giáo viên (mã giáo viên, họ tên) là giáo viên chủ nhiệm của một lớp, đồng thời dạy cho
lớp đó ít nhất một môn học.
!![](assets/images/obsidian/Pasted image 20250419103716.png)
24. Tìm họ tên lớp trưởng của lớp có sỉ số cao nhất.
!![](assets/images/obsidian/Pasted image 20250401222247.png)
25. * Tìm họ tên những LOPTRG thi không đạt quá 3 môn (mỗi môn đều thi không đạt ở tất cả
các lần thi).
!![](assets/images/obsidian/Pasted image 20250419103734.png)
26. Tìm học viên (mã học viên, họ tên) có số môn đạt điểm 9,10 nhiều nhất.
!![](assets/images/obsidian/Pasted image 20250419103751.png)
27. Trong từng lớp, tìm học viên (mã học viên, họ tên) có số môn đạt điểm 9,10 nhiều nhất.
!![](assets/images/obsidian/Pasted image 20250419103806.png)
28. Trong từng học kỳ của từng năm, mỗi giáo viên phân công dạy bao nhiêu môn học, bao
nhiêu lớp.
!![](assets/images/obsidian/Pasted image 20250419103816.png)
29. Trong từng học kỳ của từng năm, tìm giáo viên (mã giáo viên, họ tên) giảng dạy nhiều nhất.
!![](assets/images/obsidian/Pasted image 20250419103912.png)
30. Tìm môn học (mã môn học, tên môn học) có nhiều học viên thi không đạt (ở lần thi thứ 1)
nhất.
!![](assets/images/obsidian/Pasted image 20250419104019.png)
31. Tìm học viên (mã học viên, họ tên) thi môn nào cũng đạt (chỉ xét lần thi thứ 1).
!![](assets/images/obsidian/Pasted image 20250419104031.png)
32. * Tìm học viên (mã học viên, họ tên) thi môn nào cũng đạt (chỉ xét lần thi sau cùng).
!![](assets/images/obsidian/Pasted image 20250419105608.png)
33. * Tìm học viên (mã học viên, họ tên) đã thi tất cả các môn đều đạt (chỉ xét lần thi thứ 1).
!![](assets/images/obsidian/Pasted image 20250419105624.png)
34. * Tìm học viên (mã học viên, họ tên) đã thi tất cả các môn đều đạt (chỉ xét lần thi sau cùng).
!![](assets/images/obsidian/Pasted image 20250419105640.png)
35. ** Tìm học viên (mã học viên, họ tên) có điểm thi cao nhất trong từng môn (lấy điểm ở lần
thi sau cùng).
!![](assets/images/obsidian/Pasted image 20250419105655.png)

## Bài tập 3. Các câu hỏi Store procedure cuối chương 3

1. Nhập vào MAKH,HOTEN,… kiểm tra xem đã tồn tại chưa, nếu có hãy thông báo lỗi, nếu không hãy thêm thông tin đó.

```sql

CREATE PROCEDURE sp_ThemKhachHang (
    @MAKH VARCHAR(10), -- Điều chỉnh kiểu dữ liệu và độ dài nếu cần
    @HOTEN NVARCHAR(50),
    @DCHI NVARCHAR(100),
    @SODT VARCHAR(15),
    @NGSINH DATE,
    @NGDK DATE,
    @DOANHSO MONEY -- Thêm các tham số khác tương ứng với các cột trong bảng KHACHHANG
)
AS
BEGIN
    -- Kiểm tra xem MAKH đã tồn tại chưa
    IF EXISTS (SELECT 1 FROM KHACHHANG WHERE MAKH = @MAKH)
    BEGIN
        -- Nếu tồn tại, thông báo lỗi
        PRINT N'Lỗi: Mã khách hàng ' + @MAKH + N' đã tồn tại trong hệ thống.'
        RETURN -- Kết thúc procedure
    END

    -- Nếu chưa tồn tại, thêm thông tin khách hàng mới
    INSERT INTO KHACHHANG (MAKH, HOTEN, DCHI, SODT, NGSINH, NGDK, DOANHSO) -- Thêm các cột khác vào đây
    VALUES (@MAKH, @HOTEN, @DCHI, @SODT, @NGSINH, @NGDK, @DOANHSO); -- Thêm các giá trị tham số tương ứng

    PRINT N'Đã thêm thành công khách hàng có mã: ' + @MAKH;
END;
GO

-- Ví dụ cách gọi procedure:
-- EXEC sp_ThemKhachHang 'KH01', N'Nguyễn Văn A', N'123 Đường ABC', '0909123456', '1990-01-15', '2024-01-01', 0;
-- EXEC sp_ThemKhachHang 'KH01', N'Trần Thị B', N'456 Đường XYZ', '0987654321', '1995-05-20', '2024-02-10', 0; -- Sẽ báo lỗi nếu KH01 đã tồn tại

```

!![](assets/images/obsidian/Pasted image 20250419134235.png)

2. Nhập SOHD, NGHD,… kiểm tra xem hóa đơn này tồn tại chưa, nếu tồn tại thì thông báo lỗi; kiểm tra mã KH, mã NV nếu không có thì thông báo lỗi; nếu đúng hết các điều kiện khóa chính, khóa ngoại thì hãy thêm thông tin vào bảng HOADON.

```sql

CREATE PROCEDURE sp_ThemHoaDon (
    @SOHD INT, -- Hoặc VARCHAR tùy theo thiết kế của bạn
    @NGHD DATE,
    @MAKH VARCHAR(10), -- Điều chỉnh kiểu dữ liệu và độ dài nếu cần
    @MANV VARCHAR(10), -- Điều chỉnh kiểu dữ liệu và độ dài nếu cần
    @TRIGIA MONEY
    -- Thêm các tham số khác nếu cần
)
AS
BEGIN
    -- 1. Kiểm tra xem SOHD đã tồn tại chưa
    IF EXISTS (SELECT 1 FROM HOADON WHERE SOHD = @SOHD)
    BEGIN
        PRINT N'Lỗi: Số hóa đơn ' + CAST(@SOHD AS VARCHAR) + N' đã tồn tại.'
        RETURN
    END

    -- 2. Kiểm tra xem MAKH có tồn tại trong bảng KHACHHANG không
    IF NOT EXISTS (SELECT 1 FROM KHACHHANG WHERE MAKH = @MAKH)
    BEGIN
        PRINT N'Lỗi: Mã khách hàng ' + @MAKH + N' không tồn tại.'
        RETURN
    END

    -- 3. Kiểm tra xem MANV có tồn tại trong bảng NHANVIEN không
    IF NOT EXISTS (SELECT 1 FROM NHANVIEN WHERE MANV = @MANV)
    BEGIN
        PRINT N'Lỗi: Mã nhân viên ' + @MANV + N' không tồn tại.'
        RETURN
    END

    -- Nếu tất cả kiểm tra đều hợp lệ, thêm hóa đơn mới
    INSERT INTO HOADON (SOHD, NGHD, MAKH, MANV, TRIGIA) -- Thêm các cột khác nếu có
    VALUES (@SOHD, @NGHD, @MAKH, @MANV, @TRIGIA); -- Thêm các giá trị tham số tương ứng

    PRINT N'Đã thêm thành công hóa đơn có số: ' + CAST(@SOHD AS VARCHAR);
END;
GO

-- Ví dụ cách gọi procedure:
-- EXEC sp_ThemHoaDon 1001, '2024-04-19', 'KH01', 'NV01', 500000;
-- EXEC sp_ThemHoaDon 1002, '2024-04-20', 'KH99', 'NV01', 200000; -- Sẽ báo lỗi nếu KH99 không tồn tại
-- EXEC sp_ThemHoaDon 1001, '2024-04-21', 'KH01', 'NV01', 100000; -- Sẽ báo lỗi nếu SOHD 1001 đã tồn tại

```

!![](assets/images/obsidian/Pasted image 20250419134414.png)
!![](assets/images/obsidian/Pasted image 20250419134719.png)

3. Nhập vào MASP, hãy cho biết sản phẩm này được bán trong bao nhiêu hóa đơn rồi.

```sql

CREATE PROCEDURE sp_DemSoHoaDonChoSanPham (
    @MASP VARCHAR(10) -- Điều chỉnh kiểu dữ liệu và độ dài nếu cần
)
AS
BEGIN
    DECLARE @SoLuongHD INT;

    -- Kiểm tra xem MASP có tồn tại không (tùy chọn)
    IF NOT EXISTS (SELECT 1 FROM SANPHAM WHERE MASP = @MASP)
    BEGIN
        PRINT N'Lỗi: Mã sản phẩm ' + @MASP + N' không tồn tại.'
        RETURN
    END

    -- Đếm số lượng hóa đơn (SOHD) phân biệt có chứa MASP này
    SELECT @SoLuongHD = COUNT(DISTINCT SOHD)
    FROM CTHD
    WHERE MASP = @MASP;

    -- In kết quả
    PRINT N'Sản phẩm ' + @MASP + N' đã được bán trong ' + CAST(@SoLuongHD AS VARCHAR) + N' hóa đơn.';

    -- Hoặc trả về kết quả để ứng dụng khác sử dụng
    -- SELECT @SoLuongHD AS SoLuongHoaDon;
END;
GO

-- Ví dụ cách gọi procedure:
-- EXEC sp_DemSoHoaDonChoSanPham 'SP01';
-- EXEC sp_DemSoHoaDonChoSanPham 'SP99'; -- Sẽ báo lỗi nếu SP99 không tồn tại (nếu có kiểm tra)

```

!![](assets/images/obsidian/Pasted image 20250419135106.png)
!![](assets/images/obsidian/Pasted image 20250419135213.png)

4. Hãy thêm thông tin khách hàng mới là họ tên của bạn, những thông tin khác tùy ý, thêm dữ liệu cho các bảng HOADON, CTHD tương ứng. Sau đó viết procedure: Nhập vào MAKH (cái bạn vừa thêm) kiểm tra xem có tồn tại thì xóa thông tin khách hàng đó và những dữ liệu liên quan, nếu không thì thông báo không có thông tin để xóa.

**Bước 1: Thêm dữ liệu mẫu**

```sql

-- Ví dụ thêm khách hàng (thay 'KH_BAN' và thông tin bằng của bạn)
INSERT INTO KHACHHANG (MAKH, HOTEN, DCHI, SODT, NGSINH, NGDK, DOANHSO)
VALUES ('KH_BAN', N'Tên Của Bạn', N'Địa chỉ của bạn', '0123456789', '2000-01-01', GETDATE(), 0);

-- Ví dụ thêm hóa đơn cho khách hàng đó (giả sử SOHD=9999, MANV='NV01' tồn tại)
INSERT INTO HOADON (SOHD, NGHD, MAKH, MANV, TRIGIA)
VALUES (9999, GETDATE(), 'KH_BAN', 'NV01', 150000);

-- Ví dụ thêm chi tiết hóa đơn (giả sử MASP='SP01' tồn tại)
INSERT INTO CTHD (SOHD, MASP, SL)
VALUES (9999, 'SP01', 3);

```

!![](assets/images/obsidian/Pasted image 20250419135932.png)
Thêm khách hàng KH21
!![](assets/images/obsidian/Pasted image 20250419135953.png)
Thêm hoá đơn 9999
!![](assets/images/obsidian/Pasted image 20250419140046.png)
Thêm CTHD
!![](assets/images/obsidian/Pasted image 20250419140129.png)

Bước 2: Viết Procedure Xóa Khách Hàng và Dữ liệu liên quan

```sql

CREATE PROCEDURE sp_XoaKhachHangVaDuLieuLienQuan (
    @MAKH_XOA VARCHAR(10) -- Điều chỉnh kiểu dữ liệu và độ dài nếu cần
)
AS
BEGIN
    -- Kiểm tra xem khách hàng có tồn tại không
    IF NOT EXISTS (SELECT 1 FROM KHACHHANG WHERE MAKH = @MAKH_XOA)
    BEGIN
        PRINT N'Thông báo: Không tìm thấy khách hàng với mã ' + @MAKH_XOA + N' để xóa.';
        RETURN
    END

    -- Bắt đầu transaction để đảm bảo xóa toàn bộ hoặc không xóa gì cả
    BEGIN TRANSACTION;

    BEGIN TRY
        -- Xóa các chi tiết hóa đơn liên quan đến các hóa đơn của khách hàng này
        DELETE FROM CTHD
        WHERE SOHD IN (SELECT SOHD FROM HOADON WHERE MAKH = @MAKH_XOA);

        -- Xóa các hóa đơn của khách hàng này
        DELETE FROM HOADON
        WHERE MAKH = @MAKH_XOA;

        -- Xóa khách hàng
        DELETE FROM KHACHHANG
        WHERE MAKH = @MAKH_XOA;

        -- Nếu không có lỗi, commit transaction
        COMMIT TRANSACTION;
        PRINT N'Đã xóa thành công khách hàng ' + @MAKH_XOA + N' và các dữ liệu liên quan.';
    END TRY
    BEGIN CATCH
        -- Nếu có lỗi, rollback transaction
        IF @@TRANCOUNT > 0
            ROLLBACK TRANSACTION;
        PRINT N'Lỗi: Đã xảy ra lỗi trong quá trình xóa. Dữ liệu đã được khôi phục.';
        -- In thông tin lỗi chi tiết (tùy chọn)
        PRINT ERROR_MESSAGE();
    END CATCH
END;
GO

-- Ví dụ cách gọi procedure (dùng mã khách hàng bạn vừa thêm):
-- EXEC sp_XoaKhachHangVaDuLieuLienQuan 'KH_BAN';
-- EXEC sp_XoaKhachHangVaDuLieuLienQuan 'KH_KO_TON_TAI'; -- Sẽ báo không tìm thấy

```

Tạo SP
!![](assets/images/obsidian/Pasted image 20250419140230.png)
Test kết quả
!![](assets/images/obsidian/Pasted image 20250419140727.png)
Đã xoá hoá đơn 9999 của KH21
!![](assets/images/obsidian/Pasted image 20250419140751.png)
Đã xoá chi tiết hoá đơn với hoá đơn 9999
!![](assets/images/obsidian/Pasted image 20250419140911.png)
Đã xoá KH21
!![](assets/images/obsidian/Pasted image 20250419140939.png)
5. Thêm 1 cột số lần mua hàng của khách hàng vào bảng KHACHHANG, bổ sung dữ liệu cột đó bằng procedure.

Bước 1: Thêm cột vào bảng KHACHHANG

```sql

ALTER TABLE KHACHHANG
ADD SoLanMuaHang INT DEFAULT 0; -- Thêm cột mới với giá trị mặc định là 0
GO

```
!![](assets/images/obsidian/Pasted image 20250419141304.png)
!![](assets/images/obsidian/Pasted image 20250419141328.png)
Bước 2: Viết Procedure cập nhật số lần mua hàng

```sql

CREATE PROCEDURE sp_CapNhatSoLanMuaHang
AS
BEGIN
    -- Bắt đầu transaction để đảm bảo cập nhật đồng bộ
    BEGIN TRANSACTION;

    BEGIN TRY
        -- Cập nhật số lần mua hàng cho từng khách hàng
        -- Dựa trên số lượng hóa đơn (SOHD) khác nhau mà khách hàng đó có
        UPDATE KH
        SET KH.SoLanMuaHang = ISNULL(HD_COUNT.SoLuong, 0) -- Dùng ISNULL để gán 0 nếu KH chưa mua hàng
        FROM KHACHHANG KH
        LEFT JOIN (
            SELECT MAKH, COUNT(DISTINCT SOHD) AS SoLuong
            FROM HOADON
            GROUP BY MAKH
        ) AS HD_COUNT ON KH.MAKH = HD_COUNT.MAKH;

        -- Commit transaction nếu thành công
        COMMIT TRANSACTION;
        PRINT N'Đã cập nhật thành công số lần mua hàng cho tất cả khách hàng.';

    END TRY
    BEGIN CATCH
         -- Rollback nếu có lỗi
        IF @@TRANCOUNT > 0
            ROLLBACK TRANSACTION;
        PRINT N'Lỗi: Đã xảy ra lỗi trong quá trình cập nhật số lần mua hàng.';
         -- In thông tin lỗi chi tiết (tùy chọn)
        PRINT ERROR_MESSAGE();
    END CATCH
END;
GO

-- Cách gọi procedure để cập nhật:
-- EXEC sp_CapNhatSoLanMuaHang;

```

!![](assets/images/obsidian/Pasted image 20250419141401.png)
Tạo store procedure để cập nhật số lượng mua hàng của khách hàng
!![](assets/images/obsidian/Pasted image 20250419141525.png)
!![](assets/images/obsidian/Pasted image 20250419141604.png)

6. Các câu trigger làm trong bài tập thực hành CSDL.
Đã làm ở trên phần DDL của bài tập 1 và bài tập 2

---
*Nguồn: Evergreen/concept-base/university/semester01/IE103_information-management/practice/Bài tập chương 3 - Trần Nhật Sang - 24410347.md*