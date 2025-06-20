---
layout: post
title: "Thuật toán sắp xếp và các loại thuật toán sắp xếp phổ biến"
date: 2025-08-03 10:00:00 +0700
categories: concept-base technical algorithm Master Coding Interview Sorting
tags: ["javascript", "typescript", "database", "algorithm"]
source_path: "Evergreen/concept-base/technical/algorithm/Master Coding Interview/Sorting/Thuật toán sắp xếp và các loại thuật toán sắp xếp phổ biến.md"
---
---
profileName: sangtrandev00
postId: 3354
postType: post
categories:
  - 39
---
Chắc hẳn trong đa số người học lập trình như chúng ta đã nghe qua về các thuật toán sắp xếp, chúng dường như xuất hiện rất nhiều trong các bài kiểm tra, phỏng vấn. Hôm nay mình sẽ dành thời gian ôn tập và cách tích hợp các loại thuật toán sắp xếp phổ biến nhất.

Yêu cầu trước khi đọc các thuật toán sắp xếp ở mức độ khó như merge sort hoặc quick sort bên dưới thì các bạn phải hiểu thế nào là recursion trước (bài viết đó ở đây >> [[Recursion (Đệ quy) là gì ? Giải thuật quan trọng trong lâp trình]]). Nếu đã học rồi thì các bạn cứ tiếp tục tận hưởng thôi!

Một điều nho nhỏ hơn để hiểu thuật toán như thế nào thì trong đầu mình phải có các. bước chạy của nó. https://visualgo.net/en/sorting là một trong những trang web rất hay để mô hình hoá các bước chạy tuần tự của các thuật toán phổ biến mà đặc biệt là các thuật toán merge. Hãy xem thật kỹ nó trước khi implement từng bước bằng code nhé!
## Các loại sắp xếp phổ biến

Bên dưới là các thuật toán sắp xếp phổ biến trong lập trình. Tuy nhiên hôm nay mình sẽ trình bày 5 thuật toán căn bản nhất cần phải biết (bubble, insertion, selection, merge, quick sort ) và một số thuật toán sort phụ đính kèm!
![assets/images/obsidian/Pasted image 20241213095939.png](https://trannhatsang.com/wp-content/uploads/2024/12/Pasted-image-20241213095939.png)
					https://www.bigocheatsheet.com/
### Bubble sort - Thuật toán sắp xếp nổi bọt

```Typescript
const numbers = [99, 44, 6, 2, 1, 5, 63, 87, 283, 4, 0]

export function bubbleSort(array: number[]) {
  //Code here

  const length = array.length

  for (let i = 0; i < length; i++) {
    for (let j = i + 1; j < length; j++) {
      if (array[i] > array[j]) {
        let temp = array[i]

        array[i] = array[j]

        array[j] = temp
      }
    }
  }

  return array
}

function bubbleSortV3(
  callback: (a: number, b: number) => number,
  array: number[]
) {
  //Code here

  //Code here

  const length = array.length

  for (let i = 0; i < length; i++) {
    for (let j = 0; j < length; j++) {
      if (callback(array[j], array[j + 1]) > 0) {
        let temp = array[j]

        array[j] = array[j + 1]

        array[j + 1] = temp
      }
    }
  }

  return array
}

export function bubbleSortV2(array: number[]) {
  //Code here

  const length = array.length

  for (let i = 0; i < length; i++) {
    for (let j = 0; j < length; j++) {
      if (array[j] > array[j + 1]) {
        let temp = array[j]

        array[j] = array[j + 1]

        array[j + 1] = temp
      }
    }
  }

  return array
}

// bubbleSort(numbers);

// bubbleSortV2(numbers);

bubbleSortV3((a, b) => b - a, numbers)

console.log(numbers)


```

### Insertion sort - Thuật toán sắp xếp chèn
```Typescript
const numbers = [99, 44, 6, 2, 1, 5, 63, 87, 283, 4, 0]

export function insertionSort(array: number[]) {
  //Code Here

  const length = array.length

  for (let i = 0; i < length; i++) {
    for (let j = i; j >= 0; j--) {
      // Trường hợp xấu nhất là lặp đến j = 0 => arrar[j - 1] là undefined => Vẫn đúng

      if (array[j] < array[j - 1]) {
        let temp = array[j]

        array[j] = array[j - 1]

        array[j - 1] = temp
      } else {
        break
      }
    }
  }

  return array
}

export function insertionSortCallback(
  array: number[],
  callback: (a: number, b: number) => number
) {
  //Code Here

  const length = array.length

  for (let i = 0; i < length; i++) {
    for (let j = i; j >= 0; j--) {
      if (callback(array[j], array[j - 1]) < 0) {
        let temp = array[j]

        array[j] = array[j - 1]

        array[j - 1] = temp
      } else {
        break
      }
    }
  }

  return array
}

// console.log(insertionSort(numbers));

console.log(insertionSortCallback(numbers, (a, b) => b - a))


```

### Selection sort - Thuật toán sắp xếp chọn

```Typescript
  

const numbers = [99, 44, 6, 2, 1, 5, 63, 87, 283, 4, 0]

export function selectionSort(array: number[]) {
  //Code Here

  const length = array.length

  for (let i = 0; i < length; i++) {
    let minIndex = i

    for (let j = i + 1; j < length; j++) {
      if (array[j] < array[minIndex]) {
        minIndex = j
      }
    }

    // Swap the found minimum element with the first element

    if (i !== minIndex) {
      let temp = array[i]

      array[i] = array[minIndex] // Thừa

      array[minIndex] = temp
    }
  }

  return array
}

export function selectionSortCallback(
  array: number[],
  callback: (a: number, b: number) => number
) {
  //Code Here

  const length = array.length

  for (let i = 0; i < length; i++) {
    let index = i

    for (let j = i + 1; j < length; j++) {
      if (callback(array[j], array[index]) < 0) {
        index = j
      }
    }

    if (index !== i) {
      let temp = array[i]

      array[i] = array[index]

      array[index] = temp
    }
  }

  return array
}

// console.log(selectionSort([99, 44, 6, 2, 1, 5, 63, 87, 283, 4, 0]));

// console.log(selectionSortCallback(numbers, (a, b) => b - a));


```

### Merge sort - Thuật toán sắp xếp trộn

Tại sao thuật toán sắp xếp này chỉ mất NLogN thời gian ?
logN đại điện cho chiều cao của cây 

Sau khi implement thuật toán merge sort mình đã hiểu ra tại sao lại như vậy. Quá trình code mình cũng có giải thích

```Typescript
const numbers = [99, 44, 6, 2, 1, 5, 63, 87, 283, 4, 0]

export function mergeSort(array: number[]): number[] {
  // Stop point (base case)

  if (array.length <= 1) {
    return array
  }

  // Split Array in into right and left

  // Split Array in into right and left

  const length = array.length

  const middle = Math.floor(length / 2)

  const left = array.slice(0, middle)

  const right = array.slice(middle)

  // Recursive point

  // Mỗi lần merge thì mất n

  return merge(
    mergeSort(left), // Chia đôi chiều dài của mảng để mảng đạt 1 phần tử tốn logN thời gian (logN lần lặp => Ví dụ mảng có 256 phần tử => Tốn log256 => tốn 8 lần chạy của hàm )

    mergeSort(right)
  )
}

// Lần 1: left: [99, 44, 6, 2, 1, 5], right: [63, 87, 283, 4, 0]

// Lần 1: return merge(mergeSort([99, 44, 6, 2, 1, 5]), mergeSort([ 63, 87, 283, 4, 0]))

// Lần 2: Chia nháp nhỏ ra

// Lần 3:

// Lần cuối: ta sẽ có merge của ( merge([item, item], [item]) hoặc merge([item], [item]))

// Vấn đề bây giờ nằm ở hàm merge (hàm con thôi! => Chia nhỏ thành bài toán merge 2 mảng đã sắp xếp => Thành một mảng tăng dần, với độ phức tạp nhỏ nhất)

export function merge(left: number[], right: number[]) {
  const result = []

  let leftIndex = 0

  let rightIndex = 0

  while (leftIndex < left.length && rightIndex < right.length) {
    if (left[leftIndex] < right[rightIndex]) {
      result.push(left[leftIndex])

      leftIndex++
    } else {
      result.push(right[rightIndex])

      rightIndex++
    }
  }

  return result.concat(left.slice(leftIndex)).concat(right.slice(rightIndex))
}

// console.log("merge([99, 44, 6, 2, 1, 5], [63, 87, 283, 4, 0])", merge([1, 2, 6, 12, 30], [4, 5, 12, 44]));

const answer = mergeSort(numbers)

console.log(answer)

```


### Quick sort - Thuật toán sắp xếp nhanh

Có khá nhiều cách để tích hợp quick sort tuỳ thuộc vào cách chúng ta chọn pivot (đỉnh) của array để so sánh 
![assets/images/obsidian/Pasted image 20241213163706.png](https://trannhatsang.com/wp-content/uploads/2024/12/Pasted-image-20241213163706.png)
Đây là một thuật toán khác phức tạp để implement, tham khảo code bên dưới
```Typescript
const numbers = [99, 44, 6, 2, 1, 5, 63, 87, 283, 4, 0]

// Chọn pivot 99

// Lần 1: 99 với 0 => swap 0 với 99 => [0, 99, 44, 6, 2, 1, 5, 63, 87, 283, 4]

// Lần 2: 99 với 4 => swap 4 với 99 => [0, 4, 99, 44, 6, 2, 1, 5, 63, 87, 283]

// Lần 3: 99 với 283 => Không thể swap

// Lần 4: 99 với 87 => Swap 87 với 99 => [0, 4, 87, 99, 44, 6, 2, 1, 5, 63, 283]

// Lần 5: 99 với 63 => Swap 63 với 99 => [0, 4, 87, 63, 99, 44, 6, 2, 1, 5, 283]

// ...

// Lần thứ n: 99 với .. => Swap với 99 => [0, 4, 87, 63, 5, 99, 44, 6, 2, 1, 283]

// Lần thứ n: 99 với .. => Swap với 99 => [0, 4, 87, 63, 5, 1, 99, 44, 6, 2, 283]

// Lần thứ n: 99 với .. => Swap với 99 => [0, 4, 87, 63, 5, 1, 2, 99, 44, 6, 283]

// Lần thứ n: 99 với .. => Swap với 99 => [0, 4, 87, 63, 5, 1, 2, 6, 44, 99 , 283]

function quickSort(array: number[], left: number, right: number) {
  const len = array.length

  let pivot

  let partitionIndex: number

  if (left < right) {
    pivot = right

    partitionIndex = partition(array, pivot, left, right)

    //sort left and right

    quickSort(array, left, partitionIndex - 1)

    quickSort(array, partitionIndex + 1, right)
  }

  return array
}

function partition(
  array: number[],
  pivot: number,
  left: number,
  right: number
): number {
  let pivotValue = array[pivot]

  let partitionIndex = left

  for (let i = left; i < right; i++) {
    if (array[i] < pivotValue) {
      swap(array, i, partitionIndex)

      partitionIndex++
    }
  }

  swap(array, right, partitionIndex)

  return partitionIndex
}

function swap(array: number[], firstIndex: number, secondIndex: number) {
  var temp = array[firstIndex]

  array[firstIndex] = array[secondIndex]

  array[secondIndex] = temp
}

//Select first and last index as 2nd and 3rd parameters

quickSort(numbers, 0, numbers.length - 1)

console.log(numbers)

```


## Như vậy thì thuật toán sort nào tốt nhất ?


Trả lời các câu hỏi ?
### Khi nào sử dụng insertion sort ?
Data thì ít, và lượng phần tử trong data gần như được sắp xếp, cần ít bộ nhớ

### Khi nào sử dụng bubble sort ?
Không bao giờ sử dụng =))) trong thực tế

### Khi nào sử dụng selection sort
Không bao giờ được sử dụng => Sử dụng trong giảng dạy

### Khi nào thì sử dụng merge sort ?
Tới bước này mình sẽ phân vân giữa quick sort và merge sort. 2 thuật toán gần như tương đương nhau về timecomplexity. Phải có chút tính toán so sánh ưu nhược.
- Phân vân về trường hợp xấu nhất của quick sort => chọn merge sort
- Phân vân về cần tối ưu memory (bộ nhớ) của merge sort => Chọn quick sort
### Thế còn heap sort thì sao ?
Đọc thêm ở đây
https://brilliant.org/wiki/heap-sort/
Trước tiên để hiểu heap sort chúng ta phải đọc qua cấu trúc dữ liệu tree. Cụ thể là Binary Search Tree [[Cấu trúc dữ liệu Trees trong khoa học máy tính (Chủ đề khó)]]

### Thế còn các thuật toán sort khác thì sao ? Cụ thể là Heap Radix sort và Counting sort
![assets/images/obsidian/Pasted image 20241213172114.png](https://trannhatsang.com/wp-content/uploads/2024/12/Pasted-image-20241213172114.png)

2 Thuật toán này còn được gọi là Non - Comparision Sort
=> Chỉ hiệu quả trên một tập hợp dữ liệu nhỏ và dữ liệu là một số nguyên (integer)
Đọc thêm về các thuật toán sort ở đây
https://brilliant.org/wiki/radix-sort/
https://www.cs.usfca.edu/~galles/visualization/RadixSort.html
https://brilliant.org/wiki/counting-sort/
https://www.cs.usfca.edu/~galles/visualization/CountingSort.html

## Bài tập sử dụng sorting trong các bài phỏng vấn

#1 - Sort 10 schools around your house by distance:
My Answer: any kind of sort above.
Solution: Insertion sort. Vì rất nhanh, dễ code, có thể danh sách trên gần được sort rồi!
#2 - eBay sorts listings by the current Bid amount:
My Answer: merge sort, quick sort
Solution: Radix or counting sort 
Giải thích: Vì bid amount thường nhỏ 1 -> 100$, là số, độ phức tạp O(n + k)
#3 - Sort scores on ESPN
My Answer: merge sort, quick sort
Solution: quick sort
Giải thích: Tập hợp data thường phức tạp, float number, rất nhiều điểm, thể loại để xử lý
#4 - Massive database (can't fit all into memory) needs to sort through past year's user data
My answer: quick sort
Solution: merge sort
Giải thích: Vì data rất lớn. Mà database lại quan tâm đến tốc độ => Quick sort có nhược điểm trường hợp xấu nhất có thể là ON^2

#5 - Almost sorted Udemy review data needs to update and add 2 new reviews
My Answer: insertion sort
Solution: insertion sort
Giải thích:
#6 - Temperature Records for the past 50 years in Canada
My Answer: merge sort, quick sort
Solution:
+ radix, counting sort (trường hợp nhiệt độ thì là số thực)
+ quick sort (tối ưu bộ nhớ, nhanh)

Giải thích: 
#7 - Large user name database needs to be sorted. Data is very random.
My Answer: merge sort, quick sort
**Solution: Quick sort**
Giải thích: Chọn được pivot tốt ?

#8 - You want to teach sorting for the first time!
bubble sort

==> Lưu ý về khi trả lời các câu hỏi dạng mở như thế này. Mình cứ dùng giống 15 bước giải quyết vấn đề để trả lời. Tất nhiên không cần dùng hết, chỉ giải thích lý do tại sao lại chọn là được phân tích, clearify, communication

## Fun Fact
### Javascript sử dụng thuật toán sort gì ?
Tuỳ thuộc vào trình duyệt (engine của trình duyệt: V8 chrome - quick sort | insertion sort (smaller array), Mozilla: merge sort )

---

## Liên quan

https://visualgo.net/en/sorting

#data-structure #algorithm #sorting

---
*Nguồn: Evergreen/concept-base/technical/algorithm/Master Coding Interview/Sorting/Thuật toán sắp xếp và các loại thuật toán sắp xếp phổ biến.md*