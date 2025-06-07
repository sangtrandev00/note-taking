
**Câu hỏi: Em có sử dụng Procedure không? Khi nào em sử dụng Procedure?**  
**Trả lời:**

- Có, em đã sử dụng **stored procedure** trong một số trường hợp khi cần thực thi các thao tác phức tạp trên cơ sở dữ liệu mà yêu cầu hiệu năng cao hoặc cần logic phức tạp được thực hiện trực tiếp trên server database.
- Em sử dụng **procedure** khi các thao tác cần được tái sử dụng nhiều lần và có thể được tối ưu hóa tốt hơn nếu thực hiện ở phía database thay vì phía ứng dụng.

---

### **Khi nào em sử dụng Procedure?**

1. **Thao tác phức tạp trên cơ sở dữ liệu:**
    
    - **Procedure** phù hợp khi cần thực hiện các thao tác nhiều bước, như chèn dữ liệu vào nhiều bảng hoặc xử lý dữ liệu phức tạp.
    - **Ví dụ:** Cập nhật số lượng tồn kho khi một đơn hàng được tạo và ghi log cho thay đổi đó.
2. **Tối ưu hóa hiệu suất:**
    - **Procedure** giúp giảm thiểu việc trao đổi dữ liệu qua lại giữa ứng dụng và database, đặc biệt khi thực hiện các truy vấn phức tạp hoặc xử lý dữ liệu lớn.
    - **Ví dụ:** Tính toán báo cáo doanh thu hàng tháng trực tiếp trong cơ sở dữ liệu thay vì lấy toàn bộ dữ liệu ra ứng dụng.
3. **Đảm bảo tính toàn vẹn và logic nghiệp vụ:**
    
    - Khi cần đảm bảo logic nghiệp vụ được thực thi nhất quán, việc đóng gói logic này vào một **procedure** giúp giảm thiểu lỗi.
    - **Ví dụ:** Một procedure kiểm tra quyền truy cập trước khi thực hiện cập nhật dữ liệu.
4. **Tái sử dụng và giảm mã lặp:**
    
    - **Procedure** giúp tái sử dụng các đoạn mã xử lý giống nhau nhiều lần trong các ứng dụng hoặc tác vụ khác nhau.
    - **Ví dụ:** Một procedure chung để tìm kiếm nhân viên theo các tiêu chí linh hoạt (tên, phòng ban, trạng thái).

---

### **Ví dụ em đã sử dụng Procedure:**

1. **Tìm kiếm nhân viên theo danh sách ID:**

    - **Khi sử dụng:** Lấy danh sách nhân viên theo một danh sách ID được truyền từ ứng dụng.
    - **Lợi ích:** Giảm logic phía ứng dụng, tăng tốc độ xử lý trên server.
```sql

```

1. **Cập nhật trạng thái hóa đơn:**
    
    - **Khi sử dụng:** Thực hiện cập nhật trạng thái hóa đơn theo một logic nhất định.
    - **Lợi ích:** Đảm bảo logic cập nhật trạng thái được thực thi thống nhất.

```sql


```

1. **Tạo báo cáo doanh thu:**
    
    - **Khi sử dụng:** Tính toán tổng doanh thu trong một tháng cụ thể để sử dụng trong báo cáo.
    - **Lợi ích:** Xử lý trực tiếp trên database, giảm thời gian xử lý và tải dữ liệu về ứng dụng.

```sql



```

---

### **Ưu và nhược điểm của Procedure:**

#### **Ưu điểm:**

1. **Hiệu năng cao:** Procedure được thực thi trực tiếp trên server database, giảm thiểu việc truyền dữ liệu giữa ứng dụng và database.
2. **Tái sử dụng:** Logic được đóng gói và tái sử dụng dễ dàng.
3. **Bảo mật:** Procedure giúp ẩn logic xử lý và hạn chế quyền truy cập trực tiếp vào bảng dữ liệu.

#### **Nhược điểm:**

1. **Khó bảo trì:** Nếu logic phức tạp được nhúng trong procedure, việc sửa đổi hoặc nâng cấp có thể khó khăn.
2. **Khả năng mở rộng:** Sử dụng quá nhiều procedure có thể dẫn đến sự phụ thuộc vào database và làm giảm tính linh hoạt khi thay đổi nền tảng hoặc công nghệ.

---

### **Kết luận:**

Em sử dụng **stored procedure** trong các trường hợp cần hiệu năng cao, thao tác phức tạp hoặc logic cần tái sử dụng nhiều lần. Tuy nhiên, em cũng cân nhắc kỹ trước khi sử dụng, đảm bảo nó thực sự cần thiết và phù hợp với yêu cầu của hệ thống.


## Có thể sử dụng Trigger và Procedure thông qua thư viện Typeorm không ? Cho ví dụ

Trong **TypeORM**, bạn có thể sử dụng cả **Trigger** và **Stored Procedure** bằng cách kết hợp các phương pháp sau:

---

### **1. Sử dụng Trigger trong TypeORM**

TypeORM không cung cấp API trực tiếp để tạo **trigger**, nhưng bạn có thể sử dụng **migration** hoặc chạy các câu lệnh SQL thủ công để tạo **trigger**. Sau khi trigger được thiết lập, nó sẽ hoạt động như bình thường trong cơ sở dữ liệu.

**Ví dụ: Tạo Trigger bằng Migration**  
Giả sử bạn muốn tạo một trigger để ghi log khi cập nhật dữ liệu trong bảng `employees`:

#### Migration File:

typescript

Sao chép mã

``import { MigrationInterface, QueryRunner } from "typeorm";  export class AddTriggerEmployeeLog1672500000000 implements MigrationInterface {   public async up(queryRunner: QueryRunner): Promise<void> {     await queryRunner.query(`       CREATE TRIGGER trg_update_employee_log       AFTER UPDATE ON employees       FOR EACH ROW       BEGIN         INSERT INTO audit_log (employeeId, old_data, new_data, updated_at)         VALUES (OLD.id, OLD.name, NEW.name, NOW());       END;     `);   }    public async down(queryRunner: QueryRunner): Promise<void> {     await queryRunner.query(`       DROP TRIGGER IF EXISTS trg_update_employee_log;     `);   } }``

#### Chạy Migration:

bash

Sao chép mã

`yarn typeorm migration:run`

---

### **2. Sử dụng Stored Procedure trong TypeORM**

TypeORM không có API trực tiếp để tạo **stored procedure**, nhưng bạn có thể gọi chúng thông qua phương thức `query` hoặc chạy migration để định nghĩa chúng.

#### Ví dụ: Tạo Stored Procedure bằng Migration

Giả sử bạn muốn tạo một stored procedure để lấy nhân viên theo danh sách ID.

#### Migration File:

typescript

Sao chép mã

``import { MigrationInterface, QueryRunner } from "typeorm";  export class CreateProcedureGetEmployees1672500000001 implements MigrationInterface {   public async up(queryRunner: QueryRunner): Promise<void> {     await queryRunner.query(`       CREATE PROCEDURE GetEmployeesByIds(IN employeeIds VARCHAR(255))       BEGIN           SET @query = CONCAT('SELECT * FROM employees WHERE id IN (', employeeIds, ')');           PREPARE stmt FROM @query;           EXECUTE stmt;           DEALLOCATE PREPARE stmt;       END;     `);   }    public async down(queryRunner: QueryRunner): Promise<void> {     await queryRunner.query(`       DROP PROCEDURE IF EXISTS GetEmployeesByIds;     `);   } }``

#### Gọi Stored Procedure trong TypeORM:

Sau khi procedure được tạo, bạn có thể gọi nó từ code TypeScript.

typescript

Sao chép mã

``import { getManager } from "typeorm";  async function getEmployeesByIds(ids: string) {   const entityManager = getManager();   const employees = await entityManager.query(`CALL GetEmployeesByIds(?)`, [ids]);   return employees; }  // Sử dụng: const employees = await getEmployeesByIds("1,2,3"); console.log(employees);``

---

### **3. Kết hợp Trigger và Stored Procedure**

Trong nhiều trường hợp, trigger có thể gọi stored procedure. Ví dụ, bạn có thể định nghĩa một trigger để tự động gọi stored procedure khi có sự kiện xảy ra.

**Ví dụ:** Trigger gọi Procedure:

1. Tạo Stored Procedure để ghi nhật ký:
    
    sql
    
    Sao chép mã
    
    `CREATE PROCEDURE LogEmployeeUpdate(IN employeeId INT, IN oldName VARCHAR(255), IN newName VARCHAR(255)) BEGIN     INSERT INTO audit_log (employeeId, old_data, new_data, updated_at)     VALUES (employeeId, oldName, newName, NOW()); END;`
    
2. Tạo Trigger để gọi Procedure:
    
    sql
    
    Sao chép mã
    
    `CREATE TRIGGER trg_update_employee_call_proc AFTER UPDATE ON employees FOR EACH ROW BEGIN     CALL LogEmployeeUpdate(OLD.id, OLD.name, NEW.name); END;`
    
3. Sử dụng Migration để triển khai trigger và procedure.
    

---

### **Khi nào sử dụng Trigger và Procedure qua TypeORM?**

- **Trigger:** Sử dụng khi cần tự động hóa các thao tác trên cơ sở dữ liệu mà không phụ thuộc vào logic phía ứng dụng.
- **Stored Procedure:** Sử dụng khi cần logic phức tạp, có thể tái sử dụng nhiều lần, hoặc để tối ưu hóa hiệu suất xử lý trực tiếp trên cơ sở dữ liệu.

Kết hợp cả hai giúp hệ thống của bạn trở nên linh hoạt và hiệu quả hơn, đặc biệt trong các ứng dụng xử lý dữ liệu lớn hoặc yêu cầu hiệu năng cao.