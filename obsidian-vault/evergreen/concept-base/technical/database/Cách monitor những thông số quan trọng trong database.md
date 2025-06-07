
## MySQL Connection Pool Monitoring

### 1. Direct Database Monitoring

typescript

```typescript
// MySQL connection statistics via direct query
async function getMySQLPoolStats(dataSource: DataSource) {
  // Get connection status
  const [processlist] = await dataSource.query(`SHOW PROCESSLIST`);
  
  // Get connection pool variables
  const [variables] = await dataSource.query(`
    SHOW VARIABLES WHERE Variable_name IN (
      'max_connections', 
      'max_user_connections',
      'wait_timeout'
    )
  `);
  
  // Get global status
  const [status] = await dataSource.query(`
    SHOW GLOBAL STATUS WHERE Variable_name IN (
      'Threads_connected',
      'Threads_running', 
      'Connections', 
      'Connection_errors_max_connections',
      'Aborted_connects'
    )
  `);
  
  // Transform into a user-friendly object
  const maxConnections = variables.find(v => v.Variable_name === 'max_connections').Value;
  const threadsConnected = status.find(s => s.Variable_name === 'Threads_connected').Value;
  
  return {
    maxPoolSize: parseInt(maxConnections),
    currentActive: parseInt(threadsConnected),
    running: processlist.length,
    connectionErrors: parseInt(status.find(s => s.Variable_name === 'Connection_errors_max_connections').Value)
  };
}
```

### 2. TypeORM Connection Metrics

typescript

```typescript
// NestJS service to track TypeORM connection pool
@Injectable()
export class ConnectionMonitorService {
  private metrics = {
    acquired: 0,
    released: 0,
    active: 0,
    queued: 0,
    maxActive: 0,
    totalTime: 0,
    operations: 0
  };
  
  constructor(private dataSource: DataSource) {
    this.setupMonitoring();
  }
  
  private setupMonitoring() {
    // Get the underlying driver pool from TypeORM
    const pool = (this.dataSource.driver as any).pool;
    
    if (pool) {
      // Listen for connection acquisition
      pool.on('acquire', () => {
        this.metrics.acquired++;
        this.metrics.active++;
        this.metrics.maxActive = Math.max(this.metrics.maxActive, this.metrics.active);
      });
      
      // Listen for connection release
      pool.on('release', () => {
        this.metrics.released++;
        this.metrics.active--;
      });
    }
  }
  
  // Add tracking wrapper for transactions
  async trackTransaction<T>(operation: () => Promise<T>): Promise<T> {
    const startTime = Date.now();
    try {
      return await operation();
    } finally {
      const duration = Date.now() - startTime;
      this.metrics.totalTime += duration;
      this.metrics.operations++;
    }
  }
  
  getMetrics() {
    return {
      ...this.metrics,
      avgTransactionDuration: this.metrics.operations ? 
        this.metrics.totalTime / this.metrics.operations : 0
    };
  }
}
```

## MongoDB Connection Pool Monitoring

### 1. Direct MongoDB Server Statistics

typescript

```typescript
// MongoDB connection stats via serverStatus command
async function getMongoDBPoolStats(client: MongoClient) {
  // Get server status
  const serverStatus = await client.db('admin').command({ serverStatus: 1 });
  
  // Extract connection info
  const { connections, metrics } = serverStatus;
  
  return {
    maxPoolSize: connections.current,
    currentActive: connections.active,
    available: connections.available,
    pending: connections.pending,
    totalCreated: connections.totalCreated,
    avgTransactionTime: metrics?.operation?.timeouts ? metrics.operation.timeouts.executionTime : 'N/A'
  };
}
```

### 2. Mongoose/MongoDB Driver Monitoring

typescript

```typescript
// Set up MongoDB driver monitoring
@Injectable()
export class MongoConnectionMonitorService implements OnModuleInit {
  private currentOperations = new Map<string, { startTime: number, op: any }>();
  private metrics = {
    connectionsMade: 0,
    connectionsEnded: 0,
    currentActive: 0,
    waitingForConnection: 0,
    totalTime: 0,
    operations: 0,
    longestTransaction: 0,
    longestTransactionId: ''
  };
  
  constructor(
    @InjectConnection() private readonly connection: Connection
  ) {}
  
  onModuleInit() {
    // Get MongoDB native driver
    const client = this.connection.getClient();
    
    // Set up command monitoring
    const mongoClient = client as MongoClient;
    
    mongoClient.on('connectionPoolCreated', (event) => {
      console.log(`Connection pool created with max size ${event.options.maxPoolSize}`);
    });
    
    mongoClient.on('connectionCreated', () => {
      this.metrics.connectionsMade++;
      this.metrics.currentActive++;
    });
    
    mongoClient.on('connectionClosed', () => {
      this.metrics.connectionsEnded++;
      this.metrics.currentActive--;
    });
    
    // Monitor command execution
    mongoClient.on('commandStarted', (event) => {
      const id = event.requestId.toString();
      this.currentOperations.set(id, { 
        startTime: Date.now(),
        op: event
      });
    });
    
    mongoClient.on('commandSucceeded', (event) => {
      const id = event.requestId.toString();
      const opInfo = this.currentOperations.get(id);
      
      if (opInfo) {
        const duration = Date.now() - opInfo.startTime;
        this.metrics.totalTime += duration;
        this.metrics.operations++;
        
        if (duration > this.metrics.longestTransaction) {
          this.metrics.longestTransaction = duration;
          this.metrics.longestTransactionId = id;
        }
        
        this.currentOperations.delete(id);
      }
    });
    
    mongoClient.on('commandFailed', (event) => {
      const id = event.requestId.toString();
      this.currentOperations.delete(id);
    });
  }
  
  getMetrics() {
    return {
      ...this.metrics,
      avgTransactionDuration: this.metrics.operations ? 
        this.metrics.totalTime / this.metrics.operations / 1000 : 0,
      longestTransactionSeconds: this.metrics.longestTransaction / 1000
    };
  }
  
  // Get currently running operations
  async getCurrentOps() {
    const db = this.connection.db;
    return db.admin().command({ currentOp: 1, active: true });
  }
}
```

## Comprehensive Monitoring API Endpoint

typescript

```typescript
@Controller('monitoring')
export class DatabaseMonitoringController {
  constructor(
    @InjectDataSource() private dataSource: DataSource,
    @InjectConnection() private mongoConnection: Connection,
    private mySqlMonitorService: ConnectionMonitorService,
    private mongoMonitorService: MongoConnectionMonitorService
  ) {}
  
  @Get('connection-pools')
  @UseGuards(AdminGuard) // Restrict to admins only
  async getConnectionPoolStatus() {
    // Get MySQL stats
    const mySqlPoolStats = await getMySQLPoolStats(this.dataSource);
    const mySqlMetrics = this.mySqlMonitorService.getMetrics();
    
    // Get MongoDB stats
    const mongoClient = this.mongoConnection.getClient() as MongoClient;
    const mongoPoolStats = await getMongoDBPoolStats(mongoClient);
    const mongoMetrics = this.mongoMonitorService.getMetrics();
    
    return {
      mysql: {
        maxPoolSize: mySqlPoolStats.maxPoolSize,
        currentActive: mySqlPoolStats.currentActive,
        waitingForConnection: mySqlMetrics.queued,
        avgTransactionDuration: `${mySqlMetrics.avgTransactionDuration.toFixed(1)}ms`,
        longestActiveTransaction: mySqlMetrics.maxActive > 0 ? 
          `${(Date.now() - mySqlMetrics.maxActive) / 1000}s` : 'None'
      },
      mongodb: {
        maxPoolSize: mongoPoolStats.maxPoolSize,
        currentActive: mongoPoolStats.currentActive,
        waitingForConnection: mongoMetrics.waitingForConnection,
        avgTransactionDuration: `${mongoMetrics.avgTransactionDuration.toFixed(1)}s`,
        longestActiveTransaction: `${mongoMetrics.longestTransactionSeconds.toFixed(1)}s (ID: ${mongoMetrics.longestTransactionId})`
      }
    };
  }
  
  @Get('slow-queries')
  @UseGuards(AdminGuard)
  async getSlowQueries() {
    // Get currently running MongoDB operations
    const currentOps = await this.mongoMonitorService.getCurrentOps();
    
    // Get slow queries from MySQL
    const [slowQueries] = await this.dataSource.query(`
      SELECT * FROM performance_schema.events_statements_current 
      WHERE TIMER_WAIT > 1000000000000
      ORDER BY TIMER_WAIT DESC
    `);
    
    return {
      mysql: slowQueries,
      mongodb: currentOps.inprog.filter(op => op.secs_running > 2)
    };
  }
}
```

## Setting Up Real-Time Monitoring Dashboard

For production systems, consider integrating with Prometheus and Grafana:

typescript

```typescript
// metrics.service.ts
import { Injectable } from '@nestjs/common';
import { register, Gauge } from 'prom-client';

@Injectable()
export class MetricsService {
  private mysqlActiveConnections: Gauge<string>;
  private mysqlMaxConnections: Gauge<string>;
  private mysqlWaitingConnections: Gauge<string>;
  private mysqlAvgTransactionTime: Gauge<string>;
  
  private mongodbActiveConnections: Gauge<string>;
  private mongodbMaxConnections: Gauge<string>;
  private mongodbWaitingConnections: Gauge<string>;
  private mongodbAvgTransactionTime: Gauge<string>;
  
  constructor(
    private mySqlMonitorService: ConnectionMonitorService,
    private mongoMonitorService: MongoConnectionMonitorService
  ) {
    // Initialize Prometheus metrics
    this.mysqlActiveConnections = new Gauge({
      name: 'mysql_active_connections',
      help: 'Number of active MySQL connections'
    });
    
    // Initialize other metrics...
    
    // Start metrics collection
    this.startCollection();
  }
  
  getMetrics() {
    return register.metrics();
  }
  
  private startCollection() {
    // Collect metrics every 15 seconds
    setInterval(async () => {
      const mysqlMetrics = this.mySqlMonitorService.getMetrics();
      const mongoMetrics = this.mongoMonitorService.getMetrics();
      
      this.mysqlActiveConnections.set(mysqlMetrics.active);
      this.mysqlWaitingConnections.set(mysqlMetrics.queued);
      this.mysqlAvgTransactionTime.set(mysqlMetrics.avgTransactionDuration);
      
      this.mongodbActiveConnections.set(mongoMetrics.currentActive);
      this.mongodbWaitingConnections.set(mongoMetrics.waitingForConnection);
      this.mongodbAvgTransactionTime.set(mongoMetrics.avgTransactionDuration);
    }, 15000);
  }
}
```

## Additional Recommendations

1. **Alerting**: Set up alerts when connections reach 80% of max pool size
2. **Logging**: Log connection errors and timeouts
3. **Resource Planning**: Use metrics to right-size connection pools
4. **Load Testing**: Simulate high connection load to test pool behavior

---


## Resource to track

All the good questions here below!
https://claude.ai/chat/1709c76b-46e4-4424-87d8-a6c2fac56735