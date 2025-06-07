---
profileName: sangtrandev00
postId: 3447
postType: post
categories:
  - 39
---
**Injection scopes** trong NestJS là cách định nghĩa vòng đời (lifecycle) của các provider trong ứng dụng. Khi một provider được sử dụng trong ứng dụng, vòng đời của nó sẽ ảnh hưởng đến cách NestJS tạo và quản lý instance của provider đó.

NestJS hỗ trợ ba loại injection scopes chính:

---

## **1. Default Scope (Singleton Scope)**

**Mô tả**:

- Đây là scope mặc định.
- Một instance duy nhất của provider được tạo và được dùng chung trong toàn bộ ứng dụng.

**Ứng dụng thực tế**:

- Các service như `DatabaseService`, nơi một connection duy nhất được duy trì trong suốt vòng đời của ứng dụng.

**Ví dụ**:

```typescript

@Injectable()
export class DatabaseService {
  private connection: any;

  constructor() {
    this.connection = this.createConnection();
  }

  private createConnection() {
    // Logic tạo kết nối database
    return "Database connection";
  }

  getConnection() {
    return this.connection;
  }
}

```

```typescript

// Controller
@Controller('users')
export class UserController {
  constructor(private readonly databaseService: DatabaseService) {}

  @Get()
  getUsers() {
    return this.databaseService.getConnection(); // Cùng một instance
  }
}

```

---

## **2. Request Scope**

**Mô tả**:

- Mỗi yêu cầu (HTTP request) tạo ra một instance mới của provider.
- Phù hợp với các tình huống mà dữ liệu hoặc trạng thái cần được gắn kết với từng request cụ thể.

**Ứng dụng thực tế**:

- Các service xử lý dữ liệu cụ thể của người dùng trong một request, như `AuthService` lưu trạng thái phiên làm việc.

**Ví dụ**:

```typescript

@Injectable({ scope: Scope.REQUEST })
export class LoggerService {
  constructor(@Inject(REQUEST) private readonly request: Request) {}

  log() {
    console.log(`Request ID: ${this.request.id}`);
  }
}

```

```typescript

// Controller
@Controller('logs')
export class LogController {
  constructor(private readonly loggerService: LoggerService) {}

  @Get()
  logRequest() {
    this.loggerService.log(); // Instance mới cho mỗi request
  }
}


```

---

## **3. Transient Scope**

**Mô tả**:

- Một instance mới của provider được tạo mỗi lần provider được inject.
- Phù hợp với các dịch vụ có trạng thái ngắn hạn hoặc được dùng tạm thời.

**Ứng dụng thực tế**:

- Các dịch vụ xử lý logic không cần dùng lại, như `RandomGeneratorService` tạo các giá trị ngẫu nhiên.

**Ví dụ**:

```typescript

@Injectable({ scope: Scope.TRANSIENT })
export class RandomGeneratorService {
  generate() {
    return Math.random();
  }
}

```

```typescript

// Controller
@Controller('random')
export class RandomController {
  constructor(private readonly randomGeneratorService: RandomGeneratorService) {}

  @Get()
  getRandom() {
    return this.randomGeneratorService.generate(); // Instance mới mỗi lần gọi
  }
}

```

---

## **Liên quan đến các khái niệm khác**

1. **Dependency Injection (DI)**:
    
    - Injection scopes là một phần của DI, giúp NestJS quản lý cách các dependency được khởi tạo và chia sẻ.
2. **Module**:
    
    - Các provider thường được khai báo trong module, và scope của chúng sẽ ảnh hưởng đến cách các module khác sử dụng chúng.
3. **Lifecycle Hooks**:
    
    - Scope ảnh hưởng đến lifecycle hooks như `OnModuleInit`, `OnApplicationBootstrap`, v.v. Ví dụ, một `Request-scoped service` sẽ khởi chạy các hooks mỗi khi có request mới.
4. **Performance**:
    
    - `Singleton` tiết kiệm tài nguyên hơn vì chỉ khởi tạo một lần. `Request` và `Transient` có thể tốn tài nguyên hơn, vì chúng tạo ra nhiều instance hơn.

---

## **So sánh các scope**

|Scope|Instance được tạo khi nào?|Dùng chung cho toàn ứng dụng?|
|---|---|---|
|Singleton|Khi ứng dụng khởi chạy|Có|
|Request|Khi có một HTTP request mới|Không|
|Transient|Mỗi lần provider được inject|Không|

---

## **Khi nào sử dụng từng loại scope?**

1. **Singleton**:
    
    - Hầu hết các dịch vụ không cần trạng thái (`stateless services`).
    - Các dịch vụ kết nối cơ sở dữ liệu, logging toàn cục, hoặc xử lý không phụ thuộc vào request cụ thể.
2. **Request**:
    
    - Các dịch vụ cần trạng thái riêng biệt cho mỗi request.
    - Dữ liệu liên quan đến người dùng hoặc các middleware như `AuthGuard`.
3. **Transient**:
    
    - Các dịch vụ chỉ cần tồn tại trong thời gian ngắn.
    - Các dịch vụ xử lý logic phức tạp, không phụ thuộc vào bất kỳ request nào.



---
## Liên quan
https://chatgpt.com/share/6770b188-e1a4-8013-ab92-96d80d4fdd78
https://docs.nestjs.com/fundamentals/injection-scopes
Tham khảo cách implement cụ thể trong github repository của mình nhé
https://github.com/sangtrandev00/injection-scopes-nestjs

#nestjs #backend #nodejs