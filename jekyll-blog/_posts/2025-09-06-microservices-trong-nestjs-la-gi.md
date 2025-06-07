---
layout: post
title: "Microservices trong NestJS là gì ?"
date: 2025-09-06 10:00:00 +0700
categories: concept-base technical backend nestjs microservices
tags: ["nestjs", "typescript", "microservices", "backend"]
source_path: "Evergreen/concept-base/technical/backend/nestjs/microservices/Microservices trong NestJS là gì ?.md"
---
---
profileName: sangtrandev00
postId: 3506
postType: post
categories:
  - 39
---
## **Khái niệm về Microservices trong NestJS**

Microservices là một kiến trúc phần mềm trong đó ứng dụng được chia thành các dịch vụ nhỏ, độc lập, có thể phát triển, triển khai, và mở rộng một cách độc lập. Mỗi dịch vụ thường đảm nhiệm một chức năng cụ thể và giao tiếp với nhau qua các giao thức nhẹ (ví dụ: HTTP, WebSocket, gRPC, hoặc qua hệ thống nhắn tin như Kafka, RabbitMQ).

Trong NestJS, microservices được hỗ trợ như một phần trong hệ sinh thái của framework, giúp xây dựng các dịch vụ nhỏ dễ dàng bằng cách tận dụng các decorator, module-based architecture, và hệ thống transport layer linh hoạt.

---

## **Khi nào nên sử dụng Microservices?**

- **Tăng khả năng mở rộng (Scalability):** Khi ứng dụng của bạn cần mở rộng một phần chức năng cụ thể mà không muốn ảnh hưởng đến toàn bộ hệ thống.
- **Độc lập trong phát triển (Independence in Development):** Khi các nhóm phát triển khác nhau muốn làm việc trên các thành phần khác nhau của hệ thống mà không phụ thuộc nhau.
- **Phân tán ứng dụng (Distributed Systems):** Khi ứng dụng cần xử lý các tác vụ phân tán hoặc cần tích hợp với các hệ thống bên ngoài qua các giao thức khác nhau.
- **Tối ưu hiệu suất:** Khi một số phần của hệ thống cần tối ưu để giảm tải, ví dụ: xử lý thời gian thực, công việc hàng loạt (batch jobs).
- **Tích hợp dễ dàng với hệ thống khác:** Khi ứng dụng cần giao tiếp với các hệ thống hoặc dịch vụ bên ngoài thông qua các giao thức cụ thể.

---

## **Các khái niệm cơ bản liên quan trong Microservices (NestJS)**

1. **Transport Layer (Lớp vận chuyển):**
    
    - NestJS hỗ trợ nhiều loại giao thức vận chuyển như:
        - **TCP:** Sử dụng để giao tiếp đồng bộ giữa các dịch vụ.
        - **Redis:** Sử dụng để giao tiếp pub-sub.
        - **NATS/Kafka/RabbitMQ:** Sử dụng cho messaging patterns như Event-driven hoặc CQRS.
2. **Clients and Servers (Client-Server Communication):**
    
    - **Client:** Thành phần gửi yêu cầu (request) đến một microservice khác.
    - **Server:** Thành phần xử lý yêu cầu và trả về phản hồi (response).
3. **Message Patterns (Mẫu thông điệp):**
    
    - **Request-Response:** Client gửi yêu cầu, server trả lời.
    - **Event-based Communication:** Server phát sự kiện, các service khác lắng nghe và phản hồi.
4. **Custom Transport Strategies:**
    
    - Nếu không dùng transport mặc định, bạn có thể tạo các chiến lược vận chuyển tùy chỉnh.
5. **Service Discovery:**
    
    - Là cách để các dịch vụ tìm và giao tiếp với nhau trong một hệ thống phân tán.

---

## **Ví dụ thực tế**

### **1. Xây dựng hệ thống đặt hàng trực tuyến**

- **Mô tả:**
    - Hệ thống có các dịch vụ:
        - Dịch vụ đặt hàng (`Order Service`)
        - Dịch vụ thanh toán (`Payment Service`)
        - Dịch vụ quản lý sản phẩm (`Product Service`)
    - Các dịch vụ này giao tiếp với nhau qua Redis hoặc RabbitMQ.
- **Lợi ích:**
    - Tăng khả năng mở rộng: Nếu dịch vụ thanh toán nhận được nhiều lưu lượng truy cập, chỉ cần mở rộng dịch vụ này mà không ảnh hưởng đến các phần khác.

### **2. Ứng dụng thể thao trực tuyến**

- **Mô tả:**
    - Dịch vụ **truyền phát video** (streaming) hoạt động tách biệt với dịch vụ **quản lý người dùng**.
    - Dịch vụ **thống kê trận đấu** giao tiếp qua RabbitMQ để cập nhật dữ liệu thời gian thực.
- **Lợi ích:**
    - Độc lập trong triển khai: Các nhóm có thể triển khai từng dịch vụ mà không cần phải triển khai toàn bộ hệ thống.

### **3. Ứng dụng IoT**

- **Mô tả:**
    - Các thiết bị IoT gửi dữ liệu đến một dịch vụ tập trung thông qua MQTT hoặc WebSocket.
    - Dữ liệu được xử lý bởi các microservices riêng lẻ như dịch vụ phân tích dữ liệu, cảnh báo.
- **Lợi ích:**
    - Dễ dàng tích hợp thêm thiết bị mới hoặc nâng cấp dịch vụ mà không làm gián đoạn toàn bộ hệ thống.

## Triển khai hệ thống microservices thực tế trong NestJS

### **Kịch bản thực tế**

Chúng ta sẽ xây dựng một hệ thống quản lý đơn hàng với hai microservices:

1. **Order Service**: Xử lý các yêu cầu liên quan đến đơn hàng.
2. **Payment Service**: Xử lý thanh toán và giao tiếp với Order Service.

Giao tiếp giữa các microservices sẽ được thực hiện thông qua **TCP transport**.

---

### **1. Tạo và thiết lập Order Service**

#### **Step 1: Tạo ứng dụng**

`nest new order-service`

#### **Step 2: Thiết lập Order Service**

- Thêm logic xử lý đơn hàng:

```typescript

// src/app.service.ts
import { Injectable } from '@nestjs/common';

@Injectable()
export class AppService {
  getOrders(): string[] {
    return ['Order 1', 'Order 2', 'Order 3'];
  }

  createOrder(order: string): string {
    return `Order ${order} created successfully!`;
  }
}

```

- Lắng nghe yêu cầu từ microservices khác:

```typescript

// src/app.controller.ts
import { Controller } from '@nestjs/common';
import { MessagePattern } from '@nestjs/microservices';
import { AppService } from './app.service';

@Controller()
export class AppController {
  constructor(private readonly appService: AppService) {}

  @MessagePattern({ cmd: 'get_orders' })
  getOrders() {
    return this.appService.getOrders();
  }

  @MessagePattern({ cmd: 'create_order' })
  createOrder(order: string) {
    return this.appService.createOrder(order);
  }
}

```


- Cấu hình transport trong `main.ts`:

```typescript

import { NestFactory } from '@nestjs/core';
import { AppModule } from './app.module';
import { MicroserviceOptions, Transport } from '@nestjs/microservices';

async function bootstrap() {
  const app = await NestFactory.createMicroservice<MicroserviceOptions>(AppModule, {
    transport: Transport.TCP,
    options: { host: '127.0.0.1', port: 3001 },
  });
  await app.listen();
}
bootstrap();

```
---

### **2. Tạo và thiết lập Payment Service**

#### **Step 1: Tạo ứng dụng**

`nest new payment-service`

#### **Step 2: Thiết lập Payment Service**

- Kết nối đến Order Service:

```typescript

// src/app.service.ts
import { Injectable } from '@nestjs/common';
import { ClientProxy, ClientProxyFactory, Transport } from '@nestjs/microservices';

@Injectable()
export class AppService {
  private client: ClientProxy;

  constructor() {
    this.client = ClientProxyFactory.create({
      transport: Transport.TCP,
      options: { host: '127.0.0.1', port: 3001 },
    });
  }

  getOrders() {
    return this.client.send({ cmd: 'get_orders' }, {});
  }

  createOrder(order: string) {
    return this.client.send({ cmd: 'create_order' }, order);
  }
}

```

- Xử lý logic thanh toán:

```typescript

// src/app.controller.ts
import { Controller, Get, Post, Body } from '@nestjs/common';
import { AppService } from './app.service';

@Controller('payment')
export class AppController {
  constructor(private readonly appService: AppService) {}

  @Get('orders')
  async getOrders() {
    const orders = await this.appService.getOrders().toPromise();
    return orders;
  }

  @Post('order')
  async createOrder(@Body('order') order: string) {
    const response = await this.appService.createOrder(order).toPromise();
    return response;
  }
}


```

- Cấu hình transport trong `main.ts`:

```typescript

import { NestFactory } from '@nestjs/core';
import { AppModule } from './app.module';

async function bootstrap() {
  const app = await NestFactory.create(AppModule);
  await app.listen(3002);
}
bootstrap();


```
---

### **3. Kiểm tra hệ thống**

#### **Step 1: Khởi động Order Service**

`cd order-service npm run start:dev`

#### **Step 2: Khởi động Payment Service**

`cd payment-service npm run start:dev`

#### **Step 3: Gửi yêu cầu từ Payment Service**

- Sử dụng Postman hoặc Curl:

1. **Lấy danh sách đơn hàng:**
    
    `curl http://localhost:3002/payment/orders`
    
    **Kết quả:**
    
    `["Order 1", "Order 2", "Order 3"]`
    
2. **Tạo một đơn hàng mới:**
    
    `curl -X POST http://localhost:3002/payment/order -H "Content-Type: application/json" -d '{"order":"4"}'`
    
    **Kết quả:**
    
    `"Order 4 created successfully!"`
    

---

### ** Kết luận**

Hệ thống microservices này cho thấy cách các dịch vụ giao tiếp qua TCP transport. Bạn có thể mở rộng hệ thống bằng cách thêm các transport khác (Redis, Kafka) hoặc tích hợp thêm nhiều microservices khác để đáp ứng nhu cầu thực tế.


---
## Liên quan
https://chatgpt.com/share/6777a88b-5c6c-8013-a2bf-7b42cabd8d58
https://docs.nestjs.com/microservices/basics
Tham khảo thêm 2 repository bên dưới về cách tương tác giữa các service với nhau:
https://github.com/sangtrandev00/order-service-message-pattern-microservices-nestjs
https://github.com/sangtrandev00/payment-service-message-pattern-microservices-nestjs

#backend #nestjs #microservice

---
*Nguồn: Evergreen/concept-base/technical/backend/nestjs/microservices/Microservices trong NestJS là gì ?.md*