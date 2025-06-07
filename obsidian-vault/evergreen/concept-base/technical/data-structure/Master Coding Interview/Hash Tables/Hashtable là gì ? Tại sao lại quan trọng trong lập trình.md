
## Hash function ?

Được tích hợp bên dưới của các cấu trúc như Map <> , Object trong javascript khi tạo ra các key 

VD: const x = {'key': 100}; 'key' sẽ được hash function -> biến đổi thành một dãy bộ nhớ và lưu trữ trong memory


## Set trong Javascript có phải là một hashtable

https://chatgpt.com/share/675503ab-5eac-8013-9b26-ba15694408bc


## Hiện tượng Collisions - Sự va chạm trong HashTable ?
Xem visualization
https://www.cs.usfca.edu/~galles/visualization/OpenHash.html

![[Pasted image 20241208094254.png]]
Khái niệm này xảy ra khi một địa chỉ (như hình là 152) có thể lưu 2 giá trị. Cấu trúc dữ liệu để lưu 2 giá trị này là linkedList

Khi xảy ra hiện tượng collision trong việc lưu trữ giá trị như vậy. Nó sẽ xảy ra trường hợp xấu khi đọc và và thêm dữ liệu. Độ phức tạp lúc này có thể là O(n)


## Hashtable trong các ngôn ngữ lập trình


## Cách điều chỉnh Size trong Hashtable ?


## So sánh giữa Hashtable và Arrays

![[Pasted image 20241208115947.png]]

Sự khác nhau Hashtable và array. Hashtable lưu trữ các giá trị khong theo một thứ tự nào trong bộ nhớ cả.


## Tóm tắt lại về Hashtable
![[Pasted image 20241208162948.png]]


### Lý do slow key iteration ?
Bởi vì chúng ta phải lặp qua hết các buket, kể cả bucket đó không tồn tại giá trị mà ta cần!
## Lưu ý
Keywords
- collision
- bucket
---
## Liên quan
#algorithm #data-structure #hash-table #map #object