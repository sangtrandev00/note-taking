---
layout: post
title: "Cách thiết kế database như thế nào ? 10 bước thiết kế database cho Backend Engineer"
date: 2025-12-16 10:00:00 +0700
categories: concept-base technical interview fullteron health
tags: ["mysql", "database", "sql", "nosql"]
source_path: "Evergreen/concept-base/technical/interview/fullteron health/Cách thiết kế database như thế nào ? 10 bước thiết kế database cho Backend Engineer.md"
---
---
profileName: sangtrandev00
postId: 3436
postType: post
categories:
  - 39
---
**Câu hỏi 1: Em có thiết kế database không?**  
**Trả lời:**

- Có, em đã tham gia vào việc thiết kế database trong các dự án mà em làm việc, bao gồm cả việc thiết kế mới và tối ưu hóa các cơ sở dữ liệu hiện có.
- Em sử dụng các hệ quản trị cơ sở dữ liệu như MySQL, MSSQL, MariaDB và cũng có kinh nghiệm với NoSQL (như Redis) để xử lý các tình huống đặc thù.

---

**Câu hỏi 2: Khi thiết kế database, em sẽ thực hiện các bước gì?**  
**Trả lời:**  
Khi thiết kế database, em thường tuân theo các bước sau để đảm bảo cơ sở dữ liệu vừa hiệu quả, vừa dễ bảo trì:

## **1. Thu thập và phân tích yêu cầu**

- **Mục tiêu**: Hiểu rõ các yêu cầu từ phía khách hàng, business analyst hoặc đội phát triển.
- **Ví dụ**: Định nghĩa rõ các đối tượng (entities) cần lưu trữ, như "nhân viên", "hóa đơn", "phòng" trong hệ thống HRM hoặc RMS.
- **Kết quả**: Danh sách các chức năng chính và các trường dữ liệu cần thiết.

---

## **2. Xác định các thực thể (entities) và mối quan hệ (relationships)**

- **Mục tiêu**: Xác định các bảng chính trong cơ sở dữ liệu và mối quan hệ giữa chúng (1-1, 1-n, n-n).
- **Ví dụ**: Trong hệ thống quản lý nhân sự, xác định mối quan hệ giữa bảng `employees` (nhân viên) và bảng `departments` (phòng ban).

---

## **3. Tạo mô hình ERD (Entity-Relationship Diagram)**

- **Mục tiêu**: Vẽ sơ đồ ERD để trực quan hóa các bảng và quan hệ của chúng.
- **Công cụ hỗ trợ**: Sử dụng MySQL Workbench, Navicat, hoặc các công cụ trực tuyến như Draw.io.

---

## **4. Chuẩn hóa cơ sở dữ liệu (Database Normalization)**

- **Mục tiêu**: Áp dụng các bước chuẩn hóa (1NF, 2NF, 3NF) để loại bỏ dữ liệu dư thừa, giảm thiểu rủi ro lỗi logic và tối ưu hiệu năng.
- **Ví dụ**: Chuyển các trường dữ liệu lặp lại từ một bảng sang bảng riêng biệt và sử dụng khóa ngoại (foreign keys) để liên kết.

---

## **5. Định nghĩa các chỉ mục và tối ưu hiệu năng**

- **Mục tiêu**: Xác định các cột cần đánh chỉ mục (indexes) để tăng tốc độ truy vấn.
- **Ví dụ**: Đánh chỉ mục trên các cột thường xuyên được dùng để lọc, như `employeeId` và `isDeleted`.

---

## **6. Lập kế hoạch xử lý dữ liệu lớn (scalability)**

- **Mục tiêu**: Đảm bảo cơ sở dữ liệu có thể mở rộng khi dữ liệu tăng trưởng.
- **Cách làm**:
    - Sử dụng kỹ thuật **partitioning** để chia bảng lớn.
    - Áp dụng **replication** hoặc **sharding** nếu cần.

---

## **7. Viết migrations và thực thi**

- **Mục tiêu**: Sử dụng công cụ migration (ví dụ TypeORM) để tạo, chỉnh sửa và triển khai cấu trúc database.
- **Lợi ích**: Đảm bảo sự đồng bộ giữa môi trường phát triển, staging, và production.

---

## **8. Kiểm tra và tinh chỉnh (Testing and Optimization)**

- **Mục tiêu**: Kiểm tra hiệu năng của các truy vấn SQL, xem xét kế hoạch thực thi (execution plan) và tối ưu nếu cần.
- **Công cụ hỗ trợ**: SQL Profiler (cho MSSQL), EXPLAIN (cho MySQL).

---

## **9. Đảm bảo an toàn dữ liệu**

- **Mục tiêu**: Thiết lập các chính sách bảo mật như phân quyền truy cập (Role-based access control), mã hóa dữ liệu nhạy cảm (encryption).
- **Ví dụ**: Mã hóa các trường như mật khẩu, số thẻ ngân hàng.

---

## **10. Theo dõi và bảo trì (Monitoring and Maintenance)**

- **Mục tiêu**: Đảm bảo database luôn hoạt động ổn định thông qua việc giám sát hiệu năng, backup định kỳ và cải tiến dựa trên phản hồi thực tế.

---
## Liên quan

#database #sql

---
*Nguồn: Evergreen/concept-base/technical/interview/fullteron health/Cách thiết kế database như thế nào ? 10 bước thiết kế database cho Backend Engineer.md*