---
profileName: sangtrandev00
postId: 3558
postType: post
categories:
  - 39
---
Khi phỏng vấn cho vị trí **Node.js Junior Backend**, các câu hỏi về TypeScript thường liên quan đến các khái niệm cơ bản, cách sử dụng TypeScript trong phát triển ứng dụng backend, cũng như các đặc điểm liên quan đến cấu trúc mã và hiệu suất. Dưới đây là một số câu hỏi về TypeScript mà bạn có thể gặp trong buổi phỏng vấn:

### 1. **Giải thích sự khác biệt giữa `interface` và `type` trong TypeScript.**

- **Câu hỏi này kiểm tra**: Khả năng phân biệt giữa `interface` và `type`, và khi nào nên sử dụng cái nào.
- **Trả lời**:
    - `interface` được sử dụng chủ yếu để định nghĩa kiểu cho đối tượng, lớp (class), và các cấu trúc tương tự.
    - `type` có thể định nghĩa bất kỳ kiểu nào, bao gồm các kiểu đối tượng, mảng, hàm, v.v.
    - `interface` có thể mở rộng và bổ sung thuộc tính, trong khi `type` không thể.

### 2. **Bạn có thể sử dụng `any` trong TypeScript không? Khi nào nên tránh sử dụng `any`?**

- **Câu hỏi này kiểm tra**: Hiểu biết về việc sử dụng `any` và sự ảnh hưởng của nó đến mã nguồn.
- **Trả lời**:
    - `any` có thể được sử dụng khi bạn không biết chắc chắn kiểu dữ liệu sẽ là gì, nhưng nên hạn chế vì nó bỏ qua các tính năng kiểm tra kiểu của TypeScript.
    - Tránh sử dụng `any` vì nó làm mất đi tính an toàn của TypeScript, chỉ sử dụng khi thật sự cần thiết hoặc trong các tình huống chưa xác định kiểu.

### 3. **Giải thích `unknown` trong TypeScript và cách sử dụng nó.**

- **Câu hỏi này kiểm tra**: Sự hiểu biết về sự khác biệt giữa `unknown` và `any` trong TypeScript.
- **Trả lời**:
    - `unknown` là một kiểu an toàn hơn `any` vì bạn không thể thao tác trực tiếp với giá trị có kiểu `unknown` mà không thực hiện kiểm tra kiểu hoặc ép kiểu.
    - `unknown` yêu cầu bạn phải kiểm tra kiểu trước khi sử dụng, giúp tránh các lỗi không mong muốn.

### 4. **Giải thích về `strict mode` trong TypeScript.**

- **Câu hỏi này kiểm tra**: Kiến thức về các chế độ kiểm tra nghiêm ngặt trong TypeScript.
- **Trả lời**:
    - `strict mode` là một tập hợp các cài đặt TypeScript giúp cải thiện tính an toàn của mã nguồn bằng cách bật các tính năng như kiểm tra `null`, `undefined`, kiểm tra kiểu nghiêm ngặt, v.v.
    - Khi bật `strict`, TypeScript yêu cầu mã của bạn phải tuân thủ chặt chẽ các quy định về kiểu dữ liệu.

### 5. **Giải thích cách sử dụng `async` và `await` trong TypeScript.**

- **Câu hỏi này kiểm tra**: Sự hiểu biết về việc làm việc với các hàm bất đồng bộ trong TypeScript.
- **Trả lời**:
    - `async` được sử dụng để khai báo một hàm bất đồng bộ, và `await` được sử dụng để chờ đợi một Promise được giải quyết.
    - Cả `async` và `await` giúp viết mã bất đồng bộ trông giống như mã đồng bộ, dễ đọc và bảo trì hơn.

### 6. **Các kiểu dữ liệu cơ bản trong TypeScript là gì?**

- **Câu hỏi này kiểm tra**: Kiến thức về các kiểu dữ liệu cơ bản trong TypeScript.
- **Trả lời**:
    - Các kiểu dữ liệu cơ bản trong TypeScript bao gồm: `number`, `string`, `boolean`, `void`, `null`, `undefined`, `any`, `unknown`, `never`, và `symbol`.

### 7. **Giải thích sự khác biệt giữa `null` và `undefined` trong TypeScript.**

- **Câu hỏi này kiểm tra**: Hiểu biết về các giá trị đặc biệt trong TypeScript.
- **Trả lời**:
    - `null` là một giá trị đặc biệt đại diện cho "không có giá trị" và được gán thủ công.
    - `undefined` là một giá trị mặc định của biến chưa được khởi tạo hoặc chưa được gán giá trị.

### 8. **Làm thế nào để xử lý lỗi trong TypeScript?**

- **Câu hỏi này kiểm tra**: Khả năng xử lý lỗi và sử dụng các cơ chế xử lý lỗi trong TypeScript.
- **Trả lời**:
    - TypeScript sử dụng cơ chế `try`, `catch` để bắt và xử lý lỗi, tương tự như trong JavaScript. Bạn cũng có thể sử dụng các kiểu dữ liệu như `never` để mô tả các hàm không bao giờ trả về giá trị (chẳng hạn như ném lỗi).

### 9. **Giải thích về `generics` trong TypeScript và khi nào sử dụng chúng.**

- **Câu hỏi này kiểm tra**: Kiến thức về generic types và khả năng sử dụng chúng để tạo mã linh hoạt và tái sử dụng.
- **Trả lời**:
    - `Generics` cho phép bạn định nghĩa các hàm, lớp, và giao diện mà không cần chỉ định kiểu cụ thể cho đến khi sử dụng chúng.
    - Bạn sử dụng `generics` khi bạn muốn viết mã có thể làm việc với nhiều kiểu khác nhau mà không cần phải lặp lại mã.

### 10. **Bạn đã bao giờ làm việc với `decorators` trong TypeScript chưa? Giải thích cách sử dụng và lợi ích của chúng.**

- **Câu hỏi này kiểm tra**: Kiến thức về các `decorators`, một tính năng mạnh mẽ trong TypeScript.
- **Trả lời**:
    - `Decorators` là một tính năng trong TypeScript cho phép bạn thêm logic vào các lớp, phương thức, thuộc tính hoặc tham số.
    - Chúng hữu ích khi bạn muốn thêm các hành vi mới vào các đối tượng mà không thay đổi mã gốc.

### 11. **Sự khác biệt giữa `const` và `let` trong TypeScript là gì?**

- **Câu hỏi này kiểm tra**: Kiến thức về cách khai báo biến trong TypeScript.
- **Trả lời**:
    - `const` được sử dụng để khai báo biến có giá trị không thay đổi sau khi gán.
    - `let` được sử dụng khi bạn cần thay đổi giá trị của biến sau khi khai báo.

### 12. **Giải thích về `module` và `namespace` trong TypeScript.**

- **Câu hỏi này kiểm tra**: Hiểu biết về cách tổ chức mã và sử dụng `module` hoặc `namespace`.
- **Trả lời**:
    - `module` trong TypeScript giúp bạn tổ chức mã vào các file và có thể sử dụng `import/export` để chia sẻ mã giữa các file.
    - `namespace` là một cách cũ để nhóm các hàm và biến lại với nhau, nhưng `module` hiện nay được ưa chuộng hơn.

Các câu hỏi này giúp nhà tuyển dụng kiểm tra mức độ thành thạo của bạn với TypeScript và khả năng áp dụng các khái niệm của nó trong phát triển ứng dụng backend với Node.js.


---
## Liên quan

https://chatgpt.com/share/676baf2b-7cfc-8013-a058-574e68206a6c

#interview #typescript