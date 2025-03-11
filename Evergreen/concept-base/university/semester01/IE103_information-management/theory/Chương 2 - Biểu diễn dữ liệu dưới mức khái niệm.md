
## Bài 3:

### Sơ đồ quan hệ ERD
![[Pasted image 20250310223009.png]]

#### Các mối kết hợp:

1. **TRUONGNHOM** (Là trưởng nhóm): THO (0,1) - (1,1) NHOM [Một thợ có thể là trưởng của một nhóm]
2. **THUOC**: THO (1,1) - (1,n) NHOM [Một thợ thuộc một nhóm, một nhóm có nhiều thợ]
3. **THUCHIEN**: THO (1,n) - (1,1) CONGVIEC_HOPDONG [Một thợ thực hiện nhiều công việc của hợp đồng]
4. **LIENQUAN**: CONGVIEC (1,n) - (1,1) CONGVIEC_HOPDONG [Một công việc được thực hiện trong nhiều hợp đồng]
5. **BAOTRONG**: HOPDONG (1,1) - (1,n) CONGVIEC_HOPDONG [Một hợp đồng có nhiều công việc]
6. **KY**: KHACHHANG (1,n) - (1,1) HOPDONG [Một khách hàng ký nhiều hợp đồng]
7. **SO_HUU**: KHACHHANG (1,n) - (1,1) XE [Một khách hàng sở hữu nhiều xe]
8. **LIENKET**: XE (1,n) - (1,1) HOPDONG [Một xe liên kết với nhiều hợp đồng]



### Sơ đồ lớp


Trình bày

```plantuml
Class Nhom {
  MANHOM: string
  TENNHOM: string
  
  Set<Tho>
  Tuple(Tho)
  
  ThemNhom()
  XoaNhom()
}

Class Tho {
  MATHO: string
  TENTHO: string
  
  Tuple(Nhom)
  Set<CongViec_HopDong>
  
  NhapTho()
  XuatTho()
}

Class CongViec {
  MACV: string
  NOIDUNGCV: string
  
  Set<CongViec_HopDong>
  
  NhapCV()
  XuatCV()
}

Class HopDong {
  MAHD: string
  NGAYKY: date
  NGAYDUKIEN: date
  NGAYGIAO: date
  TONGTRIGIA: decimal
  
  Tuple(KhachHang)
  Tuple(Xe)
  Set<CongViec_HopDong>
  
  NhapHD()
  XuatHD()
  TinhTriGia()
}

Class KhachHang {
  MAKH: string
  TENKH: string
  DIACHI: string
  SDT: string
  
  Set<HopDong>
  Set<Xe>
  
  NhapKH()
  XuatKH()
}

Class Xe {
  BIENSO: string
  NUOCSX: string
  LOAIXE: string
  SOPK: int
  SOKHUNG: string
  SOSUON: string
  MAUXE: string
  
  Tuple(KhachHang)
  Set<HopDong>
  
  NhapXe()
  XuatXe()
}

Class CongViec_HopDong {
  TRIGIACV: decimal
  
  Tuple(HopDong)
  Tuple(CongViec)
  Tuple(Tho)
  
  NhapCVHD()
  XuatCVHD()
}

```


![[Pasted image 20250310224148.png]]
#### Đây là mô hình lớp (Class Diagram) thể hiện rõ các lớp và mối quan hệ giữa chúng như sau:

1. **Nhom** có nhiều **Tho**, một **Tho** là trưởng của một **Nhom**
2. **Tho** thực hiện nhiều **CongViec_HopDong**
3. **CongViec** liên kết với nhiều **CongViec_HopDong**
4. **HopDong** có nhiều **CongViec_HopDong**
5. **KhachHang** có nhiều **HopDong**
6. **KhachHang** sở hữu nhiều **Xe**
7. **Xe** liên kết với nhiều **HopDong**

### Mức Logic:
- **NHOM** (MANHOM, TENNHOM, MATRUONGNHOM) - GROUP
    - MANHOM: Khóa chính
    - MATRUONGNHOM: Khóa ngoại tham chiếu đến THO
- **THO** (MATHO, TENTHO, MANHOM) - EMPLOYEE
    - MATHO: Khóa chính
    - MANHOM: Khóa ngoại tham chiếu đến NHOM
- **CONGVIEC** (MACV, NOIDUNGCV) - WORK
    - MACV: Khóa chính
- **HOPDONG** (**MAHD**, NGAYKY, NGAYDUKIEN, NGAYGIAO, TONGTRIGIA, **MAKH**, **BIENSO**) - CONTRACT
    - MAHD: Khóa chính
    - MAKH: Khóa ngoại tham chiếu đến KHACHHANG
    - BIENSO: Khóa ngoại tham chiếu đến XE
- **KHACHHANG** (MAKH, TENKH, DIACHI, SDT) - CUSTOMER
    - MAKH: Khóa chính
- **XE** (BIENSO, NUOCSX, LOAIXE, SOPK, SOKHUNG, SOSUON, MAUXE, MAKH) - CAR
    - BIENSO: Khóa chính
    - MAKH: Khóa ngoại tham chiếu đến KHACHHANG
- **CONGVIEC_HOPDONG** (MAHD, MACV, MATHO, TRIGIACV) - CONTRACT_WORK
    - (MAHD, MACV, MATHO): Khóa chính tổng hợp
    - MAHD: Khóa ngoại tham chiếu đến HOPDONG
    - MACV: Khóa ngoại tham chiếu đến CONGVIEC
    - MATHO: Khóa ngoại tham chiếu đến THO