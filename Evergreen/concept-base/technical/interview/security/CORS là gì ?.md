

CORS (Cross-Origin Resource Sharing) là một cơ chế bảo mật trình duyệt web cho phép hoặc hạn chế các yêu cầu từ một nguồn (origin) khác truy cập tài nguyên của một server. Ví dụ, nếu bạn có một ứng dụng frontend chạy trên `http://localhost:4200` và ứng dụng backend chạy trên `http://localhost:3000`, thì trình duyệt sẽ chặn các yêu cầu từ frontend đến backend nếu không có sự cho phép thông qua CORS.

Trong tài liệu của NestJS, CORS là một tính năng mà bạn có thể bật trong ứng dụng của mình để cho phép các yêu cầu từ các nguồn khác nhau (chẳng hạn như từ một domain khác) được phép truy cập vào các tài nguyên của server backend.

Cấu hình CORS trong NestJS có thể thực hiện bằng cách sử dụng `app.enableCors()` trong ứng dụng NestJS. Điều này cho phép bạn cấu hình các thông số như:

- **Origin**: Định nghĩa các domain hoặc địa chỉ mà server sẽ cho phép truy cập.
- **Methods**: Chỉ định các phương thức HTTP nào (như `GET`, `POST`, v.v.) được phép.
- **Headers**: Chỉ định các header được phép trong yêu cầu.
- **Credentials**: Xác định liệu cookie hoặc các thông tin xác thực khác có thể được gửi kèm trong yêu cầu hay không.

Dưới đây là một ví dụ đơn giản để cấu hình CORS trong ứng dụng NestJS:

typescript

Sao chép mã

`import { NestFactory } from '@nestjs/core'; import { AppModule } from './app.module';  async function bootstrap() {   const app = await NestFactory.create(AppModule);   app.enableCors({     origin: 'http://localhost:4200', // Chỉ cho phép domain này     methods: 'GET,POST', // Chỉ cho phép các phương thức GET và POST     allowedHeaders: 'Content-Type,Authorization', // Chỉ cho phép các header này     credentials: true, // Cho phép cookie và thông tin xác thực   });   await app.listen(3000); }  bootstrap();`

Khi bật CORS, bạn kiểm soát ai có thể truy cập tài nguyên của mình và cách mà họ có thể thực hiện yêu cầu.



---
## Liên quan

https://chatgpt.com/share/676b8a49-e1d0-8013-8b42-4d41349706bd
