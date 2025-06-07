---
layout: post
title: "Helmet là gì ? Cách sử dụng thư viện Helmet"
date: 2025-12-18 10:00:00 +0700
categories: concept-base technical interview fullteron health
tags: ["nodejs", "nestjs", "javascript", "typescript", "backend"]
source_path: "Evergreen/concept-base/technical/interview/fullteron health/Helmet là gì ? Cách sử dụng thư viện Helmet.md"
---
**Helmet** là một thư viện bảo mật cho các ứng dụng Node.js (bao gồm cả NestJS khi sử dụng Express hoặc Fastify làm HTTP adapter). Nó cung cấp các middlewares để thiết lập các **HTTP headers bảo mật** giúp ngăn chặn một số loại tấn công web phổ biến, bao gồm cả **Cross-Site Scripting (XSS)**, **clickjacking**, **data injection** và nhiều tấn công khác.

### **Cách thức hoạt động của Helmet**

Helmet giúp tăng cường bảo mật ứng dụng bằng cách thiết lập một số **HTTP headers** quan trọng mà trình duyệt có thể sử dụng để bảo vệ ứng dụng. Dưới đây là một số header chính mà Helmet thiết lập và cách chúng giúp bảo vệ:

1. **Content-Security-Policy (CSP)**:
    
    - CSP cho phép bạn kiểm soát các nguồn mà trình duyệt được phép tải nội dung từ đó. Nếu cấu hình đúng, CSP có thể giúp ngăn chặn các cuộc tấn công **XSS** bằng cách hạn chế các nguồn script và tài nguyên được phép chạy trên trang web.
    - Ví dụ:
        
        javascript
        
        Sao chép mã
        
        `res.setHeader('Content-Security-Policy', "default-src 'self'; script-src 'self';");`
        
        Điều này đảm bảo rằng chỉ các script từ cùng một nguồn (domain) mới được phép thực thi.
2. **X-Frame-Options**:
    
    - Đây là một header bảo vệ ứng dụng khỏi các cuộc tấn công **clickjacking**, nơi kẻ tấn công có thể chèn trang web của bạn vào một iframe và khiến người dùng nhấp vào các mục không mong muốn.
    - `X-Frame-Options: DENY` đảm bảo rằng trang web không bao giờ được hiển thị trong một iframe.
        
        javascript
        
        Sao chép mã
        
        `res.setHeader('X-Frame-Options', 'DENY');`
        
3. **X-XSS-Protection**:
    
    - Header này kích hoạt bảo vệ chống lại các cuộc tấn công **XSS**. Trình duyệt sẽ cố gắng phát hiện và ngăn chặn mã JavaScript độc hại trong các trang web.
    - Ví dụ:
        
        javascript
        
        Sao chép mã
        
        `res.setHeader('X-XSS-Protection', '1; mode=block');`
        
        Điều này sẽ bật chế độ bảo vệ XSS và chặn các cuộc tấn công.
4. **Strict-Transport-Security (HSTS)**:
    
    - HSTS yêu cầu trình duyệt chỉ kết nối với trang web của bạn qua HTTPS, giúp ngăn ngừa các cuộc tấn công **man-in-the-middle (MITM)**.
    - Ví dụ:
        
        javascript
        
        Sao chép mã
        
        `res.setHeader('Strict-Transport-Security', 'max-age=31536000; includeSubDomains');`
        
5. **X-Content-Type-Options**:
    
    - Header này giúp ngăn chặn các cuộc tấn công **MIME sniffing**, bảo vệ ứng dụng khỏi việc trình duyệt tự động xác định loại nội dung (content type) của tài nguyên.
    - Ví dụ:
        
        javascript
        
        Sao chép mã
        
        `res.setHeader('X-Content-Type-Options', 'nosniff');`
        
6. **Referrer-Policy**:
    
    - Header này kiểm soát thông tin referrer (nguồn gốc của yêu cầu) mà trình duyệt gửi khi chuyển hướng hoặc thực hiện các yêu cầu khác.
    - Ví dụ:
        
        javascript
        
        Sao chép mã
        
        `res.setHeader('Referrer-Policy', 'no-referrer');`
        

### **Cách sử dụng Helmet trong NestJS (với Express adapter)**

Để sử dụng Helmet trong ứng dụng NestJS, bạn cần cài đặt nó và tích hợp vào ứng dụng.

1. **Cài đặt Helmet**:
    
    bash
    
    Sao chép mã
    
    `npm install helmet`
    
2. **Cấu hình Helmet trong NestJS**: Trong tệp `main.ts` của ứng dụng NestJS, bạn cần cài đặt Helmet như sau:
    
    typescript
    
    Sao chép mã
    
    `import { NestFactory } from '@nestjs/core'; import { AppModule } from './app.module'; import * as helmet from 'helmet';  async function bootstrap() {   const app = await NestFactory.create(AppModule);   app.use(helmet()); // Thêm helmet vào ứng dụng   await app.listen(3000); } bootstrap();`
    

### **Tóm lại**:

- **Helmet** giúp bảo vệ ứng dụng của bạn khỏi các tấn công phổ biến như XSS, clickjacking, MITM và sniffing bằng cách thiết lập các HTTP headers bảo mật.
- **Cách ngăn chặn tấn công XSS**: Helmet cung cấp header `X-XSS-Protection` và `Content-Security-Policy`, giúp ngăn ngừa việc chèn mã độc vào trang web và kiểm soát các nguồn tài nguyên được phép tải.
- Để bảo mật ứng dụng web của bạn, **Helmet là một công cụ không thể thiếu**, đặc biệt khi bạn sử dụng Express hoặc Fastify trong ứng dụng NestJS.

Hy vọng rằng bạn có thể trả lời câu hỏi về Helmet trong buổi phỏng vấn một cách rõ ràng và thuyết phục.



## Liên quan

https://chatgpt.com/share/676b8982-d2b0-8013-a9b5-e5689f539988

#backend #nodejs #nestjs #security

---
*Nguồn: Evergreen/concept-base/technical/interview/fullteron health/Helmet là gì ? Cách sử dụng thư viện Helmet.md*