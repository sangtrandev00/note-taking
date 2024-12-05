---
profileName: sangtrandev00
postId: 3246
postType: post
categories:
  - 39
---
Trong khoa học máy tính nói chung và phần mềm nói riêng, để lập trình tạo ra những dòng code chất lương, chúng ta phải đi từ những khái niệm cơ bản nhất. Và BigO là khái niệm cần phải biết trước tiên khi bước vào từng cấu trúc giải thuật và dữ liệu! 
## BigO là gì ?

Là độ phức tạp của thuật toán, dùng để đánh giá, phân tích thuật toán có tối ưu hay không ? dựa vào giá trị gia tăng của số lượng biến đầu vào

Các dạng BigO phổ biến
- O(n): Linear time
- O(1): Constant time, là hằng số thời gian không thay đổi theo lượng input đầu vào
VD: có 100000 input item và 1 input item thì kết quả của thuật toán không khác nhau
- O(logN): Mỗi lần lặp sẽ giảm đi 1/2 thời gian
- O (n2): 2 vòng lặp lồng nhau

## Sự khác nhau giữa BigO, Big Omega, BigTheta notations ?

Dưới là 2 link mình đã tìm kiếm có giải thích kỹ lưỡng về sự khác nhau của 3 khái niệm
https://www.quora.com/What-is-the-difference-between-big-oh-big-omega-and-big-theta-notations

https://chatgpt.com/share/67511669-c008-8013-9f74-e212c9eda9d2

Khá khó giải thích bằng lời, nhưng để cho dễ tiếp cận mình sẽ giải thích sự khác nhau như sau:
- BigO: Trường hợp xấu nhất
- Big Omega: Trường hợp tốt nhất (best case)
- Big Theta: Trường hợp xấu nhất, tốt nhất, trung bình 

Ví dụ: về thuật toán linear search

`js
function linearSearch(arr, target) {
    for (let i = 0; i < arr.length; i++) {
        if (arr[i] === target) {
            return i;
        }
    }
    return -1;
}
- **Big-O (`O(n)`)**:
    - Worst-case:  We have to check all  elements.
    - Time complexity: O(n).
- **Big-Omega (`Ω(1)`)**:
    - Best-case:  We find it in 1 operation.
    - Time complexity: Ω(1).
- **Big-Theta (`Θ(n)`)**:
    - Average-case: On average, the element is found halfway through the array, requiring n/2 checks.
    - Time complexity: Θ(n)

## Làm thế nào để tính toán BigO ?

Dựa vào các rule sau đây:

### Rule 1: Luôn chọn trường hợp xấu nhất
### Rule 2: Xoá đi các constant

### Rule 3: Input khác nhau nên có các biến khác nhau

### Rule 4: Xoá đi những giá trị không chiếm ưu thế (non-dominant)

### Bài tập thực tế

VD 1: O(n2 + 3x + 100 + x/2)
BigO ở đây được tính như thế nào dựa vào 4 rule trên
Rule 1: Worse case n2
Rule 2: Xoá constant 100
Rule 3: Chỉ có 1 input là x
Rule 4: Xoá non-dominant: Xoá 3x + x/2

==> Giá trị thực tế BigO là O(n2)

## Điều gì tạo nên một đoạn code tốt ?

- Readable
- Scalable
	- Speed
	- Memorry

## Vocab

- arbitrary
	- Tuỳ ý
	- synonyms
- steepest
	- Dốc đứng, tốn kém nhất
- pillar
	- Trụ cột, mũi nhọn
	- synonyms:
		- column
		- post
		- pole
		- vertical
- tradeoff
	- Đánh đổi
	- remind ?
		- Đánh đổi giữa tốc độ và bộ nhớ (time and space complexity)

----
## Liên quan

https://www.bigocheatsheet.com/

#algorithm #data-structure #bigO