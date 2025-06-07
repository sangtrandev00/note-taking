---
profileName: sangtrandev00
postId: 3462
postType: post
categories:
  - 39
---
## Câu hỏi 1 

### Đề tiếng anh
There are N trees (numbered from 0 to N-1) in a forest. The K-th tree is located at coordinates
(X[K], Y[K)).
We want to build the widest possible vertical path, such that there is no tree on it. The path must
be built somewhere between a leftmost and a rightmost tree, which means that the width of the
path cannot be infinite.
What is the width of the widest possible path that can be built?
Write a function:
function solution(X: number[I, Y: number[1) : number;
that, given two arrays X and Y consisting of N integers each, denoting the positions of trees,
returns the width of the widest possible path that can be built.
**Examples:**
1. Given X=[1, 8, 7, 3, 4, 1, 8], Y=[6, 4, 1, 8, 5, 1, 7], the function should return 3. (Sơ đồ hoá lên, vẽ sơ đồ toạ độ X, Y thì mới hiểu thêm được)
2. Given X=(5, 5, 5, 7, 7, 7], Y=(3, 4, 5, 1, 3, 7], the function should return 2.
3. Given X=[4, 1, 5, 4], Y-|4, 5, 1, 3], the function should return 3.
### Câu hỏi 1 dịch sang tiếng việt:

Có **N cây** (được đánh số từ 0 đến N-1) trong một khu rừng. Cây thứ K có tọa độ ở vị trí X[K],Y[K]X[K], Y[K]X[K],Y[K].  
Chúng ta muốn xây dựng **đường thẳng đứng rộng nhất có thể** sao cho không có cây nào nằm trên đó. Đường này phải được xây dựng giữa cây ngoài cùng bên trái và cây ngoài cùng bên phải, có nghĩa là độ rộng của đường không thể vô hạn.  
Hỏi độ rộng lớn nhất của đường thẳng đứng có thể xây dựng là bao nhiêu?

Viết một hàm:
```typescript
function solution(X: number[], Y: number[]): number;
```

Hàm này nhận vào hai mảng **X** và **Y**, mỗi mảng có N số nguyên, biểu diễn tọa độ của cây, và trả về **độ rộng lớn nhất của đường thẳng đứng** có thể xây dựng.

**Ví dụ:**

1. Với X=[1,8,7,3,4,1,8]X = [1, 8, 7, 3, 4, 1, 8]X=[1,8,7,3,4,1,8], Y=[6,4,1,8,5,1,7]Y = [6, 4, 1, 8, 5, 1, 7]Y=[6,4,1,8,5,1,7], hàm trả về **3**.
2. Với X=[5,5,5,7,7,7]X = [5, 5, 5, 7, 7, 7]X=[5,5,5,7,7,7], Y=[3,4,5,1,3,7]Y = [3, 4, 5, 1, 3, 7]Y=[3,4,5,1,3,7], hàm trả về **2**.
3. Với X=[4,1,5,4]X = [4, 1, 5, 4]X=[4,1,5,4], Y=[4,5,1,3]Y = [4, 5, 1, 3]Y=[4,5,1,3], hàm trả về **3**.


## **Câu hỏi  2** 

### Đề tiếng anh

A group of friends is going on holiday together. They have come to a meeting point (the start of the
journey) using N cars. There are P[K] people and S(K] seats in the K-th car for K in range 0..N-1].
Some of the seats in the cars may be free, so it is possible for some of the friends to change the car
they are in. The friends have decided that, in order to be ecological, they will leave some cars parked
at the meeting point and travel with as few cars as possible.
Write a function:
function solution(P: number[], S: number []) : number;
that, given two arrays P and S, consisting of N integers each, returns the minimum number of cars
needed to take all of the friends on holiday.

**Examples:**
1. Given P = [1, 4, 1] and S = [1, 5, 1], the function should return 2. A person from car number 0 can
travel in car number 1 instead. This way, car number 0 can be left parked at the meeting point.
2. Given P = [4, 4, 2, 4] and S = [5, 5, 2, 5], the function should return 3. One person from car number
2 can travel in car number 0 and the other person from car number 2 can travel in car number 3
3. Given P = [2, 3, 4, 2] and S = [2, 5, 7, 2], the function should return 2. Passengers from car number
0 can travel in car number 1 and passengers from car number 3 can travel in car number 2.
Write an efficient algorithm for the following assumptions:
• Nis an integer within the range [1..100,000);
each element of arrays P and S is an integer within the range [1..9];
• every friend had a seat in the car they came in; that is, P[k]s S{k] for each K within the range [0..N-1]

### Câu hỏi 2 dịch sang tiếng việt:

Một nhóm bạn đi nghỉ mát cùng nhau. Họ đã đến một điểm tập trung (điểm bắt đầu chuyến đi) bằng **N chiếc xe ô tô**. Xe thứ K chở **P[K] người** và có **S[K] chỗ ngồi**.  
Một số chỗ ngồi trong xe có thể trống, vì vậy một số người có thể đổi xe. Nhóm bạn quyết định rằng, để bảo vệ môi trường, họ sẽ để lại một số xe ở điểm tập trung và đi chung xe nhiều nhất có thể.

Viết một hàm:

```typescript
function solution(P: number[], S: number[]): number;
```

Hàm này nhận vào hai mảng **P** và **S**, mỗi mảng có N số nguyên, và trả về **số xe ít nhất cần sử dụng để chở tất cả mọi người đi nghỉ**.

**Ví dụ:**

1. Với P=[1,4,1]P = [1, 4, 1]P=[1,4,1] và S=[1,5,1]S = [1, 5, 1]S=[1,5,1], hàm trả về **2**.
2. Với P=[4,4,2,4]P = [4, 4, 2, 4]P=[4,4,2,4] và S=[5,5,2,5]S = [5, 5, 2, 5]S=[5,5,2,5], hàm trả về **3**.
3. Với P=[2,3,4,2]P = [2, 3, 4, 2]P=[2,3,4,2] và S=[2,5,7,2]S = [2, 5, 7, 2]S=[2,5,7,2], hàm trả về **2**.

**Giả định:**

- NNN là một số nguyên trong khoảng [1..100,000].
- Mỗi phần tử của **P** và **S** là một số nguyên trong khoảng [1..9].
- Số người trong mỗi xe không vượt quá số ghế của xe đó (P[K]≤S[K]P[K] \leq S[K]P[K]≤S[K]).

## **Câu 3**
### Đề tiếng anh
You are given a positive integer N. Your task is to find the smallest integer greater than N that does
not contain two identical consecutive digits.
For example, given N = 1765, the smallest integer greater than N is 1766. However, in 1766 the last
two digits are identical. The next integer, 1767, does not contain two identical consecutive digits,
and is the smallest integer greater than 1765 that fulfils the condition. Note that the second and
fourth digits in 1767 can both be 7 as they are not consecutive.
Write a function:
function solution(N: number): number;
that, given an integer N, returns the smallest integer greater than N that does not contain two
identical consecutive digits.
Examples:
1. Given N = 55, the function should return 56. It is the smallest integer greater than 55 and it does
not contain two consecutive digits that are the same.
2. Given N = 1765, the function should return 1767, as explained above.
3. Given N = 98, the answer should be 101. Both 99 and 100 contain two identical consecutive
digits, but 101 does not.
4. Given N = 44432, the answer should be 45010.
5. Given N = 3298, the answer should be 3401.
Write an efficient algorithm for the following assumptions:
• N is an integer within the range [1.. 1,000,000,000].
Copyright 2009-2024 by Codility Limited. All Rights Reserved. Unauthorized copying, publication or disclosure prohibite

### Câu hỏi 3 dịch sang tiếng việt:

Bạn được cung cấp một số nguyên dương NNN. Nhiệm vụ của bạn là tìm **số nguyên nhỏ nhất lớn hơn NNN** sao cho số đó **không chứa hai chữ số giống nhau liên tiếp**.

Ví dụ:

- Với N=1765N = 1765N=1765, số nhỏ nhất lớn hơn NNN là **1767**. Tuy nhiên, 1766 không thỏa mãn vì có hai chữ số 6 liền kề.
- Với N=55N = 55N=55, số nhỏ nhất lớn hơn là **56**.
- Với N=98N = 98N=98, câu trả lời là **101**.

Viết một hàm:

```typescript
function solution(N: number): number;
```

Hàm này nhận vào một số nguyên NNN và trả về **số nhỏ nhất lớn hơn NNN** thỏa mãn điều kiện.

**Ví dụ:**

1. Với N=55N = 55N=55, hàm trả về **56**.
2. Với N=1765N = 1765N=1765, hàm trả về **1767**.
3. Với N=98N = 98N=98, hàm trả về **101**.
4. Với N=44432N = 44432N=44432, hàm trả về **45010**.
5. Với N=3298N = 3298N=3298, hàm trả về **3401**.

**Giả định:**

- NNN là một số nguyên trong khoảng [1..1,000,000,000].

## Kết quả
Mình đạt được >80% performance trên nền tảng codility

---
## Liên quan
Bên dưới là link repository mình có bài giải mà mình đã implement
https://github.com/sangtrandev00/leetcode-practice/tree/main/src/codility/test

#interview #algorithm #data-structure