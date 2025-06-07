---
profileName: sangtrandev00
postId: 3441
postType: post
categories:
  - 39
---
Thêm một khái niệm fundamental nữa lấy ra từ docs của nestjs.com, đây là một khái niệm cũng thường xuyên được hỏi trong các cuộc phỏng vấn NestJS mà mình đã từng gặp. Chính vì vậy hôm nay mình quyết định lên một bài viết nói về khái niệm này. Tham khảo khái niệm circular dependency này của mình nhé

## Hiểu về Circular Dependency trong NestJS

Trong **NestJS**, **circular dependency** (phụ thuộc vòng tròn) xảy ra khi hai hoặc nhiều module hoặc provider phụ thuộc vào nhau, tạo thành một vòng lặp. Ví dụ:

- Module A phụ thuộc vào Module B.
- Module B lại phụ thuộc vào Module A.

Điều này có thể dẫn đến các vấn đề như lỗi runtime hoặc hành vi không mong muốn vì NestJS không thể giải quyết các phụ thuộc đúng cách.

---

## Ví dụ về Circular Dependency

Dưới đây là một ví dụ về **circular dependency** giữa hai service:

#### `service-a.service.ts`

```typescript

import { Injectable } from '@nestjs/common';
import { ServiceB } from './service-b.service';

@Injectable()
export class ServiceA {
  constructor(private readonly serviceB: ServiceB) {}

  getMessageFromB(): string {
    return this.serviceB.getMessage();
  }
}

```
#### `service-b.service.ts`

```typescript

import { Injectable } from '@nestjs/common';
import { ServiceA } from './service-a.service';

@Injectable()
export class ServiceB {
  constructor(private readonly serviceA: ServiceA) {}

  getMessage(): string {
    return `Hello from ServiceB. Called by: ${this.serviceA.getMessageFromB()}`;
  }
}

```

Ở đây, cả `ServiceA` và `ServiceB` đều phụ thuộc lẫn nhau, tạo ra **circular dependency**.

---

## Lỗi Thường Gặp

Khi chạy đoạn mã trên, NestJS sẽ báo lỗi tương tự như sau:

`Error: A circular dependency has been detected (ServiceA -> ServiceB -> ServiceA).`

---

## Các Giải Pháp Giải Quyết Circular Dependency

### 1. **Sử dụng `forwardRef`**

NestJS cung cấp hàm `forwardRef` để xử lý **circular dependency**.

Chỉnh sửa cách import trong cả hai service như sau:

##### `service-a.service.ts`

```typescript

import { Injectable, forwardRef, Inject } from '@nestjs/common';
import { ServiceB } from './service-b.service';

@Injectable()
export class ServiceA {
  constructor(@Inject(forwardRef(() => ServiceB)) private readonly serviceB: ServiceB) {}

  getMessageFromB(): string {
    return this.serviceB.getMessage();
  }
}

```
##### `service-b.service.ts`

```typescript

import { Injectable, forwardRef, Inject } from '@nestjs/common';
import { ServiceA } from './service-a.service';

@Injectable()
export class ServiceB {
  constructor(@Inject(forwardRef(() => ServiceA)) private readonly serviceA: ServiceA) {}

  getMessage(): string {
    return `Hello from ServiceB. Called by: ${this.serviceA.getMessageFromB()}`;
  }
}

```

---

### 2. **Tái cấu trúc code để tránh Circular Dependency**

Thay vì để các service phụ thuộc trực tiếp vào nhau, bạn có thể thêm một service trung gian (Mediator) để xử lý tương tác.

##### Tạo `mediator.service.ts`

```typescript

import { Injectable } from '@nestjs/common';

@Injectable()
export class MediatorService {
  getSharedMessage(): string {
    return 'Shared Message';
  }
}

```
#### Cập nhật `service-a.service.ts`

```typescript

import { Injectable } from '@nestjs/common';
import { MediatorService } from './mediator.service';

@Injectable()
export class ServiceA {
  constructor(private readonly mediatorService: MediatorService) {}

  getMessageFromMediator(): string {
    return this.mediatorService.getSharedMessage();
  }
}

```
#### Cập nhật `service-b.service.ts`

```typescript

import { Injectable } from '@nestjs/common';
import { MediatorService } from './mediator.service';

@Injectable()
export class ServiceB {
  constructor(private readonly mediatorService: MediatorService) {}

  getMessageFromMediator(): string {
    return this.mediatorService.getSharedMessage();
  }
}

```

---

### 3. **Tổ chức lại cấu trúc module**

Nếu **circular dependency** xuất phát từ việc các module import lẫn nhau, hãy xem xét tổ chức lại module. Đưa logic dùng chung vào một module riêng để cả hai module cùng phụ thuộc.

---

## Tóm tắt

- Sử dụng **`forwardRef`** là cách xử lý nhanh chóng, nhưng không nên lạm dụng vì có thể làm phức tạp thiết kế.
- Cách tốt nhất là tái cấu trúc code để **tránh phụ thuộc vòng tròn** hoàn toàn.
- Xem xét sử dụng **mediator** hoặc tổ chức lại module để quản lý phụ thuộc một cách rõ ràng hơn.

---

## Liên quan
https://docs.nestjs.com/fundamentals/circular-dependency
https://chatgpt.com/share/676f69d7-0150-8013-85b0-78a8b829e0a1
Tham khảo đoạn code github của mình dùng để giải quyết circular dependency
https://github.com/sangtrandev00/circular-dependency-nestjs
Tham khảo thêm các khái niệm fundamental trong series NestJS cơ bản.


#nestjs #backend