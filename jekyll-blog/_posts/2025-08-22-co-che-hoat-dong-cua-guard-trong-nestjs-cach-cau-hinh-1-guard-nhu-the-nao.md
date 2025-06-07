---
layout: post
title: "Cơ chế hoạt động của Guard trong NestJS ? Cách cấu hình 1 Guard như thế nào ?"
date: 2025-08-22 10:00:00 +0700
categories: concept-base technical backend nestjs fundamental
tags: ["nestjs", "typescript", "backend"]
source_path: "Evergreen/concept-base/technical/backend/nestjs/fundamental/Cơ chế hoạt động của Guard trong NestJS ? Cách cấu hình 1 Guard như thế nào ?.md"
---
### **1. Cơ chế hoạt động: Tại sao khai báo ở Controller mà lại kiểm tra được trong Guards?**

1. **Khai báo Metadata ở Controller**:
    
    - Khi bạn sử dụng `SetMetadata` (hoặc một decorator tuỳ chỉnh như `@Roles`), bạn đang **gắn metadata** vào class hoặc method. Metadata này không trực tiếp thực hiện logic, nó chỉ lưu trữ thông tin.
2. **Guards sử dụng ExecutionContext**:
    
    - **Guards** được gọi trước khi thực hiện một handler (method trong controller).
    - `ExecutionContext` trong guards cung cấp khả năng truy cập vào thông tin của handler và class, bao gồm cả metadata được gắn.
3. **Reflector lấy Metadata**:
    
    - Trong guard, `Reflector` được sử dụng để **lấy lại metadata** từ handler hoặc class mà request hiện tại đang được xử lý.
    - Dựa vào metadata, guard sẽ quyết định cho phép hoặc từ chối truy cập.

---

### **2. Logic trong Guards**

Logic trong **Guards** dựa trên 2 phần chính:

1. Lấy metadata (thông tin bổ sung) từ handler hoặc class.
2. Thực hiện kiểm tra dựa trên thông tin từ metadata.

#### **Ví dụ: Role-based Access Control (RBAC)**

- **Metadata ở Controller:**
    
    - Khai báo yêu cầu vai trò cụ thể trên một endpoint bằng `@Roles`.
- **Guard kiểm tra:**
    
    - Lấy metadata `roles` bằng `Reflector`.
    - Kiểm tra xem user trong request có vai trò phù hợp không.

---

#### **Quá trình hoạt động**

1. Khi client gửi một request đến server:
    
    - NestJS sẽ gọi **guards** trước khi handler (method trong controller) được thực thi.
2. Guard kiểm tra:
    
    - Guard lấy metadata từ handler hoặc class (nếu có).
    - Dựa trên logic (ví dụ: kiểm tra quyền), guard quyết định **cho phép** hoặc **từ chối** request.

---

### **3. Code Chi Tiết để Minh Họa Cơ Chế**

#### **Controller (Khai báo Metadata)**

typescript

Sao chép mã

`import { Controller, Get } from '@nestjs/common'; import { Roles } from './roles.decorator';  @Controller('users') export class UserController {   @Roles('admin') // Gắn metadata 'roles' với giá trị ['admin']   @Get('admin')   getAdminData() {     return 'This is admin data';   }    @Roles('user', 'admin') // Gắn metadata 'roles' với ['user', 'admin']   @Get('profile')   getUserProfile() {     return 'This is user profile';   } }`

#### **Guard (Kiểm tra Metadata)**

typescript

Sao chép mã

`import { Injectable, CanActivate, ExecutionContext } from '@nestjs/common'; import { Reflector } from '@nestjs/core';  @Injectable() export class RolesGuard implements CanActivate {   constructor(private reflector: Reflector) {}    canActivate(context: ExecutionContext): boolean {     // Lấy metadata 'roles' từ handler     const roles = this.reflector.get<string[]>('roles', context.getHandler());     if (!roles) {       return true; // Nếu không có metadata, cho phép truy cập     }      // Lấy request và user từ context     const request = context.switchToHttp().getRequest();     const user = request.user;      // Kiểm tra user có vai trò phù hợp hay không     return roles.some((role) => user?.roles?.includes(role));   } }`

#### **App Module (Đăng ký Guard)**

typescript

Sao chép mã

`import { Module } from '@nestjs/common'; import { APP_GUARD } from '@nestjs/core'; import { RolesGuard } from './roles.guard'; import { UserController } from './user.controller';  @Module({   controllers: [UserController],   providers: [     {       provide: APP_GUARD,       useClass: RolesGuard, // Đặt RolesGuard làm global guard     },   ], }) export class AppModule {}`

---

### **4. Kết quả**

#### **Request ví dụ**

1. Request đến `/users/admin`:
    
    - Guard kiểm tra metadata `roles = ['admin']`.
    - Guard kiểm tra user (từ request) có vai trò `admin`.
    - Nếu user không có vai trò phù hợp, request bị từ chối.
2. Request đến `/users/profile`:
    
    - Metadata `roles = ['user', 'admin']`.
    - User có vai trò `user` hoặc `admin` được phép truy cập.

---

### **5. Tại sao thiết kế như vậy?**

1. **Tách biệt khai báo và logic**:
    
    - Controller chỉ cần khai báo yêu cầu (metadata).
    - Logic kiểm tra được thực hiện bởi guard, giúp code sạch sẽ và dễ bảo trì.
2. **Tính tái sử dụng cao**:
    
    - Guards có thể tái sử dụng ở nhiều nơi, kiểm tra các loại metadata khác nhau (ví dụ: `roles`, `permissions`, `rate limits`).
3. **Tùy chỉnh linh hoạt**:
    
    - Dễ dàng thêm logic kiểm tra mới mà không cần thay đổi controller.

---

### **6. Tóm tắt**

- **Khai báo metadata ở controller**:
    
    - Metadata giống như "cờ" chỉ định logic cần thực hiện cho một handler.
- **Guards xử lý logic**:
    
    - Lấy metadata từ handler/class qua `Reflector`.
    - Kiểm tra điều kiện dựa trên metadata và quyết định cho phép hay từ chối truy cập.

---
## Liên quan

https://chatgpt.com/share/6774b4f3-9df4-8013-ba77-177bbe6c1e80
Tham khảo
https://github.com/sangtrandev00/execution-context-nestjs

#nestjs #backend

---
*Nguồn: Evergreen/concept-base/technical/backend/nestjs/fundamental/Cơ chế hoạt động của Guard trong NestJS ? Cách cấu hình 1 Guard như thế nào ?.md*