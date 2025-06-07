---
layout: post
title: "Setmetadata và Refector là gì ? 2 Khái niệm bổ trợ trong NestJS"
date: 2025-09-01 10:00:00 +0700
categories: concept-base technical backend nestjs fundamental
tags: ["nestjs", "javascript", "typescript", "api", "backend"]
source_path: "Evergreen/concept-base/technical/backend/nestjs/fundamental/Setmetadata và Refector là gì ? 2 Khái niệm bổ trợ trong NestJS.md"
---
### **Cú pháp và Cách sử dụng `SetMetadata` và `Reflector` trong NestJS**

---

### **1. `SetMetadata`**

`SetMetadata` là một hàm decorator trong NestJS, dùng để gắn **metadata** vào một handler (method) hoặc một class. Metadata này có thể được sử dụng bởi các **guards**, **interceptors**, hoặc bất kỳ phần nào khác trong ứng dụng để áp dụng logic tùy chỉnh.

---

#### **Cú pháp**

`SetMetadata(metadataKey: string, metadataValue: any)`

- `metadataKey`: Tên của metadata (một chuỗi định danh).
- `metadataValue`: Giá trị của metadata (có thể là bất kỳ kiểu dữ liệu nào).

---

#### **Ví dụ với `SetMetadata`**

##### **Sử dụng `SetMetadata` để định nghĩa vai trò cho handler**

```typescript

import { SetMetadata, Controller, Get } from '@nestjs/common';

export const Roles = (...roles: string[]) => SetMetadata('roles', roles);

@Controller('users')
export class UserController {
  @Roles('admin') // Gắn metadata 'roles' với giá trị ['admin']
  @Get('admin')
  getAdminData() {
    return 'This route is accessible only to admins';
  }
}


```

**Giải thích**:

- `@Roles('admin')`: Là một decorator tuỳ chỉnh sử dụng `SetMetadata` để gắn metadata có key là `roles` và giá trị là `['admin']`.
- Metadata này sẽ được kiểm tra trong **guards** để quyết định quyền truy cập.

---

### **2. `Reflector`**

`Reflector` là một dịch vụ do NestJS cung cấp, dùng để **lấy** metadata đã được gắn trước đó bằng `SetMetadata`. Dịch vụ này sử dụng API `Reflect` của JavaScript để làm việc với metadata.

---

#### **Cú pháp**

`Reflector.get(metadataKey: string, target: Function | Object): any;`

- `metadataKey`: Tên của metadata cần truy xuất.
- `target`: Class, method, hoặc property chứa metadata.

---

#### **Ví dụ với `Reflector`**

##### **Guard kiểm tra quyền truy cập dựa trên metadata `roles`**

```typescript
import { Injectable, CanActivate, ExecutionContext } from '@nestjs/common';
import { Reflector } from '@nestjs/core';

@Injectable()
export class RolesGuard implements CanActivate {
  constructor(private reflector: Reflector) {}

  canActivate(context: ExecutionContext): boolean {
    // Lấy metadata 'roles' từ handler
    const roles = this.reflector.get<string[]>('roles', context.getHandler());
    if (!roles) {
      return true; // Nếu không có metadata, cho phép truy cập
    }

    const request = context.switchToHttp().getRequest();
    const user = request.user;

    // Kiểm tra nếu user có bất kỳ role nào trong danh sách 'roles'
    return roles.some((role) => user?.roles?.includes(role));
  }
}

```

**Giải thích**:

- `this.reflector.get('roles', context.getHandler())`: Lấy metadata `roles` từ handler hiện tại.
- Guard kiểm tra vai trò của user (lấy từ request) và so khớp với metadata để quyết định quyền truy cập.

---

### **Khi nào sử dụng `SetMetadata` và `Reflector`**

1. **Quản lý quyền truy cập (Role-based Access Control - RBAC)**:
    
    - Gắn metadata các vai trò vào các endpoint cụ thể.
    - Sử dụng `Reflector` trong guards để kiểm tra quyền truy cập dựa trên vai trò.
2. **Tùy chỉnh logic xử lý request**:
    
    - Gắn metadata tùy chỉnh cho các method hoặc class (ví dụ: kích hoạt logging, cấu hình cache).
    - Sử dụng `Reflector` để lấy thông tin metadata trong các interceptor hoặc middleware.
3. **Xây dựng hệ thống annotation**:
    
    - Khi bạn cần một cách nhất quán để gắn và truy xuất thông tin trên các phần tử trong ứng dụng.

---

### **Ví dụ thực tế toàn diện**

#### **Tích hợp guard và decorator tùy chỉnh**

1. **Tạo decorator `@Roles()`**

```typescript

import { SetMetadata } from '@nestjs/common';

export const Roles = (...roles: string[]) => SetMetadata('roles', roles);


```


2. **Tạo guard kiểm tra vai trò**

```typescript

import { Injectable, CanActivate, ExecutionContext } from '@nestjs/common';
import { Reflector } from '@nestjs/core';

@Injectable()
export class RolesGuard implements CanActivate {
  constructor(private reflector: Reflector) {}

  canActivate(context: ExecutionContext): boolean {
    const roles = this.reflector.get<string[]>('roles', context.getHandler());
    if (!roles) {
      return true;
    }

    const request = context.switchToHttp().getRequest();
    const user = request.user;

    return roles.some((role) => user?.roles?.includes(role));
  }
}

```

3. **Áp dụng trong controller**

```typescript

import { Controller, Get, UseGuards } from '@nestjs/common';
import { Roles } from './roles.decorator';
import { RolesGuard } from './roles.guard';

@Controller('users')
@UseGuards(RolesGuard) // Sử dụng RolesGuard cho tất cả endpoint
export class UserController {
  @Roles('admin') // Chỉ admin mới được truy cập
  @Get('admin')
  getAdminData() {
    return 'Admin data';
  }

  @Roles('user', 'admin') // Admin và user đều có quyền truy cập
  @Get('profile')
  getProfileData() {
    return 'User profile';
  }
}

```


**Kết quả**:

- Endpoint `/users/admin`: Chỉ cho phép người dùng có vai trò `admin`.
- Endpoint `/users/profile`: Cho phép người dùng có vai trò `user` hoặc `admin`.

---

### **Tóm tắt**

- **`SetMetadata`**:
    
    - Sử dụng để gắn metadata vào handler hoặc class.
    - Thích hợp cho việc khai báo logic đặc biệt như RBAC, logging, caching.
- **`Reflector`**:
    
    - Sử dụng để truy xuất metadata trong guards, interceptors, hoặc bất kỳ phần logic nào khác.
    - Kết hợp tốt với `SetMetadata` để xây dựng hệ thống linh hoạt.

---
## Liên quan

https://chatgpt.com/share/6774b4f3-9df4-8013-ba77-177bbe6c1e80

#nestjs #backend

---
*Nguồn: Evergreen/concept-base/technical/backend/nestjs/fundamental/Setmetadata và Refector là gì ? 2 Khái niệm bổ trợ trong NestJS.md*