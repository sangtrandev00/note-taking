---
layout: post
title: "Lazy Load Modules trong NestJS là gì ?"
date: 2025-08-27 10:00:00 +0700
categories: concept-base technical backend nestjs fundamental
tags: ["nestjs", "typescript", "backend"]
source_path: "Evergreen/concept-base/technical/backend/nestjs/fundamental/Lazy Load Modules trong NestJS là gì ?.md"
---
---
profileName: sangtrandev00
postId: 3452
postType: post
categories:
  - 39
---
Lazy Loading Modules trong NestJS giúp tối ưu hóa hiệu suất ứng dụng bằng cách chỉ tải những module mà ứng dụng cần sử dụng tại một thời điểm cụ thể. Điều này đặc biệt hữu ích trong các ứng dụng lớn với nhiều module phức tạp, giúp giảm thời gian khởi động và tiết kiệm tài nguyên hệ thống.

Thay vì tải tất cả module ngay khi ứng dụng khởi chạy (eager loading), với lazy loading, bạn có thể tải module khi thực sự cần thiết.

---

## Cách hoạt động Lazy Loading Modules

Để thực hiện Lazy Loading trong NestJS, bạn cần:

1. **Tạo Module cần Lazy Load**: Đây sẽ là module được tải khi cần thiết.
2. **Sử dụng Dynamic Module Loader**: Import module đó bằng phương pháp động (`import()`).

---

## Ví dụ thực tế

### 1. **Cấu trúc dự án mẫu**

Giả sử bạn có ứng dụng quản lý nhân sự (HRM) với các module như sau:

- **EmployeeModule**: Quản lý nhân viên.
- **ShiftModule**: Quản lý ca làm việc.
- **ReportModule**: Tạo báo cáo.

Bạn muốn lazy load `ReportModule` vì nó chỉ được sử dụng khi người dùng yêu cầu tạo báo cáo.

### 2. **Tạo `ReportModule`**

```typescript
// report.module.ts
import { Module } from '@nestjs/common';
import { ReportService } from './report.service';
import { ReportController } from './report.controller';

@Module({
  controllers: [ReportController],
  providers: [ReportService],
})
export class ReportModule {}

```

### 3. **Lazy Load Module trong `AppModule`**

```typescript

// app.module.ts
import { Module } from '@nestjs/common';

@Module({
  imports: [], // Không cần import eager module như trước
})
export class AppModule {}

```


Trong một `Controller` hoặc `Service`, bạn có thể sử dụng lazy loading như sau:

### 4. **Lazy Load trong Controller**

```typescript

// app.controller.ts
import { Controller, Get } from '@nestjs/common';

@Controller()
export class AppController {
  @Get('load-report-module')
  async loadReportModule() {
    const { ReportModule } = await import('./report/report.module');
    // Có thể thực hiện logic sau khi module được tải, ví dụ gọi service hoặc khởi tạo
    return 'ReportModule loaded!';
  }
}

```

---

## Ứng dụng thực tế

1. **Hệ thống quản lý nhân sự (HRM)**:
    
    - `ShiftModule` chỉ được tải khi quản lý cần xem thông tin ca làm việc.
    - `PayrollModule` chỉ được tải khi tính toán lương.
2. **Ứng dụng thương mại điện tử**:
    
    - `OrderModule` được tải khi người dùng vào trang "Đơn hàng".
    - `ProductModule` được tải khi người dùng duyệt sản phẩm.

---

## Lợi ích

1. **Hiệu suất tốt hơn**: Giảm thời gian khởi tạo ứng dụng, đặc biệt khi có nhiều module phức tạp.
2. **Tiết kiệm tài nguyên**: Module chỉ được tải khi cần thiết.
3. **Tối ưu hóa trải nghiệm người dùng**: Người dùng có cảm giác nhanh hơn vì không cần tải các phần không cần thiết ngay từ đầu.


---
## Liên quan

https://kelvinbz.medium.com/nestjs-lazy-loading-modules-f2f32c506c84
https://docs.nestjs.com/fundamentals/lazy-loading-modules
Bên dưới là source mình đã tạo các đoạn code ví dụ trong bài viết, cách khởi tạo và sử dụng cơ bản, tham khảo nhé
https://github.com/sangtrandev00/lazy-loading-modules-nestjs

Xem thêm [[**series NestJS cơ bản tại đây nhé!**]]

#nestjs #backend

---
*Nguồn: Evergreen/concept-base/technical/backend/nestjs/fundamental/Lazy Load Modules trong NestJS là gì ?.md*