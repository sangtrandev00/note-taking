---
layout: post
title: "Index là gì ? trong CSDL"
date: 2025-12-03 10:00:00 +0700
categories: concept-base technical interview
tags: ["database", "sql"]
source_path: "Evergreen/concept-base/technical/interview/Index là gì ? trong CSDL.md"
---
Index trong cơ sở dữ liệu SQL là một cấu trúc dữ liệu đặc biệt giúp tăng tốc độ thực hiện các truy vấn (SELECT) trong bảng. Nó hoạt động giống như một cuốn sách có mục lục, cho phép tìm kiếm nhanh chóng thay vì phải quét toàn bộ nội dung.

### **Index là gì?**

- **Khái niệm:** Index là một cấu trúc dữ liệu được tạo ra trên một hoặc nhiều cột của bảng trong cơ sở dữ liệu, nhằm cải thiện hiệu suất truy vấn.
- **Cách hoạt động:** Index lưu trữ một bản sao của các giá trị trong cột được chỉ mục, sắp xếp theo một trật tự nhất định (thường là tăng dần hoặc giảm dần). Dựa vào index, cơ sở dữ liệu có thể nhanh chóng tìm kiếm hoặc sắp xếp các dữ liệu mà không phải duyệt qua toàn bộ bảng (Full Table Scan).

---

### **Tại sao cần dùng Index?**

1. **Tăng tốc độ truy vấn:**
    
    - Với các bảng lớn, việc tìm kiếm hoặc lọc dữ liệu sẽ rất chậm nếu không có index, vì hệ thống phải quét toàn bộ bảng.
    - Index giúp giảm thiểu thời gian truy vấn bằng cách chỉ tập trung vào các bản ghi liên quan.
2. **Hỗ trợ các truy vấn phổ biến:**
    
    - **Truy vấn có điều kiện (`WHERE`):** Ví dụ: `SELECT * FROM employees WHERE department = 'HR'`.
    - **Sắp xếp (`ORDER BY`):** Index giúp sắp xếp nhanh chóng các bản ghi.
    - **Nhóm dữ liệu (`GROUP BY`):** Index cải thiện hiệu suất khi nhóm dữ liệu.
3. **Cải thiện hiệu suất join:**
    
    - Trong các truy vấn `JOIN` giữa các bảng, index giúp xác định nhanh các bản ghi liên quan giữa các bảng.

---

### **Nhược điểm của Index:**

- **Tăng dung lượng lưu trữ:** Index chiếm thêm không gian lưu trữ trong cơ sở dữ liệu.
- **Làm chậm các thao tác ghi:** Các thao tác như thêm, cập nhật, hoặc xóa dữ liệu sẽ chậm hơn, vì hệ thống phải cập nhật lại index.

---

### **Khi nào nên dùng Index?**

- Khi bạn thường xuyên truy vấn dựa trên một cột cụ thể hoặc một nhóm cột.
- Khi bảng chứa lượng dữ liệu lớn.
- Khi có các truy vấn liên quan đến sắp xếp hoặc nhóm dữ liệu.

---

### **Ví dụ thực tế:**

- **Bảng `employees`:**
    
    sql
    
    Sao chép mã
    
    `CREATE TABLE employees (     id INT PRIMARY KEY,     name VARCHAR(100),     department VARCHAR(50),     salary INT );`
    
- Nếu bạn thường xuyên truy vấn theo phòng ban (`department`), bạn có thể tạo index trên cột `department`:
    
    sql
    
    Sao chép mã
    
    `CREATE INDEX idx_department ON employees(department);`
    
- Truy vấn:
    
    sql
    
    Sao chép mã
    
    `SELECT * FROM employees WHERE department = 'HR';`
    
    Khi có index, hệ thống sẽ tìm kiếm nhanh hơn so với khi quét toàn bộ bảng.




https://chatgpt.com/share/67639e8c-558c-8013-bcde-a726cf8c5001


--- 
## Liên quan

#database #data-structure #sql  #index

---
*Nguồn: Evergreen/concept-base/technical/interview/Index là gì ? trong CSDL.md*