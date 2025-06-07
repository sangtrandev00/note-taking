---
profileName: sangtrandev00
postId: 3497
postType: post
categories:
  - 39
---
## Lifecycle Events trong NestJS là gì ?

Lifecycle Events trong NestJS là các hook (móc vòng đời) mà framework cung cấp để bạn có thể thực thi logic vào những thời điểm cụ thể trong vòng đời của một module hoặc service. Những event này giúp quản lý và điều khiển quá trình khởi tạo, xử lý, và hủy của các thành phần trong ứng dụng.

Các lifecycle event chính trong NestJS bao gồm:
![images/Pasted image 20250102163128.png](https://trannhatsang.com/wp-content/uploads/2025/01/Pasted-image-20250102163128.png)
1. **`onModuleInit`**:
    
    - Được gọi khi module chứa service được khởi tạo.
    - Bạn có thể sử dụng phương thức này để khởi tạo dữ liệu hoặc thực hiện các công việc cần thiết trước khi module sẵn sàng phục vụ.
2. **`onApplicationBootstrap`**:
    
    - Được gọi sau khi toàn bộ ứng dụng đã khởi tạo (bootstrap xong).
    - Phù hợp cho việc thực hiện các tác vụ phụ thuộc vào toàn bộ ứng dụng.
3. **`beforeApplicationShutdown`**:
    
    - Được gọi trước khi ứng dụng tắt.
    - Sử dụng để giải phóng tài nguyên, đóng kết nối, hoặc thực hiện công việc dọn dẹp.
4. **`onApplicationShutdown`**:
    
    - Được gọi khi ứng dụng bị tắt hoặc khi một signal như `SIGINT` được gửi.
    - Dùng để dọn dẹp sâu hơn, ví dụ tắt các kết nối DB.
5. **`onModuleDestroy`**:
    
    - Được gọi khi một module bị hủy.
    - Hiếm khi cần thiết, nhưng hữu ích nếu bạn có tài nguyên cục bộ ở module cần giải phóng.

---

## Ví dụ thực tế:

#### 1. **`onModuleInit`**:

**Tình huống**: Khởi tạo kết nối đến Redis khi module được khởi tạo.

```typescript

import { Injectable, OnModuleInit } from '@nestjs/common';
import { RedisClient } from 'redis';

@Injectable()
export class CacheService implements OnModuleInit {
    private client: RedisClient;

    onModuleInit() {
        this.client = new RedisClient({ host: 'localhost', port: 6379 });
        console.log('Redis client initialized');
    }
}


```
#### 2. **`onApplicationBootstrap`**:

**Tình huống**: Tải cấu hình toàn bộ ứng dụng sau khi tất cả các module đã sẵn sàng.

```typescript

import { Injectable, OnApplicationBootstrap } from '@nestjs/common';

@Injectable()
export class AppService implements OnApplicationBootstrap {
    onApplicationBootstrap() {
        console.log('Application bootstrap complete.');
        // Ví dụ: gọi API bên ngoài để khởi tạo dữ liệu.
    }
}

```

#### 3. **`beforeApplicationShutdown`**:

**Tình huống**: Đóng kết nối đến cơ sở dữ liệu trước khi ứng dụng tắt.

```typescript

import { Injectable, OnApplicationShutdown } from '@nestjs/common';
import { Connection } from 'typeorm';

@Injectable()
export class DatabaseService implements OnApplicationShutdown {
    constructor(private readonly connection: Connection) {}

    async onApplicationShutdown() {
        console.log('Closing database connection...');
        await this.connection.close();
    }
}

```

#### 4. **`onApplicationShutdown`**:

**Tình huống**: Hủy các tác vụ hàng đợi trước khi ứng dụng tắt.

```typescript

import { Injectable, OnApplicationShutdown } from '@nestjs/common';
import { Queue } from 'bull';

@Injectable()
export class TaskService implements OnApplicationShutdown {
    constructor(private readonly taskQueue: Queue) {}

    async onApplicationShutdown() {
        console.log('Stopping task queue...');
        await this.taskQueue.close();
    }
}

```


---

## Khi nào sử dụng lifecycle events?

- **`onModuleInit`**: Khi bạn cần chuẩn bị tài nguyên cục bộ cho một module (kết nối Redis, tải dữ liệu khởi tạo, v.v.).
- **`onApplicationBootstrap`**: Khi công việc cần thực hiện sau khi toàn bộ ứng dụng đã khởi tạo (kết nối API bên ngoài, log trạng thái toàn cục, v.v.).
- **`beforeApplicationShutdown`**: Khi cần dọn dẹp tài nguyên quan trọng trước khi ứng dụng dừng, ví dụ đóng kết nối cơ sở dữ liệu.
- **`onApplicationShutdown`**: Dành cho các hành động dọn dẹp cuối cùng khi ứng dụng bị tắt.

## Chuyện gì sẽ xảy ra nếu chúng ta không sử dụng lifecycle events cho ứng dụng NestJS của mình

### 1. **Tài nguyên không được khởi tạo đúng cách**

- **Hậu quả**: Các tài nguyên quan trọng như cơ sở dữ liệu, Redis, hoặc các service bên ngoài (API, queue) không được khởi tạo trước khi sử dụng, dẫn đến lỗi runtime.
- **Ví dụ**:
    - Nếu không dùng `onModuleInit` để khởi tạo kết nối Redis, khi ứng dụng cần gửi hoặc nhận dữ liệu, sẽ xảy ra lỗi vì kết nối chưa tồn tại.

---

### 2. **Công việc phụ thuộc toàn cục không được hoàn tất**

- **Hậu quả**: Những tác vụ phụ thuộc vào toàn bộ ứng dụng (như tải cấu hình, khởi tạo các thành phần phức tạp) có thể không chạy đúng thứ tự hoặc không thực hiện.
- **Ví dụ**:
    - Không dùng `onApplicationBootstrap` để tải cấu hình từ API bên ngoài, dẫn đến ứng dụng hoạt động với cấu hình sai hoặc thiếu.

---

### 3. **Rò rỉ tài nguyên**

- **Hậu quả**: Các tài nguyên như kết nối cơ sở dữ liệu, file, hoặc các hàng đợi không được giải phóng đúng cách, dẫn đến **rò rỉ tài nguyên**.
- **Ví dụ**:
    - Không dùng `onApplicationShutdown` hoặc `beforeApplicationShutdown` để đóng kết nối cơ sở dữ liệu, các kết nối vẫn mở và tiêu tốn tài nguyên hệ thống.

---

### 4. **Lỗi không dự đoán được khi ứng dụng tắt**

- **Hậu quả**: Khi ứng dụng bị tắt đột ngột (ví dụ khi nhận tín hiệu `SIGINT` hoặc `SIGTERM`), các tác vụ quan trọng như ghi log, đồng bộ dữ liệu hoặc hủy các tiến trình sẽ không được thực hiện.
- **Ví dụ**:
    - Không dùng `onApplicationShutdown` để lưu trạng thái cuối cùng vào cơ sở dữ liệu, dẫn đến mất dữ liệu quan trọng.

---

### 5. **Ứng dụng không dễ bảo trì**

- **Hậu quả**: Nếu bạn không sử dụng lifecycle events, việc thêm hoặc thay đổi logic liên quan đến khởi tạo hoặc hủy tài nguyên sẽ phức tạp hơn.
- **Ví dụ**:
    - Mọi logic khởi tạo và hủy tài nguyên có thể bị phân tán trong ứng dụng, khiến code khó đọc và khó debug.

---

### 6. **Phụ thuộc vào cách làm thủ công**

- **Hậu quả**: Nếu không dùng lifecycle events, bạn phải tự gọi các hàm khởi tạo và hủy tài nguyên theo cách thủ công, điều này dễ gây lỗi và khó kiểm soát.
- **Ví dụ**:
    - Bạn cần nhớ gọi hàm `connectToDatabase()` khi module khởi tạo và `disconnectDatabase()` khi ứng dụng dừng. Nếu quên, hệ thống sẽ gặp lỗi hoặc tài nguyên bị rò rỉ.

## Lý do **nên sử dụng lifecycle events**

Lifecycle events không chỉ giúp **tự động hóa** mà còn làm ứng dụng:

1. **Ổn định hơn**: Tài nguyên được khởi tạo và giải phóng đúng thời điểm.
2. **Dễ bảo trì**: Logic quản lý tài nguyên được tách biệt và rõ ràng.
3. **Ít lỗi hơn**: NestJS đảm bảo các event được gọi chính xác, tránh lỗi do người lập trình quên.

Tóm lại, không sử dụng các lifecycle events có thể dẫn đến một ứng dụng không ổn định, khó bảo trì và dễ mắc lỗi, đặc biệt khi ứng dụng phát triển lớn hơn.


## 7 Ví dụ thực tế 
### 1. **`onModuleInit` - Khởi tạo bộ lập lịch công việc**

**Tình huống**: Tự động khởi tạo bộ lập lịch (scheduler) cho các công việc định kỳ khi module được khởi tạo.

```typescript

import { Injectable, OnModuleInit } from '@nestjs/common';
import { CronJob } from 'cron';

@Injectable()
export class SchedulerService implements OnModuleInit {
  private job: CronJob;

  onModuleInit() {
    this.job = new CronJob('0 * * * *', () => {
      console.log('Running scheduled job every hour');
    });
    this.job.start();
    console.log('Scheduler initialized and job started.');
  }
}

```

---

### 2. **`onApplicationBootstrap` - Tải dữ liệu từ API bên ngoài**

**Tình huống**: Lấy dữ liệu từ API để khởi tạo một cache hoặc seed dữ liệu cần thiết.

```typescript

import { Injectable, OnApplicationBootstrap } from '@nestjs/common';
import axios from 'axios';

@Injectable()
export class DataService implements OnApplicationBootstrap {
  private cache = {};

  async onApplicationBootstrap() {
    console.log('Fetching initial data...');
    const response = await axios.get('https://api.example.com/data');
    this.cache = response.data;
    console.log('Data fetched and cached:', this.cache);
  }
}

```
---

### 3. **`beforeApplicationShutdown` - Đóng kết nối WebSocket**

**Tình huống**: Đóng kết nối WebSocket để đảm bảo tài nguyên được giải phóng.

```typescript

import { Injectable, OnApplicationShutdown } from '@nestjs/common';
import { Server } from 'ws';

@Injectable()
export class WebSocketService implements OnApplicationShutdown {
  private server: Server;

  constructor() {
    this.server = new Server({ port: 8080 });
    this.server.on('connection', (socket) => {
      console.log('New WebSocket connection');
    });
  }

  onApplicationShutdown() {
    console.log('Closing WebSocket server...');
    this.server.close(() => {
      console.log('WebSocket server closed.');
    });
  }
}

```

---

### 4. **`onApplicationShutdown` - Đóng hàng đợi RabbitMQ**

**Tình huống**: Hủy kết nối với RabbitMQ trước khi ứng dụng tắt.

```typescript

import { Injectable, OnApplicationShutdown } from '@nestjs/common';
import * as amqp from 'amqplib';

@Injectable()
export class RabbitMQService implements OnApplicationShutdown {
  private connection: amqp.Connection;
  private channel: amqp.Channel;

  async connect() {
    this.connection = await amqp.connect('amqp://localhost');
    this.channel = await this.connection.createChannel();
    console.log('RabbitMQ connected.');
  }

  async onApplicationShutdown() {
    console.log('Closing RabbitMQ connection...');
    await this.channel.close();
    await this.connection.close();
    console.log('RabbitMQ connection closed.');
  }
}


```
---

### 5. **`onModuleDestroy` - Dọn dẹp module khi bị hủy**

**Tình huống**: Xóa các file tạm được tạo ra trong module.

```typescript

import { Injectable, OnModuleDestroy } from '@nestjs/common';
import * as fs from 'fs';

@Injectable()
export class FileService implements OnModuleDestroy {
  private tempFilePath = './temp-file.txt';

  createTempFile() {
    fs.writeFileSync(this.tempFilePath, 'Temporary data');
    console.log('Temporary file created.');
  }

  onModuleDestroy() {
    if (fs.existsSync(this.tempFilePath)) {
      fs.unlinkSync(this.tempFilePath);
      console.log('Temporary file deleted.');
    }
  }
}


```
---

### 6. **`onApplicationBootstrap` - Đăng ký middleware bên thứ ba**

**Tình huống**: Đăng ký một middleware như Prometheus cho việc monitor.

```typescript

import { Injectable, OnApplicationBootstrap } from '@nestjs/common';
import * as Prometheus from 'prom-client';

@Injectable()
export class MetricsService implements OnApplicationBootstrap {
  onApplicationBootstrap() {
    const collectDefaultMetrics = Prometheus.collectDefaultMetrics;
    collectDefaultMetrics();
    console.log('Prometheus metrics initialized.');
  }
}


```
---

### 7. **`onApplicationShutdown` - Lưu trạng thái cuối cùng vào cơ sở dữ liệu**

**Tình huống**: Lưu log hoặc trạng thái cuối cùng trước khi ứng dụng dừng.

```typescript

import { Injectable, OnApplicationShutdown } from '@nestjs/common';
import { Repository } from 'typeorm';
import { InjectRepository } from '@nestjs/typeorm';
import { Log } from './log.entity';

@Injectable()
export class LogService implements OnApplicationShutdown {
  constructor(
    @InjectRepository(Log)
    private readonly logRepository: Repository<Log>,
  ) {}

  async onApplicationShutdown() {
    console.log('Saving shutdown log...');
    await this.logRepository.save({ message: 'Application is shutting down' });
    console.log('Shutdown log saved.');
  }
}

```
---

### Tóm lại:

Những ví dụ trên giúp bạn hiểu rõ hơn về cách áp dụng lifecycle hooks trong các tình huống thực tế như:

- Khởi tạo tài nguyên (Redis, RabbitMQ).
- Đóng tài nguyên khi ứng dụng tắt (WebSocket, database).
- Dọn dẹp dữ liệu tạm hoặc xử lý hậu kỳ (log, file).
- Xử lý công việc định kỳ hoặc tải cấu hình.

Việc sử dụng lifecycle hooks đảm bảo ứng dụng hoạt động ổn định, tài nguyên được quản lý hiệu quả, và dễ mở rộng khi cần thiết


---
## Liên quan

https://docs.nestjs.com/fundamentals/lifecycle-events
https://chatgpt.com/share/67765a14-7eb4-8013-805f-13563025c5c2
Tham khảo thêm các đoạn code mình implement sử dụng lifecycles events trong bài viết nhé:
https://github.com/sangtrandev00/lifecycle-events-nestjs
Ngoài ra, mình cũng có viết thêm nhiều bài viết về series **NestJS cơ bản**. Hãy ghé thăm để hiểu thêm các các concepts cốt lỗi của NestJS

#nestjs #backend