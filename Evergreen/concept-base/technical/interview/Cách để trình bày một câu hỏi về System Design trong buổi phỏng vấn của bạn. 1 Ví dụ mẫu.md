

## Trình tự các bước để thực hành

Trình tự này khá giống với bài [[Làm sao để giải quyết các bài toán lập trình ? 15 Bước cụ thể để giải quyết vấn đề]]]

### 1. **Clarify the Requirements** (Step 1: Understand)  

Before jumping into the solution, clarify the problem with the interviewer to ensure you understand the question:

- **What is the main objective?**
- **Are there any constraints? (e.g., scale, response time, concurrent users)**

For example, if the question is: _"How would you design an employee management module?"_  
Say:

> "To clarify, is the goal to manage employee records with features like CRUD operations, filtering, and performance optimization? Should I consider scalability?"


---

### 2. **Define the High-Level Design** (Step 2: Break into Components)  

Split the problem into manageable parts and explain them one by one.  
Focus on the following components:

- **API Design**
- **Database Design**
- **Architecture**

### 3. **Draw the Architecture** (Step 3: Visual Representation)  
    If a whiteboard or tools are available, **draw a simple architecture diagram**:

**Flowchart Example:**

1. **Request** → Controller → Service → Repository → Database
2. If Cache Enabled: **Service → Check Cache (Redis) → Fallback to Database**

Here’s how you can **explain** it:

- "The user sends an API request to get employees. The controller validates the request and passes it to the service layer. The service checks Redis (to optimize query performance) and falls back to the database if the data isn't cached. The result is returned to the client."

---

### 4. **Database Schema Design** (Step 4: Design the Tables)  

Example: **Employee Table Design**

|Column|Type|Constraints|
|---|---|---|
|`employeeId`|INT|Primary Key, Auto-Increment|
|`name`|VARCHAR(255)|Not Null|
|`department`|VARCHAR(100)|Foreign Key (Departments)|
|`salary`|DECIMAL(10,2)|Not Null|
|`isActive`|BOOLEAN|Default True|

Explain:

> "The `employeeId` is the primary key, `department` links to the department table to normalize the data, and `salary` is stored as a decimal for precision. Adding an `isActive` flag helps soft-delete records without removing them."

### 5. **Handle Performance Optimization** 
(Step 5: Optimizations and Scaling)  
Discuss how you ensure **high performance**:
### 5.1. **Caching**: 
Use Redis for fast access to frequently used data.
- Example: "Cache active employees or frequently queried departments."
### 5.2. **Indexes**: 
Add indexes on frequently filtered columns (`department`, `isActive`).

### 5.3. **Pagination**: 
For large data sets, use offset and limit for API results.

#### 5.4 **Database Query Optimization**: 
Write efficient queries (e.g., avoid `SELECT *` and use composite indexes).


## 1 Bài thực hành mẫu

**Interviewer**: _"How would you design an employee management module?"_

**You**:

> "To clarify, are we building an API that supports CRUD operations for employees with a focus on scalability and performance? Should I consider caching and large-scale data?"

_Assuming the interviewer says 'Yes', proceed:_

1. **High-Level Design**:
    - I would structure the system into three layers:
        - **Controller**: Handles API requests like `POST /employees` and `GET /employees`.
        - **Service**: Implements business logic like adding or retrieving employee data.
        - **Repository**: Interacts with the database using TypeORM (MSSQL in our case).
2. **Database Design**:
    
    - The `employees` table will include:  
        | `employeeId` | `name` | `department` | `salary` | `isActive` |
        - Indexes on `department` and `isActive` for efficient lookups.
3. **Performance Optimizations**:
    
    - **Caching**: Use Redis to store frequently accessed employee lists (e.g., active employees).
    - **Pagination**: Add `offset` and `limit` for large datasets.
    - **Composite Indexes**: Combine `department` and `isActive` to optimize queries.
4. **Architecture**:
    
    - **Request Flow**: API Request → Controller → Service → Redis Cache → Database.
    - If Redis hits a cache miss, the service fetches from the database, stores it in Redis, and returns the result.
5. **Trade-offs**:
    
    - Adding Redis improves read performance but increases system complexity.
    - Soft deletes (`isActive`) are efficient for recovery but require additional filtering in queries.
    **Example Query for Active Employees in HR**:

```sql
SELECT * FROM employees 
WHERE department = 'HR' AND isActive = true
ORDER BY salary DESC;

```

> "This design is clean, scalable, and optimized for performance with caching and query improvements. Let me know if you'd like me to discuss other modules or alternatives."

## Format để thực hành dạng câu hỏi này

1. **Understand Requirements**.
2. **Design High-Level Components**.
3. **Draw Architecture Flow**.
4. **Explain the Database Design**.
5. **Discuss Optimizations**.
6. **Highlight Trade-offs**.

## Liên quan

#system-design #interview 