# 1. Mô tả các thành phần cấu tạo CSHT CNTT của Tiki

Cơ sở hạ tầng CNTT bao gồm 4 thành phần chính: phần cứng, phần mềm, tài nguyên mạng, và quản trị bảo mật. Dưới đây là mô tả các thành phần của Tiki:

## 1.1. Phần cứng

- **Hệ thống máy chủ**: Tiki sử dụng hạ tầng đám mây từ Google Cloud, cho phép mở rộng linh hoạt theo nhu cầu sử dụng
- **Trung tâm dữ liệu**: Tiki có các trung tâm dữ liệu được thiết kế theo tiêu chuẩn cao, hỗ trợ lưu trữ và xử lý lượng lớn dữ liệu
- **Hệ thống kho bãi tự động**: TikiNOW Smart Logistics gồm 20 Trung tâm Thực hiện Đơn hàng và Kho bãi với các hệ thống robot tự động
- **Thiết bị đầu cuối**: Hệ thống máy tính, thiết bị di động phục vụ cho nhân viên làm việc và quản lý

## 1.2. Phần mềm

- **Hệ thống quản lý nội dung (CMS)**: Nền tảng Custom Cart được phát triển riêng cho Tiki
- **Phần mềm quản lý hàng tồn kho**: Hệ thống Arcturus được phát triển nội bộ để quản lý hàng tồn kho
- **Ứng dụng di động**: Phát triển bằng React Native, tương thích với cả iOS và Android
- **Phần mềm phân tích dữ liệu**: Sử dụng Google Analytics, Amplitude, Hotjar để phân tích hành vi người dùng
- **Phần mềm quản lý đơn hàng**: Hệ thống quản lý đơn hàng, xử lý thanh toán và vận chuyển

## 1.3. Tài nguyên mạng

- **Mạng phân phối nội dung (CDN)**: Hợp tác với VNCDN (giải pháp CDN của VNETWORK) để tăng tốc độ truyền tải nội dung
- **API và khung tích hợp**: Nền tảng OpenAPI (open.tiki.vn) cho phép tích hợp với các dịch vụ và đối tác
- **Hệ thống cơ sở dữ liệu**: Sử dụng MySQL và PostgreSQL cho dữ liệu giao dịch và BigQuery của Google Cloud cho kho dữ liệu phân tích
- **Kết nối thanh toán**: Tích hợp với nhiều cổng thanh toán như PayTraq, PayPal và các ngân hàng địa phương

## 1.4. Quản trị và bảo mật

- **Hệ thống bảo mật**: Sử dụng Trung tâm Lệnh Bảo mật của Google Cloud để giám sát và quản lý bảo mật
- **Hệ thống phát hiện gian lận**: Sử dụng TensorFlow để đào tạo và quản lý các mô hình phát hiện gian lận
- **Hệ thống sao lưu và khôi phục dữ liệu**: Đảm bảo tính liên tục của hoạt động kinh doanh
- **Quản lý quyền truy cập**: Kiểm soát và giám sát quyền truy cập vào dữ liệu và hệ thống

# 2. Mô hình hoạt động của quy trình mua hàng trên Tiki có ứng dụng CNTT

Quy trình mua hàng trên Tiki có thể được mô hình hóa thành 3 giai đoạn chính, với các thành phần CNTT hỗ trợ cho từng giai đoạn:

## 2.1. Giai đoạn Trước Mua Hàng

`[Bắt đầu] → [Truy cập website/app] → [Đăng nhập] → [Duyệt/Tìm kiếm sản phẩm] → [Xem thông tin sản phẩm] → [Quyết định mua hàng]`

![[Pasted image 20250408215735.png]]



**Các thành phần CNTT hỗ trợ:**

- Website và ứng dụng di động (Custom Cart, React Native)
- Hệ thống xác thực người dùng
- Công cụ tìm kiếm và lọc sản phẩm
- CDN (VNCDN) để tải nhanh hình ảnh và thông tin sản phẩm
- Hệ thống đề xuất sản phẩm dựa trên phân tích dữ liệu
- Công cụ phân tích (Google Analytics, Amplitude) theo dõi hành vi người dùng

## 2.2. Giai đoạn Mua Hàng

`[Thêm vào giỏ hàng] → [Xem giỏ hàng] → [Nhập địa chỉ giao hàng] → [Chọn phương thức thanh toán] → [Xác nhận đơn hàng] → [Thanh toán] → [Xác nhận thanh toán]`

![[Pasted image 20250408215702.png]]

**Các thành phần CNTT hỗ trợ:**

- Hệ thống giỏ hàng (Custom Cart)
- Hệ thống quản lý thông tin khách hàng
- Hệ thống cập nhật hàng tồn kho Arcturus
- Cổng thanh toán (PayTraq, PayPal, các ngân hàng)
- Hệ thống xử lý đơn hàng
- Công nghệ bảo mật giao dịch

## 2.3. Giai đoạn Sau Mua Hàng

`[Xử lý đơn hàng] → [Đóng gói] → [Vận chuyển] → [Theo dõi đơn hàng] → [Giao hàng] → [Đánh giá sản phẩm] → [Hỗ trợ sau bán hàng]`

![[Pasted image 20250408215817.png]]

**Các thành phần CNTT hỗ trợ:**

- Hệ thống quản lý đơn hàng
- Hệ thống quản lý kho hàng và logistics TikiNOW Smart Logistics
- Hệ thống theo dõi đơn hàng cho khách hàng
- Hệ thống đánh giá và bình luận sản phẩm
- Hệ thống hỗ trợ khách hàng đa kênh

# 3. Phân tích ưu, nhược điểm và giải pháp phát triển

## 3.1. Phần cứng

**Ưu điểm:**

- Sử dụng hạ tầng đám mây Google Cloud giúp mở rộng linh hoạt, tăng độ tin cậy
- Hệ thống kho bãi tự động giúp tối ưu hóa quy trình vận hành
- Khả năng xử lý khối lượng giao dịch lớn nhờ cơ sở hạ tầng mạnh

**Nhược điểm:**

- Phụ thuộc vào nhà cung cấp đám mây bên thứ ba
- Chi phí duy trì và vận hành hệ thống kho bãi tự động cao
- Đầu tư ban đầu lớn cho cơ sở hạ tầng

**Giải pháp phát triển:**

- Xây dựng chiến lược đa đám mây (multi-cloud) để giảm thiểu rủi ro phụ thuộc
- Tối ưu hóa quy trình kho bãi và logistics dựa trên phân tích dữ liệu
- Đầu tư thêm vào công nghệ tự động hóa và AI để nâng cao hiệu suất

## 3.2. Phần mềm

**Ưu điểm:**

- Nền tảng tùy chỉnh (Custom Cart) đáp ứng đúng nhu cầu kinh doanh
- Hệ thống quản lý hàng tồn kho Arcturus có khả năng xử lý đồng thời cao
- Ứng dụng di động đa nền tảng giúp tiếp cận nhiều người dùng

**Nhược điểm:**

- Chi phí phát triển và bảo trì phần mềm tùy chỉnh cao
- Hệ thống phức tạp đòi hỏi đội ngũ kỹ thuật chuyên sâu
- Cần cập nhật liên tục để theo kịp công nghệ mới

**Giải pháp phát triển:**

- Chuyển đổi sang kiến trúc microservices để tăng tính mô-đun và khả năng mở rộng
- Tối ưu hóa giao diện người dùng dựa trên phân tích hành vi
- Áp dụng DevOps và CI/CD để nâng cao hiệu quả phát triển và triển khai

## 3.3. Tài nguyên mạng

**Ưu điểm:**

- CDN mạnh mẽ giúp tăng tốc độ tải trang và trải nghiệm người dùng
- Nền tảng API mở tạo điều kiện tích hợp với đối tác và bên thứ ba
- Hệ thống cơ sở dữ liệu kết hợp giữa quan hệ và kho dữ liệu phân tích

**Nhược điểm:**

- Phụ thuộc vào nhà cung cấp CDN bên thứ ba
- Tiềm ẩn rủi ro bảo mật nếu API không được quản lý đúng cách
- Phức tạp trong việc quản lý nhiều loại cơ sở dữ liệu khác nhau

**Giải pháp phát triển:**

- Đánh giá và tối ưu hiệu suất CDN thường xuyên
- Triển khai các biện pháp bảo mật API mạnh mẽ
- Cải thiện hiệu suất cơ sở dữ liệu bằng cách tối ưu hóa truy vấn và cấu trúc dữ liệu

## 3.4. Quản trị và bảo mật

**Ưu điểm:**

- Sử dụng công nghệ bảo mật tiên tiến từ Google Cloud
- Khả năng phát hiện gian lận bằng mô hình học máy
- Hệ thống sao lưu đảm bảo tính liên tục của hoạt động kinh doanh

**Nhược điểm:**

- Cần liên tục cập nhật để đối phó với các mối đe dọa mới
- Rủi ro về quyền riêng tư dữ liệu khi thu thập nhiều thông tin người dùng
- Chi phí triển khai các giải pháp bảo mật cao cấp

**Giải pháp phát triển:**

- Triển khai các biện pháp bảo mật mạnh mẽ hơn dựa trên AI
- Cải thiện quy trình quản lý sự cố và khôi phục sau thảm họa
- Tăng cường xác thực đa yếu tố và kiểm soát truy cập

Qua phân tích trên, có thể thấy Tiki đã xây dựng một CSHT CNTT vững mạnh, tích hợp nhiều công nghệ tiên tiến để hỗ trợ các hoạt động kinh doanh. Để duy trì lợi thế cạnh tranh, Tiki cần tiếp tục đầu tư vào công nghệ, đặc biệt là AI và tự động hóa, đồng thời tối ưu hóa các quy trình hiện có để nâng cao hiệu quả và trải nghiệm người dùng.


