

### **1. Hiểu rõ yêu cầu**

Trước tiên, bạn cần hiểu rõ:

- **Mục đích của API:** API này phục vụ cho tính năng nào?
- **Người dùng mục tiêu:** Ai sẽ sử dụng API (frontend, mobile app, hệ thống khác)?
- **Dữ liệu cần xử lý:** Loại dữ liệu nào API sẽ thao tác (ví dụ: danh sách người dùng, sản phẩm, bài viết)?
- **Hành động cần hỗ trợ:** API cần thực hiện những hành động gì (CRUD: Create, Read, Update, Delete)?

Ví dụ: Nếu được yêu cầu thiết kế API cho quản lý sản phẩm, bạn cần xác định:
- Mục tiêu: CRUD cho sản phẩm.
- Dữ liệu: Tên sản phẩm, giá, mô tả, trạng thái còn hàng.

---

### **2. Xác định tài nguyên (Resource)**

Trong RESTful API, tài nguyên là các đối tượng dữ liệu chính.  
Ví dụ: Với API quản lý sản phẩm, tài nguyên chính là **products**.

---

### **3. Định nghĩa các endpoint**

Tuân theo quy tắc RESTful:

- **GET:** Lấy dữ liệu.
- **POST:** Tạo mới.
- **PUT/PATCH:** Cập nhật.
- **DELETE:** Xóa.

Ví dụ cho tài nguyên **products**:

|HTTP Method|Endpoint|Mô tả|
|---|---|---|
|GET|`/products`|Lấy danh sách sản phẩm|
|GET|`/products/:id`|Lấy thông tin chi tiết|
|POST|`/products`|Tạo sản phẩm mới|
|PUT|`/products/:id`|Cập nhật sản phẩm|
|DELETE|`/products/:id`|Xóa sản phẩm|

---

### **4. Thiết kế dữ liệu (Request/Response)**

Xác định các trường dữ liệu cần thiết:

#### **Ví dụ: POST `/products`**

- **Request Body:**

json

Sao chép mã

`{   "name": "Product A",   "price": 100,   "description": "A great product",   "inStock": true }`

- **Response:**

json

Sao chép mã

`{   "id": 1,   "name": "Product A",   "price": 100,   "description": "A great product",   "inStock": true,   "createdAt": "2024-12-25T12:00:00Z" }`

#### **Ví dụ: GET `/products`**

- **Response:**

json

Sao chép mã

`[   {     "id": 1,     "name": "Product A",     "price": 100,     "description": "A great product",     "inStock": true   },   {     "id": 2,     "name": "Product B",     "price": 150,     "description": "Another product",     "inStock": false   } ]`

---

### **5. Thiết lập các tiêu chuẩn khác**

- **Mã trạng thái HTTP:** Đảm bảo sử dụng mã trạng thái chuẩn:
    
    - `200 OK`: Thành công.
    - `201 Created`: Tạo thành công.
    - `400 Bad Request`: Dữ liệu không hợp lệ.
    - `404 Not Found`: Không tìm thấy tài nguyên.
    - `500 Internal Server Error`: Lỗi máy chủ.
- **Xác thực (Authentication):**  
    Ví dụ: Sử dụng token (JWT) trong header.
    
    http
    
    Sao chép mã
    
    `Authorization: Bearer <your-token>`
    
- **Xử lý lỗi:**  
    Trả về thông báo lỗi rõ ràng.
    
    json
    
    Sao chép mã
    
    `{   "error": "Invalid input data",   "details": ["price must be a positive number"] }`
    

---

### **6. Xây dựng và demo mã nguồn (nếu yêu cầu)**

Nếu phỏng vấn yêu cầu viết code:

- **Chọn framework:** ExpressJS là một lựa chọn tốt.
- **Ví dụ: API tạo sản phẩm với ExpressJS:**

```js

const express = require('express');
const app = express();
app.use(express.json());

let products = [];
let id = 1;

app.post('/products', (req, res) => {
  const { name, price, description, inStock } = req.body;
  if (!name || price === undefined) {
    return res.status(400).json({ error: "Name and price are required" });
  }
  
  const product = { id: id++, name, price, description, inStock };
  products.push(product);
  res.status(201).json(product);
});

app.listen(3000, () => console.log('Server running on port 3000'));

```
---

### **7. Chuẩn bị trả lời câu hỏi thêm**

- **Cách tối ưu hóa API:**
    - Cache dữ liệu với Redis.
    - Phân trang (pagination) khi trả về danh sách lớn.
    - Giới hạn request (rate limiting) để tránh DDoS.
- **Cách đảm bảo bảo mật:**
    
    - Dùng HTTPS.
    - Xác thực bằng token.
    - Kiểm tra input để tránh SQL Injection hoặc XSS.


---
## Liên quan

#nodejs #api #rest-api