**Overriding** và **Overloading** là hai khái niệm quan trọng trong lập trình hướng đối tượng (OOP). Dưới đây là sự khác biệt giữa chúng:

---

### **1. Method Overriding (Ghi đè phương thức)**

- **Định nghĩa**: Xảy ra khi một phương thức trong lớp con có cùng tên, kiểu trả về, và danh sách tham số như phương thức trong lớp cha, nhưng lớp con cung cấp cách triển khai riêng cho phương thức đó.
- **Mục đích**: Thay đổi hoặc mở rộng hành vi của phương thức trong lớp cha.
- **Thời điểm**: Quyết định tại **runtime** (đa hình động).

**Ví dụ thực tế:**

Sao chép mã

```js
class Animal {
  makeSound() {
    console.log("Animal makes a sound");
  }
}

class Dog extends Animal {
  makeSound() {
    console.log("Dog barks");
  }
}

class Cat extends Animal {
  makeSound() {
    console.log("Cat meows");
  }
}

// Sử dụng overriding
const animals = [new Animal(), new Dog(), new Cat()];
animals.forEach(animal => animal.makeSound());

// Output:
// Animal makes a sound
// Dog barks
// Cat meows


```


**Ứng dụng thực tế bạn đã thấy hoặc sử dụng**:

- Trong hệ thống quản lý nhân sự (HRM), bạn có lớp `Employee` với phương thức `calculateSalary()`. Trong lớp con `Manager` hoặc `Developer`, bạn ghi đè phương thức này để tính toán lương theo cách khác nhau.

---

### **2. Method Overloading (Nạp chồng phương thức)**

- **Định nghĩa**: Xảy ra khi trong cùng một lớp, có nhiều phương thức cùng tên nhưng khác nhau về số lượng hoặc kiểu tham số.
- **Mục đích**: Cho phép một phương thức có thể hoạt động với nhiều kiểu dữ liệu hoặc số lượng tham số khác nhau.
- **Thời điểm**: Quyết định tại **compile-time** (đa hình tĩnh).

**Ví dụ thực tế (giả lập overloading trong JavaScript):**

```js

class Calculator {
  add(a, b) {
    return a + b;
  }

  add(a, b, c) {
    return a + b + c;
  }
}

// Sử dụng overloading
const calc = new Calculator();
console.log(calc.add(2, 3, 5)); // 10

// Trong JavaScript, cách này phải được cấu hình rõ ràng vì nó không hỗ trợ overloading tự nhiên như Java hoặc C++.

```


**Ứng dụng thực tế bạn đã thấy hoặc sử dụng**:

- Trong một hệ thống quản lý đơn hàng, phương thức `calculateTotalPrice()` có thể được triển khai với overloading:
    - Tính tổng giá cho một sản phẩm (`calculateTotalPrice(price)`).
    - Tính tổng giá cho nhiều sản phẩm (`calculateTotalPrice(priceArray)`).

---

### **So sánh Overriding và Overloading**

| **Đặc điểm**             | **Overriding**                           | **Overloading**                                       |
| ------------------------ | ---------------------------------------- | ----------------------------------------------------- |
| **Nơi áp dụng**          | Giữa lớp cha và lớp con                  | Trong cùng một lớp                                    |
| **Mục đích**             | Thay đổi hành vi phương thức của lớp cha | Cung cấp nhiều cách thực thi của phương thức cùng tên |
| **Thời điểm quyết định** | Runtime (đa hình động)                   | Compile-time (đa hình tĩnh)                           |
| **Sử dụng**              | Đa hình                                  | Linh hoạt với tham số                                 |


---
## Liên quan

#interview #oop