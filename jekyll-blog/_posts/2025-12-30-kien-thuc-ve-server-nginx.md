---
layout: post
title: "Kiến thức về Server - NgInx"
date: 2025-12-30 10:00:00 +0700
categories: concept-base technical interview unitysport
tags: ["nodejs", "javascript", "backend"]
source_path: "Evergreen/concept-base/technical/interview/unitysport/Kiến thức về Server - NgInx.md"
---
Ôn phỏng vấn các kiến thức về server
Ôn lại các câu hỏi được hỏi trong công ty fullterton health

**Nginx** (phát âm là "Engine-X") là một web server mã nguồn mở rất phổ biến, nổi bật với hiệu suất cao và khả năng xử lý nhiều kết nối đồng thời. Nó không chỉ là một web server mà còn có thể hoạt động như một reverse proxy, load balancer và HTTP cache. Để giúp bạn trả lời các câu hỏi về Nginx trong buổi phỏng vấn, tôi sẽ giải thích một số khái niệm cơ bản.

### **Các tính năng chính của Nginx**

1. **Web Server**: Nginx có thể xử lý và phục vụ các tài nguyên tĩnh như HTML, CSS, JavaScript, hình ảnh và video. Đây là công việc chính của Nginx khi đóng vai trò là web server.
    
    **Ví dụ cấu hình đơn giản của Nginx làm web server**:
    
    nginx
    
    Sao chép mã
    
    `server {     listen 80;     server_name example.com;      location / {         root /var/www/html;         index index.html;     } }`
    
    Trong ví dụ trên, Nginx sẽ lắng nghe các yêu cầu HTTP đến port 80 và phục vụ các tệp tĩnh từ thư mục `/var/www/html`.
    
2. **Reverse Proxy**: Nginx có thể đóng vai trò là reverse proxy, có nghĩa là nó nhận yêu cầu từ khách hàng và chuyển tiếp yêu cầu đó đến một máy chủ khác (chẳng hạn như một ứng dụng NodeJS hoặc một server backend khác). Đây là cách phổ biến để phân phối tải cho các server backend.
    
    **Ví dụ cấu hình reverse proxy**:
    
    nginx
    
    Sao chép mã
    
    `server {     listen 80;     server_name example.com;      location / {         proxy_pass http://localhost:3000; # Chuyển tiếp yêu cầu tới server backend     } }`
    
    Khi người dùng truy cập `example.com`, yêu cầu sẽ được chuyển đến ứng dụng NodeJS đang chạy trên `localhost:3000`.
    
3. **Load Balancer**: Nginx cũng có thể hoạt động như một **load balancer** phân phối các yêu cầu đến nhiều server backend, giúp tối ưu hóa hiệu suất và đảm bảo tính khả dụng cao.
    
    **Ví dụ cấu hình load balancing**:
    
    nginx
    
    Sao chép mã
    
    `upstream backend {     server backend1.example.com;     server backend2.example.com; }  server {     listen 80;     server_name example.com;      location / {         proxy_pass http://backend; # Lệnh này chuyển tiếp yêu cầu đến backend     } }`
    
    Trong ví dụ này, Nginx sẽ phân phối yêu cầu giữa hai backend server (`backend1.example.com` và `backend2.example.com`).
    
4. **HTTP Cache**: Nginx có khả năng caching hiệu quả các nội dung tĩnh hoặc kết quả từ các server backend. Điều này giúp giảm tải cho server backend và cải thiện tốc độ tải trang cho người dùng.
    
    **Ví dụ cấu hình cache trong Nginx**:
    
    nginx
    
    Sao chép mã
    
    `location /images/ {     proxy_cache my_cache;     proxy_cache_valid 200 1h;     proxy_pass http://backend; }`
    
    Trong ví dụ này, Nginx sẽ lưu trữ (cache) các tài nguyên hình ảnh và sử dụng cache trong 1 giờ. Điều này giúp giảm số lượng yêu cầu đến server backend.
    
5. **SSL/TLS Termination**: Nginx có thể xử lý mã hóa SSL/TLS, bảo vệ kết nối giữa người dùng và server. Khi sử dụng SSL, Nginx sẽ giải mã dữ liệu trước khi chuyển tiếp đến server backend.
    
    **Ví dụ cấu hình SSL trong Nginx**:
    
    nginx
    
    Sao chép mã
    
    `server {     listen 443 ssl;     server_name example.com;      ssl_certificate /etc/nginx/ssl/example.crt;     ssl_certificate_key /etc/nginx/ssl/example.key;      location / {         root /var/www/html;         index index.html;     } }`
    
    Trong cấu hình trên, Nginx sẽ lắng nghe các kết nối HTTPS trên port 443 và sử dụng chứng chỉ SSL được chỉ định.
    

### **Các kỹ thuật Cache dữ liệu trong Nginx**

1. **Proxy Cache**: Nginx có thể cache các response từ các server backend và phục vụ trực tiếp từ cache. Điều này giúp giảm tải cho server và cải thiện hiệu suất.
    
    - **Cache-Control**: Cấu hình header HTTP để chỉ định thời gian lưu trữ cache. Ví dụ: `Cache-Control: public, max-age=3600` sẽ cho phép cache trong 1 giờ.
2. **FastCGI Cache**: Dành cho các ứng dụng PHP hoặc các ứng dụng web động khác. Khi sử dụng FastCGI, bạn có thể cache các kết quả trả về từ ứng dụng và phục vụ nhanh chóng mà không cần xử lý lại.
    

### **Tóm tắt cách sử dụng Nginx**

- **Web Server**: Đảm bảo Nginx phục vụ các tài nguyên tĩnh một cách nhanh chóng.
- **Reverse Proxy**: Chuyển tiếp yêu cầu từ người dùng đến các server backend.
- **Load Balancer**: Phân phối yêu cầu đến nhiều server backend để tăng tính khả dụng và hiệu suất.
- **Caching**: Giảm tải cho server bằng cách lưu trữ tạm thời kết quả các yêu cầu, giúp tăng tốc độ cho người dùng.
- **SSL/TLS Termination**: Quản lý kết nối bảo mật HTTPS, giúp bảo vệ dữ liệu trong quá trình truyền tải.

### **Cách ngăn ngừa một số lỗi thường gặp trong Nginx**

1. **Thiết lập quá tải (Rate Limiting)**: Nếu bạn có quá nhiều yêu cầu từ một địa chỉ IP, bạn có thể ngăn chặn hoặc giới hạn bằng cách sử dụng `limit_req`.
2. **Dữ liệu nhạy cảm**: Nginx có thể bảo vệ các đường dẫn nhạy cảm bằng cách yêu cầu xác thực.

---
*Nguồn: Evergreen/concept-base/technical/interview/unitysport/Kiến thức về Server - NgInx.md*