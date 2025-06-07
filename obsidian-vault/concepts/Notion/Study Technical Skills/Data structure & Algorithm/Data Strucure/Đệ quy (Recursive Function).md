  

## Có bao nhiêu loại đệ quy ?

A recursive function is a function that calls itself to solve a smaller part of the problem until it reaches a base case, where it can return a result without further recursion. Recursive functions are often used to solve problems that have repetitive sub-structures, like tree traversal, searching, or mathematical calculations (like factorials or Fibonacci numbers).

### Types of Recursive Functions

1. **Direct Recursion**: When a function calls itself directly.
2. **Indirect Recursion**: When a function calls another function, which eventually calls the original function again.
3. **Tail Recursion**: A form of direct recursion where the recursive call is the last operation in the function. This allows for optimizations, as the function does not need to keep track of the previous states.
4. **Non-Tail Recursion**: When the recursive call is not the last operation in the function, meaning some operations need to be performed after the recursion call returns.

### Examples in TypeScript

1. **Direct Recursion Example (Factorial)**:
    
    ```TypeScript
    typescript
    Sao chép mã
    function factorial(n: number): number {
        if (n <= 1) return 1;  // Base case
        return n * factorial(n - 1);  // Recursive case
    }
    
    console.log(factorial(5));  // Output: 120
    
    ```
    
2. **Indirect Recursion Example**:
    
    ```TypeScript
    typescript
    Sao chép mã
    function isEven(n: number): boolean {
        if (n === 0) return true;
        return isOdd(n - 1);
    }
    
    function isOdd(n: number): boolean {
        if (n === 0) return false;
        return isEven(n - 1);
    }
    
    console.log(isEven(4));  // Output: true
    console.log(isOdd(3));   // Output: true
    
    ```
    
3. **Tail Recursion Example (Factorial)**:
    
    ```TypeScript
    typescript
    Sao chép mã
    function factorialTailRec(n: number, accumulator: number = 1): number {
        if (n <= 1) return accumulator;  // Base case
        return factorialTailRec(n - 1, accumulator * n);  // Recursive case
    }
    
    console.log(factorialTailRec(5));  // Output: 120
    
    ```
    
4. **Non-Tail Recursion Example (Fibonacci)**:
    
    ```TypeScript
    typescript
    Sao chép mã
    function fibonacci(n: number): number {
        if (n <= 1) return n;  // Base cases
        return fibonacci(n - 1) + fibonacci(n - 2);  // Recursive case
    }
    
    console.log(fibonacci(6));  // Output: 8
    
    ```
    

Each recursive function type has its own applications, and using tail recursion can be more efficient due to optimization in some languages.

  

**Root:** [https://chatgpt.com/share/671f0068-a448-8013-b980-8d1827c6eea0](https://chatgpt.com/share/671f0068-a448-8013-b980-8d1827c6eea0)