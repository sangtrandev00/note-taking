---
layout: post
title: "Thuật toán tìm kiếm trong lập trình (BFS, DFS)"
date: 2025-07-31 10:00:00 +0700
categories: concept-base technical algorithm Master Coding Interview Searching
tags: ["typescript", "algorithm"]
source_path: "Evergreen/concept-base/technical/algorithm/Master Coding Interview/Searching/Thuật toán tìm kiếm trong lập trình (BFS, DFS).md"
---
---
profileName: sangtrandev00
postId: 3369
postType: post
categories:
  - 39
---

## Thuật toán tìm kiếm tuyến tính
Thuật toán tìm kiếm tuyến tính khá đơn giản, đối tượng được tìm kiếm một cách tuần tự bằng cách lặp từ đầu đến cuối mảng. Độ phức tạp time complexity là O(n)

```Typescript
// Linear search
function linearSearch(array: number[], target: number): number {
  for (let i = 0; i < array.length; i++) {
    if (array[i] === target) {
      return i
    }
  }

  return -1
}

```

## Thuật toán tìm kiếm nhị phân 
Là thuật toán dùng kỹ thuật chi để trị. Mỗi lần tìm kiếm sẽ chia đôi độ dài của mảng. Ý tưởng của bài toán này khi một mảng đã được sắp xếp các phần tử. Tham khảo thuật toán được tích hợp bên dưới. Độ phức tạp timecomplexity là OlogN

```Typescript
// Function này chưa handle trường hợp duplicate element trong array!

export function binarySearch(array: number[], target: number): number {
  let left = 0

  let right = array.length - 1

  while (left <= right) {
    const middle = Math.floor((left + right) / 2)

    if (array[middle] === target) {
      return middle
    } else if (array[middle] < target) {
      // Target nằm bên phải

      left = middle + 1
    } else if (array[middle] > target) {
      // Target nằm bên trái

      right = middle - 1
    }
  }

  return -1
}

console.log(binarySearch([1, 2, 3, 4, 5, 6, 7, 8, 9, 10], 5))

```

## BFS và DFS là gì ?
là từ viết tắt của Breadth first search và Depth First Search ?
Hiểu đơn giản là một thuật toán lặp qua cây theo chiều ngang và lặp qua cây theo chiều sâu
## Breadth first search/ Traversal
Đi từ root node -> left -> right (Chiều ngang)

## Depth First Search/ Traversal 
Đi thật xa để trở về (Đi đến tận cùng của node đó, đi ngược lại tiếp tục node con tiếp theo)
Tìm kiếm theo chiều sâu. Bên dưới bài viết sẽ giải thích rõ hơn. Cơ bản có 3 cách tìm của DFS (InOrder, PreOrder, PostOrder)

## So sánh giữa BFS vs DFS

!![](assets/images/obsidian/Pasted image 20241214100833.png)
!![](assets/images/obsidian/Pasted image 20241214101248.png)


## Bài tập ứng dụng của DFS và BFS

//If you know a solution is not far from the root of the tree:
=> BFS
**Solution: BFS**
//If the tree is very deep and solutions are rare: 
=> DFS
**Solution: BFS**
(DFS sẽ rất chậm vì cây có độ sâu rất sâu)
//If the tree is very wide:
=> DFS
**Solution: DFS**
Vì BFS cần rất nhiều memory
//If solutions are frequent but located deep in the tree:
=> DFS
**Solution: DFS**
Giải thích:
//Determining whether a path exists between two nodes:
=> BFS
**Solution: DFS**
Giải thích: Tại sao nhỉ ?
Bởi vì có nhiều kỹ thuật lặp trong DFS (PreOrder, PostOrder, InOrder)
//Finding the shortest path:
=> BFS
**Solution: BFS**
Giải thích:

## Implement BFS (Breadth  first search) bằng code
Breadth dịch sang tiếng anh là chiều rộng (Tìm kiếm theo chiều rộng sang ngang)
```Typescript
class Node {
  left: Node | null

  right: Node | null

  value: number

  constructor(value: number) {
    this.left = null

    this.right = null

    this.value = value
  }
}

export class BinarySearchTree {
  root: Node | null

  constructor() {
    this.root = null
  }

  insert(value: number) {
    const newNode = new Node(value)

    if (this.root === null) {
      this.root = newNode
    } else {
      let currentNode = this.root

      while (true) {
        if (currentNode.value > value) {
          // Left

          if (!currentNode.left) {
            currentNode.left = newNode

            return this
          }

          currentNode = currentNode.left
        } else {
          // Right

          if (!currentNode.right) {
            currentNode.right = newNode

            return this
          }

          currentNode = currentNode.right
        }
      }
    }
  }

  lookup(value: number) {
    if (!this.root) {
      return false
    }

    let currentNode: Node | null = this.root

    while (currentNode) {
      if (currentNode.value > value) {
        // Left

        currentNode = currentNode.left
      } else if (currentNode.value < value) {
        // Right

        currentNode = currentNode.right
      } else if (currentNode.value === value) {
        return currentNode
      }
    }

    return false
  }

  remove(value: number) {
    if (!this.root) {
      return false
    }

    let currentNode: Node | null = this.root

    let parentNode = null

    while (currentNode) {
      if (value < currentNode.value) {
        parentNode = currentNode

        currentNode = currentNode.left
      } else if (value > currentNode.value) {
        parentNode = currentNode

        currentNode = currentNode.right
      } else if (currentNode.value === value) {
        //We have a match, get to work!

        //Option 1: No right child:

        if (currentNode.right === null) {
          if (parentNode === null) {
            this.root = currentNode.left
          } else {
            //if parent > current value, make current left child a child of parent

            if (currentNode.value < parentNode.value) {
              parentNode.left = currentNode.left

              //if parent < current value, make left child a right child of parent
            } else if (currentNode.value > parentNode.value) {
              parentNode.right = currentNode.left
            }
          }

          //Option 2: Right child which doesnt have a left child
        } else if (currentNode.right.left === null) {
          currentNode.right.left = currentNode.left

          if (parentNode === null) {
            this.root = currentNode.right
          } else {
            //if parent > current, make right child of the left the parent

            if (currentNode.value < parentNode.value) {
              parentNode.left = currentNode.right

              //if parent < current, make right child a right child of the parent
            } else if (currentNode.value > parentNode.value) {
              parentNode.right = currentNode.right
            }
          }

          //Option 3: Right child that has a left child
        } else {
          //find the Right child's left most child

          let leftmost = currentNode.right.left

          let leftmostParent = currentNode.right

          while (leftmost.left !== null) {
            leftmostParent = leftmost

            leftmost = leftmost.left
          }

          //Parent's left subtree is now leftmost's right subtree

          leftmostParent.left = leftmost.right

          leftmost.left = currentNode.left

          leftmost.right = currentNode.right

          if (parentNode === null) {
            this.root = leftmost
          } else {
            if (currentNode.value < parentNode.value) {
              parentNode.left = leftmost
            } else if (currentNode.value > parentNode.value) {
              parentNode.right = leftmost
            }
          }
        }

        return true
      }
    }
  }

  // Memory comsumption thì rất tệ! Vì phải lưu trữ queue

  breathFirstSearch() {
    let currentNode: any = this.root

    let list = []

    let queue = []

    queue.push(currentNode)

    while (queue.length > 0) {
      console.log(currentNode.value)

      currentNode = queue.shift() // O(n) => Queue để lưu trữ các node ở phía tước

      list.push(currentNode.value) // O(1)

      if (currentNode.left) {
        queue.push(currentNode.left) // O(1)
      }

      if (currentNode.right) {
        queue.push(currentNode.right) // O(1)
      }
    }

    return list
  }

  breathFirstSearchRecursive(queue: any[], list: number[]): number[] {
    // Base case

    if (queue.length === 0) {
      return list
    }

    let currentNode: any = queue.shift(). // Có thể thay thế bằng cách implment queue bằng linkedList

    list.push(currentNode.value) // O(1)

    if (currentNode.left) {
      queue.push(currentNode.left) // O(1)
    }

    if (currentNode.right) {
      queue.push(currentNode.right) // O(1)
    }

    // Recursive case

    return this.breathFirstSearchRecursive(queue, list)
  }
}

// 9

// 4 20

//1 6 15 170

const tree = new BinarySearchTree()

tree.insert(9)

tree.insert(4)

tree.insert(6)

tree.insert(20)

tree.insert(170)

tree.insert(15)

tree.insert(1)

tree.remove(170)

// JSON.stringify(traverse(tree.root));

// console.log(tree.lookup(20));

console.log(tree.breathFirstSearch())

console.log(tree.breathFirstSearchRecursive([tree.root], []))

```

## PreOrder, InOrder, PostOrder
Đây là các cách thức lặp qua tất cả node trong cây Tree
## Implement DFS  bằng code

```typescript
class Node {
  left: Node | null

  right: Node | null

  value: number

  constructor(value: number) {
    this.left = null

    this.right = null

    this.value = value
  }
}

export class BinarySearchTree {
  root: Node | null

  constructor() {
    this.root = null
  }

  insert(value: number) {
    const newNode = new Node(value)

    if (this.root === null) {
      this.root = newNode
    } else {
      let currentNode = this.root

      while (true) {
        if (currentNode.value > value) {
          // Left

          if (!currentNode.left) {
            currentNode.left = newNode

            return this
          }

          currentNode = currentNode.left
        } else {
          // Right

          if (!currentNode.right) {
            currentNode.right = newNode

            return this
          }

          currentNode = currentNode.right
        }
      }
    }
  }

  lookup(value: number) {
    if (!this.root) {
      return false
    }

    let currentNode: Node | null = this.root

    while (currentNode) {
      if (currentNode.value > value) {
        // Left

        currentNode = currentNode.left
      } else if (currentNode.value < value) {
        // Right

        currentNode = currentNode.right
      } else if (currentNode.value === value) {
        return currentNode
      }
    }

    return false
  }

  remove(value: number) {
    if (!this.root) {
      return false
    }

    let currentNode: Node | null = this.root

    let parentNode = null

    while (currentNode) {
      if (value < currentNode.value) {
        parentNode = currentNode

        currentNode = currentNode.left
      } else if (value > currentNode.value) {
        parentNode = currentNode

        currentNode = currentNode.right
      } else if (currentNode.value === value) {
        //We have a match, get to work!

        //Option 1: No right child:

        if (currentNode.right === null) {
          if (parentNode === null) {
            this.root = currentNode.left
          } else {
            //if parent > current value, make current left child a child of parent

            if (currentNode.value < parentNode.value) {
              parentNode.left = currentNode.left

              //if parent < current value, make left child a right child of parent
            } else if (currentNode.value > parentNode.value) {
              parentNode.right = currentNode.left
            }
          }

          //Option 2: Right child which doesnt have a left child
        } else if (currentNode.right.left === null) {
          currentNode.right.left = currentNode.left

          if (parentNode === null) {
            this.root = currentNode.right
          } else {
            //if parent > current, make right child of the left the parent

            if (currentNode.value < parentNode.value) {
              parentNode.left = currentNode.right

              //if parent < current, make right child a right child of the parent
            } else if (currentNode.value > parentNode.value) {
              parentNode.right = currentNode.right
            }
          }

          //Option 3: Right child that has a left child
        } else {
          //find the Right child's left most child

          let leftmost = currentNode.right.left

          let leftmostParent = currentNode.right

          while (leftmost.left !== null) {
            leftmostParent = leftmost

            leftmost = leftmost.left
          }

          //Parent's left subtree is now leftmost's right subtree

          leftmostParent.left = leftmost.right

          leftmost.left = currentNode.left

          leftmost.right = currentNode.right

          if (parentNode === null) {
            this.root = leftmost
          } else {
            if (currentNode.value < parentNode.value) {
              parentNode.left = leftmost
            } else if (currentNode.value > parentNode.value) {
              parentNode.right = leftmost
            }
          }
        }

        return true
      }
    }
  }

  // Memory comsumption thì rất tệ! Vì phải lưu trữ queue

  breathFirstSearch() {
    let currentNode: any = this.root

    let list = []

    let queue = []

    queue.push(currentNode)

    while (queue.length > 0) {
      console.log(currentNode.value)

      currentNode = queue.shift() // O(n) => Queue để lưu trữ các node ở phía tước

      list.push(currentNode.value) // O(1)

      if (currentNode.left) {
        queue.push(currentNode.left) // O(1)
      }

      if (currentNode.right) {
        queue.push(currentNode.right) // O(1)
      }
    }

    return list
  }

  breathFirstSearchRecursive(queue: any[], list: number[]): number[] {
    // Base case

    if (queue.length === 0) {
      return list
    }

    let currentNode: any = queue.shift()

    list.push(currentNode.value) // O(1)

    if (currentNode.left) {
      queue.push(currentNode.left) // O(1)
    }

    if (currentNode.right) {
      queue.push(currentNode.right) // O(1)
    }

    // Recursive case

    return this.breathFirstSearchRecursive(queue, list)
  }

  DFSInorder() {
    return this.traverseInOrder(this.root, [])
  }

  DFSPreorder() {
    return this.traversePreOrder(this.root, [])
  }

  DFSPostorder() {
    return this.traversePostOrder(this.root, [])
  }

  // 9

  // 4 20

  //1 6 15 170

  // InOrder - Left -> Root -> Right: [1, 4, 6, 9, 15, 20, 170]

  traverseInOrder(node: any, list: number[]) {
    // Đều sử dụng cấu trúc dữ liệu stack. Function nào gọi sau -> thì thực hiện trước!

    console.log(node.value)

    console.log(list)

    // Recursive case:

    if (node.left) {
      this.traverseInOrder(node.left, list)
    }

    list.push(node.value)

    if (node.right) {
      this.traverseInOrder(node.right, list)
    }

    // Base case ?

    return list
  }

  // PreOrder - Root -> Left -> Right: [9, 4, 1, 6, 20, 15, 170]

  traversePreOrder(node: any, list: number[]) {
    // Đều sử dụng cấu trúc dữ liệu stack. Function nào gọi sau -> thì thực hiện trước!

    console.log(node.value)

    console.log(list)

    list.push(node.value)

    // Recursive case:

    if (node.left) {
      this.traversePreOrder(node.left, list)
    }

    if (node.right) {
      this.traversePreOrder(node.right, list)
    }

    // Base case ?

    return list
  }

  traversePostOrder(node: any, list: number[]) {
    // Đều sử dụng cấu trúc dữ liệu stack. Function nào gọi sau -> thì thực hiện trước!

    console.log(node.value)

    console.log(list)

    // Recursive case:

    if (node.left) {
      this.traversePostOrder(node.left, list)
    }

    if (node.right) {
      this.traversePostOrder(node.right, list)
    }

    list.push(node.value)

    // Base case ?

    return list // Space complexity -> O(h) h: là chiều cao của cây nhị phân
  }
}

// 9

// 4 20

//1 6 15 170

// InOrder - Left -> Root -> Right: [1, 4, 6, 9, 15, 20, 170]

// PreOrder - Root -> Left -> Right: [9, 4, 1, 6, 20, 15, 170]

// PostOrder - Left -> Right -> Root: [1, 4, 6, 9, 15, 20, 170]

const tree = new BinarySearchTree()

tree.insert(9)

tree.insert(4)

tree.insert(6)

tree.insert(20)

tree.insert(170)

tree.insert(15)

tree.insert(1)

// tree.remove(170);

// JSON.stringify(traverse(tree.root));

// console.log(tree.lookup(20));

// console.log(tree.breathFirstSearch());

// console.log(tree.breathFirstSearchRecursive([tree.root], []));

// console.log(tree.DFSInorder());

// console.log(tree.DFSPreorder());

console.log(tree.DFSPostorder())

function traverse(node: Node | null) {
  if (!node) return null

  const tree: Node | null = { value: node.value, left: null, right: null }

  tree.left = node.left === null ? null : traverse(node.left)

  tree.right = node.right === null ? null : traverse(node.right)

  return tree
}


```


---

## Graph Traversals (Tác giả chữa nói rõ và giải thích kỹ phần này)
Đọc bài liên quan đến Graph [[Cấu trúc dữ liệu Graph]]]
https://visualgo.net/en/dfsbfs?slide=1
!![](assets/images/obsidian/Pasted image 20241214161941.png)
### BFS In Graph

!![](assets/images/obsidian/Pasted image 20241214162921.png)
Đường đi ngắn nhất (Bạn bè thân nhất trên linkedin, hàng hoá liên quan trên amazon, Facebook friend, Google maps)

Nodes nào gì gần nhất với node A ?

### DFS in Graphs
!![](assets/images/obsidian/Pasted image 20241214162901.png)

## Gợi nhớ đến các thuật toán gì ?

Đệ quy, huy hoạch động (Recursion, Backtracking)

## 2 thuật toán cần nhớ để tìm đường đi ngắn nhất

+ bellman-ford
+ dijkstra

## Liên quan

https://stackoverflow.com/questions/9844193/what-is-the-time-and-space-complexity-of-a-breadth-first-and-depth-first-tree-tr
https://visualgo.net/en/dfsbfs?slide=1
https://medium.com/basecs/finding-the-shortest-path-with-a-little-help-from-dijkstra-613149fbdc8e

#data-structure #algorithm #searching

---
*Nguồn: Evergreen/concept-base/technical/algorithm/Master Coding Interview/Searching/Thuật toán tìm kiếm trong lập trình (BFS, DFS).md*