---
layout: post
title: "Dynamic Programming là gì ? 1 kỹ thuật hữu ích để giải quyết các bài toán lập trình"
date: 2025-07-24 10:00:00 +0700
categories: concept-base technical algorithm Master Coding Interview Dynamic Programming
tags: ["typescript", "algorithm", "programming"]
source_path: "Evergreen/concept-base/technical/algorithm/Master Coding Interview/Dynamic Programming/Dynamic Programming là gì ? 1 kỹ thuật hữu ích để giải quyết các bài toán lập trình.md"
---
---
profileName: sangtrandev00
postId: 3385
postType: post
categories:
  - 39
---
Một kỹ thuật tối ưu trong lập trình. Caching 

## Dynamic programming là gì ?

> Nguồn GPT: https://chatgpt.com/share/675ed0db-3ba8-8013-b896-37ad3a27e431
> **Dynamic Programming (DP)** là một kỹ thuật trong lập trình nhằm giải quyết các bài toán phức tạp bằng cách chia nhỏ chúng thành các bài toán con đơn giản hơn. DP đặc biệt hiệu quả với các bài toán có **tính chất con lặp lại** (_overlapping subproblems_) và **tính chất tối ưu con** (_optimal substructure_).

## Các tính chất của DP (Dynamic Programming)

1. **Tính chất con lặp lại (Overlapping Subproblems)**  
    Một bài toán có thể được chia thành nhiều bài toán con và các bài toán con này có thể lặp lại nhiều lần trong quá trình giải. Thay vì tính toán lại các bài toán con mỗi lần, DP lưu trữ kết quả của chúng để sử dụng lại sau.
    
2. **Tính chất tối ưu con (Optimal Substructure)**  
    Một bài toán có tính chất tối ưu con nếu lời giải tối ưu của bài toán lớn có thể được xây dựng từ lời giải tối ưu của các bài toán con.
    
3. **Lưu trữ kết quả (Memoization hoặc Tabulation)**
    
    - **Memoization**: Lưu kết quả của các bài toán con trong quá trình tính toán (top-down).
    - **Tabulation**: Tính toán và lưu trữ tất cả các bài toán con trước khi giải quyết bài toán lớn (bottom-up).

## Các bài toán và ứng dụng sử dụng Dynamic Programming

1. **Fibonacci Sequence (Dãy Fibonacci)**  
    Ví dụ kinh điển minh hoạ tính lặp lại trong DP.
    
    **Cách thông thường (Đệ quy):**
```Typescript

function fib(n: number): number {
    if (n <= 1) return n;
    return fib(n - 1) + fib(n - 2);
}
console.log(fib(10)); // Kết quả: 55

```

    Hàm trên không hiệu quả vì tính lại cùng một giá trị nhiều lần.
    
    **Cách dùng DP với Memoization:**
```typescript

function fibDP(n: number, memo: Record<number, number> = {}): number {
    if (n in memo) return memo[n];
    if (n <= 1) return n;
    memo[n] = fibDP(n - 1, memo) + fibDP(n - 2, memo);
    return memo[n];
}
console.log(fibDP(10)); // Kết quả: 55

```

Cách dùng trên tương đối khó hiểu => Mình sẽ có cách dùng trình bày tốt hơn

```typescript

let calculations = 0

function fibonacci(n: number): number {
  calculations++

  if (n <= 2) return 1

  return fibonacci(n - 1) + fibonacci(n - 2)
}

// console.log(fibonacci(10))

// console.log("calculation", calculations);

// Việc tính như vậy khá lâu, và không tối ưu (Caching)

function dp() {
  const caching: any = new Map()

  caching.set(0, 0)

  caching.set(1, 1)

  return function fibonacciDP(number: number): number {
    calculations++

    if (caching.has(number)) {
      return caching.get(number)
    } else {
      const result = fibonacciDP(number - 1) + fibonacciDP(number - 2)

      caching.set(number, result)

      console.log("caching!", caching)

      return result
    }
  }
}

const fib = dp()

console.log("slow", fibonacci(20)) // 13529 lần gọi function => Tốn rất nhiều bộ nhớ khi sử dụng recursive function! => Rất dễ gây nghẽn (exceed bộ nhớ!)

console.log("fast", fib(20)) // 39 lần gọi function => Super fast


```
=> Giải thích cơ bản cho bài toán trên là áp dụng kỹ thuật đệ quy. Mỗi lần đệ quy thì lưu các giá trị con vào hashmap => Từ đó tính được các giá trị của dãy số lớn hơn

    **Cách dùng DP với Tabulation:**
```typescript

function fibTabulation(n: number): number {
    if (n <= 1) return n;
    const dp = [0, 1];
    for (let i = 2; i <= n; i++) {
        dp[i] = dp[i - 1] + dp[i - 2];
    }
    return dp[n];
}
console.log(fibTabulation(10)); // Kết quả: 55

```


---

2. **Knapsack Problem (Bài toán cái túi)**  
    Cho một danh sách các vật phẩm với trọng lượng và giá trị, chọn các vật phẩm sao cho giá trị tổng lớn nhất nhưng không vượt quá sức chứa của túi.
    
    - **Input**: Trọng lượng, giá trị của từng vật phẩm, và sức chứa của túi.
    - **Output**: Giá trị lớn nhất có thể chứa.
    
    **Cách tiếp cận bằng DP:**
```typescript

function knapsack(
  weights: number[],
  values: number[],
  capacity: number
): number {
  const n = weights.length
  const dp: number[][] = Array(n + 1)
    .fill(null)
    .map(() => Array(capacity + 1).fill(0))

  for (let i = 1; i <= n; i++) {
    for (let w = 0; w <= capacity; w++) {
      if (weights[i - 1] <= w) {
        dp[i][w] = Math.max(
          dp[i - 1][w], // Không chọn vật phẩm i
          dp[i - 1][w - weights[i - 1]] + values[i - 1] // Chọn vật phẩm i
        )
      } else {
        dp[i][w] = dp[i - 1][w]
      }
    }
  }
  return dp[n][capacity]
}

const weights = [1, 2, 3]
const values = [6, 10, 12]
const capacity = 5
console.log(knapsack(weights, values, capacity)) // Kết quả: 22

```
   

---

3. **Longest Common Subsequence (Chuỗi con chung dài nhất)**  
    Tìm độ dài chuỗi con chung dài nhất của hai chuỗi.
    
    **DP giải bài toán này:**
```typescript

function longestCommonSubsequence(s1: string, s2: string): number {
    const m = s1.length, n = s2.length;
    const dp: number[][] = Array(m + 1).fill(null).map(() => Array(n + 1).fill(0));

    for (let i = 1; i <= m; i++) {
        for (let j = 1; j <= n; j++) {
            if (s1[i - 1] === s2[j - 1]) {
                dp[i][j] = dp[i - 1][j - 1] + 1;
            } else {
                dp[i][j] = Math.max(dp[i - 1][j], dp[i][j - 1]);
            }
        }
    }
    return dp[m][n]; // Cách tiếp cận này chưa tối ưu. Độ phức tạp của thuật toán time complexity là O(n^2) và space complexity
}

console.log(longestCommonSubsequence("abcde", "ace")); // Kết quả: 3

```

## Khi nào thì áp dụng kỹ thuật Dynamic Programming ?
![assets/images/obsidian/Pasted image 20241215170049.png](https://trannhatsang.com/wp-content/uploads/2024/12/Pasted-image-20241215170049.png)


**Đặt các câu hỏi sau:**
1. Can be divided into subproblem (Có thể chia nhỏ thành các vấn đề phụ ?)
2. Recursive Solution (Có thể sử dụng đệ quy ?)
3. Are there repetitive subproblems? (Vấn đề phụ có bị lặp lại ?)
4. Memoize subproblems (Cần phải lưu trữ các giá trị con)
5. Demand a raise from your boss (Yêu cầu tăng lương từ Sếp của mình!, Kỹ thuật caching!)

## Có phải trong các ngôn ngữ lập trình khác đều sử dụng closure kết hợp với Hashtable để giải quyết vấn đề này!


## Một trong các bài toán phổ biến thường dùng Dynamic Programming

- Fibonacci (Dãy số). Đã có ví dụ trên
- Knapsack (Bài toán cái túi).
- Longest Common Subsequence (Chuỗi con chung dài nhất). - Bài toán này có thể áp dụng nhiều kỹ thuật
- Shortest Path (Đường đi ngắn nhất, ví dụ: Floyd-Warshall, Bellman-Ford).
- Matrix Chain Multiplication (Nhân chuỗi ma trận).


## Lợi ích 
Khi kết hợp memorize (caching) của dynamic function với recursive -> ta có thể giảm độ phức tạp không gian từ O(2^n)  xuống còn O(n) => Giảm đi bộ nhớ rất nhiều!


---
## Liên quan

#algorithm #data-structure #dynamic-programming

---
*Nguồn: Evergreen/concept-base/technical/algorithm/Master Coding Interview/Dynamic Programming/Dynamic Programming là gì ? 1 kỹ thuật hữu ích để giải quyết các bài toán lập trình.md*