
## 1. Dựa vào kết quả khảo sát của bệnh viện Trung Ương Huế, hãy mô tả các thành phần cấu tạo CSHT CNTT

### a) Phần cứng

+ **Hệ thống đường dây và thiết bị đính kèm**:
    - Hệ thống mạng tương đối hoàn chỉnh
    - Áp dụng công nghệ cáp quang cho 3 đường dây chính (backbone)
    - Thiết kế bao phủ diện tích lớn hơn 12 hécta
+ **Máy chủ**:
    - 01 máy chủ chính
    - 01 máy chủ backup (dự phòng)
    - Hệ thống sao lưu dữ liệu: thông qua máy con và CDROM hàng ngày
+ **Máy con (máy trạm)**:
    - Khoảng 50 máy tham gia vào mạng, phân bổ tại các khoa phòng
    - Được kết nối vào hệ thống điện ưu tiên và hệ thống lưu trữ điện
+  **Giải pháp về nguồn điện**:
    - Hệ thống điện ưu tiên của bệnh viện
    - Hệ thống lưu trữ điện (có thể là UPS) cho các thiết bị mạng và máy tính

### b) Phần mềm

+ **Phần mềm quản lý tổng thể**:
    - Phần mềm hoàn chỉnh gồm 3 module liên kết với nhau
    - Sử dụng số nhập viện làm gốc để liên kết thông tin giữa các module
+ **Module quản lý bệnh nhân**:
    - Quản lý thông tin bệnh nhân từ khi nhập viện (cấp số nhập viện và tem nhập viện)
    - Ghi nhận toàn bộ số liệu chuyên môn khám chữa bệnh
    - Lưu trữ hồ sơ bệnh nhân ra viện
    - Tạo báo cáo hoạt động chuyên môn hàng ngày của các khoa phòng
    - Hỗ trợ trích lập số liệu chuyên môn, nghiên cứu khoa học
+  **Module quản lý thu phí**:
    - Quản lý việc tạm ứng nhiều lần và thanh toán một lần
    - Hiển thị công khai chi phí hàng ngày và khi ra viện
    - Quản lý các chế độ miễn giảm
    - Quản lý tài chính (thu chi)
    - Giảm thiểu thất thu cho bệnh viện
+ **Module quản lý dược**:
    - Quản lý nhập-xuất-tồn thuốc hàng ngày
    - Quản lý phân bổ thuốc cho bệnh nhân và khoa phòng
    - Hỗ trợ lên dự trù thuốc

### c) Tài nguyên mạng

- **Hệ thống cáp mạng**:
    - Cáp quang cho 3 đường dây chính (backbone)
    - Hệ thống cáp mạng nội bộ kết nối các khoa phòng
- **Kết nối mạng LAN**:
    - Mạng nội bộ phủ sóng toàn bệnh viện (>12 hécta)
    - Kết nối giữa 50 máy trạm và máy chủ
- **Thiết bị mạng**:
    - Các thiết bị mạng đính kèm theo hệ thống đường dây
    - Thiết bị định tuyến, chuyển mạch để quản lý lưu lượng dữ liệu
- **Băng thông và khả năng truyền dữ liệu**:
    - Khả năng truyền dữ liệu với tốc độ cao nhờ công nghệ cáp quang
    - Đáp ứng nhu cầu sử dụng hiện tại và trong tương lai
### d) Dịch vụ khác

1. **Dịch vụ bảo mật và an toàn dữ liệu**:
    - Hệ thống sao lưu dữ liệu hàng ngày (qua máy con và CDROM)
    - Giải pháp bảo vệ dữ liệu thông qua máy chủ backup
2. **Dịch vụ quản lý và báo cáo**:
    - Dịch vụ báo cáo thống kê hàng ngày, hàng tháng, hàng quý
    - Dịch vụ trích lập báo cáo chuyên môn
    - Dịch vụ quản lý tài chính và thanh toán
3. **Dịch vụ mở rộng và phát triển**:
    - Chuẩn bị cơ sở để phát triển các chương trình khác
    - Quản lý nhân lực
    - Khám chữa bệnh ngoại trú
    - Đào tạo từ xa
4. **Dịch vụ cung cấp điện ưu tiên**:
    - Hệ thống điện ưu tiên cho các thiết bị mạng và máy tính
    - Hệ thống lưu trữ điện đảm bảo hoạt động liên tục

## 2. Trình bày tổng quan (khái niệm, phương thức hoạt động, chức năng)

### a) Giao thức Kerberos

#### Định nghĩa

Kerberos là một giao thức xác thực mạng hoạt động dựa trên cơ chế "ticket" để cho phép các nút mạng chứng minh danh tính của mình với nhau một cách an toàn trên một mạng không an toàn. Giao thức này được phát triển bởi MIT và được đặt tên theo con chó ba đầu Cerberus trong thần thoại Hy Lạp.

#### Phương thức hoạt động

Kerberos hoạt động theo mô hình "bên thứ ba đáng tin cậy" (trusted third-party), trong đó có sự tham gia của:

1. **Client** (người dùng/ứng dụng)
2. **Authentication Server (AS)** và **Ticket Granting Server (TGS)** (cùng tạo thành Key Distribution Center - KDC)
3. **Service Server** (máy chủ cung cấp dịch vụ)

Quy trình hoạt động gồm các bước chính:

1. **Xác thực ban đầu**: Client gửi yêu cầu đến AS, nhận về Ticket Granting Ticket (TGT)
2. **Yêu cầu truy cập dịch vụ**: Client dùng TGT gửi yêu cầu đến TGS để nhận Service Ticket
3. **Sử dụng dịch vụ**: Client sử dụng Service Ticket để xác thực với Service Server

Kerberos sử dụng mã hóa đối xứng (symmetric key) và timestamp để bảo vệ thông tin xác thực và ngăn chặn tấn công phát lại (replay attack).

#### Chức năng

- Xác thực mạnh mẽ giữa client-server
- Single Sign-On (SSO): người dùng chỉ cần xác thực một lần
- Bảo vệ thông tin xác thực khi truyền qua mạng không an toàn
- Hỗ trợ ủy quyền (delegation) và chuyển tiếp xác thực (authentication forwarding)

#### Ví dụ ứng dụng

- Microsoft Active Directory sử dụng Kerberos làm cơ chế xác thực chính
- Các hệ thống Unix/Linux cũng tích hợp Kerberos thông qua gói MIT Kerberos
- Nhiều dịch vụ doanh nghiệp lớn như hệ thống email, chia sẻ tập tin, và truy cập từ xa

### b) Giao thức Secure Socket Layer (SSL)/Transport Layer Security (TLS)

#### Định nghĩa

SSL (Secure Socket Layer) và phiên bản kế nhiệm TLS (Transport Layer Security) là các giao thức mật mã học được thiết kế để cung cấp bảo mật thông tin truyền thông qua mạng máy tính. SSL đã được Netscape phát triển ban đầu và sau đó phát triển thành TLS do IETF tiêu chuẩn hóa.

#### Phương thức hoạt động

SSL/TLS hoạt động thông qua hai giai đoạn chính:

1. **Bắt tay (Handshake)**:
    - Client và server trao đổi thông tin về phiên bản SSL/TLS, bộ mã hóa (cipher suites)
    - Server gửi chứng chỉ số (digital certificate) để client xác minh danh tính
    - Thiết lập khóa phiên (session key) thông qua trao đổi khóa mã hóa bất đối xứng
2. **Truyền dữ liệu**:
    - Dữ liệu được mã hóa bằng khóa phiên (đối xứng) đã thiết lập
    - Mỗi gói tin được bảo vệ bởi mã xác thực thông điệp (MAC - Message Authentication Code)

#### Chức năng

- Đảm bảo tính bảo mật (Confidentiality): thông tin được mã hóa
- Đảm bảo tính toàn vẹn (Integrity): phát hiện sửa đổi dữ liệu
- Xác thực (Authentication): xác minh danh tính của các bên tham gia
- Hỗ trợ nhiều thuật toán mã hóa khác nhau
- Forward secrecy: bảo vệ các phiên trước ngay cả khi khóa bí mật bị xâm phạm

#### Ví dụ ứng dụng

- Bảo mật cho trang web thông qua HTTPS
- Bảo mật cho dịch vụ email (SMTP, IMAP, POP3)
- Bảo mật VPN, giao thức FTP an toàn (FTPS)
- Các ứng dụng thanh toán trực tuyến, ngân hàng điện tử

### c) Giao thức Pretty Good Privacy (PGP)

#### Định nghĩa

PGP (Pretty Good Privacy) là một chương trình mã hóa dữ liệu và một giao thức bảo mật được phát triển bởi Phil Zimmermann vào năm 1991. PGP cung cấp khả năng mã hóa, chữ ký số, và nén dữ liệu, thường được sử dụng để mã hóa email và tập tin.

#### Phương thức hoạt động

PGP kết hợp cả kỹ thuật mã hóa đối xứng và bất đối xứng:

**Khi mã hóa**:

1. Tạo khóa phiên ngẫu nhiên (khóa đối xứng)
2. Mã hóa nội dung thông điệp bằng khóa phiên
3. Mã hóa khóa phiên bằng khóa công khai của người nhận
4. Gửi cả thông điệp đã mã hóa và khóa phiên đã mã hóa

**Khi giải mã**:

1. Giải mã khóa phiên bằng khóa riêng của người nhận
2. Sử dụng khóa phiên để giải mã nội dung thông điệp

**Với chữ ký số**:

1. Tạo hàm băm (hash) của thông điệp
2. Mã hóa giá trị băm bằng khóa riêng của người gửi (tạo chữ ký)
3. Người nhận xác minh chữ ký bằng khóa công khai của người gửi

#### Chức năng

- Mã hóa và giải mã thông điệp
- Chữ ký số và xác minh chữ ký
- Tạo và quản lý cặp khóa mã hóa
- Nén dữ liệu trước khi mã hóa
- Quản lý mạng lưới tin cậy (Web of Trust) để xác thực khóa công khai

#### Ví dụ ứng dụng

- Bảo mật email cá nhân và doanh nghiệp
- Mã hóa tập tin lưu trữ nhạy cảm
- Mã hóa ổ đĩa và phân vùng
- Xác thực tài liệu và phần mềm

### d) Giao thức Secure/Multipurpose Internet Mail Extensions (S/MIME)

#### Định nghĩa

S/MIME (Secure/Multipurpose Internet Mail Extensions) là một tiêu chuẩn cho mã hóa và ký số email dựa trên cú pháp MIME. S/MIME được phát triển bởi RSA Data Security và hiện được duy trì bởi IETF, cung cấp các dịch vụ bảo mật cho truyền thông qua email.

#### Phương thức hoạt động

S/MIME sử dụng công nghệ mã hóa khóa công khai (PKI) và chứng chỉ số X.509:

**Mã hóa email**:

1. Tạo khóa phiên ngẫu nhiên
2. Mã hóa nội dung email bằng khóa phiên
3. Mã hóa khóa phiên bằng khóa công khai của người nhận
4. Đóng gói và gửi theo định dạng MIME

**Chữ ký số**:

1. Tạo hàm băm cho nội dung email
2. Mã hóa giá trị băm bằng khóa riêng của người gửi
3. Đính kèm chữ ký với email

#### Chức năng

- Mã hóa nội dung email để đảm bảo tính bảo mật
- Chữ ký số để xác nhận danh tính người gửi
- Đảm bảo tính toàn vẹn của thông điệp
- Xác thực dựa trên hạ tầng khóa công khai (PKI)
- Không thể phủ nhận nguồn gốc thông điệp (non-repudiation)

#### Ví dụ ứng dụng

- Được tích hợp trong các ứng dụng email phổ biến như Microsoft Outlook, Mozilla Thunderbird
- Truyền thông an toàn trong môi trường doanh nghiệp
- Bảo vệ thông tin nhạy cảm trong các tổ chức tài chính, y tế
- Gửi tài liệu pháp lý qua email một cách an toàn

### So sánh các giao thức bảo mật

|Tiêu chí|Kerberos|SSL/TLS|PGP|S/MIME|
|---|---|---|---|---|
|**Mục đích chính**|Xác thực mạng|Bảo mật kênh truyền|Mã hóa email và tập tin|Bảo mật email|
|**Loại mã hóa**|Đối xứng|Kết hợp đối xứng và bất đối xứng|Kết hợp đối xứng và bất đối xứng|Kết hợp đối xứng và bất đối xứng|
|**Xác thực**|Dựa trên KDC|Chứng chỉ X.509|Web of Trust|Chứng chỉ X.509|
|**Mô hình tin cậy**|Tập trung (KDC)|Phân cấp (CA)|Phi tập trung|Phân cấp (CA)|
|**Tầng OSI**|Application|Transport|Application|Application|
|**Hiệu suất**|Nhẹ|Nặng hơn do handshake|Nhẹ với email|Tương tự PGP|
|**Triển khai**|Phức tạp|Trung bình|Dễ dàng|Trung bình|
|**Phạm vi sử dụng**|Mạng nội bộ|Internet/Web|Cá nhân/Nhóm|Doanh nghiệp|
|**Tiêu chuẩn hóa**|MIT, RFC|IETF|OpenPGP (RFC)|IETF|
|**Đặc trưng nổi bật**|Single Sign-On|Forward secrecy|Web of Trust|Tích hợp với client email|

## 3. Các giao thức phổ biến khác

### 1. SSH (Secure Shell)

#### Định nghĩa

SSH là một giao thức mạng mã hóa được sử dụng để truy cập từ xa và quản lý hệ thống một cách an toàn. SSH cung cấp một kênh bảo mật để thực hiện các lệnh từ xa, chuyển tập tin và tạo đường hầm cho các ứng dụng khác. SSH được phát triển như một giải pháp thay thế an toàn hơn cho các giao thức không bảo mật như Telnet, rlogin và rsh.

#### Phương thức hoạt động

SSH hoạt động theo mô hình client-server và sử dụng mã hóa bất đối xứng để xác thực hai bên tham gia:

1. **Thiết lập kết nối**: Client kết nối đến server và thỏa thuận về phiên bản SSH và thuật toán mã hóa.
2. **Trao đổi khóa**: Server gửi khóa công khai và client tạo khóa phiên, mã hóa bằng khóa công khai của server.
3. **Xác thực**: Client xác thực với server thông qua một trong các phương pháp: mật khẩu, khóa công khai, hoặc phương pháp khác.
4. **Lưu lượng an toàn**: Sau khi xác thực, dữ liệu được mã hóa và truyền qua kênh an toàn.

#### Chức năng

- Truy cập và quản lý hệ thống từ xa an toàn
- Truyền tập tin bảo mật (thông qua SFTP hoặc SCP)
- Tạo đường hầm (tunneling) cho các giao thức khác
- Chuyển tiếp cổng (port forwarding)
- Xác thực dựa trên khóa công khai hoặc mật khẩu
- Nén dữ liệu trong quá trình truyền

#### Ví dụ ứng dụng

- Quản lý máy chủ Linux/Unix từ xa
- Truyền tập tin an toàn giữa các máy tính
- Kết nối đến các dịch vụ đám mây (AWS, Google Cloud)
- Tạo đường hầm bảo mật cho các ứng dụng khác
- Git sử dụng SSH để truy cập repository một cách an toàn

### 2. HTTPS (Hypertext Transfer Protocol Secure)

#### Định nghĩa

HTTPS là phiên bản bảo mật của giao thức HTTP, sử dụng SSL/TLS để mã hóa và bảo mật dữ liệu được trao đổi giữa trình duyệt web và máy chủ web. HTTPS không phải là một giao thức riêng biệt mà là sự kết hợp giữa HTTP thông thường và giao thức mã hóa SSL/TLS.

#### Phương thức hoạt động

HTTPS hoạt động tương tự như HTTP nhưng có thêm lớp bảo mật:

1. **Thiết lập kết nối HTTPS**: Khi người dùng truy cập website qua HTTPS, trình duyệt kết nối đến cổng 443 (thay vì cổng 80 của HTTP).
2. **Bắt tay SSL/TLS**: Trình duyệt và máy chủ thực hiện quá trình bắt tay SSL/TLS để thiết lập kênh bảo mật.
3. **Xác thực máy chủ**: Máy chủ gửi chứng chỉ SSL/TLS để trình duyệt xác thực.
4. **Trao đổi dữ liệu**: Sau khi thiết lập kết nối an toàn, HTTP hoạt động bình thường nhưng được mã hóa.

#### Chức năng

- Mã hóa dữ liệu trao đổi giữa trình duyệt và máy chủ
- Xác thực danh tính của máy chủ web
- Bảo vệ tính toàn vẹn của dữ liệu
- Ngăn chặn tấn công nghe trộm và tấn công trung gian (Man-in-the-Middle)
- Tạo niềm tin cho người dùng (thông qua biểu tượng khóa và chứng chỉ SSL)

#### Ví dụ ứng dụng

- Bảo mật cho các trang web thương mại điện tử
- Bảo vệ thông tin đăng nhập và dữ liệu cá nhân
- Bảo mật các giao dịch ngân hàng trực tuyến
- Bảo vệ dữ liệu nhạy cảm trên các trang web y tế
- Tăng xếp hạng SEO (Google ưu tiên các trang HTTPS)

### 3. OAuth 2.0

#### Định nghĩa

OAuth 2.0 là một giao thức ủy quyền mở, cho phép các ứng dụng bên thứ ba có thể truy cập tài nguyên của người dùng trên một dịch vụ khác mà không cần biết thông tin xác thực của người dùng. OAuth không phải là giao thức xác thực, mà là giao thức ủy quyền, tuy nhiên nó thường được sử dụng kết hợp với các giao thức xác thực như OpenID Connect.

#### Phương thức hoạt động

OAuth 2.0 hoạt động theo mô hình 4 bên:

1. **Resource Owner** (Chủ sở hữu tài nguyên): Thường là người dùng.
2. **Client** (Ứng dụng khách): Ứng dụng muốn truy cập tài nguyên.
3. **Authorization Server** (Máy chủ ủy quyền): Cấp phép truy cập.
4. **Resource Server** (Máy chủ tài nguyên): Nơi lưu trữ tài nguyên.

Quy trình cơ bản:

1. Ứng dụng khách yêu cầu ủy quyền từ chủ sở hữu tài nguyên.
2. Chủ sở hữu ủy quyền cho ứng dụng khách.
3. Ứng dụng khách yêu cầu mã thông báo truy cập (access token) từ máy chủ ủy quyền.
4. Máy chủ ủy quyền cấp mã thông báo truy cập.
5. Ứng dụng khách sử dụng mã thông báo này để truy cập tài nguyên từ máy chủ tài nguyên.

#### Chức năng

- Cung cấp phương thức ủy quyền an toàn
- Cho phép truy cập hạn chế vào tài nguyên của người dùng
- Hỗ trợ nhiều luồng ủy quyền (authorization flows) khác nhau
- Tách biệt xác thực và ủy quyền
- Không chia sẻ thông tin xác thực của người dùng với ứng dụng bên thứ ba

#### Ví dụ ứng dụng

- Đăng nhập bằng tài khoản Google, Facebook, hoặc Microsoft
- Cho phép ứng dụng bên thứ ba truy cập Gmail, Google Drive
- Tích hợp với các dịch vụ API của mạng xã hội
- Ứng dụng di động yêu cầu quyền truy cập tài nguyên
- Hệ thống Single Sign-On (SSO) doanh nghiệp