---
profileName: sangtrandev00
postId: 3520
postType: post
categories:
  - 39
---
## **Khái niệm Microservices với RabbitMQ trong NestJS**

Microservices (dịch vụ vi mô) là một kiến trúc phần mềm, trong đó các ứng dụng lớn được chia thành các dịch vụ nhỏ độc lập, có thể triển khai và mở rộng độc lập. Trong NestJS, kiến trúc Microservices được hỗ trợ mạnh mẽ thông qua các message broker như RabbitMQ.

RabbitMQ là một **message broker** cho phép giao tiếp không đồng bộ giữa các dịch vụ bằng cách gửi và nhận thông qua các **queues** và **exchanges**. NestJS tích hợp sẵn với RabbitMQ để xử lý giao tiếp giữa các microservices một cách dễ dàng.

---

## **Tại sao dùng RabbitMQ trong Microservices?**

### **Lợi ích:**

1. **Giao tiếp không đồng bộ**:
    - Các dịch vụ không cần đợi phản hồi tức thì từ các dịch vụ khác, giúp tăng hiệu suất.
2. **Tính tách biệt**:
    - Các dịch vụ hoạt động độc lập, chỉ giao tiếp thông qua RabbitMQ, giảm sự phụ thuộc giữa chúng.
3. **Khả năng mở rộng**:
    - Dễ dàng mở rộng từng microservice mà không ảnh hưởng đến toàn bộ hệ thống.
4. **Retry và xử lý lỗi**:
    - RabbitMQ có cơ chế quản lý message (xác nhận, dead-letter queue) giúp tái gửi message khi xảy ra lỗi.
5. **Hỗ trợ phân tán**:
    - RabbitMQ cho phép các microservices giao tiếp qua mạng trong các hệ thống phân tán.

### **Hạn chế:**

1. **Phức tạp hơn so với giao tiếp trực tiếp**:
    - Cần quản lý RabbitMQ, message queues, và cấu hình nhiều hơn.
2. **Độ trễ giao tiếp**:
    - Giao tiếp qua RabbitMQ có thể chậm hơn so với giao tiếp trực tiếp (HTTP/gRPC) do việc trung gian qua broker.
3. **Khó debug**:
    - Khi xảy ra lỗi trong message processing, khó lần ra nguyên nhân nếu không có log và giám sát tốt.

---

## **Luồng hoạt động thực tế**

1. **Producer gửi message**:
    
    - Người dùng gửi yêu cầu tạo đơn hàng qua REST API (`POST /orders`).
    - Message với nội dung đơn hàng được gửi đến RabbitMQ.
2. **Consumer xử lý message**:
    
    - Consumer nhận message từ queue `orders_queue`.
    - Tiến hành xử lý logic đơn hàng (lưu database, gọi API khác...).

---

## **Use Case Thực Tế**

1. **Hệ thống đặt hàng trực tuyến**:
    
    - Producer (API Gateway): Gửi thông tin đơn hàng.
    - Consumer (Order Service): Xử lý đơn hàng.
    - Consumer (Notification Service): Gửi thông báo cho khách hàng.
2. **Hệ thống phân tích log**:
    
    - Producer (App Services): Gửi log đến RabbitMQ.
    - Consumer (Log Analyzer): Xử lý và lưu trữ log.
3. **Hệ thống thanh toán**:
    
    - Producer (Payment Gateway): Gửi trạng thái thanh toán.
    - Consumer (Order Service): Cập nhật trạng thái đơn hàng.

## **Triển khai Microservices với RabbitMQ sử dụng NestJS và Docker**

---

### **Bước 1: Chuẩn bị môi trường**

#### **1. Khởi tạo dự án NestJS**

Tạo hai dự án NestJS:

- `api-gateway` (Producer)
- `order-service` (Consumer)

```bash

# Tạo API Gateway (Producer)
nest new api-gateway
cd api-gateway
yarn add @nestjs/microservices amqplib

# Tạo Order Service (Consumer)
cd ..
nest new order-service
cd order-service
yarn add @nestjs/microservices amqplib

```
---

#### **2. Docker Compose cho RabbitMQ**

Tạo file `docker-compose.yml`:

```yaml

version: '3.8'
services:
  rabbitmq:
    image: rabbitmq:3-management
    container_name: rabbitmq
    ports:
      - "5672:5672"   # RabbitMQ protocol port
      - "15672:15672" # RabbitMQ management UI
    environment:
      RABBITMQ_DEFAULT_USER: guest
      RABBITMQ_DEFAULT_PASS: guest

```
Khởi chạy RabbitMQ:

`docker-compose up -d`

Truy cập UI quản lý tại: http://localhost:15672 (user: `guest`, pass: `guest`).

---

### **Bước 2: Triển khai API Gateway (Producer)**

#### **1. Cấu hình Producer**

Tạo `OrderService` trong `api-gateway` để gửi đơn hàng.

- **`src/order/order.service.ts`**:
    
```typescript
import { Injectable } from '@nestjs/common';
import { ClientProxy, ClientProxyFactory, Transport } from '@nestjs/microservices';

@Injectable()
export class OrderService {
  private client: ClientProxy;

  constructor() {
    this.client = ClientProxyFactory.create({
      transport: Transport.RMQ,
      options: {
        urls: ['amqp://guest:guest@localhost:5672'],
        queue: 'orders_queue',
        queueOptions: {
          durable: true,
        },
      },
    });
  }

  async createOrder(order: any) {
    return this.client.emit('order_created', order);
  }
}


```

- **`src/order/order.controller.ts`**:
    
```typescript
import { Controller, Post, Body } from '@nestjs/common';
import { OrderService } from './order.service';

@Controller('orders')
export class OrderController {
  constructor(private readonly orderService: OrderService) {}

  @Post()
  async createOrder(@Body() order: any) {
    await this.orderService.createOrder(order);
    return { message: 'Order sent to processing!' };
  }
}


```


- **`src/order/order.module.ts`**:
    
```typescript

import { Module } from '@nestjs/common';
import { OrderService } from './order.service';
import { OrderController } from './order.controller';

@Module({
  controllers: [OrderController],
  providers: [OrderService],
})
export class OrderModule {}

```

- **`src/app.module.ts`**:
    
```typescript

import { Module } from '@nestjs/common';
import { OrderModule } from './order/order.module';

@Module({
  imports: [OrderModule],
})
export class AppModule {}


```

    

---

### **Bước 3: Triển khai Order Service (Consumer)**

#### **1. Cấu hình Consumer**

Tạo một microservice lắng nghe sự kiện từ RabbitMQ.

- **`src/app.controller.ts`**:

```typescript

import { Controller } from '@nestjs/common';
import { MessagePattern } from '@nestjs/microservices';

@Controller()
export class AppController {
  @MessagePattern('order_created')
  handleOrderCreated(order: any) {
    console.log('Processing order:', order);
    // Xử lý logic lưu đơn hàng vào database
  }
}


```

- **`src/main.ts`**:
    
```typescript

import { NestFactory } from '@nestjs/core';
import { MicroserviceOptions, Transport } from '@nestjs/microservices';
import { AppModule } from './app.module';

async function bootstrap() {
  const app = await NestFactory.createMicroservice<MicroserviceOptions>(
    AppModule,
    {
      transport: Transport.RMQ,
      options: {
        urls: ['amqp://guest:guest@localhost:5672'],
        queue: 'orders_queue',
        queueOptions: {
          durable: true,
        },
      },
    },
  );

  await app.listen();
  console.log('Order Service is listening...');
}
bootstrap();


```

---

### **Bước 4: Triển khai Notification Service (Consumer phụ)**

Bạn có thể mở rộng thêm service khác lắng nghe cùng một queue `orders_queue` để gửi thông báo:

- **`src/notification/notification.controller.ts`**:
    

```typescript

import { Controller } from '@nestjs/common';
import { MessagePattern } from '@nestjs/microservices';

@Controller()
export class NotificationController {
  @MessagePattern('order_created')
  notifyCustomer(order: any) {
    console.log('Sending notification for order:', order);
    // Gửi email/SMS thông báo
  }
}

```

---

### **Bước 5: Kiểm tra hoạt động**

#### **1. Chạy các ứng dụng**

- Khởi động từng ứng dụng:
    
    bash
    
    `# API Gateway cd api-gateway yarn start:dev  # Order Service cd ../order-service yarn start:dev`
    

#### **2. Gửi yêu cầu tạo đơn hàng**

Sử dụng `Postman` hoặc `curl` để gửi request đến API Gateway:

bash

`curl -X POST http://localhost:3000/orders \ -H "Content-Type: application/json" \ -d '{"orderId": 123, "product": "Laptop", "quantity": 2}'`

#### **3. Kết quả**

- **API Gateway**: Gửi message đến RabbitMQ.
- **Order Service**: Nhận và xử lý message.
- **Notification Service**: Gửi thông báo (nếu được triển khai).

---

### **Lợi ích từ kiến trúc này**

1. **Phân tách trách nhiệm**:
    - API Gateway chỉ gửi yêu cầu, không chịu trách nhiệm xử lý logic.
2. **Dễ dàng mở rộng**:
    - Có thể thêm các consumer khác mà không cần thay đổi producer.
3. **Độ tin cậy cao**:
    - RabbitMQ đảm bảo message không bị mất nếu cấu hình đúng.

## Câu hỏi 

Nguyên lý cốt lõi của Microservice là gì ?
Các khái niệm liên quan đến RabbitMQ.
Triển khai trong dự án lớn sẽ có sự khác biệt như thế nào ?

---
## Liên quan

https://chatgpt.com/share/6778fe61-053c-8013-b04b-de5224c5453c
https://docs.nestjs.com/microservices/rabbitmq
Tham khảo cách mình implement các source microservice đơn giản
https://github.com/sangtrandev00/api-gateway-rabbitmq-microservices-nestjs
https://github.com/sangtrandev00/order-service-rabbitmq-microservices-nestjs



#nestjs #backend #microservice