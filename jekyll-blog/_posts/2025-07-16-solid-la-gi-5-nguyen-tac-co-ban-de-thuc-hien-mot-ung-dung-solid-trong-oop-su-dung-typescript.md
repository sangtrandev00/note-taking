---
layout: post
title: "SOLID là gì ? 5 Nguyên tắc cơ bản để thực hiện một ứng dụng SOLID trong OOP sử dụng Typescript"
date: 2025-07-16 10:00:00 +0700
categories: concept-base technical OOP
tags: ["nestjs", "mongodb", "mysql", "typescript", "database", "sql"]
source_path: "Evergreen/concept-base/technical/OOP/SOLID là gì ? 5 Nguyên tắc cơ bản để thực hiện một ứng dụng SOLID trong OOP sử dụng Typescript.md"
---
---
profileName: sangtrandev00
postId: 3560
postType: post
categories:
  - 39
---
SOLID là tập hợp năm nguyên tắc thiết kế phần mềm trong lập trình hướng đối tượng (OOP), giúp cải thiện khả năng mở rộng, bảo trì và khả năng đọc mã nguồn. Dưới đây là từng nguyên tắc SOLID cùng ví dụ minh họa bằng TypeScript.

---

### **1. Single Responsibility Principle (SRP)**

**Nguyên tắc**: Một class chỉ nên đảm nhận một trách nhiệm duy nhất.

**Ví dụ**:

```typescript

// Vi phạm SRP
class UserManager {
  createUser(user: string) {
    console.log(`User ${user} created`);
  }
  logActivity(activity: string) {
    console.log(`Activity logged: ${activity}`);
  }
}

// Tuân thủ SRP
class UserCreator {
  createUser(user: string) {
    console.log(`User ${user} created`);
  }
}

class ActivityLogger {
  logActivity(activity: string) {
    console.log(`Activity logged: ${activity}`);
  }
}

// Sử dụng
const userCreator = new UserCreator();
const logger = new ActivityLogger();
userCreator.createUser("John");
logger.logActivity("User creation");

```


---

### **2. Open/Closed Principle (OCP)**

**Nguyên tắc**: Một class nên mở rộng được mà không cần chỉnh sửa mã hiện có.

**Ví dụ**:

```typescript

// Vi phạm OCP
class Notification {
  send(type: string, message: string) {
    if (type === "email") {
      console.log(`Sending email: ${message}`);
    } else if (type === "sms") {
      console.log(`Sending SMS: ${message}`);
    }
  }
}

// Tuân thủ OCP
interface Notification {
  send(message: string): void;
}

class EmailNotification implements Notification {
  send(message: string): void {
    console.log(`Sending email: ${message}`);
  }
}

class SMSNotification implements Notification {
  send(message: string): void {
    console.log(`Sending SMS: ${message}`);
  }
}

// Sử dụng
function notify(notification: Notification, message: string) {
  notification.send(message);
}

notify(new EmailNotification(), "Hello via Email!");
notify(new SMSNotification(), "Hello via SMS!");


```
---

### **3. Liskov Substitution Principle (LSP)**

**Nguyên tắc**: Các class con nên có thể thay thế class cha mà không làm thay đổi hành vi của chương trình.

**Ví dụ**:

```typescript

// Vi phạm LSP
class Bird {
  fly() {
    console.log("Flying");
  }
}

class Penguin extends Bird {
  fly() {
    throw new Error("Penguins can't fly");
  }
}

// Tuân thủ LSP
class Bird {
  move() {
    console.log("Moving");
  }
}

class FlyingBird extends Bird {
  move() {
    console.log("Flying");
  }
}

class Penguin extends Bird {
  move() {
    console.log("Swimming");
  }
}

// Sử dụng
const birds: Bird[] = [new FlyingBird(), new Penguin()];
birds.forEach((bird) => bird.move());

```

---

### **4. Interface Segregation Principle (ISP)**

**Nguyên tắc**: Một interface không nên ép buộc các class thực thi nó phải phụ thuộc vào các phương thức không cần thiết.

**Ví dụ**:

```typescript

// Vi phạm ISP
interface Animal {
  fly(): void;
  swim(): void;
}

class Dog implements Animal {
  fly() {
    throw new Error("Dogs can't fly");
  }
  swim() {
    console.log("Dog swimming");
  }
}

// Tuân thủ ISP
interface Swimmer {
  swim(): void;
}

interface Flyer {
  fly(): void;
}

class Dog implements Swimmer {
  swim() {
    console.log("Dog swimming");
  }
}

class Bird implements Flyer {
  fly() {
    console.log("Bird flying");
  }
}

// Sử dụng
const dog = new Dog();
dog.swim();

const bird = new Bird();
bird.fly();


```

---

### **5. Dependency Inversion Principle (DIP)**

**Nguyên tắc**: Các module cấp cao không nên phụ thuộc vào các module cấp thấp. Cả hai nên phụ thuộc vào abstraction.

**Ví dụ**:

```typescript

// Vi phạm DIP
class MySQLDatabase {
  connect() {
    console.log("Connecting to MySQL");
  }
}

class App {
  db: MySQLDatabase;

  constructor() {
    this.db = new MySQLDatabase();
  }

  start() {
    this.db.connect();
  }
}

// Tuân thủ DIP
interface Database {
  connect(): void;
}

class MySQLDatabase implements Database {
  connect() {
    console.log("Connecting to MySQL");
  }
}

class MongoDBDatabase implements Database {
  connect() {
    console.log("Connecting to MongoDB");
  }
}

class App {
  db: Database;

  constructor(db: Database) {
    this.db = db;
  }

  start() {
    this.db.connect();
  }
}

// Sử dụng
const app1 = new App(new MySQLDatabase());
app1.start();

const app2 = new App(new MongoDBDatabase());
app2.start();

```

---

Những nguyên tắc SOLID giúp thiết kế mã nguồn rõ ràng, dễ bảo trì và mở rộng, đồng thời giảm thiểu các lỗi phát sinh khi thay đổi hoặc nâng cấp hệ thống.



---
## Liên quan
https://viblo.asia/p/boilerplate-nestjs-mot-ti-solid-5pPLkAgy4RZ
https://ngontumathuat.com/post/y-tuong-dang-sau-design-pattern-cua-nestjs-9rtF1xwqphjT4rQB9aMH/
Tham khảo đoạn code mình thực thi ở bên dưới link repository github
https://github.com/sangtrandev00/solid-principle-typescript
Ngoài các đoạn ví dụ minh hoạ trên các bạn có thể tham khảo series học lập trình trong blog của mình nhé!

#typescript #oop #solid

---
*Nguồn: Evergreen/concept-base/technical/OOP/SOLID là gì ? 5 Nguyên tắc cơ bản để thực hiện một ứng dụng SOLID trong OOP sử dụng Typescript.md*