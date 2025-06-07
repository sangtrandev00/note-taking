---
profileName: sangtrandev00
postId: 3404
postType: post
categories:
  - 39
---
Ở bài viết về [[Trình bày tóm tắt vòng đời cách chạy của Framework Nestjs ?]] của NestJS mình đã có đề cặp đến một lớp là Exception trong NestJS. Tuy nhiên để thực sự hiểu hơn về quá trình bắt lỗi cũng như cách khởi tạo một exception cơ bản chúng ta phải làm như thế nào ?

**Exception Filters** trong **NestJS** là một cơ chế để xử lý các lỗi (exceptions) phát sinh trong ứng dụng một cách linh hoạt và đồng nhất. Khi một lỗi xảy ra trong quá trình xử lý request, NestJS sẽ chuyển nó vào **Exception Filter**, và từ đó bạn có thể tùy chỉnh cách thức lỗi được xử lý và trả về cho client.
Dưới đây là một giải thích chi tiết và dễ hiểu về **Exception Filters** trong NestJS:
### 1. **Mục đích của Exception Filter**

Mục đích chính của **Exception Filter** là để xử lý lỗi trong ứng dụng một cách nhất quán và linh hoạt. Thay vì để hệ thống mặc định xử lý lỗi và trả về các thông báo lỗi không thân thiện, bạn có thể sử dụng exception filters để:

- Xử lý và log lỗi một cách chi tiết.
- Cung cấp các thông báo lỗi rõ ràng và thân thiện hơn cho người dùng.
- Quản lý lỗi dựa trên các loại ngoại lệ khác nhau, cho phép phân loại và xử lý theo cách khác nhau (ví dụ: lỗi 404 cho không tìm thấy tài nguyên, lỗi 500 cho các lỗi hệ thống).

### 2. **Cách hoạt động của Exception Filter**

NestJS cung cấp một cơ chế để bạn có thể tạo các **custom exception filters**. Khi một exception (lỗi) xảy ra trong quá trình xử lý request, NestJS sẽ tìm kiếm xem có filter nào được đăng ký để xử lý lỗi này hay không. Nếu có, NestJS sẽ chuyển exception vào filter đó để xử lý.

### 3. **Cách tạo và sử dụng Exception Filters**

#### Bước 1: Tạo một Exception Filter

Để tạo một Exception Filter, bạn cần implement interface `ExceptionFilter` và sử dụng decorator `@Catch()` để chỉ định loại lỗi mà filter sẽ xử lý.

Ví dụ: Dưới đây là cách tạo một Exception Filter đơn giản để xử lý lỗi `HttpException`.


```typescript
import { ExceptionFilter, Catch, ArgumentsHost } from '@nestjs/common';
import { HttpException, HttpStatus } from '@nestjs/common';

@Catch(HttpException)
export class HttpExceptionFilter implements ExceptionFilter {
  catch(exception: HttpException, host: ArgumentsHost) {
    const response = host.switchToHttp().getResponse();
    const status = exception.getStatus();
    const message = exception.message;

    response
      .status(status)
      .json({
        statusCode: status,
        message: message,
        timestamp: new Date().toISOString(),
        path: host.switchToHttp().getRequest().url,
      });
  }
}

```

Trong ví dụ trên:

- `@Catch(HttpException)` cho phép filter này chỉ xử lý các lỗi thuộc loại `HttpException`.
- `catch()` là phương thức chính để xử lý lỗi. Bạn có thể truy cập vào `exception` (lỗi) và `host` (đối tượng chứa thông tin về request và response).
- Trong phương thức `catch()`, bạn có thể lấy thông tin lỗi, xử lý và trả về response phù hợp cho client.

#### Bước 2: Đăng ký Exception Filter

Bạn có thể đăng ký **Exception Filter** cho toàn bộ ứng dụng hoặc cho một controller cụ thể.

- **Đăng ký toàn cục (Global)**: Để sử dụng Exception Filter toàn cục, bạn đăng ký nó trong lớp `main.ts` khi khởi tạo ứng dụng NestJS:
```typescript
import { NestFactory } from '@nestjs/core';
import { AppModule } from './app.module';
import { HttpExceptionFilter } from './http-exception.filter';

async function bootstrap() {
  const app = await NestFactory.create(AppModule);
  app.useGlobalFilters(new HttpExceptionFilter());
  await app.listen(3000);
}

bootstrap();

```

- **Đăng ký trong controller (Local)**: Bạn cũng có thể đăng ký Exception Filter trong một controller cụ thể:
```typescript

import { Controller, Get, UseFilters } from '@nestjs/common';
import { HttpExceptionFilter } from './http-exception.filter';

@Controller('cats')
@UseFilters(HttpExceptionFilter)
export class CatsController {
  @Get()
  findAll() {
    throw new HttpException('Cats not found', HttpStatus.NOT_FOUND);
  }
}

```

### 4. **Các loại Exception trong NestJS**

NestJS sử dụng các loại exception phổ biến để xử lý các tình huống lỗi trong HTTP requests. Một số loại exception phổ biến bao gồm:

- **HttpException**: Là lớp cơ sở cho tất cả các lỗi HTTP (ví dụ: 404 Not Found, 500 Internal Server Error).
- **NotFoundException**: Được sử dụng khi tài nguyên không tìm thấy.
- **BadRequestException**: Dùng khi request không hợp lệ.
- **UnauthorizedException**: Dùng khi người dùng không có quyền truy cập.
- **ForbiddenException**: Dùng khi quyền truy cập bị từ chối.

### 5. **Tùy chỉnh Exception Filter**

Ngoài việc xử lý các lỗi HTTP, bạn có thể tạo các **custom exceptions** (lỗi tùy chỉnh) để xử lý các lỗi không phải HTTP, và sau đó sử dụng Exception Filter để xử lý các loại lỗi này theo cách riêng của bạn.

```typescript
import { ExceptionFilter, Catch, ArgumentsHost } from '@nestjs/common';
import { MyCustomException } from './my-custom.exception';

@Catch(MyCustomException)
export class MyCustomExceptionFilter implements ExceptionFilter {
  catch(exception: MyCustomException, host: ArgumentsHost) {
    const response = host.switchToHttp().getResponse();
    response
      .status(500)
      .json({
        message: 'A custom error occurred',
        details: exception.message,
      });
  }
}

```

### 6. **Kết luận**

**Exception Filters** trong NestJS giúp bạn xử lý lỗi một cách nhất quán và linh hoạt. Bạn có thể tạo các filter riêng biệt để xử lý các loại lỗi khác nhau, từ đó cung cấp thông tin lỗi rõ ràng cho người dùng và dễ dàng log các lỗi trong ứng dụng. Đây là một công cụ mạnh mẽ giúp quản lý và kiểm soát lỗi trong ứng dụng NestJS của bạn.



---
## Liên quan
https://docs.nestjs.com/exception-filters
https://chatgpt.com/share/6768e7fc-eaf4-8013-bef8-f05aaa179c47

#nestjs #backend