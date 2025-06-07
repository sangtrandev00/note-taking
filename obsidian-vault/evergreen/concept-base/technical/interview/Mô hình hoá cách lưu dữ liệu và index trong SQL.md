

**Mô hình hóa cách lưu dữ liệu và index trong SQL**

### 1. Cách lưu dữ liệu trong bảng (Table):

- Bảng trong cơ sở dữ liệu được lưu dưới dạng **hàng** và **cột**. Mỗi hàng là một bản ghi (record), và mỗi cột tương ứng với một thuộc tính.
    
- VD: Bảng `employees`:

| ID  | Name    | Department |
| --- | ------- | ---------- |
| 1   | Alice   | HR         |
| 2   | Bob     | Finance    |
| 3   | Charlie | HR         |
| 4   | Diana   | IT         |
| 5   | Eve     | Finance    |

- **Lưu trữ thực tế:**
    
    - Bản ghi được lưu trong dạng hàng trên đĩa cứng.
        
    - Khi truy vấn `WHERE`, database phải duyệt từng hàng (đối với Full Table Scan).
        

### 2. Cách lưu dữ liệu trong Index:

- **Index** là một cấu trúc dữ liệu tổ chức theo thứ tự, thường dưới dạng cây (B-tree).
    
- Nó chỉ lưu giá trị được index (VD: `Department`) và tham chiếu (địa chỉ) đến bản ghi trong bảng.
    
- **VD:** Index trên cột `Department`:

|            |        |     |
| ---------- | ------ | --- |
| Department | RowIDs |     |
| Finance    | [2, 5] |     |
| HR         | [1, 3] |     |
| IT         | [4]    |     |
- **Lưu trữ thực tế:**
    
    - Index được sắp xếp theo thứ tự tăng (hoặc giảm).
        
    - Mỗi giá trị trên cột index đính kèm danh sách tham chiếu (địa chỉ hàng).
        

### 3. Mô hình hoá:

#### **Bàng dữ liệu (Table):**

```
Hàng 1: [ID=1, Name=Alice, Department=HR]
Hàng 2: [ID=2, Name=Bob, Department=Finance]
...
```

#### **Index:**

```
Finance -> Hàng 2, Hàng 5
HR -> Hàng 1, Hàng 3
IT -> Hàng 4
```

#### **Hướng dẫn truy vấn:**

- **Truy vấn:** `SELECT * FROM employees WHERE Department='Finance';`
    
    1. Database tìm giá trị "Finance" trong Index.
        
    2. Nhận RowIDs (2, 5).
        
    3. Truy cập bản ghi tương ứng trong bàng.
        

### 4. Lợi ích:

- **Truy vấn nhanh chóng:** Giảm Full Table Scan.
    
- **Hỗ trợ sắp xếp/nhóm:** Đắt hiệu quả khi sử dụng `ORDER BY`, `GROUP BY`.
    

### 5. Nhược điểm:

- Tăng dung lượng lưu trữ.
    
- Làm chậm thao tác ghi (INSERT/UPDATE/DELETE).