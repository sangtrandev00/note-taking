
### **1. Kiến trúc hệ thống**

Hệ thống sẽ gồm các microservices chính:

1. **API Gateway:** Làm trung gian giữa client và các dịch vụ. Đảm nhận việc xác thực, ủy quyền, và định tuyến.
2. **Order Service:** Quản lý đơn hàng (tạo, cập nhật, hủy).
3. **Payment Service:** Xử lý thanh toán (thẻ, ví điện tử, chuyển khoản).
4. **Notification Service:** Gửi thông báo qua email, SMS hoặc push notification.
5. **Log Service:** Thu thập và phân tích log từ các dịch vụ khác.
6. **Inventory Service:** Quản lý tồn kho sản phẩm.
7. **User Service:** Quản lý tài khoản người dùng (đăng ký, đăng nhập, thông tin người dùng).
8. **Database Layer:** Sử dụng các cơ sở dữ liệu phù hợp (MongoDB, MySQL, Redis).
9. **Message Broker (RabbitMQ):** Đảm nhận giao tiếp bất đồng bộ giữa các dịch vụ.
10. **Monitoring & Observability:** Bao gồm Prometheus, Grafana để giám sát.

---

### **2. High-Level Architecture Diagram**
				
`Client    |    ↓ API Gateway    ↓ +----------------------------+ |        Microservices       | +----------------------------+ | - Order Service            | | - Payment Service          | | - Notification Service     | | - Log Service              | | - Inventory Service        | | - User Service             | +----------------------------+    ↓           ↓ RabbitMQ     Database Layer`

---

### **3. Giao tiếp giữa các dịch vụ**

#### **a. API Gateway ↔ Microservices**

- Giao tiếp qua HTTP REST hoặc gRPC.
- Định tuyến các request đến các dịch vụ tương ứng.

#### **b. Microservices ↔ RabbitMQ**

- RabbitMQ dùng để truyền message bất đồng bộ.
- Ví dụ: Khi một đơn hàng được tạo, `Order Service` gửi message `order_created` tới RabbitMQ để các dịch vụ khác (Payment, Notification) xử lý.

#### **c. Database Layer**

- Dịch vụ nào cần stateful sẽ sử dụng cơ sở dữ liệu riêng.
- Ví dụ:
    - `Order Service`: MySQL để lưu trữ chi tiết đơn hàng.
    - `Log Service`: MongoDB để lưu trữ log.
    - `Inventory Service`: Redis để quản lý tồn kho theo thời gian thực.

---

### **4. Cách tổ chức source code**

#### **Root Directory Structure**

```sql

project/
├── api-gateway/
├── order-service/
├── payment-service/
├── notification-service/
├── log-service/
├── inventory-service/
├── user-service/
├── shared-libs/
│   ├── common/
│   ├── constants/
│   ├── dtos/
│   ├── exceptions/
│   └── interfaces/
├── docker-compose.yml
├── kubernetes/
│   ├── api-gateway/
│   ├── order-service/
│   └── ...
└── docs/

```


#### **Service Directory Structure**

Ví dụ: `order-service`

```css

order-service/
├── src/
│   ├── app.module.ts
│   ├── main.ts
│   ├── controllers/
│   │   ├── order.controller.ts
│   ├── services/
│   │   ├── order.service.ts
│   ├── repositories/
│   │   ├── order.repository.ts
│   ├── entities/
│   │   ├── order.entity.ts
│   └── dtos/
│       ├── create-order.dto.ts
│       ├── update-order.dto.ts
│       └── response.dto.ts
├── test/
├── package.json
└── Dockerfile


```

---

### **5. Use Case: Đặt Hàng Trực Tuyến**

#### **Luồng hoạt động**

1. **Client gửi yêu cầu tạo đơn hàng** qua API Gateway.
2. **Order Service**:
    - Lưu đơn hàng vào database.
    - Gửi message `order_created` đến RabbitMQ.
3. **Payment Service**:
    - Nhận message từ RabbitMQ.
    - Xử lý thanh toán.
    - Gửi message `payment_completed` hoặc `payment_failed` đến RabbitMQ.
4. **Notification Service**:
    - Nhận message `order_created` và `payment_completed`.
    - Gửi thông báo tới người dùng.
5. **Log Service**:
    - Thu thập log từ các dịch vụ khác thông qua RabbitMQ.
    - Lưu trữ vào MongoDB để phân tích.

---

### **6. Ví dụ Cụ Thể Bằng Code**

#### **Order Service (Tạo đơn hàng)**

- **`order.controller.ts`:**
    

```typescript


```

- **`order.service.ts`:**

```typescript


```

#### **Payment Service (Xử lý thanh toán)**

- **`payment.service.ts`:**

```typescript


```

#### **Notification Service (Gửi thông báo)**

- **`notification.service.ts`:**
    

```typescript


```

---

### **7. Mở rộng & Tối ưu**

1. **Authentication & Authorization**:
    
    - API Gateway sử dụng OAuth2 hoặc JWT để xác thực người dùng.
2. **Monitoring & Observability**:
    
    - Sử dụng **Prometheus** và **Grafana** để giám sát hiệu suất.
    - **ELK Stack** (Elasticsearch, Logstash, Kibana) để phân tích log.
3. **Deployment**:
    
    - Sử dụng Kubernetes để triển khai và quản lý các microservices.
    - Dockerize từng dịch vụ để dễ dàng triển khai trên nhiều môi trường.
4. **CQRS & Event Sourcing**:
    
    - Sử dụng CQRS cho việc tách logic ghi và đọc.
    - Event Sourcing để lưu trữ các sự kiện.


---
## Liên quan

Theo dõi cấu trúc dự án tại repository mình publish tại đây!
https://github.com/sangtrandev00/rabbitmq-microservices-project-structure-nestjs
https://chatgpt.com/share/6778fe61-053c-8013-b04b-de5224c5453c

#nestjs #backend #microservice 