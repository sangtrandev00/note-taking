---
layout: post
title: "Bài tập chương 4"
date: 2026-02-26 10:00:00 +0700
categories: concept-base university semester01 IE107_ops-he-dieu-hanh practice
source_path: "Evergreen/concept-base/university/semester01/IE107_ops-he-dieu-hanh/practice/Bài tập chương 4.md"
---
# Lời giải Bài tập về Định thời CPU (Giải thích chi tiết)

## BÀI TẬP 1

Trước khi bắt đầu, chúng ta cần hiểu các khái niệm:

- **Arrival Time**: Thời điểm tiến trình vào hàng đợi sẵn sàng (Tiến trình xuất hiện trong hàng chờ Ready)
- **Burst Time**: Thời gian tiến trình cần CPU để hoàn thành
- **Waiting Time**: Thời gian tiến trình chờ trong hàng đợi sẵn sàng
- **Turnaround Time**: Tổng thời gian từ lúc tiến trình đến đến khi hoàn thành
- **Response Time**: Thời gian từ lúc tiến trình bắt đầu đến khi được CPU xử lý lần đầu

### 1. Giải thuật FCFS (First-Come, First-Served)

FCFS là giải thuật đơn giản nhất: "Ai đến trước được phục vụ trước". Tiến trình nào đến sớm nhất sẽ được thực thi trước.

**Bước 1:** Sắp xếp các tiến trình theo thời gian đến

- P1 (Arrival: 0, Burst: 10)
- P2 (Arrival: 2, Burst: 29)
- P3 (Arrival: 4, Burst: 3)
- P4 (Arrival: 5, Burst: 7)
- P5 (Arrival: 7, Burst: 12)

**Bước 2:** Thực hiện lần lượt từng tiến trình

- P1 bắt đầu tại t=0, kết thúc tại t=10
- P2 bắt đầu tại t=10, kết thúc tại t=39
- P3 bắt đầu tại t=39, kết thúc tại t=42
- P4 bắt đầu tại t=42, kết thúc tại t=49
- P5 bắt đầu tại t=49, kết thúc tại t=61

**Bước 3:** Vẽ giản đồ Gantt để trực quan hóa

```


0       10       39          42       49          61
 |--------|---------|----------|--------|-----------|
    P1        P2        P3        P4        P5

```


**Bước 4:** Tính các giá trị

- **Waiting Time (WT)** = Thời điểm bắt đầu - Thời điểm đến
- **Turnaround Time (TAT)** = Thời điểm kết thúc - Thời điểm đến
- **Response Time (RT)** = Thời điểm được xử lý lần đầu - Thời điểm đến

Ví dụ cho P3:

- WT = 39 - 4 = 35 (chờ 35 đơn vị thời gian)
- TAT = 42 - 4 = 38 (ở trong hệ thống 38 đơn vị thời gian)
- RT = 39 - 4 = 35 (chờ 35 đơn vị trước khi được xử lý lần đầu)

| Process | Arrival | Burst | Start | Finish | Waiting Time | Turnaround Time | Response Time |
| ------- | ------- | ----- | ----- | ------ | ------------ | --------------- | ------------- |
| P1      | 0       | 10    | 0     | 10     | 0            | 10              | 0             |
| P2      | 2       | 29    | 10    | 39     | 8            | 37              | 8             |
| P3      | 4       | 3     | 39    | 42     | 35           | 38              | 35            |
| P4      | 5       | 7     | 42    | 49     | 37           | 44              | 37            |
| P5      | 7       | 12    | 49    | 61     | 42           | 54              | 42            |

**Bước 5:** Tính giá trị trung bình

- Thời gian đợi trung bình = (0 + 8 + 35 + 37 + 42) / 5 = 24.4
- Thời gian đáp ứng trung bình = (0 + 8 + 35 + 37 + 42) / 5 = 24.4
- Thời gian lưu lại trung bình = (10 + 37 + 38 + 44 + 54) / 5 = 36.6

### 2. Giải thuật SJF Preemptive (Shortest Remaining Time First)

SJF Preemptive chọn tiến trình có "thời gian còn lại ngắn nhất". Nếu có tiến trình mới đến với thời gian ngắn hơn tiến trình đang chạy, tiến trình đang chạy sẽ bị dừng lại (preempt).

**Bước 1:** Theo dõi dần từng thời điểm quan trọng

- t=0: Chỉ có P1 (burst=10), nên P1 chạy
- t=2: P2 đến (burst=29), P1 vẫn chạy vì burst P1 < burst P2
- t=4: P3 đến (burst=3), P1 đã chạy được 4 đơn vị, còn lại 6 đơn vị. So sánh: burst P3 (3) < remaining P1 (6), nên P3 sẽ chạy, P1 bị dừng
- t=7: P3 hoàn thành. Kiểm tra xem tiến trình nào có remaining time nhỏ nhất. P1 còn 6, P2 còn 29, P4 có burst=7, P5 chưa đến. Chọn P1 chạy tiếp.
- t=13: P1 hoàn thành. Kiểm tra: P2 còn 29, P4 còn 7, P5 có burst=12. Chọn P4 chạy tiếp.
- t=20: P4 hoàn thành. Tiếp tục chọn tiến trình có remaining time nhỏ nhất là P5 (12) < P2 (29)
- t=32: P5 hoàn thành. Chỉ còn P2, nên P2 chạy đến khi kết thúc.
- t=61: P2 hoàn thành.

**Bước 2:** Vẽ giản đồ Gantt


```

0    4     7        13       20        32                 61
 |-----|-----|---------|---------|----------|---------------|
   P1    P3     P1        P4        P5            P2

```

**Bước 3:** Tính toán các giá trị

Ví dụ cho P4:

- Start Time = 13
- Finish Time = 20
- Waiting Time = 13 - 5 = 8 (thời gian từ lúc đến đến lúc bắt đầu được xử lý)
- Turnaround Time = 20 - 5 = 15 (thời gian từ lúc đến đến lúc hoàn thành)
- Response Time = 13 - 5 = 8 (thời gian đợi trước khi được xử lý lần đầu)

| Process | Arrival | Burst | Start | Finish | **Waiting Time** | Turnaround Time | Response Time |
| ------- | ------- | ----- | ----- | ------ | ------------ | --------------- | ------------- |
| P1      | 0       | 10    | 0, 7  | 13     | **0 + 0**        | 13              | 0             |
| P2      | 2       | 29    | 32    | 61     | **30**           | 59              | 30            |
| P3      | 4       | 3     | 4     | 7      | **0**            | 3               | 0             |
| P4      | 5       | 7     | 13    | 20     | **8**            | 15              | 8             |
| P5      | 7       | 12    | 20    | 32     | **13**           | 25              | 13            |

Thời gian waiting time = TAT - Burst  time

KHI nào thì ART = AWT ?
+ Không trưng dụng
Còn trưng dụng

**Bước 4:** Tính giá trị trung bình

- Thời gian đợi trung bình = (0 + 30 + 0 + 8 + 13) / 5 = 10.2
- Thời gian đáp ứng trung bình = (0 + 30 + 0 + 8 + 13) / 5 = 10.2
- Thời gian lưu lại trung bình = (13 + 59 + 3 + 15 + 25) / 5 = 23


*** Đáp án từ giảng viên

!![](assets/images/obsidian/Pasted image 20250319210906.png)


### 3. Giải thuật RR (Round Robin) với quantum time = 10

Round Robin chia đều thời gian CPU cho tất cả tiến trình. Mỗi tiến trình được cấp phát CPU trong khoảng thời gian quantum (10), sau đó được chuyển vào cuối hàng đợi.

**Bước 1:** Theo dõi dần theo thời gian

- t=0: P1 bắt đầu (burst=10)
- t=2: P2 đến và vào hàng đợi
- t=4: P3 đến và vào hàng đợi
- t=5: P4 đến và vào hàng đợi
- t=7: P5 đến và vào hàng đợi
- t=10: P1 dùng hết quantum (10) và cũng hoàn thành. Chọn P2 từ hàng đợi.
- t=20: P2 đã chạy 10 đơn vị, còn lại 19. Chuyển P2 vào cuối hàng đợi, chọn P3.
- t=23: P3 hoàn thành (burst=3). Chọn P4.
- t=30: P4 hoàn thành (burst=7). Chọn P5.
- t=40: P5 đã chạy 10 đơn vị, còn lại 2. Chuyển P5 vào cuối hàng đợi, chọn P2.
- t=50: P2 đã chạy thêm 10 đơn vị, còn lại 9. Chuyển P2 vào cuối hàng đợi, chọn P5.
- t=52: P5 hoàn thành. Chọn P2.
- t=61: P2 hoàn thành.

**Bước 2:** Vẽ giản đồ Gantt

Copy

 `0        10        20  23     30        40        50  52       61 |---------|----------|---|---------|----------|---|-----------|    P1        P2       P3    P4        P5       P5     P2`

**Bước 3:** Tính toán các giá trị

Ví dụ cho P2:

- Arrival Time = 2
- Burst Time = 29
- Start Time = 10
- Finish Time = 61
- Waiting Time = (10-2) + (52-50) = 10 (thời gian P2 chờ trước khi bắt đầu + thời gian P2 chờ sau khi bị preempt)
- Turnaround Time = 61 - 2 = 59
- Response Time = 10 - 2 = 8 (thời gian từ lúc đến đến lúc được xử lý lần đầu)

|Process|Arrival|Burst|Start|Finish|Waiting Time|Turnaround Time|Response Time|
|---|---|---|---|---|---|---|---|
|P1|0|10|0|10|0|10|0|
|P2|2|29|10|61|10|59|8|
|P3|4|3|20|23|16|19|16|
|P4|5|7|23|30|18|25|18|
|P5|7|12|30|52|33|45|23|

**Bước 4:** Tính giá trị trung bình

- Thời gian đợi trung bình = (0 + 10 + 16 + 18 + 33) / 5 = 15.4
- Thời gian đáp ứng trung bình = (0 + 8 + 16 + 18 + 23) / 5 = 13
- Thời gian lưu lại trung bình = (10 + 59 + 19 + 25 + 45) / 5 = 31.6

## Đáp án từ giảng viên
!![](assets/images/obsidian/Pasted image 20250319214003.png)


## BÀI TẬP 2

### 1. SJF Preemptive

Để giải thuật SJF Preemptive, chúng ta cần liên tục kiểm tra xem tại mỗi thời điểm có tiến trình nào đến có thời gian xử lý ngắn hơn tiến trình đang chạy không.

**Bước 1:** Theo dõi dần theo thời gian:

- t=0: P1 đến (burst=10), P1 bắt đầu chạy
- t=1: P2 đến (burst=3), so sánh: burst P2 (3) < remaining P1 (9), P1 bị preempt, P2 chạy
- t=2: P3 đến (burst=2), so sánh: burst P3 (2) < remaining P2 (2), P2 bị preempt, P3 chạy
- t=3: P4 đến (burst=1), so sánh: burst P4 (1) < remaining P3 (1), P3 bị preempt, P4 chạy
- t=4: P4 hoàn thành, P5 đến (burst=5), hiện tại: remaining P3=1, remaining P2=2, remaining P1=9; chọn P3 chạy tiếp
- t=5: P3 hoàn thành, chọn tiến trình có remaining ngắn nhất là P2, P2 chạy tiếp
- t=7: P2 hoàn thành, chọn P5 (5) thay vì P1 (9)
- t=12: P5 hoàn thành, P1 chạy nốt
- t=21: P1 hoàn thành

**Bước 2:** Vẽ giản đồ Gantt:

Copy

 `0  1  2  3  4  5     7        12               21 |--|--|--|--|--|-----|---------|---------------|  P1  P2  P3  P4  P3   P2        P5             P1`

**Bước 3:** Tính các giá trị:

| Process | Arrival | Burst | Start | Finish | Waiting Time  | Turnaround Time | Response Time |
| ------- | ------- | ----- | ----- | ------ | ------------- | --------------- | ------------- |
| P1      | 0       | 10    | 0, 12 | 21     | 12 - 1 = 11   | 21              | 0             |
| P2      | 1       | 3     | 1, 5  | 7      | (1-1)+(5-4)=1 | 6               | 0             |
| P3      | 2       | 2     | 2, 4  | 5      | (2-2)+(4-3)=1 | 3               | 0             |
| P4      | 3       | 1     | 3     | 4      | 0             | 1               | 0             |
| P5      | 4       | 5     | 7     | 12     | 3             | 8               | 3             |

**Bước 4:** Tính giá trị trung bình:

- Thời gian đợi trung bình = (11 + 1 + 1 + 0 + 3) / 5 = 3.2
- Thời gian lưu lại trung bình = (21 + 6 + 3 + 1 + 8) / 5 = 7.8

### 2. RR với quantum time = 2

**Bước 1:** Theo dõi dần theo thời gian

- t=0: P1 bắt đầu, dùng quantum 2
- t=1: P2 đến, vào hàng đợi
- t=2: P1 hết quantum, còn lại 8 đơn vị, vào cuối hàng đợi; P2 bắt đầu, P3 cũng đến và vào hàng đợi
- t=3: P4 đến, vào hàng đợi
- t=4: P2 hết quantum, còn lại 1 đơn vị, vào cuối hàng đợi; P3 bắt đầu, P5 đến và vào hàng đợi
- t=6: P3 hoàn thành; P4 bắt đầu
- t=7: P4 hoàn thành; P5 bắt đầu
- t=9: P5 hết quantum, còn lại 3 đơn vị, vào cuối hàng đợi; P1 tiếp tục với 8 đơn vị còn lại
- t=11: P1 hết quantum, còn lại 6 đơn vị, vào cuối hàng đợi; P2 tiếp tục với 1 đơn vị còn lại
- t=12: P2 hoàn thành; P5 tiếp tục với 3 đơn vị còn lại
- t=14: P5 hết quantum, còn lại 1 đơn vị, vào cuối hàng đợi; P1 tiếp tục với 6 đơn vị còn lại
- t=16: P1 hết quantum, còn lại 4 đơn vị, vào cuối hàng đợi; P5 tiếp tục với 1 đơn vị còn lại
- t=17: P5 hoàn thành; P1 tiếp tục với 4 đơn vị còn lại
- t=19: P1 hết quantum, còn lại 2 đơn vị, vào cuối hàng đợi; P1 tiếp tục (vì không còn tiến trình nào khác)
- t=21: P1 hoàn thành

**Bước 2:** Vẽ giản đồ Gantt

Copy

 `0    2     4     6  7     9     11 12    14    16 17    19    21 |----|-----|-----|--|------|-----|--|------|--|-------|------|   P1    P2    P3  P4   P5    P1   P2   P5   P5   P1     P1`

**Bước 3:** Tính các giá trị

Ví dụ cho P5:

- Arrival Time = 4
- Burst Time = 5
- Start Time = 7
- Finish Time = 17
- Waiting Time = (7-4) + (12-9) + (16-14) = 8 (thời gian đợi trước khi bắt đầu + thời gian đợi giữa các lần thực thi)
- Turnaround Time = 17 - 4 = 13
- Response Time = 7 - 4 = 3

|Process|Arrival|Burst|Start|Finish|Waiting Time|Turnaround Time|Response Time|
|---|---|---|---|---|---|---|---|
|P1|0|10|0,9,14,19|21|0 + (9-2) + (14-11) + (19-16) = 13|21|0|
|P2|1|3|2,11|12|(2-1) + (11-4) = 8|11|1|
|P3|2|2|4|6|4 - 2 = 2|4|2|
|P4|3|1|6|7|6 - 3 = 3|4|3|
|P5|4|5|7,12,16|17|(7-4) + (12-9) + (16-14) = 8|13|3|

**Bước 4:** Tính giá trị trung bình

- Thời gian đợi trung bình = (13 + 8 + 2 + 3 + 8) / 5 = 6.8
- Thời gian lưu lại trung bình = (21 + 11 + 4 + 4 + 13) / 5 = 10.6

### 3. Preemptive Priority (độ ưu tiên 1 > 2 > ...)

Trong giải thuật này, tiến trình có độ ưu tiên cao hơn sẽ được ưu tiên xử lý trước.

**Bước 1:** Theo dõi dần theo thời gian

- t=0: P1 đến (ưu tiên 3), P1 bắt đầu chạy
- t=1: P2 đến (ưu tiên 2), so sánh: 2 > 3, nên P1 bị preempt, P2 chạy
- t=2: P3 đến (ưu tiên 1), so sánh: 1 > 2, nên P2 bị preempt, P3 chạy
- t=4: P3 hoàn thành, P5 đến (ưu tiên 4), hiện tại có P1 (ưu tiên 3), P2 (ưu tiên 2), P4 (ưu tiên 2). Chọn P2 hoặc P4 (cùng ưu tiên), theo FCFS thì chọn P2
- t=7: P2 hoàn thành, chọn P4 (ưu tiên 2)
- t=8: P4 hoàn thành, chọn P1 (ưu tiên 3)
- t=18: P1 hoàn thành, chọn P5 (ưu tiên 4)
- t=23: P5 hoàn thành

**Bước 2:** Vẽ giản đồ Gantt

Copy

 `0  1  2     4     7  8               18              23 |--|--|-----|-----|--|---------------|---------------|  P1  P2  P3    P2   P4       P1             P5`

**Bước 3:** Tính các giá trị:

|Process|Arrival|Burst|Start|Finish|Waiting Time|Turnaround Time|Response Time|
|---|---|---|---|---|---|---|---|
|P1|0|10|0, 8|18|8 - 1 = 7|18|0|
|P2|1|3|1, 4|7|(1-1) + (4-2) = 2|6|0|
|P3|2|2|2|4|0|2|0|
|P4|3|1|7|8|4|5|4|
|P5|4|5|18|23|14|19|14|

**Bước 4:** Tính giá trị trung bình

- Thời gian đợi trung bình = (7 + 2 + 0 + 4 + 14) / 5 = 5.4
- Thời gian lưu lại trung bình = (18 + 6 + 2 + 5 + 19) / 5 = 10

## BÀI TẬP 3

Đối với bài tập 3, tôi sẽ giải chi tiết giải thuật FCFS.

### 1. FCFS

**Bước 1:** Sắp xếp các tiến trình theo thời gian đến

- P1 (Arrival: 0, Burst: 20)
- P5 (Arrival: 10, Burst: 35)
- P6 (Arrival: 15, Burst: 50)
- P3 (Arrival: 20, Burst: 25)
- P2 (Arrival: 25, Burst: 25)
- P4 (Arrival: 35, Burst: 15)

**Bước 2:** Thực hiện lần lượt từng tiến trình

- P1 bắt đầu tại t=0, kết thúc tại t=20
- P5 bắt đầu tại t=20, kết thúc tại t=55
- P6 bắt đầu tại t=55, kết thúc tại t=105
- P3 bắt đầu tại t=105, kết thúc tại t=130
- P2 bắt đầu tại t=130, kết thúc tại t=155
- P4 bắt đầu tại t=155, kết thúc tại t=170

**Bước 3:** Vẽ giản đồ Gantt

Copy

 `0        20        55        105       130       155       170 |---------|----------|----------|---------|---------|---------|    P1         P5         P6        P3        P2        P4`

**Bước 4:** Tính các giá trị

|Process|Arrival|Burst|Start|Finish|Waiting Time|Turnaround Time|Response Time|
|---|---|---|---|---|---|---|---|
|P1|0|20|0|20|0|20|0|
|P2|25|25|130|155|105|130|105|
|P3|20|25|105|130|85|110|85|
|P4|35|15|155|170|120|135|120|
|P5|10|35|20|55|10|45|10|
|P6|15|50|55|105|40|90|40|

**Bước 5:** Tính giá trị trung bình

- Thời gian đợi trung bình = (0 + 105 + 85 + 120 + 10 + 40) / 6 = 60
- Thời gian đáp ứng trung bình = (0 + 105 + 85 + 120 + 10 + 40) / 6 = 60
- Thời gian lưu lại trung bình = (20 + 130 + 110 + 135 + 45 + 90) / 6 = 88.3

## Quy luật chung và lời khuyên:

1. **FCFS (First-Come, First-Served)**:
    - Đơn giản nhất: ai đến trước, được phục vụ trước
    - Thứ tự thực hiện chỉ phụ thuộc vào thời gian đến
    - Thường không hiệu quả nếu có tiến trình lớn đến sớm
2. **SJF Preemptive (Shortest Remaining Time First)**:
    - Luôn chọn tiến trình có thời gian còn lại ngắn nhất
    - Phải liên tục kiểm tra khi có tiến trình mới đến
    - Thường cho thời gian đợi trung bình nhỏ nhất
3. **Round Robin (RR)**:
    - Mỗi tiến trình được cấp một lượng thời gian cố định (quantum)
    - Nếu tiến trình chưa hoàn thành sau quantum, nó sẽ được đưa vào cuối hàng đợi
    - Thời gian đáp ứng thường tốt cho các hệ thống tương tác
4. **Priority Scheduling**:
    - Tiến trình có độ ưu tiên cao nhất được thực hiện trước
    - Preemptive: Nếu có tiến trình mới đến có độ ưu tiên cao hơn, tiến trình đang chạy bị dừng
    - Có thể dẫn đến đói tài nguyên nếu không có cơ chế già hóa (aging)

### Mẹo khi làm bài tập:

1. **Xác định thứ tự xử lý các tiến trình** theo từng giải thuật.
2. **Vẽ giản đồ Gantt** để theo dõi trực quan.
3. **Tính thời gian đợi** = Thời điểm bắt đầu - Thời điểm đến (cộng thêm thời gian đợi giữa các lần xử lý nếu bị preempt).
4. **Tính thời gian lưu lại** = Thời điể




---
## Lưu ý

+ Làm bài tập tiểu trình chương 3
+ Hoàn thiện video chương **3,4,5 (2 module 1,2)**
+ Tuần tới sẽ kiểm ra giữa kỳ (Quan trọng chương 3,4) => Tự làm và giải thử các bài tập

---
*Nguồn: Evergreen/concept-base/university/semester01/IE107_ops-he-dieu-hanh/practice/Bài tập chương 4.md*