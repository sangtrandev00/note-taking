Chủ đề cây và ứng dụng của các cây không phải dễ ngấm ngay từng lần học đầu tiên. Tuy nhiên vẫn nên giữ keyword để các lần sau trở lại học một cách nhanh chóng hơn!

![[Pasted image 20241210144729.png]]

## Tại sao cấu trúc dữ liệu trees lại quan trọng ?

DOM => trees
Chess
Comments 

## Sự khác nhau giữa LinkedList và Trees là gì ?

Node can point to child ?

## Có bao nhiêu loại biến thể của cấu trúc dữ liệu Trees. Loại nào là quan trọng nhất!



## Binary trees

Dấu hiệu ?
![[Pasted image 20241210152642.png]]

### Các loại Binary Trees

![[Pasted image 20241210153151.png]]

- Đặc điểm của perfect binary
	- 1 X 2 X 4 X 8 (Số lượng node ở các level kế = gấp đôi ở level trước)
	- Số lượng node ở level kế bằng tổng số lượng node ở các level trước + 1

![[Pasted image 20241210153712.png]]

- Số lương nodes trong một cây hiện tại = 2 ^ h - 1
	- h: Chiều cao của cây
- Chiều cao = log số lượng node.
	- Ví dụ: Có 8 nodes => Cây có chiều cao là 3
	- Số lượng bước tối đa chúng ta có thể traverse (di chuyển) là 3
		- => Độ phức tạp của thuật toán dựa trên chiều cao để tìm kiếm LogN.
		- Ví dụ: Có 100 nodes => O(n) = Log100 = 10 bước tìm kiếm tối đa để tìm được giá trị mình cần.

## Binary Search Tree là gì ?

![[Pasted image 20241210160235.png]]


Rule ?
+ Tất cả giá trị từng node bên phải phải lớn hơn node bên trái
+ 

### Các loại của Binary Search Tree

#### Unbalance Tree


#### Balance Tree


## Tại sao Unbalance Binary Search Tree thì tệ ?


## Cách để balance một cái cây ?

=> Có thư viện hỗ trợ => Học cách để hiểu ý tưởng này!
- AVL tree
- Red Black Trees


## Điểm mạnh và điểm yếu Binary Search Tree

![[Pasted image 20241210161441.png]]



## Yếu tố gì giúp Binary Search Tree mạnh hơn các cấu trúc như Array và Hashtable ?



## 2 Loại cây phổ biến khác

### Heap
![[Pasted image 20241211104327.png]]

=> Min Heap, Max Heap ?

#### Tại sao lại muốn sử dụng Binary Heap trong khi lookup mất O(n) thời gian ?
=> Rất hữu dụng trong việc so sánh (các phép toán so sánh)

![[Pasted image 20241211105326.png]]

Chú ý giữa memore heap khác với Heap Data structure ở đây. Có thể bị nhầm lẫn

#### Chú ý giữa Priority Queue và Queue. Cần phân biệt sự khác nhau
=> Ví dụ thực tế là một thẻ VIP trong một bar club. Không nhất thiết phải xếp hàng trước -> vào trước.
=> Ví dụ trong sân bay. Hành khách xếp hàng -> nhưng cơ trưởng đến sau và lên trước để khởi động và lái máy bay. Tiếp viên hàng không -> Đến trước 

#### Cách implement một Priority Queue ?




### Trie
Ứng dụng Search Text
Auto completion (Của Ant Design)
Search Words in Dictionary

## Review Binary Search Tree
![[Pasted image 20241211111127.png]]