Công ty phỏng vấn Fullerton Health

## Các chủ đề được hỏi

Giới thiệu bảng thân, background ,thành tích.
Tại sao bạn lại nghỉ việc công ty cũ và chọn đi làm công ty mới.
Kể về các dự án trước đã làm
+ Dự án bạn tâm huyết nhất
+ Các dự án phụ thì sao (Mô tả và giới thiệu và giải thích dự án)
+ Bạn đã làm gì trong các dự án đó
Hỏi hang sơ qua về công ty, tại sao bạn lại có quan hệ và nhận được dự án ?

Database
+ MySQL
	+ Quá trình làm việc bạn có thiết kế database không ?
		+ Bạn đã thiết kế nó như thế nào ?
			+ Nêu lên tạo bảng
			+ Liên kế khoá chinh, khoá ngoại
			+ Đánh index
			+ Ràng buộc constraint
				+ Unique
			+ Chuẩn hoá **(Boyce-codd, hoặc 3NF)**
			+ Sử dụng trigger
				+ After insert
				+ Before insert
				+ Cho ví dụ ?
	+ **Transaction**
		+ [[Compare 4 type of transaction in SQL]]]
		+ Nêu khái niệm
		+ Kể các cấp độ của transaction (4 cấp độ kể đủ)
			+ Uncommit
			+ Commit
			+ Repetable read
			+ Serializable
		+ Default transaction trong MySQL
			+ **REPEATABLE READ**
	+ Typeorm
		+ Cách khai báo transaction typeorm
		+ Có hay viết raw query hay không ? => Làm thế nào để tối ưu câu lệnh sql query ?
		+ Dựa vào đâu ? Có những chiến lược nào để tối ưu câu lệnh SQL của mình 
		+ Làm sao để tối ưu một câu lệnh SQL mà em gặp
		+ Hỏi về query runner 
			+ Cách để dùng transaction trong query runner
	+ Khi nhìn vào một câu lệnh MySQL thì dựa vào đâu để tối ưu
	+ Index
		+ Khi nào đánh index.
		+ Cách đánh index như thế nào cho đúng
		+ Đánh index như vào bảng như thế nào để không ảnh hưởng đến các chức năng trước đó
		+ Có những loại index nào ?
	+ Trong database bạn có sử dụng các thủ tục của procedure hay trigger gì không ? Sử dụng nó như thế nào ?
	+ Bạn có biết cách sử dụng **replica set** không ?
		+ https://chatgpt.com/share/676bb0fe-9cc0-8013-b394-1158d2ccda80
	+ Bạn có bao giờ viết raw SQL trong code chưa ? Lệnh Join dài nhất
		+ Lệnh join của bạn đã được 10 bảng chưa ?
+ MongoDB
	+ So sánh giữa hàm find và aggregate trong MongoDB
+ So sánh giữa Relation Database và No SQL 
+ Nếu bạn là Lead của một dự án thì bạn dựa vào cơ sở nào để chọn loại CSDL

Backend
NodeJS
+ Thêm file không thông qua các service bên S3 ?, bucket ?
	+ Dùng multer ?
	+ Dùng cơ chế nào khác không ?
	+ Dùng như vậy có lưu qua memory không ?
		+ Làm sao để kiểm soát bộ nhớ của file, media mình upload lên
+ Cơ chế NodeJS (Eventloop)
+ Đơn luồng hay đa luồng
	+ NodeJS là đơn luồng tại sao ?
AWS ?
+ Bạn có hay vọc vạch hay sài AWS không ?
NestJS (Hỏi sâu): => **Cần đọc kỹ lại Docs. Đặt câu hỏi trên Docs này**
+ Dynamic module: **Chỉ khởi tạo một lần duy nhất (Không nên khởi tạo nhiều lần)**
	+ => Đây có thể là từ khoá
+ Message queue, rabbitMQ
+ Authentication (JWT)
	+ Tại sao lại dùng AccessToken
	+ Tại sao lại dùng Cookies để lưu trữ Token mà không phải AccessToken
	+ Khi nào nên dùng cả 2
+ Rate limit là gì ?
+ IOC Container là gì ?
	+ Có đề cập đến Singleton
+ Bạn có hay dùng queue trong NestJS ?
+ Đã từng làm qua về Microservice trong NestJS chưa ?
+ Đã áp dụng Redis và Cache qua dự án chưa ?
+ Bạn có biết về Helmet trong NestJS không ?
+ Bảo mật các thông tin truyền qua header như thế nào ?
+ Các cơ chế bảo mật mà bạn biết trong quá trình deploy dự án 
+ Bạn đã từng deploy dự án chưa ?
+ Bạn đã từng áp dụng Web socket chưa ? Áp dụng như thế nào ?
	+ Hỏi các câu hỏi sâu hơn về Socket.io
	+ https://chatgpt.com/share/676bb13c-90a4-8013-9bd5-a8ddf72d6d16
+ Làm thế nào để lưu lại tin nhắn khi tắt khỏi connection của socket
Cơ chế log
	+ Bạn sử lý và log lỗi như thế nào ?
	+ Exception nằm ở tầng nào ?
Devops:
+ Docker
	+ Ngoài sử dụng Docker để build các image cơ bản thì còn gì đặc biệt không ?
+ CI/CD (Github)
	+ Sử dụng CI/CD trên Github hay Gitlab
+ Bạn đã dùng qua về Nginx chưa ?
Programming:
+ Javascript
	+ Foreach và Map có xử lý được bất đồng bộ hay không ?
	+ Bạn hiểu về nào về hàm Reduce trong JS
	+ Foreach và Map cái nào nhanh hơn ? Tại sao ?
	+ Bạn sử lý bất đồng bộ trong ForEach và Map như thế nào ?
	+ Closure là gì trong Javascript ?
	+ Bạn đã từng custom một cái thư viện nào chưa ? Và custom nó thông qua closure
	+ Async Await khác gì so với Promise
+ Typescript
	+ Các kiểu dữ liệu thường dùng
		+ Partial
		+ Required
		+ Reaonly
		+ Omit
		+ Record
		+ Pick
	+ Các kiểu dữ liệu utility bạn thường sài
	+ Tại sao dùng interface mà không dùng type
	+ Bạn có hay dùng kiểu dữ liệu Generic không ?
	+ Tại sao dùng type được mà lại sử dụng interface ?
Mô hình Microservice ?
Có tìm hiểu hay không -> Hỏi sâu -> Xoáy sâu đến chịu!

Nghiệp vụ dự án
+ Giải thích dự án
+ Dự án tâm đắc
+ Các ứng dụng công nghệ cho dự án
+ Các câu hỏi giải quyết vấn đề trong trong dự án
	+ Làm về export excel (Vấn đề khi gặp của export là chậm. Cách bạn xử lý về nó như thế nào ?)
		+ => Có thể nghĩ ngay đến việc lưu dữ liệu đó lại theo tháng
		+ => Export thống kê nhân viên

Câu hỏi cho công ty ?
Văn hoá công ty
Mục tiêu công ty
Các ứng dụng mục tiêu sẽ triển khai trong thời gian tới
Team size công ty đang có
Công nghệ công ty đang áp dụng

--- 
## Cảm nhận

+ Anh phỏng vấn khá tử tế, tìm hiểu khá kỹ về ứng cử viên để phỏng vấn
+ Anh đặt câu hỏi khá nhiều, chủ yếu về Backend và ngôn ngữ lập trình đang cần tuyển. Khi trả lời một câu hỏi. Anh phỏng vấn sẽ cố gắng đào thật sâu vào độ hiểu biết của ứng viên.
	+ Bạn có đánh index hay không ? => Cách đánh index như thế nào cho đúng ? => Chiến lược đánh index của bạn là gì ?
+ Anh chia sẻ về mục tiêu và nhu cầu tuyển dụng của công ty
+ Cơ hội đặt câu hỏi cho ứng viên

---
## Liên quan

#interview #backend 