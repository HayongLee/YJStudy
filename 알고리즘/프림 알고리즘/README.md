# 프림 알고리즘


* [프림 알고리즘(Prim's Algorithm)](#프림-알고리즘prims-algorithm)
* [프림 알고리즘 구현](#프림-알고리즘-구현)


&nbsp;
## 프림 알고리즘(Prim's Algorithm)
프림 알고리즘은 무방향성 연결 그래프를 이용해서 선형 시간 내에 MST를 계산하기 위해 만들어졌다. 


가중치가 있는 무방향성 연결 그래프의 모든 꼭지점을 포함하면서 각 변의 비용의 합이 최소가 되는 부분 그래프인 트리 즉, 최소 신장 트리(MST)를 찾는 알고리즘이다.


그래프의 MST를 계산하기 위한 또 다른 알고리즘인 Kruskal, Boruvka 알고리즘 초기 그래프로 무방향성 연결 그래프가 아닌 포레스트(forest)를 사용한다.


예제를 통해 프림 알고리즘의 작동 원리에 대해 알아보자:


![무방향성 연결 그래프의 초기 모습](https://github.com/0jun0815/YJStudy/blob/master/알고리즘/프림%20알고리즘/images/무방향성%20연결%20그래프의%20초기%20모습.jpeg)


* MST 계산 절차는 다음과 같다:
    1. 그래프에서 임의의 꼭지점을 출발 위치로 선택한다. (꼭지점 A에서 출발)
    2. 선택된 노드에 연결된 모서리에서 아직 방문하지 않았고, 가중치가 최소인 것을 선택한다. (A에서 C로 이동하고, C에서 방문 표식을 남긴 뒤 MST 속에 해당 모서리 정보를 저장)
    3. 가장 최근 방문 표식이 있는 노드에서 출발한다. (C)
    4. 이와 같은 절차를 그래프의 모든 꼭지점을 대상을 시행한다.
    
    
![프림 알고리즘](https://github.com/0jun0815/YJStudy/blob/master/알고리즘/프림%20알고리즘/images/프림%20알고리즘.jpeg)


&nbsp;
## 프림 알고리즘 구현
```
public class MSTNode<T: Equatable & Hashable> {
    // 값, 모서리 참조, 방문 상태 변수
    public var value: T
    public var edges: [MSTEdge<T>]
    public var visited: Bool

    public init(value: T, edges: [MSTEdge<T>], visited: Bool) {
        self.value = value
        self.edges = edges
        self.visited = visited
    }
}
```
```
public class MSTEdge<T: Equatable & Hashable>: Equatable {
    public var from: MSTNode<T>
    public var to: MSTNode<T>
    public var weight: Double

    public init(weight: Double, from: MSTNode<T>, to: MSTNode<T>) {
        self.weight = weight
        self.from = from
        self.to = to
        from.edges.append(self)
    }
}

public func ==<T: Equatable>(lhs: MSTEdge<T>, rhs: MSTEdge<T>) -> Bool {
    guard lhs.from.value == rhs.from.value else {
        return false
    }
    guard lhs.to.value == rhs.to.value else {
        return false
    }
    return true
}

extension MSTEdge: Hashable {
    public var hashValue: Int {
        get {
            let stringHash = "\(from.value)->\(to.value)"
            return stringHash.hashValue
        }
    }
}
```
```
public class MSTGraph<T: Hashable & Equatable> {
    public var nodes: [MSTNode<T>]
    public init(nodes: [MSTNode<T>]) {
        self.nodes = nodes
    }

    // Prim 알고리즘
    public static func minimumSpanningTree(startNode: MSTNode<T>, graph: MSTGraph<T>) {
        // 모서리 값을 처리하고 (아직은 방문하지 않은 노드의) 최솟값을
        // 선택하기 위해 방문 노드 관리용 배열을 사용한다.
        var visitedNodes = [MSTNode<T>]()

        // 첫 번째 노드를 출력하고, 모서리 값을 처리하기 위해
        // visitedNodes 배열에 추가한다.
        print(startNode.value)
        visitedNodes.append(startNode)
        startNode.visited = true

        // 그래프의 모든 노드를 방문할 때까지 반복한다.
        while visitedNodes.count < graph.nodes.count {
            // 가장 먼저, (무한 반복을 피하기 위해)
            // 아직 방문하지 않은 모든 모서리를 추출
            var unvisitedEdges = [MSTEdge<T>]()
            _ = visitedNodes.map({ (node) -> () in
                let edges = node.edges.filter({ (edge) -> Bool in
                    edge.to.visited == false
                })
                unvisitedEdges.append(contentsOf: edges)
            })
            // 모서리 배열에서 가중치가 좀 더 작은 것을 선택 및
            // 출력하고 while 루프의 다음 순회 시에도 노드를 계속
            // 처리할 수 있도록 visitedNode 배열에 추가함
            if let minimumUnvisitedEdge = unvisitedEdges.sorted(by: { (edgeA, edgeB) -> Bool in
                edgeA.weight < edgeB.weight
            }).first {
                print("\(minimumUnvisitedEdge.from.value) <-----> \(minimumUnvisitedEdge.to.value)")
                minimumUnvisitedEdge.to.visited = true
                visitedNodes.append(minimumUnvisitedEdge.to)
            }
        }
    }
}
```
    

* MST의 실행 절차는 다음과 같다:
    1. 첫 번째 노드에서 출발한다. 이 노드를 출력한 뒤 visitedNodes 노드 배열에 추가한다.
    2. visitedNodes 노드 배열에서 모든 미방문 노드를 추출한다. 그리고 unvisitedEdge라는 미방문 모서리 배열을 반환 받는다.
    3. 마지막으로, 미방문 노드를 가리키는 모서리 배열 unvisitedEdges에서 최소 가중치인 모서리를 가져와서 minimumUnvisitedEdge에 저장한다. 이를 출력하고 다음 최소 모서리값을 처리하기 위해 이동할 노드(unvisitedEdges.to)를 방문 노드 배열에 추가한다.
    
    
&nbsp;
&nbsp;      
### [by. 0junChoi](https://github.com/0jun0815) email: <0jun0815@gmail.com>
### 출처: [스위프트 데이터 구조와 알고리즘](http://acornpub.co.kr/book/swift-structure-algorithms)
