---
profileName: sangtrandev00
postId: 3391
postType: post
categories:
  - 39
---

Có những bạn khi làm về cơ sở dữ liệu ví như SQL đã từng làm việc với khái niệm Transaction, tuy nhiên việc thể hiện ra bằng lời vẫn chưa được chuẩn chỉ. Vậy thì hôm nay mình sẽ trình bày lại khái niệm đó một cách chuẩn bị hơn 

Khi trả lời phỏng vấn về khái niệm **Transaction** trong cơ sở dữ liệu SQL, bạn nên trình bày một cách rõ ràng, mạch lạc và có thể minh họa bằng ví dụ thực tế. Dưới đây là nội dung chi tiết bạn có thể sử dụng:

---

### **1. Transaction là gì?**

- **Transaction** là một đơn vị công việc logic trong cơ sở dữ liệu, bao gồm một hoặc nhiều câu lệnh SQL được thực thi như một thực thể duy nhất.
- Mục tiêu chính của transaction là đảm bảo tính toàn vẹn của dữ liệu ngay cả khi xảy ra lỗi hệ thống, kết nối bị gián đoạn hoặc các sự cố khác.

---

### **2. Tính chất ACID của Transaction**

Một transaction cần tuân thủ các thuộc tính ACID để đảm bảo tính nhất quán và tin cậy của dữ liệu:

- **Atomicity (Tính nguyên tử):** Một transaction phải được thực hiện hoàn toàn hoặc không được thực hiện chút nào. Nếu một phần nào đó thất bại, toàn bộ transaction sẽ bị hủy bỏ.
- **Consistency (Tính nhất quán):** Transaction phải đảm bảo dữ liệu trong cơ sở dữ liệu luôn hợp lệ trước và sau khi thực hiện.
- **Isolation (Tính độc lập):** Các transaction đang chạy đồng thời không được ảnh hưởng lẫn nhau. Kết quả của một transaction chưa hoàn tất sẽ không hiển thị với các transaction khác.
- **Durability (Tính bền vững):** Sau khi một transaction được commit, dữ liệu sẽ được lưu trữ vĩnh viễn ngay cả khi hệ thống gặp sự cố.

---

### **3. Quy trình của một Transaction**

- **BEGIN TRANSACTION:** Bắt đầu transaction.
- **SQL statements:** Thực hiện các câu lệnh SQL.
- **COMMIT:** Xác nhận và lưu thay đổi vào cơ sở dữ liệu.
- **ROLLBACK:** Hủy bỏ transaction, hoàn tác các thay đổi nếu xảy ra lỗi.

---

### **4. Ví dụ minh họa**

**Tình huống thực tế:** Chuyển tiền từ tài khoản A sang tài khoản B.

sql

Sao chép mã

`BEGIN TRANSACTION;  UPDATE accounts SET balance = balance - 1000 WHERE account_id = 'A'; UPDATE accounts SET balance = balance + 1000 WHERE account_id = 'B';  IF @@ERROR > 0     ROLLBACK; ELSE     COMMIT;`

- Nếu một trong hai câu lệnh `UPDATE` thất bại, transaction sẽ **ROLLBACK** để đảm bảo không có tiền bị "mất".
- Nếu cả hai thành công, transaction sẽ **COMMIT** để xác nhận thay đổi.

---

### **5. Tại sao Transaction quan trọng?**

- Đảm bảo **dữ liệu chính xác** trong các hệ thống quan trọng như ngân hàng, đặt vé máy bay, thương mại điện tử.
- Giảm thiểu rủi ro gây lỗi dữ liệu khi có sự cố xảy ra.
- Cải thiện tính toàn vẹn dữ liệu khi xử lý các thao tác phức tạp.

---
## Liên quan

https://chatgpt.com/share/6762de3c-3634-8013-9a0f-ed9a24ffc2a5


#sql #database #transaction