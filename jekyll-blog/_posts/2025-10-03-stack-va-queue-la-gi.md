---
layout: post
title: "Stack và Queue là gì ?"
date: 2025-10-03 10:00:00 +0700
categories: concept-base technical data-structure Master Coding Interview Stack & Queue
tags: ["javascript", "algorithm"]
source_path: "Evergreen/concept-base/technical/data-structure/Master Coding Interview/Stack & Queue/Stack và Queue là gì ?.md"
---
---
profileName: sangtrandev00
postId: 3322
postType: post
categories:
  - 39
---

## Stack
Hay còn gọi là hàng đợi một cấu trúc dữ liệu phổ biến trong lập trình. Nguyên tắc của nó là Last In First Out (Vào cuối nhưng ra trước)

!![](assets/images/obsidian/Pasted image 20241210095206.png)

Ứng dụng:
+ Undo/Redo
+ Browser history (forward, backward)
+ Function stack in JS (callback)
## Queue
Hay còn gọi là hàng đợi, cũng là một cấu trúc dữ liệu rất phổ biến trong lập trình. Khác với Stack, Queue có nguyên lý hoạt động như tên gọi của nó First In First Out (Vào trước thì ra trước)

!![](assets/images/obsidian/Pasted image 20241210095255.png)


Ứng dụng
+ Máy in
+ Hàng đợi
+ Message queue


## Tại sao nên dùng LinkedList để implement thành Stack và Queue hơn Array ?

### Với Array
Khi thêm 1 item vào. cuối -> Độ phức tạp thường sẽ là O(1), tuy nhiên, trường hợp xâu nhất của JS (Trong JS Array là Dymanic Array, xem thêm >> [[Sự khác nhau giữa Static và Dynamic Arrays  là gì ?]]) sẽ tự động phân bổ lại bộ nhớ và khi thêm vào cuối của mảng (Worst case => O(n))

### Với Queue

Khi dequeue một phần tử đầu tiên (Xoá) sử dụng Array => Độ phức tạp là O(n) Vì các item array nếu xoá ở các phần tử đầu phải dịch chuyển lên trên


## Javascript là Garbage collected language ?

Là gì ?

## Xây dựng cấu trúc dữ liệu Stack sử dụng LinkedList



## Xây dựng cấu trúc dữ liệu Queue sử dụng LinkedList



## Reviews  Stack and Queue
!![](assets/images/obsidian/Pasted image 20241210144210.png)



---
## Liên quan

#algorithm #data-structure #stack-queue

---
*Nguồn: Evergreen/concept-base/technical/data-structure/Master Coding Interview/Stack & Queue/Stack và Queue là gì ?.md*