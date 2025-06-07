---
layout: post
title: "Làm thế nào để tối ưu một câu truy vấn SQL chậm ? 5 bước cơ bản để phân tích và tối ưu SQL"
date: 2025-12-19 10:00:00 +0700
categories: concept-base technical interview fullteron health
tags: ["mysql", "database", "sql", "backend"]
source_path: "Evergreen/concept-base/technical/interview/fullteron health/Làm thế nào để tối ưu một câu truy vấn SQL chậm ? 5 bước cơ bản để phân tích và tối ưu SQL.md"
---
---
profileName: sangtrandev00
postId: 3417
postType: post
categories:
  - 39
---
Trong quá trình đi làm được thao tác trực tiếp với cơ sở dữ liệu, đặc biệt là cơ sở dữ liệu SQL mình nhận thấy rằng việc phân tích tại sao một câu lệnh SQL chậm cũng rất quan trọng, nó là kiến thức nền tảng giúp mình tối ưu lênh trong ứng dụng lập trình hàng ngày.
Hơn thế nữa nó cũng là kiến thức nền tảng và thường xuyên được hỏi trong hành trình phỏng vấn Backend Job của mình. 
Vậy có những chiến lược hay các hướng tiếp cận kinh điển nào nên áp dụng khi phân tích một câu lệnh SQL từ đó đưa ra các cơ sở để tối ưu. Hãy cùng đọc bài viết bên dưới nhé

## **1. Phân tích vấn đề**  

Trước tiên, tôi sẽ xác định nguyên nhân khiến truy vấn chậm bằng cách:

- **Sử dụng công cụ profiling hoặc explain/execution plan**:
    - Với MySQL, chạy lệnh `EXPLAIN` để xem cách truy vấn được thực thi (full table scan, index usage, etc.).
    - Kiểm tra thời gian chạy của truy vấn qua SQL profiler (nếu có).
- **Xác định các vấn đề phổ biến**: (Đây là mấu chốt ăn điểm)
    - Quét toàn bộ bảng (full table scan).
    - Thiếu hoặc sử dụng sai index.
    - Joins hoặc subquery phức tạp.
    - Xử lý quá nhiều dữ liệu không cần thiết.

---

## **2. Tối ưu hóa truy vấn**  
Dựa trên kết quả phân tích, tôi sẽ áp dụng các kỹ thuật sau:

- **Thêm hoặc tối ưu hóa Index**:
    
    - Kiểm tra cột nào được dùng trong `WHERE`, `JOIN`, `GROUP BY`, `ORDER BY` và tạo chỉ mục phù hợp.
    - Sử dụng composite index nếu cần tối ưu cho nhiều cột.
    - Tránh over-indexing (chỉ tạo index cho các trường thực sự cần thiết).

- **Giảm kích thước dữ liệu xử lý**:
    
    - **Chỉ lấy dữ liệu cần thiết**:
        
```sql
SELECT column1, column2 FROM table_name WHERE condition;

```
        
	+ Thay vì `SELECT *`, chỉ lấy các cột cần dùng.
	- **Sử dụng LIMIT** nếu chỉ cần kết quả nhỏ.
- **Tối ưu hóa Joins**:
    
    - Sử dụng đúng index cho các cột trong `ON` hoặc `JOIN`.
    - Hạn chế sử dụng quá nhiều bảng hoặc subquery phức tạp.
- **Thêm Filter sớm**:
    
    - Đảm bảo các điều kiện `WHERE` hoặc `HAVING` loại bỏ dữ liệu không cần thiết càng sớm càng tốt.
- **Tối ưu hóa GROUP BY và ORDER BY**:
    
    - Đảm bảo các cột trong `GROUP BY` hoặc `ORDER BY` đã có index.

---

## **3. Tối ưu hóa cấu trúc cơ sở dữ liệu**

- **Chuẩn hóa dữ liệu (Normalization)**:
    - Giảm dữ liệu lặp lại bằng cách tách bảng hợp lý.
- **Sử dụng Partitioning**:
    - Phân chia bảng lớn thành các phân vùng (partitions) để giảm lượng dữ liệu quét mỗi lần.

---

## **4. Kiểm tra sau tối ưu hóa**

- **Chạy lại truy vấn với EXPLAIN**:
    - So sánh execution plan trước và sau tối ưu hóa.
- **Kiểm tra thời gian thực thi**:
    - Đảm bảo truy vấn chạy nhanh hơn sau khi tối ưu hóa.

---

## **5. Giải pháp nâng cao nếu cần thiết**

- **Caching**:
    
    - Lưu kết quả truy vấn hay dùng vào bộ nhớ cache (Redis, Memcached) để giảm truy cập cơ sở dữ liệu.
- **Tối ưu cấu hình server**:
    
    - Tăng các tham số như `innodb_buffer_pool_size` (cho MySQL) để tăng hiệu năng.
- **Sử dụng các công nghệ hỗ trợ**:
    
    - Áp dụng sharding hoặc **replication** nếu dữ liệu quá lớn hoặc có quá nhiều truy vấn đồng thời.

---

## **Ví dụ thực tế** để tối ưu SQL

Giả sử tôi có một truy vấn chậm:

sql

```sql
`SELECT * FROM orders WHERE customer_id = 123 AND order_date >= '2023-01-01';`
```

- **Phân tích**: `EXPLAIN` cho thấy bảng bị quét toàn bộ (full table scan).
- **Giải pháp**:
    - Tạo index composite:
        
        `CREATE INDEX idx_customer_date ON orders(customer_id, order_date);`
        
    - Sử dụng `SELECT` chỉ lấy cột cần thiết:
        `SELECT order_id, order_date, total FROM orders WHERE customer_id = 123 AND order_date >= '2023-01-01';`
        
- Kết quả: Truy vấn nhanh hơn và tiêu tốn ít tài nguyên hơn.

---

## Tóm tắt

Bên trên là chia sẻ về những cách phân tích chiến lược thực thi của câu lệnh SQL từ đó đưa ra các cách thức phù hợp để tối ưu SQL. Đây cũng là nền tảng để giúp mình làm việc tốt hơn, tìm giải pháp nhanh hơn, bên cạnh đó cũng có thể tự tin hơn trong quá trình tham gia trả lời phỏng vấn với các câu hỏi liên quan về Database


## Liên quan

https://chatgpt.com/share/676a73b7-2398-8013-aaa1-36f103cb6c5f

#sql #database

---
*Nguồn: Evergreen/concept-base/technical/interview/fullteron health/Làm thế nào để tối ưu một câu truy vấn SQL chậm ? 5 bước cơ bản để phân tích và tối ưu SQL.md*