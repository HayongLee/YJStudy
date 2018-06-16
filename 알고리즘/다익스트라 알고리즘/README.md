# 다익스트라 알고리즘


* [최단 경로(Shortest Path)](#최단-경로shortest-path)
* [다익스트라 알고리즘(Dijkstra's Algorithm)](#다익스트라-알고리즘dijkstras-algorithm)
* [다익스트라 알고리즘 구현](#다익스트라-알고리즘-구현)


&nbsp;
## 최단 경로(Shortest Path)
그래프 이론에서 최단 경로 알고리즘은 출발지에서 목적지까지 이동하기 위한 최소 비용의 노드 이동 경로를 찾는 알고리즘이다.
* 맵 루핑 애플리케이션에서 사용돼 왔으며, 전체 경로의 가중치를 최소화하는 방법으로 지점 A에서 지점 B로 이동하기 위한 가장 빠른 길을 찾도록 도와준다.


&nbsp;
## 다익스트라 알고리즘(Dijkstra's Algorithm)
다익스트라 알고리즘은 음수가 없는, 가중치 적용 방향성 그래프이다.


알고리즘은 두 개 노드 사이의 최단 경로를 찾는 것이지만. 이를 응용해서 출발 지점에서 그래프 내의 모든 노드에 도달하기 위한 최단 경로를 찾을 수 있다. 이를 바로 최단 경로 트리(shortest path tree)라 부른다.


&nbsp;
### 구현 절차
1. 알고리즘은 먼저, 첫 번째 노드를 현재 노드로 표시한다. 그리고 나머지 모든 노드를 미방문 세트에 저장한다. 노드를 저장하면서 임시 거리를 무한 또는 최댓값으로 초기화 한다.


![구현 절차1]()


2. 현재 노드의 모든 미방문 이웃에 대해 임시 거리를 계산해서 현재 노드와 다른 모든 이웃 노드와의 경로에 따른 거리의 합, 모서리 가중치의 합을 파악한다. 그리고 그 결과값이 현재 노드의 거리보다 작으면, 현재 노드의 거리를 새로운 값으로 대체한다(최단 경로를 찾음).


![구현 절차2]()


3. 현재 노드를 미방문 노드 세트에서 제거한다.
4. 목적 노드에 방문 표식이 남겨졌다면, 알고리즘을 종료한다.
5. 목적 노드에 방문 표식이 남겨지지 않았다면, 현재 노드를 임시 최단 거리의 미방문 노드 세트에 추가하고 2단계를 반복한다.


![구현 절차3]()


&nbsp;
## 다익스트라 알고리즘 구현
#### DijkstraNode
```
public class DijkstraNode<T: Equatable & Hashable>: Equatable {
    public var value: T
    public var edges: [DijkstraEdge<T>]
    public var visited: Bool

    // 출발 지점에서 현재 노드에 이르는 최단거리
    public var distance = Int.max

    // 최단 경로에 이르는 기존의 노드
    public var previous: DijkstraNode<T>?

    public init(value: T, edges: [DijkstraEdge<T>], visited: Bool) {
        self.value = value
        self.edges = edges
        self.visited = visited
    }
}

public func ==<T: Equatable>(lhs: DijkstraNode<T>, rhs: DijkstraNode<T>) -> Bool {
    guard lhs.value == rhs.value else {
        return false
    }
    return true
}

extension DijkstraNode: Hashable {
    public var hashValue: Int {
        get {
            return value.hashValue
        }
    }
}
```


* 다익스트라 알고리즘에서는 미방문 노드를 저장하기 위해 Set을 사용한다. 이를 위해서는 먼저 노드에 Hashable, 그리고 Equatable 프로토콜을 적용한다.
* 각 노드에 이르는 임시 거리를 계산하기 위해 distance 변수를 Int.max로 초기화 한다. 이는 다익스트라 알고리즘에서 사용하는 무한값에 가까운 의미를 지닌다.
* 각 노드에 이르는 경로를 각 노드의 최단 경로로 저장해야 하므로, previous라는 변수를 추가한다.


#### DijkstraEdge
```
public class DijkstraEdge<T: Equatable & Hashable>: Equatable {
    public var from: DijkstraNode<T>
    public var to: DijkstraNode<T>
    public var weight: Double

    public init(weight: Double, from: DijkstraNode<T>, to: DijkstraNode<T>) {
        self.weight = weight
        self.from = from
        self.to = to
        from.edges.append(self)
    }
}

public func ==<T: Equatable>(lhs: DijkstraEdge<T>, rhs: DijkstraEdge<T>) -> Bool {
    guard lhs.from.value == rhs.from.value else {
        return false
    }
    guard lhs.to.value == rhs.to.value else {
        return false
    }
    return true
}

extension DijkstraEdge: Hashable {
    public var hashValue: Int {
        get {
            let stringHash = "\(from.value)->\(to.value)"
            return stringHash.hashValue
        }
    }
}
```


#### DikstraGraph
```
public class DijkstraGraph<T: Hashable & Equatable> {
    public var nodes: [DijkstraNode<T>]
    public init(nodes: [DijkstraNode<T>]) {
    self.nodes = nodes
}

// 다이스트라 알고리즘
public static func dijkstraPath(startNode: DijkstraNode<T>, graph: DijkstraGraph<T>, finishNode: DijkstraNode<T>) {
    // 모든 미방문 노드를 저장하기 위한 세트를 생성
    var unvisitedNodes = Set<DijkstraNode<T>>(graph.nodes)

    // 시작 노드에 임시 거리로 0을 입력
    startNode.distance = 0

    // 현재 노드에 할당
    var currentNode = startNode

    // 마지막 노드를 방문할 때까지 반복함
    while finishNode.visited == false {
        // 각각의 미방문 이웃에 대해, 현재 노드와의 거리를 계산
        for edge in currentNode.edges.filter({ (edge) -> Bool in
            return edge.to.visited == false
        }) {
            // 현재 노드와 그 이웃 노드의 임시 거리를 계산
            let temporaryDistance = currentNode.distance + Int(edge.weight)

            // 임시 거리가 현재 이웃과의 거리보다 작으면,
            // 임시거리로 업데이트함
            if edge.to.distance > temporaryDistance {
                edge.to.distance = temporaryDistance
                edge.to.previous = currentNode
            }
        }
        // 노드에 방문 표식을 남김
        currentNode.visited = true

        // 미방문 노드 세트에서 현재 노드를 삭제
        unvisitedNodes.remove(currentNode)

        if let newCurrent = unvisitedNodes.sorted(by: { (nodeA, nodeB) -> Bool in
            nodeA.distance < nodeB.distance
        }).first {
            currentNode = newCurrent
        } else {
            break
        }
    }
    DijkstraGraph.printShortestPath(node: finishNode)
    print()
}

public static func printShortestPath(node: DijkstraNode<T>) {
    if let previous = node.previous {
        DijkstraGraph.printShortestPath(node: previous)
    } else {
        print("Shortest path:")
    }
        print("->\(node.value)", terminator: "")
    }
}
```


dijkstraPath 메서드는 다음과 같은 절차에 따라 최단 경로를 찾는다:
1. 미방문 노드 세트를 생성 (노드를 초기화 하면서 무한값을 거리로 설정함)
2. 현재 노드를 초기 노드로 설정한다.
3. 각각의 미방문 이웃에 다다르기 위한 최단 거리를 업데이트한다. 업데이트를 마치면, 기존의 노드 또한 업데이트해서 현재 노드에 이르기 위한 최단 경로를 추적하고, 현재의 노드에 방문 표식을 남긴다.
4. 거리값이 가장 낮은 다음 노드로 이동한 뒤, 마지막 노드를 방문할 때까지 3번 과정을 반복한다.
5. 마지막 노드에서 시작하는 최단 경로를 출력한다.
    
    
&nbsp;
&nbsp;      
### [by. 0junChoi](https://github.com/0jun0815) email: <0jun0815@gmail.com>
### 출처: [스위프트 데이터 구조와 알고리즘](http://acornpub.co.kr/book/swift-structure-algorithms)
