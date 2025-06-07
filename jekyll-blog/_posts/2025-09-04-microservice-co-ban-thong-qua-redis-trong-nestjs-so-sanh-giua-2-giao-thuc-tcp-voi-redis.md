---
layout: post
title: "Microservice cơ bản thông qua Redis trong NestJS ? So sánh giữa 2 giao thức tcp với redis"
date: 2025-09-04 10:00:00 +0700
categories: concept-base technical backend nestjs microservices
tags: ["nestjs", "typescript", "api", "microservices", "backend"]
source_path: "Evergreen/concept-base/technical/backend/nestjs/microservices/Microservice cơ bản thông qua Redis trong NestJS ? So sánh giữa 2 giao thức tcp với redis.md"
---
---
profileName: sangtrandev00
postId: 3513
postType: post
categories:
  - 39
---
## ** Sử dụng Redis Transport**

### **Kịch bản**

Chúng ta sẽ xây dựng một hệ thống với hai microservices:

1. **User Service**: Quản lý người dùng.
2. **Notification Service**: Gửi thông báo đến người dùng dựa trên yêu cầu từ **User Service**.

### **Bước 1: Cài đặt Redis và các package cần thiết**

1. Cài Redis trên máy:
    
    - Nếu bạn chưa cài đặt Redis, hãy chạy:
        
        `sudo apt update sudo apt install redis-server sudo systemctl start redis`
        
2. Cài các package cần thiết trong dự án:
    
    `npm install @nestjs/microservices redis`
    

---

### **Bước 2: Tạo User Service**

1. **Khởi tạo dự án:**
    
    `nest new user-service`
    
2. **Cấu hình User Service để gửi yêu cầu qua Redis:**
    

```typescript
main.ts

import { NestFactory } from '@nestjs/core';
import { AppModule } from './app.module';
import { MicroserviceOptions, Transport } from '@nestjs/microservices';

async function bootstrap() {
  const app = await NestFactory.createMicroservice<MicroserviceOptions>(AppModule, {
    transport: Transport.REDIS,
    options: {
      host: '127.0.0.1',
      port: 6379,
    },
  });
  await app.listen();
}
bootstrap();

---

app.service.ts

import { Injectable } from '@nestjs/common';
import { ClientProxy, ClientProxyFactory, Transport } from '@nestjs/microservices';

@Injectable()
export class AppService {
  private client: ClientProxy;

  constructor() {
    this.client = ClientProxyFactory.create({
      transport: Transport.REDIS,
      options: { host: '127.0.0.1', port: 6379 },
    });
  }

  async sendNotification(data: any) {
    return this.client.send({ cmd: 'send_notification' }, data);
  }
}




```


3. **Gửi thông báo từ User Service:**
    
```typescript
app.controller.ts

import { Controller, Post, Body } from '@nestjs/common';
import { AppService } from './app.service';

@Controller('user')
export class AppController {
  constructor(private readonly appService: AppService) {}

  @Post('notify')
  notifyUser(@Body() data: { userId: string; message: string }) {
    return this.appService.sendNotification(data);
  }
}

```

---

### **Bước 3: Tạo Notification Service**

1. **Khởi tạo dự án:**
    
    `nest new notification-service`
    
2. **Lắng nghe yêu cầu từ Redis:**
    
```typescript
main.ts

import { NestFactory } from '@nestjs/core';
import { AppModule } from './app.module';
import { MicroserviceOptions, Transport } from '@nestjs/microservices';

async function bootstrap() {
  const app = await NestFactory.createMicroservice<MicroserviceOptions>(AppModule, {
    transport: Transport.REDIS,
    options: {
      host: '127.0.0.1',
      port: 6379,
    },
  });
  await app.listen();
}
bootstrap();


app.controller.ts

import { Controller } from '@nestjs/common';
import { MessagePattern } from '@nestjs/microservices';

@Controller()
export class AppController {
  @MessagePattern({ cmd: 'send_notification' })
  handleNotification(data: { userId: string; message: string }) {
    console.log(`Sending notification to user ${data.userId}: ${data.message}`);
    return `Notification sent to user ${data.userId}`;
  }
}



```

---

### **Kiểm tra Redis Microservices**

1. **Khởi động Notification Service:**
    
    `cd notification-service npm run start:dev`
    
2. **Khởi động User Service:**
    `cd user-service npm run start:dev`
    
3. **Gửi yêu cầu qua Postman hoặc Curl:**
    
    - Gửi thông báo:
        
        `curl -X POST http://localhost:3000/user/notify -H "Content-Type: application/json" -d '{"userId": "123", "message": "Welcome to Redis Microservices!"}'`
        
    - **Kết quả trên Notification Service:**
        
        `Sending notification to user 123: Welcome to Redis Microservices!`


## So sánh giữa giao tiếp thông qua redis và tcp/http thông thường
Dưới đây là bảng so sánh giữa microservices giao tiếp thông qua **Redis** và microservices giao tiếp thông qua **TCP/HTTP** thông thường:

|**Tiêu chí**|**Giao tiếp qua Redis**|**Giao tiếp qua TCP/HTTP**|
|---|---|---|
|**Kiểu giao tiếp**|Pub/Sub, Stream, Message Queue|Request/Response|
|**Hiệu năng**|Rất nhanh nhờ lưu trữ trong bộ nhớ (in-memory).|Chậm hơn vì phụ thuộc vào giao thức TCP/HTTP.|
|**Độ phức tạp**|Cần cấu hình Redis, lập trình xử lý Pub/Sub hoặc Queue.|Ít phức tạp hơn vì HTTP dễ sử dụng và phổ biến.|
|**Khả năng mở rộng**|Cao, dễ dàng thêm node nhờ Redis Cluster.|Tốt, nhưng cần thêm proxy/nginx để load balancing.|
|**Độ tin cậy**|- Redis không bền vững khi mất dữ liệu trong bộ nhớ.  <br>- Có thể cần cấu hình persistence.|Độ tin cậy cao hơn khi sử dụng HTTPS, mã hóa SSL, và lưu trữ trên disk.|
|**Giao tiếp bất đồng bộ**|Hỗ trợ tốt với Pub/Sub hoặc Message Queue.|Khó khăn hơn, cần WebSocket hoặc RabbitMQ.|
|**Giám sát & ghi log**|Khó khăn trong việc giám sát các message (cần Redis Stream hoặc tool).|Dễ dàng theo dõi qua các request/response log.|
|**Khả năng chịu lỗi**|Redis Sentinel/Cluster hỗ trợ nhưng vẫn phụ thuộc nhiều vào Redis.|Tùy thuộc vào hạ tầng mạng và load balancer.|
|**Chi phí hạ tầng**|Yêu cầu cài đặt Redis (tốn thêm tài nguyên).|Không cần dịch vụ bổ sung nếu đã dùng HTTP mặc định.|
|**Tích hợp**|Hạn chế hơn, cần các library Redis client.|Dễ dàng tích hợp với các dịch vụ hoặc API phổ biến.|

---

### **Ưu điểm và nhược điểm**

#### **Giao tiếp qua Redis**

**Ưu điểm**:

- Hiệu năng cao, giao tiếp nhanh chóng nhờ lưu trữ trong bộ nhớ.
- Hỗ trợ tốt các trường hợp bất đồng bộ qua Pub/Sub hoặc Stream.
- Phù hợp với các ứng dụng cần xử lý message nhanh, khối lượng lớn (ví dụ: chat, thông báo).

**Nhược điểm**:

- Cần quản lý Redis và cấu hình đúng để tránh mất dữ liệu (data persistence).
- Không phù hợp với giao tiếp đồng bộ hoặc các ứng dụng RESTful truyền thống.
- Khó giám sát và debug hơn so với HTTP.

#### **Giao tiếp qua TCP/HTTP**

**Ưu điểm**:

- Đơn giản, dễ triển khai và phổ biến.
- Có thể tận dụng hạ tầng HTTP hiện tại mà không cần thêm dịch vụ khác.
- Hỗ trợ giao tiếp đồng bộ, dễ dàng debug qua request/response.

**Nhược điểm**:

- Hiệu năng thấp hơn Redis do overhead của giao thức HTTP.
- Giao tiếp bất đồng bộ cần các giải pháp phức tạp hơn như WebSocket.
- Tốn băng thông mạng hơn Redis.

---

### **Khi nào sử dụng?**

1. **Redis**:
    
    - Ứng dụng real-time (chat, notification).
    - Yêu cầu hiệu năng cao và xử lý bất đồng bộ.
    - Cần hỗ trợ giao tiếp theo mô hình publish-subscribe.
2. **TCP/HTTP**:
    
    - Ứng dụng RESTful thông thường.
    - Giao tiếp cần đồng bộ, dễ quản lý.
    - Muốn tận dụng hạ tầng HTTP hiện có.



## Liên quan

https://chatgpt.com/share/6778f58e-9720-8013-b440-a25a1f4f7fee
https://chatgpt.com/share/6777a88b-5c6c-8013-a2bf-7b42cabd8d58
https://docs.nestjs.com/microservices/redis
Tham khảo source implement microservices
https://github.com/sangtrandev00/user-service-redis-microservices-nestjs
https://github.com/sangtrandev00/notification-service-redis-microservices-nestjs

#nestjs #microservice #backend

---
*Nguồn: Evergreen/concept-base/technical/backend/nestjs/microservices/Microservice cơ bản thông qua Redis trong NestJS ? So sánh giữa 2 giao thức tcp với redis.md*