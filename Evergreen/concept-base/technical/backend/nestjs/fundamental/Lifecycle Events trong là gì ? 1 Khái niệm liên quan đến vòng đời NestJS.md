
### Lifecycle Events trong NestJS là gì ?

Lifecycle Events trong NestJS là các hook (móc vòng đời) mà framework cung cấp để bạn có thể thực thi logic vào những thời điểm cụ thể trong vòng đời của một module hoặc service. Những event này giúp quản lý và điều khiển quá trình khởi tạo, xử lý, và hủy của các thành phần trong ứng dụng.

Các lifecycle event chính trong NestJS bao gồm:
![[Pasted image 20250102163128.png]]
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

## Khi nào sử dụng?

- **`onModuleInit`**: Khi bạn cần chuẩn bị tài nguyên cục bộ cho một module (kết nối Redis, tải dữ liệu khởi tạo, v.v.).
- **`onApplicationBootstrap`**: Khi công việc cần thực hiện sau khi toàn bộ ứng dụng đã khởi tạo (kết nối API bên ngoài, log trạng thái toàn cục, v.v.).
- **`beforeApplicationShutdown`**: Khi cần dọn dẹp tài nguyên quan trọng trước khi ứng dụng dừng, ví dụ đóng kết nối cơ sở dữ liệu.
- **`onApplicationShutdown`**: Dành cho các hành động dọn dẹp cuối cùng khi ứng dụng bị tắt.


---
## Liên quan

https://docs.nestjs.com/fundamentals/lifecycle-events
https://chatgpt.com/share/67765a14-7eb4-8013-805f-13563025c5c2

#nestjs #backend 