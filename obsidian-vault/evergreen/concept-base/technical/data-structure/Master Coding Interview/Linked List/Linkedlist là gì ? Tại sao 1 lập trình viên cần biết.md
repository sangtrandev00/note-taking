1 cấu trúc dữ liệu quan trọng là nền tảng để xây dựng các cấu trúc phức tạp sau này như Stack, Queue, Tree,... Linkedlist là một khái niệm mà mọi anh em lập trình như chúng ta phải biết để hiểu được các cấu trúc khó hơn khi học vào cấu trúc dữ liệu và giải thuật từ đó có một lượng kiến thức để giải quyết các bài toán lập trình. 

## What is LinkedList ? LinkedList là gì ?

Là cấu trúc dữ liệu cái mà node hiện tại sẽ liên kết đến một vùng nhớ của node tiếp theo

## Là nền tảng của các thuật toán nào ?

Hàm băm (hashtable)
Tree (Cấu trúc cây) ?
Stack, Queue (Ngăn xếp)
## What's type of ? Trong linkedlist thì có những loại nào ?

Có 2 loại chính là Single LinkedList và Doubly LinkedList. Một cái nữa là Circular LinkedList

![images/Pasted image 20241209170446.png](https://trannhatsang.com/wp-content/uploads/2024/12/Pasted-image-20241209170446.png)
## Con trỏ là gì ?

Là một vùng nhớ địa chỉ máy tính cái mà dùng để trỏ tới vùng nhớ khác.
Trong JS có khái niệm gọi là reference type và value type

## Cấu trúc của một Linkedlist  - Implement bằng code

### Single LinkedList
```ts

export class LinkedList {
    head: any
    tail: any
    length: number

    constructor(value: any) {
        this.head = {
            value: value,
            next: null,
        };
        this.tail = this.head;
        this.length = 1;
    }
    append(value: any) {
        const newNode = {
            value: value,
            next: null,
        };
        console.log(newNode);
        this.tail.next = newNode;
        this.tail = newNode;
        this.length++;
        return this;
    }
    prepend(value: any) {
        const newNode = {
            value: value,
            next: null,
        };
        newNode.next = this.head;
        this.head = newNode;
        this.length++;
        return this;
    }
    printList() {
        const array = [];
        let currentNode = this.head;
        while (currentNode !== null) {
            array.push(currentNode.value);
            currentNode = currentNode.next;
        }
        return array;
    }
    insert(index: number, value: any) {
        //Check for proper parameters;
        if (index >= this.length) {
            console.log("yes");
            return this.append(value);
        }

        const newNode = {
            value: value,
            next: null,
        };
        const leader = this.traverseToIndex(index - 1);
        const holdingPointer = leader.next;
        leader.next = newNode;
        newNode.next = holdingPointer;
        this.length++;
        return this.printList();
    }
    traverseToIndex(index: number) {
        //Check parameters
        let counter = 0;
        let currentNode = this.head;
        while (counter !== index) {
            currentNode = currentNode.next;
            counter++;
        }
        return currentNode;
    }
    remove(index: number) {
        // Check Parameters
        const leader = this.traverseToIndex(index - 1);
        const unwantedNode = leader.next;
        leader.next = unwantedNode.next;
        this.length--;
        return this.printList();
    }

    // Xem lại tại sao!
    reverse() {
        if (!this.head.next) {
            return this.head;
        }

        // Cái này có phải kỹ thuạt 2 con trỏ hay không ?
        let first = this.head;
        this.tail = this.head;
        let second = first.next;

        while (second) {
            const temp = second.next;
            second.next = first;
            first = second;
            second = temp;
        }

        // this.head.next = null; // Tác động lên đuôi tail .next = null
        this.tail.next = null; // Tác động lên đuôi tail .next = null
        this.head = first;
        return this.printList();
    }
}

let myLinkedList = new LinkedList(10);
myLinkedList.append(5);
myLinkedList.append(16);
myLinkedList.prepend(1);
myLinkedList.printList();
myLinkedList.insert(2, 99);
myLinkedList.insert(20, 88);
// myLinkedList.printList();
// myLinkedList.remove(2);

console.log(" myLinkedList.reverse();", myLinkedList.reverse())



```

### Doubly linkedList

```ts

class DoublyLinkedList {
    head: any;
    tail: any;
    length: number;

    constructor(value: any) {
        this.head = {
            value: value,
            prev: null,
            next: null,
        };
        this.tail = this.head;
        this.length = 1;
    }
    append(value: any) {
        const newNode = {
            value: value,
            prev: null,
            next: null,
        };
        newNode.prev = this.tail;
        this.tail.next = newNode;
        this.tail = newNode;
        this.length++;
        return this;
    }
    prepend(value: any) {
        const newNode = {
            value: value,
            prev: null,
            next: null,
        };
        newNode.next = this.head;
        this.head.prev = newNode;
        this.head = newNode;
        this.length++;
        return this;
    }
    printList() {
        const array = [];
        let currentNode = this.head;
        while (currentNode !== null) {
            array.push(currentNode.value);
            currentNode = currentNode.next;
        }
        return console.log(array);
    }
    insert(index: number, value: any) {
        //Check for proper parameters;
        if (index >= this.length) {
            console.log("yes");
            return this.append(value);
        }

        const newNode = {
            value: value,
            prev: null,
            next: null,
        };
        const leader = this.traverseToIndex(index - 1);
        const follower = leader.next;
        leader.next = newNode;
        newNode.prev = leader;
        newNode.next = follower;
        follower.prev = newNode;
        this.length++;
        return this.printList();
    }
    traverseToIndex(index: number) {
        //Check parameters
        let counter = 0;
        let currentNode = this.head;
        while (counter !== index) {
            currentNode = currentNode.next;
            counter++;
        }
        return currentNode;
    }
    remove(index: number) {
        // Check Parameters
        const leader = this.traverseToIndex(index - 1);
        const unwantedNode = leader.next;
        leader.next = unwantedNode.next;
        this.length--;
        return this.printList();
    }
}

let myLinkedList = new DoublyLinkedList(10);
myLinkedList.append(5);
myLinkedList.append(16);
myLinkedList.prepend(1);
myLinkedList.printList();
myLinkedList.insert(2, 99);
//   myLinkedList.insert(20, 88);
//   myLinkedList.remove(2);

```

## So sánh giữa LinkedList, Array, và Hashtable

![images/Pasted image 20241208211003.png](https://trannhatsang.com/wp-content/uploads/2024/12/Pasted-image-20241208211003.png)


## Review LinkedList

![images/Pasted image 20241210091940.png](https://trannhatsang.com/wp-content/uploads/2024/12/Pasted-image-20241210091940.png)

---

## Tóm tắt

LinkedList là cấu trúc dữ liệu rất quan trọng để xây dựng lên các cấu trúc khác sau này như Stack, Queue, Tree, Graph
Xem thêm về series [**cấu trúc dữ liệu và giải thuật**](https://trannhatsang.com/hoc-lap-trinh/cau-truc-du-lieu-va-giai-thuat/) của mình tại đây nhé!
Xem thêm bài viết gốc của mình tại đây:
https://trannhatsang.com/linkedlist-la-gi-tai-sao-can-dung-linkedlist