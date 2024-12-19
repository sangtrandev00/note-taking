
## Ví dụ thực tế về tính đóng gói trong thực tế

Tính đóng gói (Encapsulation) trong OOP là nguyên tắc bảo vệ dữ liệu bằng cách ẩn thông tin chi tiết của đối tượng, chỉ cho phép truy cập thông qua các phương thức (getters/setters) được định nghĩa sẵn. Điều này giúp bảo đảm tính toàn vẹn của dữ liệu và giảm thiểu sự phụ thuộc giữa các thành phần trong hệ thống.

### Ví dụ thực tế: Quản lý thông tin nhân viên

Dưới đây là một ví dụ minh họa tính đóng gói trong JavaScript/Node.js:

```js

class Employee {
  #name; // Thuộc tính private
  #salary; // Thuộc tính private

  constructor(name, salary) {
    this.#name = name;
    this.#salary = salary;
  }

  // Getter cho name
  getName() {
    return this.#name;
  }

  // Setter cho name
  setName(name) {
    if (name && name.length > 0) {
      this.#name = name;
    } else {
      throw new Error('Invalid name');
    }
  }

  // Getter cho salary
  getSalary() {
    return this.#salary;
  }

  // Setter cho salary với kiểm tra
  setSalary(salary) {
    if (salary > 0) {
      this.#salary = salary;
    } else {
      throw new Error('Salary must be positive');
    }
  }
}

// Sử dụng lớp Employee
const employee = new Employee('John Doe', 5000);

// Truy cập dữ liệu thông qua getters và setters
console.log(employee.getName()); // John Doe
console.log(employee.getSalary()); // 5000

// Cập nhật thông tin nhân viên
employee.setName('Jane Doe');
employee.setSalary(6000);

// Hiển thị thông tin sau khi cập nhật
console.log(employee.getName()); // Jane Doe
console.log(employee.getSalary()); // 6000

// Cố gắng truy cập trực tiếp thuộc tính private (sẽ báo lỗi)
try {
  console.log(employee.#salary); // Lỗi: Private field '#salary' must be declared in an enclosing class
} catch (error) {
  console.error(error.message);
}


```

## Ví dụ về tính chất đa hình trong thực tế

Nếu nhà tuyển dụng hỏi về ứng dụng thực tế, bạn có thể trả lời:

> "Tính đa hình rất hữu ích trong việc thiết kế hệ thống dễ mở rộng. Ví dụ, khi xây dựng API xử lý dữ liệu từ các loại người dùng khác nhau (admin, khách, nhân viên), tôi có thể sử dụng các lớp kế thừa từ một lớp chung và ghi đè các phương thức phù hợp, đảm bảo code dễ bảo trì và tái sử dụng."


---
## Liên quan

https://chatgpt.com/share/67637972-6600-8013-9ace-5e4f0e872e29