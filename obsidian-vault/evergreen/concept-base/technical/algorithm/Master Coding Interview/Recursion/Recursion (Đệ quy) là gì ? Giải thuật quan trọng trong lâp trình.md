---
profileName: sangtrandev00
postId: 3332
postType: post
categories:
  - 39
---
Chắc hẳn nhiều người sẽ gặp vấn đề khi mới lần đầu tiếp cận với đệ quy (recursion function). Bài viết này mình sẽ trình bày các khái niệm liên quan đến đệ quy để mọi người bước hình dung về nó. Bài này mình sẽ giới thiệu các khái niệm căn bản, cách tích hợp một vài ví dụ về đệ quy sử dụng javascript, so sánh đệ quy với loop thông thường và cuối cùng là một vài review và lưu ý.
## Algorithm là gì ?

Thuật toán là gì ?
Là tập hợp hữu hạn các bước (gồm các hàm, các dòng code) để tạo nên một chương trình, hay để giải quyết một bài toán hoặc một vấn đề nào đó.
## Recursion (hay còn gọi là đệ quy) là gì ?

Định nghĩa một vài điều kiện trong chính bản thân nó!
Function gọi lại chính nó
## Có bao nhiêu loại Recursion ?

>> Đọc thêm ở đây [[Đệ quy (Recursive Function)]]]

## Stack overflow là gì ?
Tràn bộ nhớ

## Tại sao Recursion đôi khi lại gây ra tràn bộ nhớ ?

VD: function inception() {
	inception()
}

=> Vì trong cơ chế hoạt động của javascript trên browser mỗi lần gọi function => sẽ được push vào call stack. Mà callstack lại chiếm một lượng bộ nhớ trên browser => Trường hợp function gọi lại function như đoạn code trên sẽ gây ra vượt quá giới hạn của bộ nhớ trên browser

## Base case của recursive function

+ Recursive case
+ Stop (Base case)

## Recursive function có return và không return

```JS
let counter = 0;
function inception() {
	console. log (counter)
if (counter > 3) {
	return 'done!':
}
counter++
return inception();
}
```

## Rule của Recursive function

1. Indentify the base case (Điểm dừng)
2. Indentify the recursive case (Trường hợp cần recursive)
3. Get closer and closer and return when needed. Usually you have 2 returns

## Bài toán tìm dãy số Fibonary sử dụng Recursive và Iterative

```Typescript
// Given a number N return the index value of the Fibonacci sequence, where the sequence is:

// 0, 1, 1, 2, 3, 5, 8, 13, 21, 34, 55, 89, 144 ...

// the pattern of the sequence is that each value is the sum of the 2 previous values, that means that for N=5 → 2+3

//For example: fibonacciRecursive(6) should return 8

export function fibonacciIterative(n: number) {
  if (n < 0) return -1

  if (n == 0) return 0

  if (n == 1) return 1

  let i = 2

  let first = 0

  let second = 1

  let sum = 1

  while (i <= n) {
    sum = first + second // 1, 2, 3, 5, 8

    first = second // 1, 1, 2, 3, 5

    second = sum // 1, 2, 3, 5, 8

    i++ // 3, 4, 5, 6, 7
  }

  return sum
}

console.log("fibonacciIterative(6)", fibonacciIterative(100))

export function fibonacciRecursive(n: number): number {
  // Điểm dừng

  if (n < 0) return -1

  if (n == 0) return 0

  if (n <= 2) return 1

  n--

  return fibonacciRecursive(n) + fibonacciRecursive(n - 1)
}

// Ta có quy luật như sau: f(n) = f(n-1) + f(n-2). Ví dụ 8 = 5 + 3, 5 = 3 + 2

// Nháp:

//f(6) => f(5) + f(4) = f(4) + f(3) + f(3) + f(2) = f(3) + f(2)

// console.log("fibonacciRecursive", fibonacciRecursive(10));

```


## So sánh giữa recursive function và loop thông thường

### Recursive Fibonacci (fibonacciRecursive)

Time Complexity: O(2^n)

- Each function call spawns two more recursive calls

- Creates an exponential number of function calls

- Extremely inefficient for larger inputs

- Example call tree for n=5 creates multiple redundant calculations

Space Complexity: O(n)

- Uses call stack space proportional to the input

- Each recursive call adds a new frame to the call stack

- Maximum depth of recursion is n

Visualization:

                f(5)

            /           \

        f(4)             f(3)

      /     \           /     \

   f(3)    f(2)      f(2)     f(1)

   ...     redundant   ...     ...

### Iterative Fibonacci (fibonacciIterative)

Time Complexity: O(n)

- Single pass through a loop

- Constant number of operations per iteration

- Linear time complexity

- Much more efficient than recursive approach

Space Complexity: O(1)

- Uses only a fixed number of variables

- Constant extra space regardless of input size

- No additional memory allocation as input grows

Visualization:

Input: n=5

i=2: sum = 0+1 = 1

i=3: sum = 1+1 = 2

i=4: sum = 1+2 = 3

i=5: sum = 2+3 = 5

### Comparative Table

| Aspect | Recursive | Iterative |

|--------|-----------|-----------|

| **Time Complexity** | O(2^n) | O(n) |

| **Space Complexity** | O(n) | O(1) |

| Readability | More intuitive | More performant |

| Scalability | Poor (exponential growth) | Excellent |

### Optimization Strategies

- Recursive Optimization:

- Memoization

- Dynamic Programming

- Tail Call Optimization (not supported in all languages)
    
    // Memoized Recursive Approach
    
    function fibonacciMemoized(n: number, memo: Record<number, number> = {}): number {
    
        if (n in memo) return memo[n];
    
        if (n < 0) return -1;
    
        if (n <= 1) return n;
    
        memo[n] = fibonacciMemoized(n-1, memo) + fibonacciMemoized(n-2, memo);
    
        return memo[n];
    
    }
    
    // Time Complexity: O(n)
    
    // Space Complexity: O(n)
    

### Practical Implications

1. For small inputs (n < 20), recursive might be acceptable

- For larger inputs, always prefer iterative or memoized approaches

- In interviews/coding challenges, discuss trade-offs

### Recommendation

✅ Use Iterative for:

- Production code

- Large input ranges

- Performance-critical applications

✅ Use Recursive for:

- Small inputs

- Educational purposes

- When clarity is more important than performance

## Reviews
![images/Pasted image 20241212155750.png](https://trannhatsang.com/wp-content/uploads/2024/12/Pasted-image-20241212155750.png)

## Tóm tắt

+ Nhìn chung khi so sánh giữa lặp thông thường và recursion, chúng ta luôn chú ý về sự đánh đổi. Recursive tuy có điểm mạnh là rõ ràng (Clarify), tuy nhiên về mặt Time Complexity và Space Complexity (Đọc thêm về Big ở đây >> [[Big O là gì ?]]) thì chiếm nhiều bộ nhớ và thực thi chậm
+ Bất cứ thứ gì mình có thể implement bằng đệ quy thì mình hoàn toàn có thể implement bằng for loop

## New Rule

**Every time you are using a tree or converting** **Something into a tree, consider recursion**.
1. Divided into a number of subproblems that are smaller instances of the same problem.
2. Each instance of the subproblem is identical in nature.
3. The solutions of each subproblem can be combined to solve the problem at hand.
Divide and Conquer using Recursion


---
## Liên quan

Từ khoá gợi nhớ ?
+ tail call optimization ?

#algorithm #data-structure #recursion