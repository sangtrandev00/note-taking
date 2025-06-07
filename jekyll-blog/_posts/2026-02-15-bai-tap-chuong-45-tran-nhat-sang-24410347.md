---
layout: post
title: "Bài tập chương 4,5 - Trần Nhật Sang - 24410347"
date: 2026-02-15 10:00:00 +0700
categories: concept-base university semester01 IE103_information-management practice
tags: ["mysql", "database", "sql"]
source_path: "Evergreen/concept-base/university/semester01/IE103_information-management/practice/Bài tập chương 4,5 - Trần Nhật Sang - 24410347.md"
---
# Chương 4
## Bài tập 1
### Chọn 1 file dữ liệu (SV) từ excel, và import vào SQLServer 
B1: Tạo 1 file sheet excel của bảng KHACHHANG trong bài tập quản lý bán hàng
!![](assets/images/obsidian/Pasted image 20250419150308.png)

B2: Sử dụng Navicat và import wildcard
Chọn import wizard và chọn Excel file
!![](assets/images/obsidian/Pasted image 20250419150440.png)
Chọn add file
!![](assets/images/obsidian/Pasted image 20250419150514.png)
Import file excel đã tạo sẵn
!![](assets/images/obsidian/Pasted image 20250419150537.png)
Chọn Next và tick chọn file .xslx
!![](assets/images/obsidian/Pasted image 20250419150604.png)
Tiếp tục chọn Next và sau đó chọn import mode: Append
!![](assets/images/obsidian/Pasted image 20250419150637.png)
Chọn Next -> Start -> Finish
!![](assets/images/obsidian/Pasted image 20250419150702.png)
Kiểm tra kết quả
!![](assets/images/obsidian/Pasted image 20250419150718.png)
=> Đã tạo thêm 3 dòng dữ liệu tương ứng với file excel
### Chọn 1 table trong SQL Server, và export tới file Excel.

B1: Chọn bảng muốn xuất. Em chọn bảng SANPHAM
!![](assets/images/obsidian/Pasted image 20250419150814.png)
B2: Click vào bảng cần xuất và chọn Export wizard
!![](assets/images/obsidian/Pasted image 20250419150844.png)
Mặc định chọn tất cả các column cần xuất
!![](assets/images/obsidian/Pasted image 20250419150911.png)
Chọn start
!![](assets/images/obsidian/Pasted image 20250419150934.png)
Kiểm tra kết quả của file excel
!![](assets/images/obsidian/Pasted image 20250419151009.png)
Kết quả dữ liệu xuất khớp với kết quả của bảng SANPHAM trong cơ sở dữ liệu quản lý bán hàng.

## Bài tập 2
### Backup 1 CSDL từ SQL server trên máy tính A vào điã USB, đặt tên a.bak 

```sql

-- Chuyển ngữ cảnh về database master để thực hiện backup
USE master;
GO

-- Thực hiện full backup cho CSDL QLBANHANG
BACKUP DATABASE QLBANHANG
TO DISK = '/var/opt/mssql/backup/a.bak' -- Đường dẫn và tên file backup bên trong container
WITH INIT,                             -- Ghi đè nếu file a.bak đã tồn tại
     NAME = 'QLBANHANG Full Backup',   -- Tên của bản backup set
     DESCRIPTION = 'Full backup CSDL QLBANHANG cho Bai tap 2', -- Mô tả
     STATS = 10;                       -- Hiển thị tiến trình mỗi 10%
GO

```

Kết quả tạo ra file a.bak trong ổ đĩa
!![](assets/images/obsidian/Pasted image 20250419153916.png)

### Hãy restore file a.bak từ USB vào SQLServer trên máy tính B.
Em thay thế bằng trường hợp restore database hiện tại lên 1 cơ sở dữ liệu mới trong cùng 1 connection
B1: Đọc thông tin
```sql
-- Đọc thông tin header của file backup để lấy tên logical các file
RESTORE FILELISTONLY
FROM DISK = '/var/opt/mssql/backup/a.bak';
GO

```

!![](assets/images/obsidian/Pasted image 20250419154607.png)

B2: Tạo lệnh Backup và move đến cơ sở dữ liệu khác

```sql

-- Chuyển ngữ cảnh về database master
USE master;
GO

-- Restore CSDL QLBANHANG từ backup vào một CSDL MỚI tên là QLBANHANG_BACKUP
RESTORE DATABASE QLBANHANG_BACKUP               -- Tên CSDL mới
FROM DISK = '/var/opt/mssql/backup/a.bak'    -- Nguồn backup
WITH
    MOVE 'QLBANHANG' TO '/var/opt/mssql/data/QLBANHANG_BACKUP.mdf', -- Di chuyển file data logical 'QLBANHANG' sang file vật lý mới
    MOVE 'QLBANHANG_log' TO '/var/opt/mssql/data/QLBANHANG_BACKUP_log.ldf', -- Di chuyển file log logical 'QLBANHANG_log' sang file vật lý mới
    NOUNLOAD,
    STATS = 10;
GO

```

!![](assets/images/obsidian/Pasted image 20250419155304.png)

## Bài tập 3

+ Tạo 6 user từ u1 đến u6 
+ Tạo 3 role từ r1 đến r3 
+ Tạo nhóm: u1, u2 thuộc r1; u3, u4 thuộc r2; u5, u6 thuộc r3 
+ Phân quyền cho r1, r2, r3 
	+  R1 thành viên của SysAdmin 
	+  R2 thành viên của db_owner, db_accessadmin 
	+  R3 thành viên của SysAdmin, db_owner, db_accessadmin

**Bước 1: Tạo 6 Logins (từ u1 đến u6)**

Các lệnh này tạo tài khoản đăng nhập ở cấp độ Server. 

```sql
-- Chạy các lệnh này ở ngữ cảnh master hoặc bất kỳ DB nào
-- Tạo Logins với SQL Server Authentication
CREATE LOGIN u1 WITH PASSWORD = 'your_strong_password_here';
CREATE LOGIN u2 WITH PASSWORD = 'your_strong_password_here';
CREATE LOGIN u3 WITH PASSWORD = 'your_strong_password_here';
CREATE LOGIN u4 WITH PASSWORD = 'your_strong_password_here';
CREATE LOGIN u5 WITH PASSWORD = 'your_strong_password_here';
CREATE LOGIN u6 WITH PASSWORD = 'your_strong_password_here';
GO

```

**Bước 2: Tạo 6 Database Users trong CSDL**

```sql

-- Chuyển sang ngữ cảnh CSDL QLBANHANG
USE QLBANHANG;
GO

-- Tạo Database Users tương ứng với Logins
CREATE USER u1 FOR LOGIN u1;
CREATE USER u2 FOR LOGIN u2;
CREATE USER u3 FOR LOGIN u3;
CREATE USER u4 FOR LOGIN u4;
CREATE USER u5 FOR LOGIN u5;
CREATE USER u6 FOR LOGIN u6;
GO

```

**Bước 3: Tạo 3 Database Roles (từ r1 đến r3) trong CSDL `QLBANHANG`

```sql
-- Đảm bảo đang ở ngữ cảnh CSDL QLBANHANG
USE QLBANHANG;
GO

-- Tạo các Database Roles tùy chỉnh
CREATE ROLE r1;
CREATE ROLE r2;
CREATE ROLE r3;
GO

```

**Bước 4: Phân nhóm - Gán Users vào Roles

```sql

-- Đảm bảo đang ở ngữ cảnh CSDL QLBANHANG
USE QLBANHANG;
GO

-- Thêm user vào role r1
ALTER ROLE r1 ADD MEMBER u1;
ALTER ROLE r1 ADD MEMBER u2;

-- Thêm user vào role r2
ALTER ROLE r2 ADD MEMBER u3;
ALTER ROLE r2 ADD MEMBER u4;

-- Thêm user vào role r3
ALTER ROLE r3 ADD MEMBER u5;
ALTER ROLE r3 ADD MEMBER u6;
GO

```

**Bước 5: Phân quyền cho Roles (Gán vào Fixed Roles)

```sql
-- === Phân quyền cho R1 ===
-- Thêm các Logins của thành viên r1 (u1, u2) vào Fixed Server Role 'sysadmin'
-- CẢNH BÁO: Cấp quyền này cho phép kiểm soát toàn bộ SQL Server Instance!
ALTER SERVER ROLE sysadmin ADD MEMBER u1;
ALTER SERVER ROLE sysadmin ADD MEMBER u2;
GO

-- === Phân quyền cho R2 ===
-- Thêm Database Role 'r2' làm thành viên của Fixed Database Roles 'db_owner' và 'db_accessadmin' trong CSDL QLBANHANG
USE QLBANHANG;
GO
ALTER ROLE db_owner ADD MEMBER r2;
ALTER ROLE db_accessadmin ADD MEMBER r2;
GO

-- === Phân quyền cho R3 ===
-- Thêm các Logins của thành viên r3 (u5, u6) vào Fixed Server Role 'sysadmin'
-- CẢNH BÁO: Cấp quyền này cho phép kiểm soát toàn bộ SQL Server Instance!
ALTER SERVER ROLE sysadmin ADD MEMBER u5;
ALTER SERVER ROLE sysadmin ADD MEMBER u6;
GO
-- Thêm Database Role 'r3' làm thành viên của Fixed Database Roles 'db_owner' và 'db_accessadmin' trong CSDL QLBANHANG
USE QLBANHANG;
GO
ALTER ROLE db_owner ADD MEMBER r3;
ALTER ROLE db_accessadmin ADD MEMBER r3;
GO

PRINT 'Đã hoàn thành Bài tập 3!';

```

Kết quả của từng User sau khi phân quyền
u1
!![](assets/images/obsidian/Pasted image 20250419162416.png)
u2
!![](assets/images/obsidian/Pasted image 20250419162444.png)
u3
!![](assets/images/obsidian/Pasted image 20250419162454.png)
u4
!![](assets/images/obsidian/Pasted image 20250419162505.png)
u5
!![](assets/images/obsidian/Pasted image 20250419162516.png)
u6
!![](assets/images/obsidian/Pasted image 20250419162526.png)
## Bài tập 4

+ Tập làm các phát biểu grant, deny, revoke trên một CSDL gồm các table 1, T2, T3. . .đã biết 
+ U1 có quyền select, delete trên T1, T3 
+ U2 có quyền update, delete trên T2 
+ U3 có quyền insert trên T1, T2, T3 
+ U1 bị từ chối quyền insert trên T1, T2

**B1: Tạo bảng và User

```sql

-- Chọn CSDL bạn muốn thực hành (ví dụ: QLBANHANG)
USE QLBANHANG;
GO

-- === TẠO BẢNG MẪU (Nếu chưa có) ===
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[T1]') AND type in (N'U'))
CREATE TABLE T1 (id INT PRIMARY KEY, data VARCHAR(10));
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[T2]') AND type in (N'U'))
CREATE TABLE T2 (id INT PRIMARY KEY, data VARCHAR(10));
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[T3]') AND type in (N'U'))
CREATE TABLE T3 (id INT PRIMARY KEY, data VARCHAR(10));
PRINT 'Đã tạo/xác nhận tồn tại các bảng T1, T2, T3.';
GO

-- === TẠO LOGINS VÀ USERS MẪU (Nếu chưa có - Giả sử dùng SQL Authentication) ===
-- Tạo Logins ở cấp Server
IF NOT EXISTS (SELECT * FROM sys.server_principals WHERE name = 'U1')
CREATE LOGIN U1 WITH PASSWORD = 'Trannhatsang**'; -- Thay mật khẩu mạnh
IF NOT EXISTS (SELECT * FROM sys.server_principals WHERE name = 'U2')
CREATE LOGIN U2 WITH PASSWORD = 'Trannhatsang**'; -- Thay mật khẩu mạnh
IF NOT EXISTS (SELECT * FROM sys.server_principals WHERE name = 'U3')
CREATE LOGIN U3 WITH PASSWORD = 'Trannhatsang**'; -- Thay mật khẩu mạnh
GO

-- Tạo Database Users trong CSDL hiện tại
IF NOT EXISTS (SELECT * FROM sys.database_principals WHERE name = 'U1')
CREATE USER U1 FOR LOGIN U1;
IF NOT EXISTS (SELECT * FROM sys.database_principals WHERE name = 'U2')
CREATE USER U2 FOR LOGIN U2;
IF NOT EXISTS (SELECT * FROM sys.database_principals WHERE name = 'U3')
CREATE USER U3 FOR LOGIN U3;
PRINT 'Đã tạo/xác nhận tồn tại users U1, U2, U3.';
GO

```

**B2: Thực hiện các lệnh phân quyền

```sql
-- Đảm bảo đang ở đúng CSDL
USE QLBANHANG; -- Hoặc CSDL thực hành của bạn
GO

-- === Yêu cầu 1: U1 có quyền SELECT, DELETE trên T1, T3 ===
GRANT SELECT, DELETE ON dbo.T1 TO U1;
GRANT SELECT, DELETE ON dbo.T3 TO U1;
PRINT 'Cấp quyền SELECT, DELETE trên T1, T3 cho U1.';
GO

-- === Yêu cầu 2: U2 có quyền UPDATE, DELETE trên T2 ===
GRANT UPDATE, DELETE ON dbo.T2 TO U2;
PRINT 'Cấp quyền UPDATE, DELETE trên T2 cho U2.';
GO

-- === Yêu cầu 3: U3 có quyền INSERT trên T1, T2, T3 ===
GRANT INSERT ON dbo.T1 TO U3;
GRANT INSERT ON dbo.T2 TO U3;
GRANT INSERT ON dbo.T3 TO U3;
PRINT 'Cấp quyền INSERT trên T1, T2, T3 cho U3.';
GO

-- === Yêu cầu 4: U1 bị từ chối (DENY) quyền INSERT trên T1, T2 ===
DENY INSERT ON dbo.T1 TO U1;
DENY INSERT ON dbo.T2 TO U1;
PRINT 'Từ chối (DENY) quyền INSERT trên T1, T2 đối với U1.';
GO

PRINT 'Hoàn thành các yêu cầu phân quyền của Bài tập 4.';

```

# Chương 5

─ BÀI 1: Tìm thêm các ví dụ về các loại menu. 

─ BÀI 2: Thiết kế Form cho sinh viên khai báo lý lịch sinh viên. 

─ BÀI 3: Thiết kế report trả về Điểm trung bình của sinh viên trong 1 lớp. 
Yêu cầu: 
Mô tả rõ có bao nhiêu thuộc tính cần hiển thị. 
Thiết kế report bao gồm đầy đủ các thành phần. 
Viết truy vấn lấy dữ liệu cho report.

## **BÀI 1: Tìm thêm các ví dụ về các loại menu.**

Ngoài các loại menu cơ bản được đề cập trong slide (Pull-down, Pop-up, Cascading), có rất nhiều kiểu menu khác được sử dụng trong các ứng dụng và website hiện nay:

1. **Menu Ngang (Horizontal Menu / Navigation Bar):** Thường nằm ở đầu trang web hoặc ứng dụng, chứa các mục chính để điều hướng (Trang chủ, Giới thiệu, Sản phẩm, Liên hệ...). Các mục có thể có menu con thả xuống (Dropdown Menu).
    - _Ví dụ:_ Menu chính của hầu hết các trang web tin tức, thương mại điện tử.
2. **Menu Dọc (Vertical Menu / Sidebar Menu):** Thường nằm bên trái hoặc phải màn hình, đặc biệt phổ biến trong các ứng dụng quản trị (dashboards), nơi có nhiều chức năng cần truy cập. Có thể cố định hoặc ẩn/hiện.
    - _Ví dụ:_ Menu điều hướng trong Gmail, Facebook (phiên bản desktop), các trang quản trị hệ thống.
3. **Menu Hamburger:** Biểu tượng 3 dấu gạch ngang, khi nhấp vào sẽ hiển thị menu đầy đủ (thường là menu dọc). Rất phổ biến trên thiết kế web đáp ứng (responsive) cho màn hình nhỏ và ứng dụng di động.
    - _Ví dụ:_ Hầu hết các website trên trình duyệt di động, nhiều ứng dụng di động.
4. **Menu Ngữ cảnh (Context Menu / Right-click Menu):** Xuất hiện khi người dùng nhấp chuột phải vào một đối tượng (văn bản, file, ảnh,...), chứa các lệnh liên quan trực tiếp đến đối tượng đó.
    - _Ví dụ:_ Menu khi nhấp chuột phải trên desktop Windows/macOS, trong trình soạn thảo văn bản.
5. **Menu Ribbon:** Dải menu rộng, nhóm các lệnh theo chức năng vào các tab, mỗi tab lại có các nhóm lệnh với biểu tượng và chữ mô tả.
    - _Ví dụ:_ Bộ ứng dụng Microsoft Office (Word, Excel, PowerPoint).
6. **Menu Mega:** Là menu thả xuống (dropdown) lớn, hiển thị nhiều lựa chọn được tổ chức thành các nhóm, cột, đôi khi có cả biểu tượng hoặc hình ảnh. Thường dùng cho các trang web có cấu trúc phức tạp, nhiều danh mục.
    - _Ví dụ:_ Menu danh mục sản phẩm trên các trang thương mại điện tử lớn như Tiki, Lazada.
7. **Menu Tab (Tab Bar):** Thường nằm ở cuối màn hình ứng dụng di động, cho phép chuyển đổi nhanh giữa các màn hình/chức năng chính.
    - _Ví dụ:_ Menu dưới cùng của ứng dụng Facebook, Instagram, Zalo trên điện thoại.
8. **Menu Chấm (Kebab Menu - 3 chấm dọc / Meatball Menu - 3 chấm ngang):** Biểu tượng gồm 3 dấu chấm, khi nhấp vào sẽ hiển thị thêm các tùy chọn ít được sử dụng hơn hoặc liên quan đến mục chứa nó.
    - _Ví dụ:_ Menu tùy chọn cho từng bài post trên Facebook, menu cài đặt trong trình duyệt Chrome.
9. **Menu Bánh xe (Radial Menu / Pie Menu):** Các mục menu được sắp xếp thành hình tròn hoặc cung tròn xung quanh con trỏ chuột hoặc điểm chạm. Ít phổ biến hơn nhưng đôi khi dùng trong game hoặc ứng dụng đồ họa.

## **BÀI 2: Thiết kế Form cho sinh viên khai báo lý lịch sinh viên.**

Form này dùng để thu thập thông tin cá nhân, học vấn và liên lạc cơ bản của sinh viên.

### **1. Các thuộc tính/trường thông tin cần hiển thị (và thu thập):**

- **Thông tin cá nhân:**
    - Mã số sinh viên (MSSV): `TextBox` (Có thể chỉ đọc nếu hệ thống tự cấp) - _Bắt buộc_
    - Họ và tên: `TextBox` - _Bắt buộc_
    - Ngày sinh: `DatePicker` - _Bắt buộc_
    - Giới tính: `RadioButton` (Nam/Nữ/Khác) hoặc `ComboBox` - _Bắt buộc_
    - Nơi sinh (Tỉnh/Thành phố): `ComboBox` (chọn từ danh sách) hoặc `TextBox`
    - Quê quán (Tỉnh/Thành phố): `ComboBox` (chọn từ danh sách) hoặc `TextBox`
    - Dân tộc: `ComboBox` (chọn từ danh sách) - _Bắt buộc_
    - Tôn giáo: `ComboBox` (chọn từ danh sách) hoặc `TextBox`
    - Số CMND/CCCD: `TextBox` - _Bắt buộc_
    - Ngày cấp CMND/CCCD: `DatePicker`
    - Nơi cấp CMND/CCCD: `TextBox`
- **Thông tin liên lạc:**
    - Địa chỉ thường trú: `TextBox` (dài) - _Bắt buộc_
    - Địa chỉ liên lạc (nếu khác thường trú): `TextBox` (dài)
    - Số điện thoại: `TextBox` - _Bắt buộc_
    - Email: `TextBox` (có kiểm tra định dạng) - _Bắt buộc_
- **Thông tin học vấn:**
    - Lớp: `ComboBox` (chọn từ danh sách lớp thuộc khoa/ngành) - _Bắt buộc_
    - Khoa: `ComboBox` (chọn từ danh sách) - _Bắt buộc_
    - Ngành học: `ComboBox` (chọn từ danh sách) - _Bắt buộc_
    - Niên khóa: `TextBox` (Ví dụ: 2022-2026) - _Bắt buộc_
    - Hệ đào tạo: `ComboBox` (Chính quy, Tại chức,...) - _Bắt buộc_
- **Thông tin khác (Tùy chọn):**
    - Đối tượng ưu tiên (nếu có): `ComboBox` hoặc `Checkbox list`
    - Ảnh thẻ (3x4): `FileUpload` control
    - Thông tin gia đình (Họ tên, năm sinh, nghề nghiệp Cha/Mẹ - có thể tách ra form khác hoặc phần riêng)
    - Thông tin Đoàn/Đảng viên.

### **2. Thiết kế Form (Mô tả Layout & Thành phần):**

- **Tiêu đề Form:** "Phiếu Khai Báo Lý Lịch Sinh Viên" hoặc "Cập Nhật Thông Tin Cá Nhân".
- **Bố cục (Layout):**
    - Chia form thành các khu vực (sections) rõ ràng bằng cách sử dụng `GroupBox` hoặc đường kẻ ngang/khoảng trắng lớn: "Thông tin cá nhân", "Thông tin liên lạc", "Thông tin học vấn", "Thông tin khác".
    - Trong mỗi khu vực, sắp xếp các trường theo logic từ trên xuống dưới, từ trái qua phải.
    - Căn chỉnh (Alignment): Nhãn (Label) của các trường nên được căn lề trái hoặc đặt phía trên trường nhập liệu một cách nhất quán. Các ô nhập liệu (TextBox, ComboBox) nên có chiều rộng phù hợp và căn chỉnh thẳng hàng.
- **Nhãn (Labels):** Rõ ràng, ngắn gọn, đặt cạnh hoặc phía trên ô nhập liệu tương ứng. Có dấu * để chỉ các trường bắt buộc nhập.
- **Điều khiển nhập liệu (Controls):** Sử dụng các control phù hợp như đã liệt kê ở trên (TextBox, ComboBox, DatePicker, RadioButton, FileUpload...).
- **Nút bấm (Buttons):** Đặt ở cuối form, thường gồm các nút như "Lưu thông tin", "Cập nhật", "Đặt lại" (Reset/Clear Form), "Hủy".
- **Hướng dẫn/Chú thích:** Có thể thêm các hướng dẫn ngắn gọn nếu cần (ví dụ: định dạng email, yêu cầu về ảnh thẻ).
- **Validation (Kiểm tra dữ liệu nhập):** Cần có kiểm tra cơ bản phía client (ví dụ: trường bắt buộc không được trống, email đúng định dạng, số điện thoại đúng định dạng cơ bản) và kiểm tra kỹ hơn phía server. Thông báo lỗi rõ ràng nếu người dùng nhập sai.

## **BÀI 3: Thiết kế report trả về Điểm trung bình của sinh viên trong 1 lớp.**

### **1. Mô tả thuộc tính cần hiển thị:**

Report này cần hiển thị danh sách sinh viên của một lớp cụ thể cùng với điểm trung bình tích lũy (GPA hoặc ĐTBTL) của họ. Các thuộc tính chính cần hiển thị cho mỗi sinh viên là:

1. **Số thứ tự (STT):** Đánh số thứ tự các sinh viên trong danh sách.
2. **Mã số sinh viên (MSSV):** Mã định danh duy nhất của sinh viên.
3. **Họ và tên:** Tên đầy đủ của sinh viên.
4. **Điểm trung bình tích lũy (ĐTBTL):** Điểm số trung bình tính theo trọng số tín chỉ của các môn học sinh viên đã có điểm (thường tính theo hệ 10 hoặc hệ 4).

=> Vậy, report cần hiển thị **4 thuộc tính** dữ liệu chính cho mỗi dòng (mỗi sinh viên). Ngoài ra còn có các thông tin chung của report.

### **2. Thiết kế report (Bao gồm đầy đủ các thành phần):**

- **Tham số đầu vào (Parameter):**
    - `MaLop` (Mã lớp) hoặc `TenLop` (Tên lớp): Người dùng cần chọn hoặc nhập lớp muốn xem báo cáo.
- **Report Header (Tiêu đề báo cáo):**
    - Tên trường/Khoa (Ví dụ: TRƯỜNG ĐẠI HỌC XYZ - KHOA CÔNG NGHỆ THÔNG TIN)
    - Tên báo cáo: "BÁO CÁO ĐIỂM TRUNG BÌNH TÍCH LŨY SINH VIÊN"
    - Thông tin lớp: "Lớp: [Tên lớp từ tham số]" (Ví dụ: Lớp: DH20IT01)
    - Ngày tạo báo cáo: (Ví dụ: Ngày lập: 19/04/2025)
- **Page Header (Tiêu đề trang):**
    - Có thể lặp lại tên báo cáo hoặc tên lớp.
    - Tiêu đề các cột của bảng dữ liệu: "STT", "MSSV", "Họ và Tên", "ĐTB Tích Lũy (Hệ 10)".
- **Detail Section (Phần chi tiết - lặp lại cho mỗi sinh viên):**
    - Hiển thị dữ liệu tương ứng với các cột đã định nghĩa ở Page Header:
        - Cột STT: Tự động tăng.
        - Cột MSSV: Lấy từ dữ liệu truy vấn.
        - Cột Họ và Tên: Lấy từ dữ liệu truy vấn.
        - Cột ĐTB Tích Lũy (Hệ 10): Kết quả tính toán từ truy vấn, định dạng số thập phân (ví dụ: 2 chữ số sau dấu phẩy).
- **Report Footer (Chân báo cáo):**
    - Thống kê tổng hợp (tùy chọn): Số lượng sinh viên trong lớp, Điểm trung bình chung của cả lớp (tính trung bình của các ĐTBTL).
    - Chữ ký (Người lập báo cáo, Trưởng khoa/Trưởng bộ môn...).
- **Page Footer (Chân trang):**
    - Số trang (Ví dụ: Trang 1 / 5).
### **3. Viết truy vấn lấy dữ liệu cho report:**

Giả sử chúng ta có các bảng sau (tên bảng và cột có thể khác tùy CSDL của bạn):

- `SINHVIEN` (MaSV, HoTen, MaLop)
- `LOP` (MaLop, TenLop)
- `MONHOC` (MaMH, TenMH, SoTinChi)
- `DIEM` (MaSV, MaMH, DiemHe10) _(Lưu ý: `DiemHe10` là điểm tổng kết môn học theo thang 10 và đã tính)_

Truy vấn cần tính điểm trung bình tích lũy theo trọng số tín chỉ cho mỗi sinh viên thuộc lớp được chọn.
```sql

-- Giả sử người dùng chọn lớp có mã là @MaLopInput
-- Ví dụ: DECLARE @MaLopInput VARCHAR(10) = 'DH20IT01';

SELECT
    SV.MaSV,                                  -- Thuộc tính 1: MSSV
    SV.HoTen,                                 -- Thuộc tính 2: Họ Tên
    -- Tính Điểm Trung Bình Tích Lũy (ĐTBTL) theo trọng số tín chỉ
    ISNULL(                                   -- Xử lý trường hợp sinh viên chưa có điểm nào
        SUM(D.DiemHe10 * MH.SoTinChi) / NULLIF(SUM(MH.SoTinChi), 0), -- Tính tổng điểm*tín chỉ / tổng tín chỉ
        0                                     -- Nếu tổng tín chỉ = 0 thì trả về 0
    ) AS DiemTrungBinhTichLuy             -- Thuộc tính 3 (được tính toán): ĐTBTL
FROM
    SINHVIEN AS SV
INNER JOIN -- Chỉ lấy sinh viên thuộc lớp chỉ định
    LOP AS L ON SV.MaLop = L.MaLop
LEFT JOIN  -- Dùng LEFT JOIN để vẫn giữ lại sinh viên dù chưa có điểm môn nào
    DIEM AS D ON SV.MaSV = D.MaSV
LEFT JOIN
    MONHOC AS MH ON D.MaMH = MH.MaMH
WHERE
    L.MaLop = @MaLopInput  -- Lọc theo mã lớp người dùng chọn
    -- Có thể thêm điều kiện lọc điểm hợp lệ nếu cần (ví dụ: điểm > -1)
GROUP BY
    SV.MaSV, SV.HoTen                       -- Nhóm theo từng sinh viên để tính ĐTBTL
ORDER BY
    SV.HoTen;                              -- Sắp xếp theo tên để danh sách dễ nhìn
```


# Bài tập ở File C4-C5

## ## Bài 1: Tìm hiểu SQL Server

### 1.1 Các kiểu dữ liệu (data type) dùng cho các trường (field) và cách sử dụng nó.

SQL Server cung cấp nhiều kiểu dữ liệu, chia thành các nhóm chính:

- **Số chính xác (Exact Numerics):**
    - `INT`: Số nguyên lớn (4 bytes). Dùng cho ID, số đếm,...
    - `BIGINT`: Số nguyên rất lớn (8 bytes).
    - `SMALLINT`: Số nguyên nhỏ (2 bytes).
    - `TINYINT`: Số nguyên rất nhỏ (1 byte, 0 đến 255).
    - `BIT`: Lưu giá trị 0, 1, hoặc NULL. Dùng cho các cờ logic (True/False).
    - `DECIMAL(p, s)`, `NUMERIC(p, s)`: Số thập phân chính xác với `p` tổng số chữ số và `s` số chữ số sau dấu phẩy. Dùng cho tiền tệ, giá trị tài chính.
    - `MONEY`, `SMALLMONEY`: Kiểu tiền tệ (chính xác 4 chữ số thập phân).
- **Số gần đúng (Approximate Numerics):**
    - `FLOAT(n)`: Số thực dấu phẩy động. Dùng cho tính toán khoa học.
    - `REAL`: Tương tự `FLOAT(24)`.
- **Ngày giờ (Date and Time):**
    - `DATE`: Chỉ lưu ngày (YYYY-MM-DD).
    - `TIME`: Chỉ lưu giờ (hh:mm:ss.nnnnnnn).
    - `DATETIME`: Lưu ngày và giờ (độ chính xác thấp hơn).
    - `DATETIME2(n)`: Lưu ngày và giờ (độ chính xác cao hơn, n là số chữ số giây thập phân). **Khuyến nghị dùng thay `DATETIME`**.
    - `SMALLDATETIME`: Lưu ngày giờ (độ chính xác đến phút).
    - `DATETIMEOFFSET`: Lưu ngày giờ kèm múi giờ.
- **Chuỗi ký tự (Character Strings):**
    - `CHAR(n)`: Chuỗi ký tự dài cố định `n` (ANSI).
    - `VARCHAR(n)`: Chuỗi ký tự dài thay đổi, tối đa `n` (ANSI).
    - `VARCHAR(MAX)`: Chuỗi ký tự dài thay đổi, tối đa 2GB (ANSI).
    - `TEXT`: Kiểu cũ, dùng lưu chuỗi lớn (nên thay bằng `VARCHAR(MAX)`).
- **Chuỗi ký tự Unicode (Unicode Character Strings):**
    - `NCHAR(n)`: Chuỗi Unicode dài cố định `n` (lưu được tiếng Việt có dấu).
    - `NVARCHAR(n)`: Chuỗi Unicode dài thay đổi, tối đa `n`. **Thường dùng cho tên, địa chỉ tiếng Việt.**
    - `NVARCHAR(MAX)`: Chuỗi Unicode dài thay đổi, tối đa 2GB.
    - `NTEXT`: Kiểu cũ, dùng lưu chuỗi Unicode lớn (nên thay bằng `NVARCHAR(MAX)`).
- **Chuỗi nhị phân (Binary Strings):**
    - `BINARY(n)`, `VARBINARY(n)`, `VARBINARY(MAX)`: Lưu dữ liệu nhị phân (file, ảnh,...).
    - `IMAGE`: Kiểu cũ (nên thay bằng `VARBINARY(MAX)`).
- **Các kiểu khác:**
    - `UNIQUEIDENTIFIER`: Lưu giá trị GUID.
    - `XML`: Lưu dữ liệu dạng XML.
    - `CURSOR`, `TABLE`: Kiểu dữ liệu đặc biệt.
    - `hierarchyid`, `geometry`, `geography`: Kiểu dữ liệu không gian.

**Cách sử dụng:** Khai báo khi tạo bảng, ví dụ: `CREATE TABLE SinhVien ( MaSV VARCHAR(10), HoTen NVARCHAR(100), NgaySinh DATE );`

### 1.2 Dung lượng (KB) tối đa của 1 row và 1 table.

- **Dung lượng tối đa của 1 row:** Một hàng dữ liệu trong SQL Server (không bao gồm dữ liệu LOB - Large Object như `VARCHAR(MAX)`, `NVARCHAR(MAX)`, `VARBINARY(MAX)`, `XML`) bị giới hạn ở **8060 bytes**. Dữ liệu LOB được lưu trữ riêng.
- **Dung lượng tối đa của 1 table:** Thực tế không có giới hạn cụ thể cho một bảng riêng lẻ, mà bị giới hạn bởi dung lượng tối đa của cơ sở dữ liệu chứa nó.
- **Dung lượng tối đa của 1 database:** Phụ thuộc vào phiên bản SQL Server:
    - SQL Server Express: Giới hạn **10 GB** mỗi CSDL.
    - SQL Server Standard/Enterprise: Giới hạn lý thuyết rất lớn (hàng trăm Terabytes), thực tế bị giới hạn bởi dung lượng lưu trữ vật lý của hệ thống.

### 1.3 Ý nghĩa các table hệ thống trong CSDL Master: `Sysusers`, `Sysservers`, `Sysxlogins`.

Các tên bảng `sysusers`, `sysservers`, `sysxlogins` là các đối tượng hệ thống từ các phiên bản SQL Server cũ. Trong các phiên bản hiện đại, chúng thường là các **Compatibility Views** để tương thích ngược. Nên sử dụng các **System Views** mới hơn bắt đầu bằng `sys.`:

- **`sysusers` (Compatibility View):** Ánh xạ tới `sys.database_principals`. View này (trong ngữ cảnh của một CSDL cụ thể, kể cả `master`) chứa một hàng cho mỗi user, role, hoặc application role trong CSDL đó.
- **`sysservers` (Compatibility View):** Ánh xạ tới `sys.servers`. View này chứa thông tin về các server liên kết (linked server) và server từ xa (remote server) đã đăng ký, cộng với server cục bộ (server_id = 0).
- **`sysxlogins` (Compatibility View):** Ánh xạ một phần tới `sys.server_principals` và `sys.sql_logins`.
    - `sys.server_principals`: Chứa một hàng cho mỗi principal ở cấp server (SQL login, Windows login/group, server role).
    - `sys.sql_logins`: Chứa thông tin cụ thể hơn về các SQL login (như chính sách mật khẩu).

CSDL `master` lưu trữ tất cả thông tin cấp server, bao gồm thông tin về tất cả các CSDL khác, logins, cấu hình server,...

### 1.4 Khi tạo CSDL (`CREATE DATABASE ABC`), SQL Server yêu cầu tạo tối thiểu bao nhiêu file? Ý nghĩa?

SQL Server yêu cầu tạo **tối thiểu 2 file** cho mỗi CSDL:

1. **Primary Data File (File dữ liệu chính):**
    - Đuôi mặc định: `.mdf` (ví dụ: `ABC.mdf`).
    - Ý nghĩa: Chứa thông tin khởi động CSDL, các bảng hệ thống, dữ liệu người dùng, các đối tượng (index, procedure,...). Mỗi CSDL có **đúng một** file primary data.
2. **Transaction Log File (File nhật ký giao dịch):**
    - Đuôi mặc định: `.ldf` (ví dụ: `ABC_log.ldf`).
    - Ý nghĩa: Ghi lại tất cả các thay đổi dữ liệu và giao dịch xảy ra trong CSDL. Rất quan trọng cho việc phục hồi dữ liệu (rollback transaction, restore CSDL sau sự cố). Mỗi CSDL phải có **ít nhất một** file log.

Khi chạy lệnh `CREATE DATABASE ABC;` mà không chỉ định rõ file, SQL Server sẽ tự động tạo 2 file này với tên và cấu hình mặc định tại vị trí mặc định.

### (1.5) Các tính năng đảm bảo tính an ninh mà SQL Server hỗ trợ.

- **Xác thực (Authentication):** Windows Authentication, SQL Server Authentication, Azure Active Directory Authentication.
- **Phân quyền (Authorization):** Dựa trên Logins, Users, Roles (Server Roles, Database Roles). Cấp quyền (`GRANT`), Từ chối (`DENY`), Thu hồi (`REVOKE`) trên các đối tượng (Server, Database, Schema, Table, View, Procedure...).
- **Schema:** Phân tách không gian tên cho các đối tượng CSDL, giúp quản lý và phân quyền.
- **Ownership Chaining:** Quản lý quyền truy cập qua chuỗi các đối tượng.
- **Views và Stored Procedures:** Hạn chế dữ liệu người dùng thấy hoặc chỉ cho phép thực thi logic đóng gói sẵn.
- **Mã hóa (Encryption):**
    - Transparent Data Encryption (TDE): Mã hóa toàn bộ file CSDL khi lưu trữ.
    - Always Encrypted: Mã hóa dữ liệu nhạy cảm ở cấp cột, cả khi lưu trữ và khi truyền.
    - Column-level Encryption: Mã hóa dữ liệu ở từng cột bằng hàm.
    - Backup Encryption: Mã hóa file backup.
    - Connection Encryption (SSL/TLS): Mã hóa dữ liệu truyền qua mạng.
- **Auditing:** Ghi lại các sự kiện xảy ra trên server hoặc CSDL.
- **Row-Level Security:** Giới hạn các hàng dữ liệu người dùng có thể truy cập.
- **Dynamic Data Masking:** Che dấu dữ liệu nhạy cảm cho người dùng không có quyền xem.
- **SQL Server Configuration Manager:** Quản lý các dịch vụ và giao thức mạng, có thể tắt các giao thức không cần thiết.

### (1.6) Hãy tạo ra Views, chứng minh các views cũng là con đường tạo an ninh cho CSDL.

View là một bảng ảo dựa trên kết quả của một câu lệnh `SELECT`. View không lưu dữ liệu (trừ Indexed View) mà chỉ lưu định nghĩa truy vấn.

**Tạo View:**

SQL

```sql

-- Giả sử có bảng NHANVIEN(MANV, HOTEN, LUONG, DIACHI, SODT)
-- Tạo View chỉ hiển thị thông tin cơ bản, giấu cột LUONG
CREATE VIEW VW_NhanVien_CoBan
AS
SELECT MANV, HOTEN, DIACHI, SODT
FROM NHANVIEN;
GO

```

!![](assets/images/obsidian/Pasted image 20250420101522.png)

**Chứng minh tính an ninh:**

1. **Che giấu cột (Column Masking):** Bằng cách chỉ `SELECT` các cột cần thiết trong định nghĩa View (`VW_NhanVien_CoBan` ở trên giấu cột `MANV`), bạn có thể cấp quyền cho người dùng trên View này thay vì bảng gốc. Người dùng sẽ không thấy được các cột nhạy cảm.
    
    SQL
    
    ```sql
    -- Cấp quyền xem View cho user 'NhanSuTapSu'
    GRANT SELECT ON VW_NhanVien_CoBan TO NhanSuTapSu;
    -- Chặn (hoặc không cấp) quyền xem bảng gốc
    -- DENY SELECT ON NHANVIEN TO NhanSuTapSu;
    ```
    
2. **Giới hạn hàng (Row Filtering):** Có thể thêm mệnh đề `WHERE` vào định nghĩa View để chỉ hiển thị các hàng dữ liệu nhất định.
    
    SQL
    
    ```sql
    -- View chỉ hiển thị nhân viên thuộc phòng 'Kinh Doanh'
    CREATE VIEW VW_NhanVien_KinhDoanh
    AS
    SELECT MANV, HOTEN, SODT
    FROM NHANVIEN
    WHERE PhongBan = 'Kinh Doanh';
    GO
    -- Cấp quyền trên view này
    GRANT SELECT ON VW_NhanVien_KinhDoanh TO NguoiQuanLyKinhDoanh;
    ```
    
3. **Đơn giản hóa quyền phức tạp:** View có thể `JOIN` nhiều bảng và bạn chỉ cần cấp quyền trên View đó thay vì phải cấp quyền chi tiết trên từng bảng gốc.

### (1.7) Hãy backup CSDL ABC thành 1 file ABC.BAK.

SQL

```sql
-- Backup full database ABC vào file ABC.BAK
-- Thay đổi đường dẫn '/var/opt/mssql/backup/' nếu cần thiết cho môi trường của bạn
BACKUP DATABASE ABC
TO DISK = '/var/opt/mssql/backup/QLBANHANG_BACKUP_2.BAK'
WITH INIT, -- Ghi đè nếu file đã tồn tại
     NAME = 'ABC Full Backup',
     DESCRIPTION = 'Full backup of ABC database',
     STATS = 10; -- Hiển thị tiến trình
GO
```
!![](assets/images/obsidian/Pasted image 20250420104247.png)
### (1.8) Xóa CSDL ABC trong SQL. Hãy khôi phục ABC nhờ vào ABC.BAK.

**Xóa CSDL (Cẩn thận!):**

SQL

```sql
USE master;
GO
-- Ngắt kết nối tới CSDL ABC (nếu có)
ALTER DATABASE QLBANHANG SET SINGLE_USER WITH ROLLBACK IMMEDIATE;
GO
-- Xóa CSDL
DROP DATABASE QLBANHANG;
GO
```

Sau khi xoá CSDL QLBANHANG
!![](assets/images/obsidian/Pasted image 20250420104441.png)

**Khôi phục CSDL:**

SQL

```sql
USE master;
GO
-- Khôi phục từ file backup
RESTORE DATABASE ABC
FROM DISK = '/var/opt/mssql/backup/ABC.BAK'
WITH REPLACE, -- Cần thiết nếu CSDL đã tồn tại hoặc để ghi đè thông tin file
     STATS = 10;
GO
-- (Tùy chọn) Đưa về chế độ đa người dùng nếu trước đó SET SINGLE_USER
-- ALTER DATABASE ABC SET MULTI_USER;
-- GO
```
Kết quả phục hồi CSDL QLBANHANG
!![](assets/images/obsidian/Pasted image 20250420104520.png)


### 1.9 Chọn 1 file dữ liệu (SV) từ excel, và import vào SQLServer.

Tương tự như việc trình bày ở bài 1
### 1.10 Chọn 1 table trong SQL Server, và export tới file Excel.

Tương tự như việc trình bày ở bài 1
### 1.11 Hãy đọc SQL Server Log.

**Thực thi lệnh `sp_readerrorlog`:**

- Trong cửa sổ Query Editor, gõ lệnh để thực thi stored procedure `sp_readerrorlog`. Dưới đây là một số cách dùng phổ biến:
    
- **Đọc file log hiện tại (log số 0):**
    
    SQL
    
    ```
    EXEC sp_readerrorlog;
    ```
    
    _Hoặc chỉ rõ số log:_
    
    SQL
    
    ```
    EXEC sp_readerrorlog 0;
    ```
    
- **Đọc file log lưu trữ gần nhất (log số 1 - Archive #1):**
    
    SQL
    
    ```
    EXEC sp_readerrorlog 1;
    ```
    
    _(Bạn có thể thay `1` bằng `2`, `3`,... để đọc các file log cũ hơn nếu có)._
    
- **Đọc log hiện tại và lọc theo từ khóa:** (Ví dụ: tìm các dòng chứa chữ 'Error')
    
    SQL
    
    ```
    -- Tham số thứ 3 là bộ lọc văn bản
    EXEC sp_readerrorlog 0, 1, N'Error';
    ```
    
    _(Tham số thứ 2 là loại log: 1 cho SQL Server Log, 2 cho SQL Agent Log)_
    
- **Đọc log hiện tại và lọc theo khoảng thời gian:** (Ví dụ: từ 8h đến 11h ngày 20/04/2025)
    
    SQL
    
    ```
    -- Tham số thứ 5 là thời gian bắt đầu, thứ 6 là thời gian kết thúc
    EXEC sp_readerrorlog 0, 1, NULL, NULL, '2025-04-20 08:00:00', '2025-04-20 11:00:00';
    ```
    
    _(Lưu ý định dạng ngày giờ YYYY-MM-DD hh:mm:ss)_

Kết quả đọc log bằng lệnh
!![](assets/images/obsidian/Pasted image 20250420105042.png)

### 1.12 Số users có thể connect cùng 1 thời điểm.

- Giới hạn lý thuyết tối đa của SQL Server cho số kết nối người dùng đồng thời là **32,767**.
- Tuy nhiên, số lượng kết nối thực tế mà server có thể xử lý hiệu quả phụ thuộc nặng nề vào:
    - **Phiên bản SQL Server:** (Express có thể có giới hạn thấp hơn về tài nguyên).
    - **Tài nguyên phần cứng:** CPU, RAM, Disk I/O.
    - **Cấu hình SQL Server:** Bộ nhớ cấp phát, mức độ song song,...
    - **Thiết kế CSDL và ứng dụng:** Truy vấn có hiệu quả không, có bị khóa (blocking) nhiều không.    
    ```sql
    
    -- Xem cấu hình hiện tại (0 là mặc định 32767)
    EXEC sp_configure 'user connections';
    GO
    -- Thay đổi (ví dụ: giới hạn 500, cần quyền sysadmin và reconfigure)
    -- EXEC sp_configure 'user connections', 500;
    -- RECONFIGURE;
    -- GO
    ```

!![](assets/images/obsidian/Pasted image 20250420094813.png)

## Bài 2 Cơ sở dữ liệu QLSB

**CSDL:**

- `PHICONG` (MSPC, TENPC, DIACHI, NGAYSINH, NGAYVAOLAM, LUONG)
- `MAYBAY` (MSMB, TENMB, SUCCHUA, GIA)
- `PHANCONG` (MSPC, MSMB, SOGIO)

### Câu 2.1. Thực hiện các yêu cầu sau:

#### a. Tạo các bảng, khóa chính, khóa ngoại, thêm dữ liệu (nếu có).

SQL

```sql

-- Tạo Database (Nếu chưa có)
-- CREATE DATABASE QLSB;
-- GO
USE QLSB;
GO

-- Tạo bảng PHICONG
CREATE TABLE PHICONG (
    MSPC VARCHAR(10) PRIMARY KEY,
    TENPC NVARCHAR(100) NOT NULL,
    DIACHI NVARCHAR(255),
    NGAYSINH DATE,
    NGAYVAOLAM DATE,
    LUONG DECIMAL(18, 2)
);

-- Tạo bảng MAYBAY
CREATE TABLE MAYBAY (
    MSMB VARCHAR(10) PRIMARY KEY,
    TENMB NVARCHAR(100) NOT NULL,
    SUCCHUA INT,
    GIA DECIMAL(18, 2)
);

-- Tạo bảng PHANCONG
CREATE TABLE PHANCONG (
    MSPC VARCHAR(10),
    MSMB VARCHAR(10),
    SOGIO INT,
    PRIMARY KEY (MSPC, MSMB), -- Khóa chính kết hợp
    FOREIGN KEY (MSPC) REFERENCES PHICONG(MSPC) ON DELETE CASCADE ON UPDATE CASCADE, -- Thêm ràng buộc khóa ngoại
    FOREIGN KEY (MSMB) REFERENCES MAYBAY(MSMB) ON DELETE CASCADE ON UPDATE CASCADE -- Thêm ràng buộc khóa ngoại
);
GO

-- Thêm dữ liệu mẫu (Ví dụ)
INSERT INTO PHICONG (MSPC, TENPC, NGAYSINH, NGAYVAOLAM, LUONG) VALUES
('PC01', N'Nguyễn Phi Công A', '1988-01-01', '2015-01-10', 60000000),
('PC02', N'Trần Phi Công B', '1991-05-15', '2018-06-01', 55000000);

INSERT INTO MAYBAY (MSMB, TENMB, SUCCHUA, GIA) VALUES
('VN077', N'Boeing 777', 350, 250000000),
('VN321', N'Airbus A321', 180, 110000000);

INSERT INTO PHANCONG (MSPC, MSMB, SOGIO) VALUES
('PC01', 'VN077', 150),
('PC01', 'VN321', 80),
('PC02', 'VN321', 200);
GO
```
!![](assets/images/obsidian/Pasted image 20250420095154.png)

#### b. Thiết kế report và viết truy vấn cho biết tên phi công và tên máy bay, số giờ làm việc (nếu có).

**Thiết kế Report (Mô tả):**

- **Mục đích:** Liệt kê danh sách các phi công và máy bay họ được phân công lái cùng số giờ bay tương ứng.
- **Tham số:** Có thể không cần tham số nếu muốn xem tất cả.
- **Tiêu đề:** "Báo cáo Phân công Phi công - Máy bay"
- **Cột hiển thị:** STT, Tên Phi công (TENPC), Tên Máy bay (TENMB), Số giờ làm việc (SOGIO).
- **Dữ liệu:** Lấy từ kết quả truy vấn dưới đây.
- **Nhóm (Grouping):** Có thể nhóm theo Tên Phi công để dễ xem một phi công lái những máy bay nào.
- **Tổng cộng:** Có thể thêm tổng số giờ bay cho mỗi phi công hoặc tổng số giờ bay của tất cả.

**Truy vấn lấy dữ liệu:**

SQL

```sql

SELECT
    PC.TENPC AS TenPhiCong,
    MB.TENMB AS TenMayBay,
    PCG.SOGIO AS SoGioLamViec
FROM
    PHICONG AS PC
INNER JOIN
    PHANCONG AS PCG ON PC.MSPC = PCG.MSPC
INNER JOIN
    MAYBAY AS MB ON PCG.MSMB = MB.MSMB
ORDER BY
    PC.TENPC, MB.TENMB;
    
```

!![](assets/images/obsidian/Pasted image 20250420095211.png)
#### c. Tự bạn cho yêu cầu 1 câu truy vấn liên quan đến CSDL này và viết lệnh chạy.

**Yêu cầu ví dụ:** Tìm các phi công có tổng số giờ bay (trên tất cả các máy bay được phân công) lớn hơn 100 giờ.

**Truy vấn:**

SQL

```sql

SELECT
    PC.MSPC,
    PC.TENPC,
    SUM(ISNULL(PCG.SOGIO, 0)) AS TongSoGioBay
FROM
    PHICONG AS PC
LEFT JOIN -- Dùng LEFT JOIN phòng trường hợp phi công chưa được phân công
    PHANCONG AS PCG ON PC.MSPC = PCG.MSPC
GROUP BY
    PC.MSPC, PC.TENPC
HAVING
    SUM(ISNULL(PCG.SOGIO, 0)) > 100 -- Điều kiện lọc sau khi nhóm
ORDER BY
    TongSoGioBay DESC;
    
```
!![](assets/images/obsidian/Pasted image 20250420095454.png)

### Câu 2.2. Phân quyền

#### a. Hãy tạo ra 5 user có tên sau: u7, u8, u9, u10, user_HoTenCuaBan bằng câu lệnh.

SQL

```sql

-- Tạo Logins (cấp Server) - Thay mật khẩu mạnh!
CREATE LOGIN u7 WITH PASSWORD = 'Trannhatsang**';
CREATE LOGIN u8 WITH PASSWORD = 'Trannhatsang**';
CREATE LOGIN u9 WITH PASSWORD = 'Trannhatsang**';
CREATE LOGIN u10 WITH PASSWORD = 'Trannhatsang**';

CREATE LOGIN user_Trannhatsang WITH PASSWORD = 'your_strong_password_htcb';
GO

-- Tạo Database Users trong CSDL QLSB
USE QLSB;
GO
CREATE USER u7 FOR LOGIN u7;
CREATE USER u8 FOR LOGIN u8;
CREATE USER u9 FOR LOGIN u9;
CREATE USER u10 FOR LOGIN u10;
CREATE USER user_Trannhatsang FOR LOGIN user_Trannhatsang;
GO
PRINT 'Đã tạo 5 users trong QLSB.';
```
!![](assets/images/obsidian/Pasted image 20250420095731.png)
#### b. Hãy tạo ra 2 role có tên sau: r4, r5 và phân nhóm bằng câu lệnh:

SQL

```sql

USE QLSB;
GO

-- Tạo Database Roles
CREATE ROLE r4;
CREATE ROLE r5;
GO

-- Phân nhóm (gán user vào role)
-- u7, u9, u10 là thành viên: r4
ALTER ROLE r4 ADD MEMBER u7;
ALTER ROLE r4 ADD MEMBER u9;
ALTER ROLE r4 ADD MEMBER u10;

-- u8, user_HoTenCuaBan là thành viên: r5
ALTER ROLE r5 ADD MEMBER u8;
ALTER ROLE r5 ADD MEMBER user_Trannhatsang; 
GO
PRINT 'Đã tạo role r4, r5 và phân nhóm user.';

```

!![](assets/images/obsidian/Pasted image 20250420095938.png)
#### c. Hãy phân quyền: r4 được quyền select trên bảng MAYBAY.

SQL

```sql

USE QLSB;
GO
GRANT SELECT ON dbo.MAYBAY TO r4;
GO
PRINT 'Đã cấp quyền SELECT trên MAYBAY cho role r4.';

```
!![](assets/images/obsidian/Pasted image 20250420100046.png)
#### d. Hãy phân quyền: r5 được quyền select, insert, update trên bảng PHICONG.

SQL

```sql

USE QLSB;
GO
GRANT SELECT, INSERT, UPDATE ON dbo.PHICONG TO r5;
GO
PRINT 'Đã cấp quyền SELECT, INSERT, UPDATE trên PHICONG cho role r5.';

```

!![](assets/images/obsidian/Pasted image 20250420100108.png)
#### e. Hãy xóa quyền: r5 không được quyền select trên bảng PHICONG.

SQL

```sql

USE QLSB;
GO
REVOKE SELECT ON dbo.PHICONG FROM r5;
GO
PRINT 'Đã thu hồi (REVOKE) quyền SELECT trên PHICONG từ role r5.';

```

!![](assets/images/obsidian/Pasted image 20250420100145.png)

### Bài 3: Tìm hiểu các vấn đề tương tự nhưng ở cơ sở dữ liệu MySQL

#### 3.1 Các kiểu dữ liệu (data type) dùng cho các trường (field) và cách sử dụng nó trong MySQL.

MySQL hỗ trợ nhiều kiểu dữ liệu, bao gồm:

- **Kiểu số (Numeric Types):**
    - `INTEGER`, `INT`, `SMALLINT`, `TINYINT`, `MEDIUMINT`, `BIGINT`: Các kiểu số nguyên với kích thước và phạm vi khác nhau.
    - `DECIMAL(p, s)`, `NUMERIC(p, s)`: Số thập phân chính xác (fixed-point), `p` là tổng số chữ số, `s` là số chữ số sau dấu phẩy. Dùng cho tiền tệ.
    - `FLOAT`, `DOUBLE`: Số thực dấu phẩy động (floating-point), độ chính xác tương đối.
    - `BIT(n)`: Lưu trữ giá trị bit (tối đa 64 bit).
- **Kiểu ngày giờ (Date and Time Types):**
    - `DATE`: Lưu ngày (YYYY-MM-DD).
    - `TIME`: Lưu giờ (HH:MM:SS).
    - `DATETIME`: Lưu ngày và giờ (YYYY-MM-DD HH:MM:SS).
    - `TIMESTAMP`: Lưu ngày và giờ, tự động cập nhật khi hàng thay đổi (mặc định), liên quan đến múi giờ (UTC).
    - `YEAR`: Lưu năm (YYYY).
- **Kiểu chuỗi (String Types):**
    - `CHAR(n)`: Chuỗi ký tự cố định `n`.
    - `VARCHAR(n)`: Chuỗi ký tự thay đổi, tối đa `n`.
    - `BINARY(n)`, `VARBINARY(n)`: Lưu chuỗi byte nhị phân cố định/thay đổi.
    - `TINYBLOB`, `BLOB`, `MEDIUMBLOB`, `LONGBLOB`: Lưu dữ liệu nhị phân lớn (ảnh, file).
    - `TINYTEXT`, `TEXT`, `MEDIUMTEXT`, `LONGTEXT`: Lưu chuỗi ký tự lớn. Lưu ý về **Character Set** (bảng mã - vd: `utf8mb4`) và **Collation** (quy tắc so sánh - vd: `utf8mb4_unicode_ci`) rất quan trọng khi làm việc với chuỗi trong MySQL để lưu trữ và so sánh tiếng Việt đúng cách.
    - `ENUM`: Cho phép chọn một giá trị từ danh sách định sẵn.
    - `SET`: Cho phép chọn một hoặc nhiều giá trị từ danh sách định sẵn.
- **Kiểu dữ liệu không gian (Spatial Data Types):** `GEOMETRY`, `POINT`, `LINESTRING`, `POLYGON`, v.v.
- **Kiểu JSON (Từ MySQL 5.7.8):** Lưu trữ và truy vấn dữ liệu JSON hiệu quả.

**Cách sử dụng:** Khai báo trong `CREATE TABLE`, ví dụ:

SQL

```sql
CREATE TABLE SinhVien (
    MaSV VARCHAR(10) PRIMARY KEY,
    HoTen VARCHAR(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci,
    NgaySinh DATE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
```

#### 3.2 Dung lượng tối đa của 1 row và 1 table trong MySQL.

- **Dung lượng tối đa của 1 row:** Khoảng **65,535 bytes**. Giới hạn này được chia sẻ giữa tất cả các cột trong hàng (trừ các kiểu `BLOB` và `TEXT`, chúng được lưu trữ riêng và chỉ đóng góp một phần nhỏ vào giới hạn này). Kích thước thực tế còn phụ thuộc vào bảng mã (character set) sử dụng (ví dụ: `utf8mb4` dùng tối đa 4 bytes/ký tự).
- **Dung lượng tối đa của 1 table:** Phụ thuộc vào **Storage Engine** được sử dụng và giới hạn kích thước file của hệ điều hành.
    - **InnoDB (Mặc định):** Giới hạn kích thước bảng rất lớn, thường bị giới hạn bởi hệ điều hành (có thể lên đến hàng Terabytes).
    - **MyISAM:** Bị giới hạn bởi hệ điều hành hoặc mặc định khoảng 256TB (có thể cấu hình).

#### 3.3 Tìm hiểu ý nghĩa các table hệ thống trong CSDL `mysql` và `INFORMATION_SCHEMA`.

MySQL không có CSDL `Master` như SQL Server. Thay vào đó, thông tin hệ thống được lưu trữ chủ yếu trong:

- **CSDL `mysql`:** Chứa các bảng quan trọng về quyền và cấu hình:
    - `mysql.user`: Lưu thông tin tài khoản người dùng (host, user, mật khẩu, quyền global). Đây là nơi quản lý "logins".
    - `mysql.db`: Lưu quyền hạn cấp độ database.
    - `mysql.tables_priv`, `mysql.columns_priv`: Lưu quyền hạn cấp độ bảng và cột.
    - `mysql.procs_priv`: Lưu quyền hạn trên stored procedures/functions.
    - `mysql.roles_mapping`: Quản lý việc gán role cho user.
    - Các bảng khác liên quan đến replication, event scheduler, server help,...
- **CSDL `INFORMATION_SCHEMA`:** Cung cấp các **views chỉ đọc** (read-only views) chứa metadata (thông tin về cấu trúc) của tất cả các CSDL và đối tượng mà người dùng hiện tại có quyền xem. Đây là cách chuẩn SQL để truy cập metadata. Ví dụ:
    - `INFORMATION_SCHEMA.SCHEMATA`: Thông tin về các database.
    - `INFORMATION_SCHEMA.TABLES`: Thông tin về các bảng.
    - `INFORMATION_SCHEMA.COLUMNS`: Thông tin về các cột.
    - `INFORMATION_SCHEMA.STATISTICS`: Thông tin về các index.
    - `INFORMATION_SCHEMA.USER_PRIVILEGES`, `SCHEMA_PRIVILEGES`, `TABLE_PRIVILEGES`, `COLUMN_PRIVILEGES`: Thông tin về các quyền được cấp.
    - `INFORMATION_SCHEMA.VIEWS`: Thông tin về các view.
    - `INFORMATION_SCHEMA.ROUTINES`: Thông tin về stored procedures/functions.
    - `INFORMATION_SCHEMA.PROCESSLIST`: Thông tin về các kết nối hiện tại.

Không có khái niệm "linked server" trực tiếp như `sys.servers` của SQL Server. MySQL dùng `FEDERATED` storage engine hoặc replication cho các kịch bản tương tự.

#### 3.4 Khi người dùng tạo 1 CSDL, MySQL yêu cầu tạo ra tối thiểu bao nhiêu file? Ý nghĩa mỗi file?

Việc tạo file khi `CREATE DATABASE ABC;` trong MySQL phụ thuộc nhiều vào cấu hình và Storage Engine (chủ yếu là InnoDB).

- **Về mặt logic:** Lệnh `CREATE DATABASE ABC;` chủ yếu tạo ra một **thư mục** có tên `ABC` bên trong thư mục dữ liệu (`datadir`) của MySQL. Thư mục này sẽ chứa các file liên quan đến các bảng được tạo trong CSDL `ABC` sau này. MySQL cũng lưu trữ thông tin về CSDL này trong các bảng hệ thống của nó.
- **Về mặt file vật lý:**
    - **InnoDB (cấu hình `innodb_file_per_table=ON` - mặc định ở các phiên bản gần đây):** Khi bạn tạo một _bảng_ trong CSDL `ABC`, InnoDB sẽ tạo một file `.ibd` riêng cho bảng đó (ví dụ: `TenBang.ibd`) trong thư mục `ABC`. File này chứa cả dữ liệu và index của bảng. Ngoài ra, có các file log dùng chung cho InnoDB (`ib_logfile0`, `ib_logfile1`...) và có thể có file system tablespace (`ibdata1`) chứa dictionary và undo log.
    - **InnoDB (cấu hình `innodb_file_per_table=OFF`):** Dữ liệu và index của tất cả các bảng InnoDB sẽ được lưu chung trong system tablespace (`ibdata1`).
    - **MyISAM:** Khi tạo một bảng, MyISAM tạo 3 file: `.frm` (định nghĩa bảng), `.MYD` (dữ liệu), `.MYI` (index).

=> **Kết luận:** Lệnh `CREATE DATABASE` trong MySQL chủ yếu tạo cấu trúc thư mục và đăng ký CSDL trong hệ thống. Nó **không** tạo ra ngay lập tức một cặp file dữ liệu/log riêng biệt cho CSDL đó như cách SQL Server tạo `.mdf`/`.ldf`. Các file vật lý chứa dữ liệu/index thường chỉ được tạo ra khi bạn tạo bảng bên trong CSDL đó.

#### (3.5) Các tính năng nào dùng đảm bảo tính an ninh mà MySQL hỗ trợ.

- **Xác thực (Authentication):** Dựa trên username, host nguồn và phương thức xác thực (mật khẩu native, caching_sha2_password, PAM, LDAP,...).
- **Phân quyền (Authorization):**
    - Mô hình quyền chi tiết dựa trên `GRANT`/`REVOKE` ở các cấp độ: Global (`ON *.*`), Database (`ON db_name.*`), Table (`ON db_name.table_name`), Column, Stored Routine.
    - Roles (từ MySQL 8.0): Nhóm các quyền lại và gán cho user, giúp quản lý dễ dàng hơn.
- **Mã hóa:**
    - SSL/TLS cho kết nối client-server và replication.
    - Transparent Data Encryption (TDE): Tính năng mã hóa dữ liệu khi lưu trữ (thường có trong MySQL Enterprise hoặc các biến thể như Percona, MariaDB).
    - Các hàm mã hóa/giải mã tích hợp (`AES_ENCRYPT`, `AES_DECRYPT`,...).
- **Network Security:** Cấu hình `bind-address` để giới hạn IP server lắng nghe, sử dụng Firewall hệ điều hành.
- **Auditing:** MySQL Enterprise Audit, MariaDB Audit Plugin, hoặc các giải pháp bên thứ ba để ghi lại hoạt động truy cập và thay đổi dữ liệu.
- **Password Policies:** Plugin `validate_password` để kiểm tra độ mạnh mật khẩu, thiết lập chính sách hết hạn mật khẩu.
- **Views & Stored Procedures/Functions:** Che giấu cấu trúc bảng, giới hạn dữ liệu, đóng gói logic nghiệp vụ an toàn.

#### (3.6) Hãy tạo ra Views, chứng minh các views cũng là con đường tạo an ninh cho CSDL.

Khái niệm và cách sử dụng View cho an ninh trong MySQL hoàn toàn tương tự SQL Server.

**Tạo View:**

SQL

```sql
-- Giả sử có bảng NHANVIEN(MANV, HOTEN, LUONG, DIACHI, SODT)
-- Tạo View ẩn cột LUONG
CREATE VIEW VW_NhanVien_CoBan AS
SELECT MANV, HOTEN, DIACHI, SODT
FROM NHANVIEN;
```

**Chứng minh tính an ninh:**

1. **Che giấu cột:** Cấp quyền cho người dùng trên `VW_NhanVien_CoBan` thay vì bảng `NHANVIEN`. Họ sẽ không thấy được cột `LUONG`.
    
    SQL
    
    ```sql
    GRANT SELECT ON your_db_name.VW_NhanVien_CoBan TO 'nhansu'@'localhost';
    ```
    
2. **Giới hạn hàng:** Thêm mệnh đề `WHERE` vào View.
    
    SQL
    
    ```sql
    CREATE VIEW VW_NhanVien_KinhDoanh AS
    SELECT MANV, HOTEN, SODT
    FROM NHANVIEN
    WHERE PhongBan = 'Kinh Doanh';
    -- Cấp quyền trên view này
    GRANT SELECT ON your_db_name.VW_NhanVien_KinhDoanh TO 'qly_kd'@'localhost';
    ```
    

#### (3.7 & 3.8) Backup và Restore CSDL trong MySQL.

MySQL không dùng khái niệm file `.bak` như SQL Server. Các phương pháp phổ biến:

- **Logical Backup (Sử dụng `mysqldump`):**
    - **Backup:** Tạo file `.sql` chứa các lệnh SQL để tạo lại cấu trúc và dữ liệu.
        
        Bash
        
        ```sql
        mysqldump -u [username] -p[password] [database_name] > backup_file.sql
        # Backup tất cả CSDL
        mysqldump -u [username] -p[password] --all-databases > all_databases.sql
        ```
        
    - **Restore:** Thực thi file `.sql` bằng client `mysql`.
        
        Bash
        ```bash
        mysql -u [username] -p[password] [database_name] < backup_file.sql
        ```
        
    - Ưu điểm: Linh hoạt, dễ chuyển đổi giữa các phiên bản/nền tảng.
    - Nhược điểm: Chậm hơn cho CSDL lớn.
- **Physical Backup:**
    - **Cold Backup:** Dừng server MySQL và sao chép toàn bộ thư mục dữ liệu (`datadir`). Đơn giản nhưng yêu cầu downtime.
    - **Hot Backup (InnoDB):** Sử dụng công cụ chuyên dụng như **Percona XtraBackup** (miễn phí, phổ biến) để tạo bản sao lưu vật lý mà không cần dừng server.
    - **Restore:** Sao chép lại file dữ liệu (Cold Backup) hoặc theo quy trình của công cụ (Percona XtraBackup).
    - Ưu điểm: Backup và Restore rất nhanh cho CSDL lớn.
    - Nhược điểm: Phức tạp hơn, thường yêu cầu tương thích phiên bản.

#### 3.9 Chọn 1 file dữ liệu (SV) từ excel, và import vào MySQL.

Em sử dụng Navicat tương tự như cách import/export của bài 1
#### 3.10 Chọn 1 table trong MySQL, và export tới file Excel.

Em sử dụng Navicat tương tự như cách import/export của bài 1

#### 3.11 Hãy đọc MySQL Log.

MySQL có nhiều loại log, cần được bật trong file cấu hình (`my.cnf` hoặc `my.ini`):

- **Error Log (`log_error`):** Ghi lỗi khi khởi động, dừng, hoặc các lỗi nghiêm trọng khi chạy. **Luôn nên bật.** Vị trí file được chỉ định bởi biến `log_error`. Đọc trực tiếp file text này.
- **General Query Log (`general_log`, `general_log_file`):** Ghi lại mọi kết nối và mọi câu lệnh SQL được thực thi. **Chỉ bật khi cần debug** vì ảnh hưởng lớn đến hiệu năng. Đọc file text.
- **Slow Query Log (`slow_query_log`, `slow_query_log_file`, `long_query_time`):** Ghi lại các truy vấn chạy chậm hơn số giây `long_query_time` quy định. Rất hữu ích để tối ưu hiệu năng. Đọc file text hoặc dùng tool như `mysqldumpslow`.
- **Binary Log (`log_bin`):** Ghi lại các sự kiện thay đổi dữ liệu (dưới dạng binary). Dùng cho replication và point-in-time recovery. Không đọc trực tiếp được, dùng tiện ích `mysqlbinlog` để xem nội dung.

#### 3.12 Số users có thể connect cùng 1 thời điểm trong MySQL.

Số kết nối đồng thời tối đa được kiểm soát bởi biến hệ thống `max_connections`.

- Xem giá trị hiện tại:
    
    SQL
    
    ```sql
    SHOW VARIABLES LIKE 'max_connections';
    ```
    
- Giá trị mặc định thường là `151`.
- Thay đổi (cần quyền SUPER):
    - Tạm thời (đến khi restart server): `SET GLOBAL max_connections = 500;`
    - Vĩnh viễn: Sửa giá trị `max_connections = 500` trong file cấu hình (`my.cnf`/`my.ini`) và khởi động lại MySQL server.
- **Lưu ý:** Tăng `max_connections` cần đi đôi với việc tăng tài nguyên hệ thống (đặc biệt là RAM), vì mỗi kết nối đều tiêu tốn bộ nhớ. Số lượng kết nối thực tế server chịu được còn phụ thuộc vào tải công việc và tài nguyên máy chủ.

!![](assets/images/obsidian/Pasted image 20250420105218.png)

---
*Nguồn: Evergreen/concept-base/university/semester01/IE103_information-management/practice/Bài tập chương 4,5 - Trần Nhật Sang - 24410347.md*