

Là sự kết hợp giữa Tree và LinkedList ?
LinkedList < Tree < Graph
## Đỉnh (Vertex - node, point)


## Cạnh (Edge - link, line)


## Remind me ?

Ứng dụng Graph để xây family tree cho gia đình mình được không ? ==> Thử
Social Network.
Liên kết các thành phố với nhau ?
Google Maps => Graphs (Shortest path). Tính toán đường đi ngắn nhất
Graph có thể ứng dụng vào blockchain ?

## Các loại của Graphs



### Directed  (Có định hướng) là gì ?

### Undirected (Không định hướng) là gì ?

### Weighted (Có trọng số)

### UnWeighted (Không có trọng số)

### Cyclic ? (Có thể thành một vòng tròn - Đi vòng ngược lại đỉnh)

### Acylic ? (Không thể quay ngược lại từ điểm xuất phát)

## Cách implemenet Graph bằng code

```Typescript
export class Graph {
  numberOfNodes: number

  adjacentList: any

  constructor() {
    this.numberOfNodes = 0

    this.adjacentList = {
      // Example: '0': ['1', '2]
    }
  }

  addVertex(node: string) {
    if (!this.adjacentList[node]) {
      this.adjacentList[node] = []

      this.numberOfNodes++
    }
  }

  addEdge(node1: string, node2: string) {
    //undirected Graph

    if (this.adjacentList[node1] && this.adjacentList[node2]) {
      if (this.adjacentList[node1].indexOf(node2) === -1) {
        this.adjacentList[node1].push(node2)
      }

      if (this.adjacentList[node2].indexOf(node1) === -1) {
        this.adjacentList[node2].push(node1)
      }
    }
  }

  showConnections() {
    const allNodes = Object.keys(this.adjacentList)

    for (let node of allNodes) {
      let nodeConnections = this.adjacentList[node]

      let connections = ""

      let vertex

      for (vertex of nodeConnections) {
        connections += vertex + " "
      }

      console.log(node + "-->" + connections)
    }
  }
}

const myGraph = new Graph()

myGraph.addVertex("0")

myGraph.addVertex("1")

myGraph.addVertex("2")

myGraph.addVertex("3")

myGraph.addVertex("4")

myGraph.addVertex("5")

myGraph.addVertex("6")

myGraph.addEdge("3", "1")

myGraph.addEdge("3", "4")

myGraph.addEdge("4", "2")

myGraph.addEdge("4", "5")

myGraph.addEdge("1", "2")

myGraph.addEdge("1", "0")

myGraph.addEdge("0", "2")

myGraph.addEdge("6", "5")

myGraph.showConnections()

//Answer:

// 0-->1 2

// 1-->3 2 0

// 2-->4 1 0

// 3-->1 4

// 4-->3 2 5

// 5-->4 6

// 6-->5

```

## Review Graph

![[Pasted image 20241212103436.png]]

## Lưu ý
Chúng ta sẽ không bao giờ tự build một product mà implmenet graph từ đầu cả. Tốn nhiều nguồn lực, chúng ta có website có sẵn Neo4J (Graph Database)
Điều này làm mình gợi nhớ đến 1 chuẩn API ? GraphQL ? Liệu nó có liên quan đến CTDL Graph hay không nhỉ ?

--- 
## Liên quan

#algorithm #data-structure #graph