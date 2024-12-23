
Trong NestJS, **Custom Providers** được sử dụng để tùy chỉnh cách mà các dependency được quản lý và cung cấp trong ứng dụng. Chúng cung cấp một cách linh hoạt để xác định và thay thế các logic mặc định của **dependency injection (DI)**.

Dưới đây là giải thích chi tiết về các khái niệm Custom Providers cùng với ví dụ, được diễn giải bằng tiếng Việt.

---

### **1. Use Class (Sử dụng Class)**

**Mô tả:**  
Bạn có thể định nghĩa một provider bằng cách ánh xạ một token cụ thể đến một class.

**Ví dụ:**

```typescript

// logger.service.ts
export class LoggerService {
  log(message: string) {
    console.log('Log:', message);
  }
}

// app.module.ts
import { Module } from '@nestjs/common';
import { LoggerService } from './logger.service';

@Module({
  providers: [
    {
      provide: 'Logger', // Token
      useClass: LoggerService, // Class cung cấp
    },
  ],
  exports: ['Logger'],
})
export class AppModule {}

```

**Sử dụng:**

```typescript

import { Inject, Injectable } from '@nestjs/common';

@Injectable()
export class AppService {
  constructor(@Inject('Logger') private readonly logger: LoggerService) {}

  logMessage() {
    this.logger.log('Hello, Custom Provider!');
  }
}
```

**Giải thích:**  
Ở đây, token `'Logger'` được ánh xạ đến `LoggerService`. Khi inject `'Logger'`, NestJS sẽ cung cấp một instance của `LoggerService`.

---

### **2. Use Value (Sử dụng Giá Trị)**

**Mô tả:**  
Thay vì ánh xạ đến một class, bạn có thể cung cấp một giá trị cụ thể.

**Ví dụ:**

```typescript
@Module({
  providers: [
    {
      provide: 'CONFIG',
      useValue: { appName: 'MyApp', version: '1.0.0' },
    },
  ],
})
export class AppModule {}


```
**Sử dụng:**

```typescript

import { Inject, Injectable } from '@nestjs/common';

@Injectable()
export class AppService {
  constructor(@Inject('CONFIG') private readonly config: any) {}

  getConfig() {
    return this.config;
  }
}


```


**Giải thích:**  
Token `'CONFIG'` được ánh xạ đến một object `{ appName: 'MyApp', version: '1.0.0'}`. Khi inject `'CONFIG'`, bạn sẽ nhận được giá trị đó.

---

### **3. Use Factory (Sử dụng Factory)**

**Mô tả:**  
Bạn có thể tạo các provider bằng cách sử dụng một hàm (factory function), hàm này có thể nhận các dependency khác.

**Ví dụ:**

```typescript

@Module({
  providers: [
    {
      provide: 'DATABASE_CONNECTION',
      useFactory: async () => {
        const connection = await createConnection(); // Giả định hàm này kết nối database
        return connection;
      },
    },
  ],
})
export class AppModule {}

```

**Sử dụng:**

```typescript

import { Inject, Injectable } from '@nestjs/common';

@Injectable()
export class AppService {
  constructor(@Inject('DATABASE_CONNECTION') private readonly db: any) {}

  getDbStatus() {
    return this.db.status;
  }
}


```

**Giải thích:**  
Factory function cung cấp logic tạo một instance cụ thể (trong trường hợp này là kết nối database). Token `'DATABASE_CONNECTION'` sẽ nhận được instance do factory tạo ra.

---

### **4. Use Existing (Sử dụng Provider có Sẵn)**

**Mô tả:**  
Bạn có thể ánh xạ một token đến một provider đã được định nghĩa trước đó.

**Ví dụ:**

```typescript

@Module({
  providers: [
    LoggerService,
    {
      provide: 'AppLogger',
      useExisting: LoggerService, // Tái sử dụng LoggerService
    },
  ],
})
export class AppModule {}


```

**Sử dụng:**

```typescript

@Injectable()
export class AppService {
  constructor(@Inject('AppLogger') private readonly logger: LoggerService) {}

  logMessage() {
    this.logger.log('Using existing provider!');
  }
}


```

**Giải thích:**  
`AppLogger` sử dụng cùng một instance với `LoggerService`. Điều này hữu ích khi bạn muốn ánh xạ nhiều token đến cùng một logic.

---

### **Lợi Ích của Custom Providers**

1. **Linh hoạt:**  
    Bạn có thể tùy chỉnh cách các dependency được cung cấp và quản lý.
    
2. **Tái sử dụng:**  
    Có thể chia sẻ logic giữa nhiều module.
    
3. **Khả năng kiểm tra (Testability):**  
    Dễ dàng mock các dependency khi kiểm thử.


## Các câu hỏi

Phân biệt useValue, useFactory (có params, không params), useExisting. 
Khi nào thì sử dụng, cho các ví dụ cụ thể.
Cú pháp của useFactory ? Các từ khoá ví dụ provide, inject thì có ý nghĩa gì ?

### **Tóm tắt:**

1. **useClass:** Dùng class để cung cấp các dependency, phù hợp cho các chiến lược (Xác thực Oauth, JWT) hoặc logic có thể thay thế.
2. **useValue:** Dùng cho các giá trị tĩnh, chẳng hạn như config hoặc danh sách hằng số.
3. **useFactory:** Tạo dependency với logic tùy chỉnh, phù hợp khi cần khởi tạo hoặc xử lý trước khi cung cấp (Các connection ví dụ Redis, Database, Caching).
4. **useExisting:** Tái sử dụng một provider đã có, giúp tổ chức code và tiết kiệm tài nguyên.

Bạn có thể kết hợp các loại provider này để tạo ra ứng dụng NestJS linh hoạt và dễ mở rộng.


---
## Liên quan
https://chatgpt.com/share/676929f3-12cc-8013-81ac-758b7dfa81b9
https://github.com/sangtrandev00/di-custom-provider-nestjs
https://docs.nestjs.com/fundamentals/custom-providers

#nestjs #nodejs #backend