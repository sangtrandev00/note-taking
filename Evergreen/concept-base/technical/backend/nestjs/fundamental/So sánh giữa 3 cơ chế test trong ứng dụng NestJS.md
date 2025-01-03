
## **1. Unit Test**

- **Mục tiêu**: Kiểm tra logic của từng thành phần riêng lẻ (class, function, module).
- **Phạm vi**: Chỉ kiểm tra một đơn vị code cụ thể và mock tất cả các dependencies.
- **Đặc điểm**:
    - Tập trung vào logic nội bộ của thành phần.
    - Nhanh, dễ viết, và không phụ thuộc vào môi trường bên ngoài.
    - Sử dụng **mock** để giả lập dependencies.
- **Ví dụ**: Kiểm tra `UsersService` hoạt động đúng khi sử dụng repository đã được mock.

**Code ví dụ:**

```typescript

describe('UsersService', () => {
  let service: UsersService;
  let mockRepository: Partial<UsersRepository>;

  beforeEach(() => {
    mockRepository = {
      findById: jest.fn((id) => `Mocked User ${id}`),
    };

    service = new UsersService(mockRepository as UsersRepository);
  });

  it('should return user by ID', () => {
    const result = service.getUserById(1);
    expect(result).toBe('Mocked User 1');
    expect(mockRepository.findById).toHaveBeenCalledWith(1);
  });
});


```

---

## **2. Integration Test**

- **Mục tiêu**: Kiểm tra sự tương tác giữa các thành phần trong module (controller, service, repository).
- **Phạm vi**: Kiểm tra nhiều thành phần cùng hoạt động, nhưng thường không bao gồm kết nối cơ sở dữ liệu thực.
- **Đặc điểm**:
    - Không mock tất cả dependencies, mà sử dụng các phiên bản thực.
    - Đảm bảo các thành phần tích hợp đúng cách (ví dụ: `UsersService` gọi đúng repository và controller trả về đúng format).
- **Ví dụ**: Kiểm tra `UsersController` trả về đúng dữ liệu khi gọi `UsersService`.

**Code ví dụ:**


```typescript

describe('UsersController', () => {
  let controller: UsersController;
  let service: UsersService;

  beforeEach(async () => {
    const module = await Test.createTestingModule({
      controllers: [UsersController],
      providers: [UsersService, UsersRepository],
    }).compile();

    controller = module.get<UsersController>(UsersController);
    service = module.get<UsersService>(UsersService);
  });

  it('should return user by ID', async () => {
    jest.spyOn(service, 'getUserById').mockResolvedValue('User 1');
    const result = await controller.getUserById(1);
    expect(result).toBe('User 1');
  });
});

```

---

## **3. End-to-End (e2e) Test**

- **Mục tiêu**: Kiểm tra toàn bộ flow của ứng dụng từ client đến backend, bao gồm cả cơ sở dữ liệu thực.
- **Phạm vi**: Kiểm tra hệ thống như một ứng dụng hoàn chỉnh.
- **Đặc điểm**:
    - Không mock bất kỳ thành phần nào.
    - Yêu cầu môi trường thực tế, ví dụ: server chạy và kết nối cơ sở dữ liệu.
    - Chậm hơn nhưng đảm bảo rằng toàn bộ ứng dụng hoạt động như mong đợi.
- **Ví dụ**: Kiểm tra API `/users/:id` trả về đúng dữ liệu từ database.

**Code ví dụ:**

```typescript

import * as request from 'supertest';

describe('Users (e2e)', () => {
  let app: INestApplication;

  beforeAll(async () => {
    const module = await Test.createTestingModule({
      imports: [UsersModule],
    }).compile();

    app = module.createNestApplication();
    await app.init();
  });

  it('GET /users/:id', async () => {
    const response = await request(app.getHttpServer())
      .get('/users/1')
      .expect(200);

    expect(response.body).toEqual({ id: 1, name: 'User 1' });
  });

  afterAll(async () => {
    await app.close();
  });
});

```


---

### **So sánh**

|**Tiêu chí**|**Unit Test**|**Integration Test**|**End-to-End Test**|
|---|---|---|---|
|**Mục tiêu**|Kiểm tra logic của từng thành phần|Kiểm tra sự tương tác giữa các thành phần|Kiểm tra toàn bộ ứng dụng|
|**Phạm vi**|Rất nhỏ (một class hoặc function)|Module hoặc nhóm component|Hệ thống hoàn chỉnh|
|**Dependencies**|Được mock|Một số thực, một số mock|Sử dụng thực tế|
|**Tốc độ**|Nhanh|Trung bình|Chậm|
|**Độ phức tạp**|Thấp|Trung bình|Cao|
|**Khi nào sử dụng?**|Để kiểm tra logic cụ thể và nhanh chóng|Khi muốn kiểm tra tích hợp giữa các thành phần|Khi kiểm tra toàn bộ hệ thống|

---

## **Khi nào nên sử dụng loại test nào?**

1. **Unit Test**:
    
    - Kiểm tra logic cụ thể (ví dụ: tính toán, xử lý dữ liệu).
    - Dùng thường xuyên vì chúng nhanh và dễ viết.
2. **Integration Test**:
    
    - Đảm bảo rằng các thành phần hoạt động đúng khi tích hợp với nhau.
    - Thường viết cho controller để kiểm tra toàn bộ logic của module.
3. **End-to-End Test**:
    
    - Kiểm tra hệ thống thực tế trước khi phát hành.
    - Dùng ít hơn vì chậm và cần môi trường phức tạp.

---

## **Tóm lại**

- **Unit Tests**: Kiểm tra nhanh, tập trung vào logic nhỏ.
- **Integration Tests**: Đảm bảo các module hoạt động đúng với nhau.
- **e2e Tests**: Đảm bảo hệ thống hoàn chỉnh không có lỗi lớn.

Sự kết hợp hợp lý cả 3 loại test sẽ đảm bảo chất lượng cao nhất cho ứng dụng của bạn.


---
## Liên quan
[[NestJS Testing là gì ? 1 cách để đảm bảo ứng chạy hiệu quả]]

https://chatgpt.com/share/67775eed-5a40-8013-b24c-73a7c4bc13be

#nestjs #testing #backend 