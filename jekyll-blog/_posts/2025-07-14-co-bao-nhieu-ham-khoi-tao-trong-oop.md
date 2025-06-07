---
layout: post
title: "Có bao nhiêu hàm khởi tạo trong OOP"
date: 2025-07-14 10:00:00 +0700
categories: concept-base technical OOP
tags: ["javascript"]
source_path: "Evergreen/concept-base/technical/OOP/Có bao nhiêu hàm khởi tạo trong OOP.md"
---
Hàm khởi tạo không có tham số (**no-argument constructor**) là một loại hàm khởi tạo không nhận bất kỳ tham số nào. Nó thường được sử dụng để khởi tạo các giá trị mặc định cho thuộc tính của lớp.

### Ví dụ: No-Argument Constructor trong JavaScript

javascript

Sao chép mã


```js
class Employee {
  constructor() { // Đây là hàm khởi tạo không có tham số trong JS
    this.name = 'Unknown';
    this.position = 'Not Assigned';
    this.salary = 0;
  }

  displayInfo() {
    console.log(`Name: ${this.name}, Position: ${this.position}, Salary: $${this.salary}`);
  }
}

// Sử dụng no-argument constructor
const employee = new Employee();

// Thông tin ban đầu được khởi tạo với giá trị mặc định
employee.displayInfo(); // Name: Unknown, Position: Not Assigned, Salary: $0


```

---

### Giải thích:

- Hàm `constructor()` trong lớp `Employee` là một no-argument constructor vì nó không nhận bất kỳ tham số nào.
- Các thuộc tính `name`, `position`, và `salary` được khởi tạo với các giá trị mặc định (`Unknown`, `Not Assigned`, và `0`).

---

### Ứng dụng thực tế:

Hàm khởi tạo không có tham số hữu ích khi bạn muốn tạo đối tượng với trạng thái mặc định và sẽ cập nhật các giá trị sau đó thông qua các phương thức khác.

### Trả lời với nhà tuyển dụng:

> "Hàm khởi tạo không có tham số giúp khởi tạo đối tượng với các giá trị mặc định. Ví dụ, trong một ứng dụng quản lý nhân viên, tôi sử dụng no-argument constructor để tạo đối tượng `Employee` với tên, chức vụ và mức lương mặc định, sau đó cập nhật thông tin chi tiết khi có dữ liệu cụ thể từ người dùng."

Bạn có muốn thêm ví dụ hoặc giải thích khác liên quan đến các loại hàm khởi tạo không?

---
*Nguồn: Evergreen/concept-base/technical/OOP/Có bao nhiêu hàm khởi tạo trong OOP.md*