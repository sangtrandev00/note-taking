
Dynamic Modules trong NestJS là một tính năng mạnh mẽ, cho phép bạn tạo ra các module có thể cấu hình được (configurable modules). Điều này rất hữu ích khi bạn muốn tái sử dụng một module với các cấu hình khác nhau hoặc phụ thuộc vào các điều kiện cụ thể trong ứng dụng của mình.

Hãy bắt đầu với một ví dụ thực tế:

### **Bước 1: Tạo Dynamic Module**

1. **Cấu trúc module:**


```typescript


```

---

### **Bước 2: Sử dụng Dynamic Module trong ứng dụng**

```typescript


```

---

### **Bước 3: Inject và sử dụng kết nối**

```typescript


```
---

### **Giải thích bằng tiếng Việt**

1. **`DatabaseModule`**:
    
    - Là một module động (Dynamic Module).
    - Phương thức `forRoot` trả về một Dynamic Module, cho phép bạn cấu hình nó tùy theo yêu cầu.
    - Dựa trên `options.type`, module sẽ tạo một kết nối tương ứng (MySQL hoặc MongoDB).
2. **Sử dụng trong `AppModule`**:
    
    - Gọi `DatabaseModule.forRoot(...)` để cung cấp cấu hình (loại DB và host).
3. **Inject và sử dụng**:
    
    - Inject `DATABASE_CONNECTION` trong service/controller để lấy thông tin kết nối.

---

### **Chạy ứng dụng**

Khi bạn chạy ứng dụng và truy cập endpoint `/connection`, bạn sẽ nhận được kết quả như sau (giả sử `type` là `mysql` và `host` là `localhost`):

```json


```


`"Kết nối MySQL tại localhost"`


---
## Liên quan
https://docs.nestjs.com/fundamentals/dynamic-modules
https://chatgpt.com/share/676a1f1a-3db4-8013-9883-27534795d3bd
https://github.com/nestjs/nest/tree/master/sample/25-dynamic-modules
#nestjs #nodejs #backend 