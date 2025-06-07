
## 1. Dựa vào sơ đồ quy trình và kết quả khảo sát, hãy phát họa mô hình hoạt động của quy trình khám bệnh tại bệnh viện Trung Ương Huế có ứng dụng công nghệ thông tin

Dựa vào sơ đồ quy trình khám bệnh và thông tin về CSHT CNTT của bệnh viện Trung Ương Huế, em sẽ mô tả chi tiết cách CNTT được ứng dụng vào từng bước trong quy trình:

### Bước 1: Người bệnh đến lấy số thứ tự
+ Hệ thống máy in sẽ in số tự động theo thứ tự trong ngày
+ Người bệnh được cấp số và chờ đến lượt khám
### Bước 2: Tiếp nhận bệnh nhân

- ** Nộp số thứ tự tại phòng khám**
    - Hệ thống quản lý bệnh nhân **tiếp nhận thông tin** khi bệnh nhân nộp số thứ tự
    - Hệ thống **cấp số nhập viện và tem nhập viện** (số nhập viện lưu động)
    - Thông tin bệnh nhân được **lưu trữ trên máy chủ trung tâm**
    - Tem nhập viện giúp định danh bệnh nhân chính xác trong quá trình điều trị
### Bước 3: Khám bệnh và chỉ định

- **Bác sĩ khám bệnh**
    - Bác sĩ **truy cập thông tin bệnh nhân** thông qua tem nhập viện (GET)
    - **Ghi nhận kết quả khám** vào hệ thống quản lý bệnh nhân (INPUT)
    - **Nhập chỉ định xét nghiệm, chụp phim, siêu âm** vào hệ thống (INPUT)
    - Thông tin được **đồng bộ tự động** với các phòng khám, xét nghiệm và tài chính
### Bước 4-5-6: Xét nghiệm và thanh toán

- **Chi định XN → Quầy thu viện phí → Làm các XN → Có kết quả XN**
    - Nhân viên thu phí **truy cập thông tin chỉ định** từ hệ thống (GET)
    - **Module thu phí** tính toán chi phí xét nghiệm, ghi nhận tạm ứng (COMPUTE)
    - Người bệnh được **cấp phiếu hướng dẫn** làm xét nghiệm (GET)
    - Kỹ thuật viên xét nghiệm **truy xuất yêu cầu XN** qua tem nhập viện (GET)
    - **Nhập kết quả xét nghiệm** vào hệ thống quản lý bệnh nhân (INPUT)
    - Kết quả được **lưu trữ tập trung** và liên kết với hồ sơ bệnh nhân (INPUT)

### Bước 7-8: Kết luận và quyết định của bác sĩ

- **Có kết quả XN → Bác sĩ khám bệnh → Nhập viện hoặc Không nhập viện**
    - Bác sĩ **truy cập kết quả XN** từ hệ thống
    - **Cập nhật chẩn đoán** và quyết định nhập viện hoặc không
    - Nếu nhập viện: **cập nhật thông tin** vào module quản lý bệnh nhân
    - Nếu không nhập viện: **kê đơn thuốc** vào hệ thống

### Bước 9-10: Thanh toán và nhận thuốc

- **Không nhập viện → Quầy thu viện phí → Lĩnh thuốc**
    - Module thu phí **tự động tính toán** các chi phí khám, xét nghiệm
    - **Áp dụng các chế độ miễn giảm** cho đối tượng phù hợp
    - Thu ngân **truy cập thông tin từ hệ thống** và thu phí
    - Nhà thuốc **truy cập đơn thuốc** thông qua hệ thống
    - Module quản lý dược **cập nhật thông tin xuất thuốc**
    - Hệ thống **tự động theo dõi nhập-xuất-tồn kho** thuốc

## 2. Phân tích ưu, nhược điểm và giải pháp phát triển CSHT CNTT

### A. Phần cứng

#### Ưu điểm:

- Hệ thống mạng tương đối hoàn chỉnh với **cáp quang cho 3 đường backbone**
- Phủ sóng diện tích rộng (**>12 hécta**) đáp ứng nhu cầu hiện tại và tương lai
- Có giải pháp **dự phòng dữ liệu** với máy chủ backup
- Hệ thống **điện ưu tiên và lưu trữ điện** đảm bảo hoạt động liên tục
- Đã có **kế hoạch mở rộng** cho các tòa nhà sắp xây dựng

#### Nhược điểm:

- Chỉ có **01 máy chủ chính và 01 máy backup**, không đủ cho bệnh viện tuyến Trung ương
- Sao lưu qua **CDROM hạn chế về dung lượng** và không phù hợp với dữ liệu lớn
- **50 máy con** có thể chưa đủ đáp ứng cho bệnh viện quy mô lớn
- Không đề cập đến **thiết bị di động** cho việc truy cập linh hoạt
- Không rõ **cấu hình cụ thể** của máy chủ và thiết bị đầu cuối

#### Giải pháp phát triển:

- Triển khai **hệ thống máy chủ cụm** (cluster) tăng khả năng xử lý và sẵn sàng cao
- Nâng cấp giải pháp sao lưu dữ liệu với **NAS/SAN** (Network Attached Storage) thay vì CDROM
- Tăng số lượng máy trạm đảm bảo **mỗi vị trí làm việc đều có thiết bị** phù hợp
- Đầu tư **thiết bị di động** (tablet, điện thoại thông minh) cho nhân viên y tế
- Triển khai **thiết bị chuyên dụng y tế** như máy quét mã vạch, máy in tem nhập viện
- Xây dựng **trung tâm dữ liệu đạt chuẩn Tier II/III** đảm bảo hoạt động liên tục

### B. Phần mềm

#### Ưu điểm:

- Phần mềm toàn diện với **3 module liên kết chặt chẽ** (bệnh án-thu phí-dược)
- **Tem nhập viện lưu động** giúp xác định chính xác bệnh nhân trong quy trình
- Hình thức thu phí linh hoạt: **tạm ứng nhiều lần, thanh toán một lần**
- Quản lý dược đầy đủ **3 khâu: nhập - xuất - tồn**
- **Báo cáo tự động** hàng ngày cho ban giám đốc
- **Công khai chi phí** hàng ngày giúp bệnh nhân nắm rõ thông tin
- Hỗ trợ **các chế độ miễn giảm** cho đối tượng chính sách

#### Nhược điểm:

- Chưa tích hợp hệ thống **chẩn đoán hình ảnh (PACS) và xét nghiệm (LIS)**
- Chưa phát triển **module quản lý khám ngoại trú** (mới đang chuẩn bị)
- Không đề cập đến **giao diện trên thiết bị di động**
- Thiếu tính năng **phân tích dữ liệu nâng cao** và hỗ trợ quyết định
- Chưa có khả năng **tương tác với bệnh nhân** sau khi ra viện
- Không đề cập đến khả năng **tích hợp với hệ thống BHYT**

#### Giải pháp phát triển:

- Phát triển thêm **module khám ngoại trú, quản lý nhân lực, đào tạo từ xa**
- Tích hợp với hệ thống:
    - **PACS**: lưu trữ và truyền hình ảnh y khoa
    - **LIS**: quản lý thông tin xét nghiệm
    - **BHYT**: kết nối dữ liệu bảo hiểm y tế
- Phát triển **ứng dụng di động** cho nhân viên y tế và bệnh nhân
- Ứng dụng **AI/ML trong chẩn đoán** và hỗ trợ quyết định lâm sàng
- Xây dựng **hệ thống BI** (Business Intelligence) để phân tích dữ liệu
- Triển khai **đặt lịch khám online** và tư vấn từ xa

### C. Tài nguyên mạng

#### Ưu điểm:

- Sử dụng **cáp quang cho backbone** đảm bảo tốc độ cao
- Mạng **phủ sóng diện tích lớn** trên 12 hécta
- Đã có kế hoạch mở rộng cho các tòa nhà mới

#### Nhược điểm:

- Thiếu thông tin về **kết nối internet** và khả năng truy cập từ xa
- Không đề cập đến **giải pháp mạng không dây** (WiFi)
- Thiếu chiến lược **bảo mật mạng** và phân vùng mạng
- Không rõ về **dự phòng đường truyền** khi có sự cố
- Chưa đề cập đến **băng thông** và quy hoạch IP

#### Giải pháp phát triển:

- Triển khai **mạng WiFi** với độ phủ sóng toàn bệnh viện:
    - WiFi cho nhân viên y tế với bảo mật cao
    - WiFi cho bệnh nhân và người nhà
- Xây dựng hệ thống **VPN an toàn** cho truy cập từ xa
- **Phân vùng mạng (VLAN)** cho từng bộ phận chức năng
- Triển khai **kết nối internet dự phòng** từ nhiều nhà cung cấp
- Áp dụng **SDN** (Software-Defined Networking) để quản lý mạng hiệu quả
- Xây dựng **trung tâm giám sát mạng NOC** (Network Operation Center)

### D. Quản trị và bảo mật

#### Ưu điểm:

- Có giải pháp **sao lưu dữ liệu hàng ngày**
- Hệ thống **điện ưu tiên** đảm bảo hoạt động liên tục
- Có máy chủ backup dự phòng

#### Nhược điểm:

- Thiếu **chính sách bảo mật** toàn diện
- Chưa đề cập đến **phòng chống mã độc** và tấn công mạng
- Không rõ về **quy trình quản lý sự cố** và khôi phục dữ liệu
- Thiếu giải pháp **bảo vệ dữ liệu y tế nhạy cảm**
- Không đề cập đến **phân quyền truy cập** hệ thống
- Chưa rõ về **quy trình vận hành tiêu chuẩn** (SOP)

#### Giải pháp phát triển:

- Xây dựng **chính sách bảo mật toàn diện** theo tiêu chuẩn ISO 27001
- Triển khai hệ thống bảo mật nhiều lớp:
    - Firewall phần cứng và phần mềm
    - Hệ thống IDS/IPS (phát hiện và ngăn chặn xâm nhập)
    - Anti-malware và anti-virus
- **Mã hóa dữ liệu** nhạy cảm của bệnh nhân
- Xây dựng **kế hoạch BCP và DRP** đối phó thảm họa
- **Đào tạo nhận thức bảo mật** cho toàn bộ nhân viên
- Triển khai **SIEM** để giám sát an ninh thông tin 24/7
- Thực hiện **đánh giá bảo mật** và kiểm thử xâm nhập định kỳ
- Xây dựng **hệ thống phân quyền RBAC** (Role-Based Access Control)
- Tuân thủ các **quy định bảo vệ dữ liệu y tế**

Việc nâng cấp và phát triển CSHT CNTT của bệnh viện Trung Ương Huế nên được thực hiện theo lộ trình hợp lý, với các mục tiêu ngắn hạn, trung hạn và dài hạn, đảm bảo tính liên tục của dịch vụ và tối ưu hóa chi phí đầu tư.
