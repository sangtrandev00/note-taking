**Testing trong NestJS** là một phần quan trọng để đảm bảo chất lượng ứng dụng. NestJS cung cấp các công cụ tích hợp để viết và chạy unit tests, integration tests một cách dễ dàng, nhờ sử dụng các phương pháp và công cụ như Jest và các module testing của chính NestJS.

Dưới đây là giải thích rõ ràng về các khái niệm và các ví dụ thực tế:

---

## **1. Các khái niệm quan trọng trong Testing của NestJS**

1. **Unit Testing**:
    
    - Kiểm tra các thành phần nhỏ nhất trong ứng dụng (service, controller, pipe, guard...).
    - Mục tiêu là kiểm tra logic độc lập của từng thành phần.
2. **Integration Testing**:
    
    - Kiểm tra cách các thành phần làm việc cùng nhau.
    - Bao gồm việc chạy ứng dụng và thực hiện các yêu cầu HTTP đến endpoint.
3. **Testing Utilities của NestJS**:
    
    - `Test.createTestingModule`: Dùng để tạo một module thử nghiệm với cấu hình riêng.
    - `Test.createModuleBuilder`: Một công cụ xây dựng module tiện lợi hơn.
4. **Mocking**:
    
    - Quá trình thay thế các phụ thuộc (dependencies) thực bằng các đối tượng giả để kiểm tra riêng lẻ thành phần.
5. **E2E Testing (End-to-End)**:
    
    - Kiểm tra toàn bộ ứng dụng như một thể thống nhất, giống như cách người dùng tương tác với nó.
6. **Dependency Injection trong Testing**:
    
    - NestJS tận dụng DI để dễ dàng inject các mock dependencies khi testing.
7. **Jest**:
    
    - Framework testing mặc định được sử dụng với NestJS.

---

## **2. Các bước cơ bản để viết Unit Tests**

#### Ví dụ: Test một service trong NestJS

Giả sử bạn có một service tên là `UsersService`:


```typescript

@Injectable()
export class UsersService {
  getUserById(id: number): string {
    return `User with ID ${id}`;
  }
}

```

**Tạo file test:**

```typescript

import { Test, TestingModule } from '@nestjs/testing';
import { UsersService } from './users.service';

describe('UsersService', () => {
  let service: UsersService;

  beforeEach(async () => {
    const module: TestingModule = await Test.createTestingModule({
      providers: [UsersService],
    }).compile();

    service = module.get<UsersService>(UsersService);
  });

  it('should be defined', () => {
    expect(service).toBeDefined();
  });

  it('should return user by ID', () => {
    const userId = 1;
    const result = service.getUserById(userId);
    expect(result).toBe('User with ID 1');
  });
});


```

---

### **Mocking Dependencies**

Giả sử service của bạn phụ thuộc vào một repository:

```typescript

@Injectable()
export class UsersService {
  constructor(private readonly usersRepository: UsersRepository) {}

  getUserById(id: number): string {
    return this.usersRepository.findUserById(id);
  }
}

```

Bạn cần mock repository trong test:

```typescript

describe('UsersService with Mock', () => {
  let service: UsersService;
  const mockRepository = {
    findUserById: jest.fn((id) => `Mocked User with ID ${id}`),
  };

  beforeEach(async () => {
    const module: TestingModule = await Test.createTestingModule({
      providers: [
        UsersService,
        { provide: UsersRepository, useValue: mockRepository },
      ],
    }).compile();

    service = module.get<UsersService>(UsersService);
  });

  it('should return mocked user by ID', () => {
    const userId = 2;
    const result = service.getUserById(userId);
    expect(result).toBe('Mocked User with ID 2');
  });
});


```

---

### **Testing Controller**

Giả sử bạn có một controller sau:

```typescript

@Controller('users')
export class UsersController {
  constructor(private readonly usersService: UsersService) {}

  @Get(':id')
  getUserById(@Param('id') id: number): string {
    return this.usersService.getUserById(id);
  }
}

```

**Tạo test cho controller:**

```typescript

describe('UsersController', () => {
  let controller: UsersController;
  let service: UsersService;

  beforeEach(async () => {
    const module: TestingModule = await Test.createTestingModule({
      controllers: [UsersController],
      providers: [
        {
          provide: UsersService,
          useValue: {
            getUserById: jest.fn((id) => `Mocked User with ID ${id}`),
          },
        },
      ],
    }).compile();

    controller = module.get<UsersController>(UsersController);
    service = module.get<UsersService>(UsersService);
  });

  it('should return user by ID', () => {
    const userId = 3;
    const result = controller.getUserById(userId);
    expect(result).toBe('Mocked User with ID 3');
  });
});


```
---

### **5. E2E Testing**

E2E test sẽ khởi chạy toàn bộ ứng dụng và thực hiện các yêu cầu HTTP.

```typescript

import { Test, TestingModule } from '@nestjs/testing';
import { INestApplication } from '@nestjs/common';
import * as request from 'supertest';
import { AppModule } from '../src/app.module';

describe('AppController (e2e)', () => {
  let app: INestApplication;

  beforeAll(async () => {
    const moduleFixture: TestingModule = await Test.createTestingModule({
      imports: [AppModule],
    }).compile();

    app = moduleFixture.createNestApplication();
    await app.init();
  });

  it('/users/1 (GET)', () => {
    return request(app.getHttpServer())
      .get('/users/1')
      .expect(200)
      .expect('User with ID 1');
  });

  afterAll(async () => {
    await app.close();
  });
});

```

---

## **3. Lời khuyên khi implement vào dự án**

- Bắt đầu với **unit tests** cho các service cơ bản.
- Sử dụng **mock dependencies** để tách biệt các lớp trong khi kiểm tra.
- Khi đã ổn định các unit tests, mở rộng sang **integration tests** và cuối cùng là **E2E tests**.
- Tích hợp các bài test vào CI/CD pipeline để đảm bảo chất lượng mã nguồn liên tục.

Bạn có thể bắt đầu áp dụng các ví dụ trên để test từng module trong dự án NestJS của mình! Nếu cần thêm trợ giúp, hãy chia sẻ cụ thể vấn đề trong source code của bạn. 😊


---
## Liên quan
https://chatgpt.com/share/67775eed-5a40-8013-b24c-73a7c4bc13be
Theo dõi các đoạn code mình implement trong source repository này nhé!
https://github.com/sangtrandev00/testing-e2e-unitest-in-nestjs

#nestjs #backend #testing 