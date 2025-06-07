---
layout: post
title: "Cách thiết kế một test đơn giản để kiểm tra 1 API"
date: 2025-12-29 10:00:00 +0700
categories: concept-base technical interview unitysport
tags: ["nodejs", "javascript", "database", "api", "interview"]
source_path: "Evergreen/concept-base/technical/interview/unitysport/Cách thiết kế một test đơn giản để kiểm tra 1 API.md"
---
---
profileName: sangtrandev00
postId: 3587
postType: post
categories:
  - 39
---
### **1. Xác định API cần kiểm tra**

Giả sử API cần kiểm tra là một **GET API** trả về danh sách người dùng từ endpoint `/users`.

- **Input**: Không cần tham số hoặc có tham số, ví dụ: `/users?page=1`.
- **Output**: JSON chứa danh sách người dùng với status code 200.

---

### **2. Thiết kế bài test (Unit Test)**

- Mục tiêu của unit test là kiểm tra logic của API handler mà không cần gọi API thực sự.
- Sử dụng **Jest** (thường dùng với Node.js) và **Supertest** để mô phỏng request/response.

#### **Kế hoạch kiểm tra:**

1. Đảm bảo API trả về đúng status code (200 OK).
2. Đảm bảo trả về đúng cấu trúc dữ liệu (JSON object với mảng người dùng).
3. Xử lý lỗi nếu có (404, 500,...).

---

### **3. Viết Unit Test**

Dưới đây là ví dụ sử dụng Jest và Supertest:

```js

// user.controller.ts (Handler của API)
import { Request, Response } from 'express';

export const getUsers = async (req: Request, res: Response) => {
  const users = [
    { id: 1, name: 'Alice' },
    { id: 2, name: 'Bob' },
  ];
  res.status(200).json(users);
};

```

javascript

```js

// user.test.ts (Unit Test cho API)
import request from 'supertest';
import express from 'express';
import { getUsers } from './user.controller';

// Tạo một Express app mock để test API handler
const app = express();
app.get('/users', getUsers);

describe('GET /users', () => {
  it('should return a list of users with status 200', async () => {
    const response = await request(app).get('/users');

    // Kiểm tra status code
    expect(response.status).toBe(200);

    // Kiểm tra định dạng JSON trả về
    expect(response.body).toEqual([
      { id: 1, name: 'Alice' },
      { id: 2, name: 'Bob' },
    ]);
  });

  it('should return an empty list if no users are found', async () => {
    // Giả lập không có user (mock logic)
    app.get('/users', (req, res) => res.status(200).json([]));

    const response = await request(app).get('/users');

    expect(response.status).toBe(200);
    expect(response.body).toEqual([]);
  });
});

```
---

### **4. Giải thích cách thiết kế test**

- **Sử dụng mock server**: Trong bài test, tôi tạo một app mock dùng Express để chỉ kiểm tra logic của API handler mà không phụ thuộc vào database hoặc server thực tế.
- **Kiểm tra nhiều tình huống**: Tôi viết nhiều test case để kiểm tra các kịch bản:
    1. Trả về danh sách người dùng (kết quả đúng).
    2. Trả về danh sách rỗng (tình huống không có dữ liệu).
- **Dễ mở rộng**: Nếu API phức tạp hơn (có tham số, query string, etc.), tôi có thể thêm các test case mới.

---

**5. Gợi ý nâng cao**

- Sử dụng các công cụ như `nock` để giả lập các request tới dịch vụ ngoài.
- Tích hợp CI/CD để tự động chạy các bài test khi có code mới.


---
## Liên quan

#nodejs #testing #unitest #interview

---
*Nguồn: Evergreen/concept-base/technical/interview/unitysport/Cách thiết kế một test đơn giản để kiểm tra 1 API.md*