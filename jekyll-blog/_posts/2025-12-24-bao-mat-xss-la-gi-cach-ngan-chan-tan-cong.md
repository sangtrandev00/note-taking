---
layout: post
title: "Bảo mật XSS là gì ? Cách ngăn chặn tấn công"
date: 2025-12-24 10:00:00 +0700
categories: concept-base technical interview security
tags: ["javascript", "api"]
source_path: "Evergreen/concept-base/technical/interview/security/Bảo mật XSS là gì ? Cách ngăn chặn tấn công.md"
---
**Cross-Site Scripting (XSS)** là một loại tấn công mà kẻ xấu chèn mã JavaScript độc hại vào các trang web mà người dùng khác truy cập. Tấn công XSS có thể giúp kẻ tấn công ăn cắp thông tin người dùng, giả mạo các hành động của người dùng, hoặc thậm chí chiếm quyền điều khiển tài khoản người dùng.

Có ba loại chính của XSS:

1. **Stored XSS**: Mã JavaScript độc hại được lưu trữ trên server, và khi người dùng khác truy cập, mã đó sẽ được thực thi.
2. **Reflected XSS**: Mã độc hại không được lưu trữ trên server mà được phản hồi trực tiếp trong URL hoặc input mà người dùng nhập.
3. **DOM-based XSS**: XSS được thực hiện trên client-side, thông qua việc thay đổi DOM của trang mà không cần giao tiếp với server.

### **Ví dụ về XSS**

#### 1. **Stored XSS (XSS lưu trữ)**

Giả sử, trong ứng dụng của bạn, người dùng có thể nhập bình luận. Nếu không kiểm tra và làm sạch input, một kẻ tấn công có thể gửi bình luận chứa mã JavaScript độc hại:

**Input của kẻ tấn công**:

html

Sao chép mã

`<script>alert('XSS Attack!');</script>`

Khi bình luận này được hiển thị lại trên trang, trình duyệt của người dùng sẽ thực thi mã JavaScript đó.

#### 2. **Reflected XSS (XSS phản chiếu)**

Ví dụ, một ứng dụng có một endpoint tìm kiếm, nơi người dùng nhập từ khóa tìm kiếm trong URL. Nếu ứng dụng không xử lý đúng, kẻ tấn công có thể gửi một liên kết chứa mã JavaScript trong URL.

**URL của kẻ tấn công**:

url

Sao chép mã

`http://example.com/search?q=<script>alert('XSS Attack!');</script>`

Khi người dùng nhấp vào liên kết này, đoạn mã JavaScript sẽ được thực thi trong trình duyệt của họ.

#### 3. **DOM-based XSS (XSS dựa trên DOM)**

Kẻ tấn công có thể lợi dụng các ứng dụng mà không kiểm tra và làm sạch dữ liệu nhập từ người dùng trước khi cập nhật lại vào DOM (Document Object Model) của trang.

**Ví dụ:**

javascript

Sao chép mã

`// Lấy dữ liệu từ URL và cập nhật vào DOM const userInput = window.location.search.split('=')[1]; // Giả sử query string là ?name=... document.getElementById('user-name').innerHTML = userInput;`

Nếu URL chứa mã JavaScript độc hại (`?name=<script>alert('XSS Attack!');</script>`), đoạn mã này sẽ được thực thi.

---

### **Cách ngăn chặn XSS bằng code**

#### 1. **Làm sạch và mã hóa đầu vào của người dùng**

- **HTML Encoding**: Đảm bảo rằng tất cả các ký tự đặc biệt trong HTML (như `<`, `>`, `&`, `"`, `'`) đều được mã hóa đúng cách để chúng không được hiểu là phần tử HTML hoặc JavaScript.

Ví dụ, thay vì để kẻ tấn công chèn mã `<script>alert('XSS')</script>`, bạn mã hóa nó thành:

html

Sao chép mã

`&lt;script&gt;alert('XSS Attack!')&lt;/script&gt;`

**Cách làm trong ExpressJS**: Sử dụng thư viện `xss-clean` để tự động làm sạch input.

bash

Sao chép mã

`npm install xss-clean`

Trong code:

javascript

Sao chép mã

`const xssClean = require('xss-clean'); app.use(xssClean());`

#### 2. **Chỉ cho phép các input an toàn**

- Kiểm tra và xác thực đầu vào của người dùng. Ví dụ, chỉ chấp nhận các giá trị hợp lệ cho tên người dùng, email, hoặc mật khẩu.

javascript

Sao chép mã

`app.post('/comment', (req, res) => {   const comment = req.body.comment;   if (!comment || typeof comment !== 'string') {     return res.status(400).json({ error: 'Invalid comment' });   }   // Làm sạch và lưu bình luận vào DB });`

#### 3. **Sử dụng HTTP Headers bảo mật**

- Sử dụng các HTTP headers như `Content-Security-Policy` để ngăn cản các script không đáng tin cậy chạy trên trang.

**Cách sử dụng trong ExpressJS**:

javascript

Sao chép mã

`app.use((req, res, next) => {   res.setHeader('Content-Security-Policy', "default-src 'self'; script-src 'self';");   next(); });`

Cài đặt chính sách này sẽ ngăn cản các script từ các nguồn không rõ ràng (ví dụ: từ các script tải từ bên ngoài).

#### 4. **Sử dụng thư viện bảo mật cho việc chèn HTML**

- Khi bạn cần chèn dữ liệu người dùng vào HTML, hãy sử dụng các thư viện hoặc API đảm bảo rằng dữ liệu này không chứa mã độc.

Ví dụ, sử dụng `helmet` để giúp bảo mật ứng dụng Express:

bash

Sao chép mã

`npm install helmet`

Trong code:

javascript

Sao chép mã

`const helmet = require('helmet'); app.use(helmet());`

#### 5. **Cẩn thận với việc xử lý dữ liệu động trong JavaScript**

- Tránh việc trực tiếp chèn dữ liệu người dùng vào DOM mà không kiểm tra. Nếu cần thiết, hãy sử dụng các phương thức như `textContent` hoặc `setAttribute`, thay vì `innerHTML`.

**Ví dụ tốt**:

javascript

Sao chép mã

`const userInput = window.location.search.split('=')[1]; document.getElementById('user-name').textContent = userInput; // Không sử dụng innerHTML`

---

### **Tóm lại**

Để ngăn chặn các cuộc tấn công XSS, bạn cần:

1. **Làm sạch và mã hóa dữ liệu đầu vào** để ngăn cản mã JavaScript độc hại.
2. **Sử dụng các thư viện bảo mật** như `xss-clean`, `helmet`, và cấu hình **CSP (Content Security Policy)** để bảo vệ ứng dụng.
3. **Kiểm tra và xác thực đầu vào** từ người dùng để đảm bảo rằng dữ liệu đầu vào không chứa các ký tự hoặc đoạn mã có thể thực thi.
4. **Tránh sử dụng innerHTML** và thay thế bằng các phương thức an toàn hơn như `textContent`.

Bằng cách áp dụng những biện pháp trên, bạn sẽ có thể bảo vệ ứng dụng của mình khỏi các cuộc tấn công XSS.

---
*Nguồn: Evergreen/concept-base/technical/interview/security/Bảo mật XSS là gì ? Cách ngăn chặn tấn công.md*