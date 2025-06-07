---
layout: post
title: "Bài test với 3 câu hỏi đầu vào của công ty Unitysport"
date: 2025-12-26 10:00:00 +0700
categories: concept-base technical interview unitysport
tags: ["nodejs", "nestjs", "interview", "backend"]
source_path: "Evergreen/concept-base/technical/interview/unitysport/Bài test với 3 câu hỏi đầu vào của công ty Unitysport.md"
---
---
profileName: sangtrandev00
postId: 3531
postType: post
categories:
  - 39
---
Trong quá trình phỏng vấn tìm việc cuối năm ở vị trí Junior Backend, mình có tham gia phỏng vấn apply tại công ty thể thao và công nghệ UnitySport. Mình được gửi một bài test kèm 3 câu hỏi giải thuật cơ bản. Các câu hỏi giải thuật tuy không khó nhưng bí quyết là phải biết cách trình bày và giải thích, đó là bước tiền đề để mình được process các vòng sau. Hãy theo dõi bài viết để biết thêm chi tiết nhé
## Đề bài test 
### 1. Thuật toán kiểm tra chuỗi đối xứng.

Cho một chuỗi s, viết một thuật toán để kiểm tra xem chuỗi đó có phải là chuỗi đối xứng hay không. Một chuỗi đối xứng là chuỗi có thứ tự ký tự giống nhau 
khi đọc từ trái sang phải và từ phải sang trái. Ví dụ: "radar" và "level" là các chuỗi đối xứng.

Đầu Vào
    Một chuỗi s chứa các ký tự chữ cái, chữ số và ký tự đặc biệt (0 ≤ độ dài của s ≤ 10^5).
Đầu Ra
    Trả về true nếu chuỗi s là chuỗi đối xứng, ngược lại trả về false.

Ví Dụ
    Ví Dụ 1:
        Input: "level"
        Output: true
        Giải Thích: "level" đọc từ trái sang phải và từ phải sang trái đều giống nhau.
    Ví Dụ 2:
        Input: "hello"
        Output: false
        Giải Thích: "hello" không giống nhau khi đọc từ hai chiều.

### 2. Bài toán Two Sum

Mô Tả
    Cho một mảng số nguyên nums và một số nguyên target, hãy tìm tất cả các cặp chỉ số của hai số trong mảng mà tổng của chúng bằng target. Giả định rằng có thể có nhiều cặp thỏa mãn điều kiện này, và bạn cần trả về tất cả các cặp chỉ số khác nhau.

Đầu Vào
    Một mảng số nguyên nums với độ dài n (1 ≤ n ≤ 10^4) chứa các số nguyên. Các số trong mảng có thể là số dương, số âm hoặc số không.
    Một số nguyên target (−10^9 ≤ target ≤ 10^9) là tổng mà bạn cần tìm.
Đầu Ra
    Trả về một mảng hai chiều chứa tất cả các cặp chỉ số (i, j) (0 ≤ i < j < n) sao cho nums[i] + nums[j] == target.
    Nếu không tìm thấy cặp nào, hãy trả về mảng rỗng.
Điều Kiện
    Không sử dụng cùng một phần tử hai lần để tạo thành tổng.
    Các chỉ số trong các cặp trả về phải là duy nhất và không trùng lặp.
    Thứ tự của các cặp trong kết quả không quan trọng.


Ví Dụ
    Ví Dụ 1:

        Input:
            nums = [2, 7, 11, 15]
            target = 9
        Output:
            [[0, 1]]

        Giải Thích: Bởi vì nums[0] + nums[1] == 2 + 7 == 9, trả về cặp chỉ số [0, 1].

    Ví Dụ 2:

        Input:
            nums = [3, 2, 4, 3]
            target = 6
        Output:
            [[1, 2], [0, 3]]
            
        Giải Thích: Cả hai cặp [2, 4] (tại chỉ số [1, 2]) và [3, 3] (tại chỉ số [0, 3]) đều có tổng bằng 6.

### 3. Compress file data.json để đạt được file size là nhỏ nhất có thể
Điều kiện câu số 3:  Không sử dụng bất kỳ thư viện nào

## Quy định

+ Nội dung bài test : File đính kèm bên trên
+ Hình thức nộp bài: Gửi lại link github hoặc gitlab 
+ Thời gian nộp bài: Trước 18h00 ngày 17/12/2024
+ Điều kiện câu số 3:  Không sử dụng bất kỳ thư viện nào
+ Có thể thêm một video giải thích, thuyết minh bài làm sẽ là một điểm cộng

## Video giải thích cách làm
[![Tran Nhat Sang](https://img.youtube.com/vi/Zzeme36W-0Y/0.jpg)](https://youtu.be/Zzeme36W-0Y)

---
## Liên quan
Source code mình đã giải ở đây
https://github.com/sangtrandev00/unity-sport-junior-dev-test

#nestjs #interview #nodejs

---
*Nguồn: Evergreen/concept-base/technical/interview/unitysport/Bài test với 3 câu hỏi đầu vào của công ty Unitysport.md*