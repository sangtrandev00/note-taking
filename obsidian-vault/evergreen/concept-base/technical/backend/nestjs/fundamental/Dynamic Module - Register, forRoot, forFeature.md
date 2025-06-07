---
profileName: sangtrandev00
postId: 3414
postType: post
categories:
  - 39
---
Trong series về NestJS trong mục [[Nestjs cơ bản]] thì một khái niệm mình đã từng gặp trong buổi phỏng vấn đó là Dynamic Module. Vậy Dynamic Module là gì ? Tại sao cần dùng cho lập trình viên NestJS Backend.

Dynamic Modules trong NestJS là một tính năng mạnh mẽ, cho phép bạn tạo ra các module có thể cấu hình được (configurable modules). Điều này rất hữu ích khi bạn muốn tái sử dụng một module với các cấu hình khác nhau hoặc phụ thuộc vào các điều kiện cụ thể trong ứng dụng của mình.

Hãy bắt đầu với một ví dụ thực tế:

## **Bước 1: Tạo Dynamic Module**

1. **Cấu trúc module:**


```typescript

// database.module.ts
import { Module, DynamicModule } from '@nestjs/common';

@Module({})
export class DatabaseModule {
  static forRoot(options: { type: string; host: string }): DynamicModule {
    const providers = [
      {
        provide: 'DATABASE_CONNECTION',
        useFactory: async () => {
          if (options.type === 'mysql') {
            return `Kết nối MySQL tại ${options.host}`;
          } else if (options.type === 'mongodb') {
            return `Kết nối MongoDB tại ${options.host}`;
          }
          throw new Error('Loại cơ sở dữ liệu không được hỗ trợ!');
        },
      },
    ];

    return {
      module: DatabaseModule,
      providers: providers,
      exports: providers,
    };
  }
}


```

---

## **Bước 2: Sử dụng Dynamic Module trong ứng dụng**

```typescript

// app.module.ts
import { Module } from '@nestjs/common';
import { DatabaseModule } from './database.module';

@Module({
  imports: [
    DatabaseModule.forRoot({
      type: 'mysql',
      host: 'localhost',
    }),
  ],
})

export class AppModule {}


```

---

## **Bước 3: Inject và sử dụng kết nối**

```typescript

// app.service.ts
import { Injectable, Inject } from '@nestjs/common';

@Injectable()
export class AppService {
  constructor(
    @Inject('DATABASE_CONNECTION') private readonly connection: string,
  ) {}

  getConnectionInfo(): string {
    return this.connection;
  }
}

// app.controller.ts
import { Controller, Get } from '@nestjs/common';
import { AppService } from './app.service';

@Controller()
export class AppController {
  constructor(private readonly appService: AppService) {}

  @Get('connection')
  getConnection(): string {
    return this.appService.getConnectionInfo();
  }
}


```
---

## **Giải thích bằng tiếng Việt**

1. **`DatabaseModule`**:
    
    - Là một module động (Dynamic Module).
    - Phương thức `forRoot` trả về một Dynamic Module, cho phép bạn cấu hình nó tùy theo yêu cầu.
    - Dựa trên `options.type`, module sẽ tạo một kết nối tương ứng (MySQL hoặc MongoDB).
2. **Sử dụng trong `AppModule`**:
    
    - Gọi `DatabaseModule.forRoot(...)` để cung cấp cấu hình (loại DB và host).
3. **Inject và sử dụng**:
    
    - Inject `DATABASE_CONNECTION` trong service/controller để lấy thông tin kết nối.

---

### **Chạy ứng dụng**

Khi bạn chạy ứng dụng và truy cập endpoint `/connection`, bạn sẽ nhận được kết quả như sau (giả sử `type` là `mysql` và `host` là `localhost`):

```json

"Kết nối MySQL tại localhost"

```


`"Kết nối MySQL tại localhost"`


## **Triển khai `DatabaseModule` với `forRoot()` và `forFeature()`**

### 1. **Cấu hình `DatabaseModule`**

```typescript
// database.module.ts
import { Module, DynamicModule } from '@nestjs/common';

@Module({})
export class DatabaseModule {
  static forRoot(options: { type: string; host: string }): DynamicModule {
    const providers = [
      {
        provide: 'DATABASE_CONNECTION',
        useValue: `Kết nối ${options.type} tại ${options.host}`,
      },
    ];

    return {
      module: DatabaseModule,
      providers: providers,
      exports: providers,
    };
  }

  static forFeature(entities: string[]): DynamicModule {
    const providers = entities.map((entity) => ({
      provide: `${entity.toUpperCase()}_REPOSITORY`,
      useValue: `${entity} repository`,
    }));

    return {
      module: DatabaseModule,
      providers: providers,
      exports: providers,
    };
  }
}


```

- **`forRoot(options)`**:
    
    - Cung cấp thông tin kết nối cơ sở dữ liệu (loại DB và host).
- **`forFeature(entities)`**:
    
    - Định nghĩa repository cho các bảng cụ thể (danh sách các bảng).

---

### 2. **Sử dụng `forRoot()` trong `AppModule`**


```typescript

// app.module.ts
import { Module } from '@nestjs/common';
import { DatabaseModule } from './database.module';
import { UserModule } from './user.module';

@Module({
  imports: [
    DatabaseModule.forRoot({ type: 'mysql', host: 'localhost' }),
    UserModule,
  ],
})
export class AppModule {}


```
- Kết nối cơ sở dữ liệu MySQL được cấu hình cho toàn bộ ứng dụng.

---

### 3. **Sử dụng `forFeature()` trong các module con**

#### **Tạo `UserModule`**

```typescript

// user.module.ts
import { Module } from '@nestjs/common';
import { DatabaseModule } from './database.module';
import { UserService } from './user.service';

@Module({
  imports: [
    DatabaseModule.forFeature(['user', 'profile']),
  ],
  providers: [UserService],
})
export class UserModule {}


```

#### **Dịch vụ sử dụng repository**

```typescript

// user.service.ts
import { Injectable, Inject } from '@nestjs/common';

@Injectable()
export class UserService {
  constructor(
    @Inject('USER_REPOSITORY') private readonly userRepository: string,
    @Inject('PROFILE_REPOSITORY') private readonly profileRepository: string,
  ) {}

  getRepositories(): string[] {
    return [this.userRepository, this.profileRepository];
  }
}

// user.controller.ts
import { Controller, Get } from '@nestjs/common';
import { UserService } from './user.service';

@Controller('users')
export class UserController {
  constructor(private readonly userService: UserService) {}

  @Get('repositories')
  getRepositories(): string[] {
    return this.userService.getRepositories();
  }
}

```

---

### **Kết quả**

1. Khi bạn truy cập vào endpoint `/users/repositories`, bạn sẽ nhận được:

`[   "user repository",   "profile repository" ]`

2. Toàn bộ ứng dụng sử dụng kết nối MySQL được cấu hình bởi `forRoot()`, trong khi module `UserModule` được cấu hình thêm các repository với `forFeature()`.

---

### **Khi nào dùng `forRoot()` và `forFeature()`?**

#### **Dùng `forRoot()` khi:**

- Bạn cần cấu hình chung cho toàn ứng dụng.
- Chỉ gọi **một lần** trong module gốc (ví dụ: `AppModule`).
- Ví dụ thực tế:
    - Kết nối cơ sở dữ liệu (MySQL, MongoDB).
    - Cấu hình JWT hoặc OAuth2 cho toàn ứng dụng.
    - Tích hợp hệ thống gửi email (SMTP).

#### **Dùng `forFeature()` khi:**

- Bạn cần mở rộng hoặc bổ sung cấu hình cục bộ trong các module con.
- Định nghĩa các entities hoặc repository cho các bảng dữ liệu.
- Ví dụ thực tế:
    - Định nghĩa repository cho các bảng cụ thể trong ứng dụng.
    - Cấu hình logic cục bộ như dịch vụ API hoặc job workers.

---

## **Tóm tắt**

- `forRoot()` = Cấu hình toàn ứng dụng.
- `forFeature()` = Cấu hình cục bộ cho từng module con.
- Kết hợp cả hai để xây dựng hệ thống module có cấu trúc rõ ràng và linh hoạt, đặc biệt với các dự án lớn.


---
## Liên quan
https://docs.nestjs.com/fundamentals/dynamic-modules
https://chatgpt.com/share/676a1f1a-3db4-8013-9883-27534795d3bd
https://github.com/nestjs/nest/tree/master/sample/25-dynamic-modules
https://github.com/sangtrandev00/dynamic-modules-nestjs

#nestjs #nodejs #backend