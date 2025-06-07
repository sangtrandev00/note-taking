---
profileName: sangtrandev00
postId: 3451
postType: post
categories:
  - 39
---
`ModuleRef` trong NestJS là một công cụ giúp bạn truy cập và tương tác với các dịch vụ (services) giữa các module một cách linh động tại thời điểm runtime. Đây là công cụ mạnh mẽ khi bạn cần làm việc với các phụ thuộc không thể xác định khi biên dịch, hoặc khi cần truy cập các dịch vụ trong các module khác mà không dùng trực tiếp injection.

##  1 Ví dụ thực tế sử dụng module reference 

1. **Lấy một service từ một module khác**: Giả sử bạn có `ModuleA` cần gọi `ServiceB` từ `ModuleB`. Bạn có thể sử dụng `ModuleRef` để truy xuất `ServiceB` mà không cần phải inject nó trực tiếp vào `ModuleA`.
    
```typescript
@Injectable()
export class ModuleAService {
  constructor(private moduleRef: ModuleRef) {}

  someMethod() {
    const serviceB = this.moduleRef.get(ServiceB);
    serviceB.someFunction();
  }
}

```

    
2. **Cung cấp dịch vụ động**: Nếu bạn xây dựng một plugin hoặc hệ thống microservices, nơi các module có thể thay đổi hoặc bổ sung vào runtime, bạn có thể dùng `ModuleRef` để tạo và sử dụng các provider động.
    
3. **Sử dụng với các provider chưa được đăng ký trước**: `ModuleRef` giúp bạn tạo ra các instance của các provider mà không cần phải đăng ký chúng một cách tĩnh.
    

### Các trường hợp sử dụng Module Reference

- **Lấy instance của provider chưa đăng ký**: Trong một số tình huống đặc biệt (như plugin), bạn có thể không thể dự đoán trước module nào cần dùng service nào. `ModuleRef` giúp bạn giải quyết vấn đề này bằng cách lấy service một cách linh động.
- **Giải quyết các phụ thuộc khi cần thiết**: Nếu có một số phụ thuộc không thể inject vào lúc biên dịch, bạn có thể lấy chúng vào lúc runtime bằng `ModuleRef`.

Dưới đây là các ví dụ chi tiết hơn, giúp bạn dễ dàng tổ chức chúng trong source code của NestJS:

### 1. **Lấy instance của các provider**

Nếu bạn muốn lấy một instance của một provider trong một service nhưng không inject trực tiếp trong constructor, bạn có thể sử dụng `ModuleRef.get()`.

**Ví dụ:** Giả sử bạn có một service `SomeService` và muốn sử dụng nó trong `AppService` mà không cần inject vào constructor:

```typescript

@Injectable()
export class AppService {
  constructor(private moduleRef: ModuleRef) {}

  getDynamicService() {
    const dynamicService = this.moduleRef.get(SomeService);
    dynamicService.doSomething();
  }
}


```

**Cách tổ chức trong mã:**

- Đảm bảo `SomeService` được cung cấp trong `AppModule` hoặc module tương ứng.
- `AppService` có thể sử dụng `ModuleRef` để lấy dịch vụ từ module khác mà không phải inject trực tiếp.

---

### 2. **Lấy các provider chưa được đăng ký**

Nếu một provider không được đăng ký trong module chính, bạn vẫn có thể lấy nó thông qua `ModuleRef.resolve()` để tạo instance của nó.

**Ví dụ:** Giả sử bạn muốn khởi tạo một provider chưa được đăng ký như `DynamicService`:

```typescript

@Injectable()
export class DynamicModuleService {
  constructor(private moduleRef: ModuleRef) {}

  async getDynamicInstance() {
    const service = await this.moduleRef.resolve(SomeService);
    service.run();
  }
}

```
**Cách tổ chức trong mã:**

- `DynamicService` có thể là một service chưa được đăng ký trực tiếp trong module, nhưng bạn có thể sử dụng `ModuleRef` để khởi tạo nó động tại runtime.

---

### 3. **Dùng trong các module động**

Trong các tình huống như plugin hoặc khi có các module có thể thay đổi, bạn có thể sử dụng `ModuleRef` để truy xuất và tạo các provider một cách động.

**Ví dụ:** Giả sử bạn muốn tải một plugin từ một module động:

```typescript

@Injectable()
export class PluginService {
  constructor(private moduleRef: ModuleRef) {}

  loadPlugin() {
    const plugin = this.moduleRef.get(PluginService);
    plugin.initialize();
  }
}

```

**Cách tổ chức trong mã:**

- `PluginService` có thể là một service cung cấp chức năng mở rộng (plugin).
- Bạn có thể sử dụng `ModuleRef` để truy xuất service này mà không cần đăng ký trực tiếp trong module chính.

---

### 4. **Truy xuất provider từ các module không phải là phụ thuộc trực tiếp**

`ModuleRef` cho phép bạn truy xuất các provider từ module khác mà không phải inject chúng trong constructor.

**Ví dụ:** Giả sử bạn có một service trong module khác và muốn sử dụng nó trong một service khác:

```typescript

import { Injectable, ModuleRef } from '@nestjs/common';
import { SomeOtherService } from './some-other.service';

@Injectable()
export class AnotherService {
  constructor(private moduleRef: ModuleRef) {}

  useService() {
    const serviceFromAnotherModule = this.moduleRef.get(SomeOtherService);
    serviceFromAnotherModule.performAction(); // Gọi phương thức của SomeOtherService
  }
}


```


**Cách tổ chức trong mã:**

- `SomeOtherService` được đăng ký trong một module khác và không cần inject trực tiếp vào `AnotherService`.
- Bạn có thể lấy instance của `SomeOtherService` từ module khác bằng cách sử dụng `ModuleRef`.

---

Tóm lại, các ví dụ trên cho thấy cách sử dụng `ModuleRef` để linh động lấy và sử dụng các provider trong các tình huống khác nhau, giúp bạn xây dựng ứng dụng NestJS một cách linh hoạt và dễ mở rộng.


---
## Liên quan
https://chatgpt.com/share/6770cee4-b740-8013-9379-6869d289819a
https://docs.nestjs.com/fundamentals/module-ref

Xem thêm về code mà mình đã tạo trong bài viết tại repository github này nhé:
https://github.com/sangtrandev00/module-reference-nestjs

#nestjs #backend