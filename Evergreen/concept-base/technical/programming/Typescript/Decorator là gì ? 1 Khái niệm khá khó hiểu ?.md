---
profileName: sangtrandev00
postId: 3586
postType: post
categories:
  - 39
---
## Decorator là gì ?

Trong TypeScript, **decorator** là một tính năng mạnh mẽ dùng để thêm hoặc sửa đổi hành vi của **lớp**, **phương thức**, **thuộc tính**, hoặc **tham số** tại thời điểm khai báo. Decorator thường được sử dụng trong các framework như Angular để cung cấp các tính năng như Dependency Injection, Metadata Annotation, hoặc xử lý logic tự động.

Decorators được viết dưới dạng **hàm** và được gắn với các thành phần cụ thể bằng cú pháp `@decorator`.

## **Các loại decorator trong TypeScript**

TypeScript hỗ trợ bốn loại decorator chính:

1. **Class Decorator**: Áp dụng lên một lớp.
2. **Method Decorator**: Áp dụng lên một phương thức của lớp.
3. **Property Decorator**: Áp dụng lên thuộc tính của lớp.
4. **Parameter Decorator**: Áp dụng lên tham số của một phương thức.

---

### **Cách tạo và sử dụng decorator**

#### 1. **Class Decorator**

Dùng để thay đổi hoặc mở rộng hành vi của lớp.

```typescript

function LogClass(constructor: Function) {
  console.log(`Class Decorator: ${constructor.name}`);
}

@LogClass
class ExampleClass {
  constructor() {
    console.log("Instance created");
  }
}

// Output:
// Class Decorator: ExampleClass
// Instance created


```
#### 2. **Method Decorator**

Dùng để thay đổi hoặc bổ sung logic cho một phương thức.

```typescript

function LogMethod(target: any, propertyKey: string, descriptor: PropertyDescriptor) {
  const originalMethod = descriptor.value;

  descriptor.value = function (...args: any[]) {
    console.log(`Method Decorator: ${propertyKey} was called with args:`, args);
    return originalMethod.apply(this, args);
  };
}

class ExampleClass {
  @LogMethod
  sayHello(name: string) {
    console.log(`Hello, ${name}`);
  }
}

const example = new ExampleClass();
example.sayHello("Alice");

// Output:
// Method Decorator: sayHello was called with args: [ 'Alice' ]
// Hello, Alice


```

#### 3. **Property Decorator**

Dùng để thao tác với thuộc tính của lớp.

```typescript

function LogProperty(target: any, propertyKey: string) {
  console.log(`Property Decorator: ${propertyKey}`);
}

class ExampleClass {
  @LogProperty
  name: string;

  constructor(name: string) {
    this.name = name;
  }
}

// Output:
// Property Decorator: name

```

#### 4. **Parameter Decorator**

Dùng để thao tác với tham số của phương thức.

```typescript

function LogParameter(target: any, propertyKey: string, parameterIndex: number) {
  console.log(`Parameter Decorator: ${propertyKey}, parameter index: ${parameterIndex}`);
}

class ExampleClass {
  greet(@LogParameter message: string) {
    console.log(message);
  }
}

// Output:
// Parameter Decorator: greet, parameter index: 0


```

---

### **Ví dụ thực tế: Class Decorator với Metadata**

Bạn có thể dùng thư viện `reflect-metadata` để lưu trữ hoặc xử lý metadata trong decorator.

```typescript

import "reflect-metadata";

function Metadata(key: string, value: any) {
  return (target: any) => {
    Reflect.defineMetadata(key, value, target);
  };
}

@Metadata("role", "admin")
class AdminClass {}

console.log(Reflect.getMetadata("role", AdminClass)); // Output: "admin"


```

---

### **Tạo một Custom Decorator**

Để tạo một decorator tùy chỉnh, bạn chỉ cần viết một hàm và áp dụng nó. Dưới đây là ví dụ về một Method Decorator kiểm tra quyền truy cập.

```typescript

function CheckRole(role: string) {
  return (target: any, propertyKey: string, descriptor: PropertyDescriptor) => {
    const originalMethod = descriptor.value;

    descriptor.value = function (...args: any[]) {
      const userRole = args[0]; // Lấy role từ tham số đầu tiên
      if (userRole !== role) {
        console.log(`Access Denied: Required role is ${role}`);
        return;
      }
      return originalMethod.apply(this, args);
    };
  };
}

class Document {
  @CheckRole("admin")
  delete(userRole: string) {
    console.log("Document deleted");
  }
}

const doc = new Document();
doc.delete("guest"); // Output: Access Denied: Required role is admin
doc.delete("admin"); // Output: Document deleted

```

---

### **Tóm tắt** về khái niệm decorator

- Decorator là một hàm dùng để gắn thêm logic cho lớp, phương thức, thuộc tính, hoặc tham số.
- Có 4 loại chính: Class, Method, Property, Parameter Decorator.
- Decorator mạnh mẽ và hữu ích trong việc tái sử dụng logic và quản lý metadata.


### **Thứ tự thực thi decorator**

Khi có nhiều loại decorator được áp dụng lên một lớp hoặc các thành phần bên trong nó, chúng được thực thi theo thứ tự sau:

1. **Property Decorators** (các decorator của thuộc tính).
2. **Parameter Decorators** (các decorator của tham số).
3. **Method Decorators** (các decorator của phương thức).
4. **Class Decorator** (decorator của lớp).

Đối với cùng một loại decorator:

- Các decorator được gọi **từ dưới lên** trong cùng một lớp (nghĩa là decorator cuối cùng được viết trong mã nguồn sẽ được gọi trước).

---

### **Ví dụ thực thi Class Decorator trước khi khởi tạo class**

```typescript

function LogClass(constructor: Function) {
  console.log("Class Decorator executed");
}

@LogClass
class ExampleClass {
  constructor() {
    console.log("Instance created");
  }
}

const instance = new ExampleClass();

// Output:
// Class Decorator executed
// Instance created

```


**Giải thích**:

1. Decorator `@LogClass` được thực thi **ngay khi TypeScript biên dịch đoạn mã class `ExampleClass`**, trước khi `new ExampleClass()` được gọi.
2. Khi `new ExampleClass()` được thực thi, lúc đó constructor mới được gọi và instance của class được tạo.

---

### **Minh họa thứ tự thực thi khi có nhiều decorator**

Hãy xem một ví dụ phức tạp hơn với nhiều loại decorator:

```typescript

function LogClass(constructor: Function) {
  console.log("Class Decorator");
}

function LogProperty(target: any, propertyKey: string) {
  console.log(`Property Decorator: ${propertyKey}`);
}

function LogMethod(target: any, propertyKey: string, descriptor: PropertyDescriptor) {
  console.log(`Method Decorator: ${propertyKey}`);
}

function LogParameter(target: any, propertyKey: string, parameterIndex: number) {
  console.log(`Parameter Decorator: ${propertyKey}, index: ${parameterIndex}`);
}

@LogClass
class ExampleClass {
  @LogProperty
  name: string;

  constructor(name: string) {
    this.name = name;
  }

  @LogMethod
  greet(@LogParameter message: string) {
    console.log(`Hello, ${message}`);
  }
}

// Output:
// Property Decorator: name
// Method Decorator: greet
// Parameter Decorator: greet, index: 0
// Class Decorator


```

**Giải thích**:

1. **Property Decorators** (`@LogProperty`) được thực thi đầu tiên.
2. **Method Decorators** (`@LogMethod`) được thực thi tiếp theo.
3. **Parameter Decorators** (`@LogParameter`) được thực thi ngay sau đó.
4. Cuối cùng, **Class Decorator** (`@LogClass`) được thực thi.

---

### **Chạy thử class với decorator**

```typescript

const instance = new ExampleClass("Alice");
instance.greet("world");

// Output:
// (Không có thêm log nào vì decorator chỉ chạy tại compile-time)
// Hello, world


```

**Lưu ý quan trọng**:

- Sau khi decorator thực thi, nó không ảnh hưởng đến runtime của class trừ khi decorator đó thay đổi logic class (ví dụ: override constructor, thay đổi method, v.v.).

---

### **Ví dụ Decorator thay đổi runtime của Class**

Class Decorator có thể **thay thế constructor** hoặc bổ sung logic runtime:

```typescript

function ModifyClass(constructor: Function) {
  console.log("Class Decorator executed");

  return class extends (constructor as any) {
    newProperty = "I'm a new property";
    greet() {
      console.log("This is modified behavior!");
    }
  };
}

@ModifyClass
class ExampleClass {
  constructor() {
    console.log("Original constructor");
  }
}

const instance = new ExampleClass();
console.log((instance as any).newProperty); // Output: I'm a new property
(instance as any).greet(); // Output: This is modified behavior!

// Output:
// Class Decorator executed
// Original constructor
// I'm a new property
// This is modified behavior!


```


**Giải thích**:

- Decorator `@ModifyClass` thay thế `ExampleClass` bằng một class mới (kế thừa class gốc), từ đó thay đổi cả runtime behavior.

---

### **Tóm tắt** về thứ tự chạy của decorator

1. Các decorator được thực thi **ngay tại compile-time** (khi chương trình định nghĩa class, phương thức, thuộc tính).
2. **Class Decorator** luôn được gọi trước khi bất kỳ instance nào được khởi tạo.
3. Thứ tự thực thi các decorator: Property → Parameter → Method → Class.
4. Decorator có thể thay đổi logic hoặc bổ sung runtime behavior của class/method.


---
## Liên quan

https://www.typescriptlang.org/docs/handbook/decorators.html
https://chatgpt.com/share/67793eb6-694c-8013-a4c4-afc6590044a5

#typescript #programming #interview