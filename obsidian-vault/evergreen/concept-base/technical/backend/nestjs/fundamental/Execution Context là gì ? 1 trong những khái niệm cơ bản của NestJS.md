---
profileName: sangtrandev00
postId: 3468
postType: post
categories:
  - 39
---
## Execution Context là gì ?
Execution Context là một khái niệm cơ bản trong NestJS, cung cấp một abstraction để xác định ngữ cảnh mà một handler (method) được thực thi. Nó giúp phát triển các tính năng middleware, guards, interceptors, và filters bằng cách cung cấp thông tin liên quan đến quá trình thực thi.

### **Các khái niệm quan trọng liên quan đến Execution Context**

1. **Handler (Method)**  
    Đây là method cụ thể được thực thi, ví dụ: controller method được gọi khi có request đến endpoint.
    
2. **Class**  
    Class chứa handler, chẳng hạn như một controller hoặc provider.
    
3. **ArgumentsHost**
    
    - Đóng vai trò là một abstraction để truy cập các argument của handler.
    - Hỗ trợ các kiểu execution context khác nhau:
        - HTTP
        - RPC (Remote Procedure Call)
        - WebSocket
4. **ContextType**  
    Xác định loại ngữ cảnh mà handler đang chạy, bao gồm:
    - `http`
    - `rpc`
    - `ws` (WebSocket)
5. **ArgumentsHost Methods**
    
    - `switchToHttp()`: Truy cập các thông tin HTTP như request, response.
    - `switchToRpc()`: Truy cập dữ liệu RPC.
    - `switchToWs()`: Truy cập dữ liệu WebSocket.
    - `getArgs()`: Lấy toàn bộ danh sách các arguments.
    - `getType()`: Trả về kiểu context (`http`, `rpc`, `ws`).

---

## **Ví dụ thực tế về sử dụng Execution Context**

1. **Xây dựng một Guard** Guard được dùng để kiểm tra quyền truy cập trước khi handler được thực thi.

```typescript

import { CanActivate, ExecutionContext, Injectable } from '@nestjs/common';

@Injectable()
export class AuthGuard implements CanActivate {
  canActivate(context: ExecutionContext): boolean {
    const request = context.switchToHttp().getRequest();
    const user = request.user;
    return user && user.isAuthenticated; // Kiểm tra người dùng đã đăng nhập chưa
  }
}

```


2. **Custom Interceptor** Interceptor có thể được sử dụng để xử lý logic trước hoặc sau khi handler chạy.
    
```typescript

import {
  Injectable,
  NestInterceptor,
  ExecutionContext,
  CallHandler,
} from '@nestjs/common';
import { Observable } from 'rxjs';
import { tap } from 'rxjs/operators';

@Injectable()
export class LoggingInterceptor implements NestInterceptor {
  intercept(context: ExecutionContext, next: CallHandler): Observable<any> {
    const request = context.switchToHttp().getRequest();
    console.log(`Incoming request: ${request.method} ${request.url}`);
    return next.handle().pipe(
      tap(() => console.log(`Request handled successfully`)),
    );
  }
}

```

3. **Custom Exception Filter** Filter xử lý exception dựa trên Execution Context.

```typescript

import {
  ExceptionFilter,
  Catch,
  ArgumentsHost,
  HttpException,
} from '@nestjs/common';

@Catch(HttpException)
export class HttpExceptionFilter implements ExceptionFilter {
  catch(exception: HttpException, host: ArgumentsHost) {
    const ctx = host.switchToHttp();
    const response = ctx.getResponse();
    const request = ctx.getRequest();
    const status = exception.getStatus();

    response.status(status).json({
      statusCode: status,
      timestamp: new Date().toISOString(),
      path: request.url,
    });
  }
}


```

---

## **Khi nào cần sử dụng Execution Context?**

1. **Xử lý xác thực và phân quyền**

    - Kiểm tra quyền truy cập của người dùng.
    - Xác định các điều kiện trước khi cho phép truy cập handler.
2. **Ghi log hoặc đo thời gian thực thi**
    
    - Interceptor giúp đo thời gian hoặc ghi lại thông tin log của request.
3. **Tùy chỉnh phản hồi lỗi**
    
    - Filters giúp định nghĩa cách trả lỗi đồng bộ với API của bạn.
4. **Tích hợp với các giao thức khác như WebSocket hoặc gRPC**
    
    - Sử dụng các method như `switchToWs()` hoặc `switchToRpc()`.

---

## **Tóm tắt**

Execution Context trong NestJS cung cấp abstraction để truy cập các thông tin liên quan đến quá trình thực thi của handler, bao gồm: request, response, và các argument. Nó đặc biệt hữu ích khi bạn cần kiểm soát hoặc tùy chỉnh logic toàn cục (guards, interceptors, filters) mà không làm ảnh hưởng đến handler cụ thể.

---
## Liên quan
https://docs.nestjs.com/fundamentals/execution-context
https://chatgpt.com/share/6774b4f3-9df4-8013-ba77-177bbe6c1e80

Tham khảo thêm đoạn code example mà mình đã tạo trong bài viết ở repository này nhé!
https://github.com/sangtrandev00/execution-context-nestjs
#nestjs #backend