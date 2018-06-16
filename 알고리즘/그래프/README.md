# 그래프


* [그래프 이론](#그래프-이론)
    * [보편적으로 활용되는 그래프의 유형](#보편적으로-활용되는-그래프의-유형)
* [그래프의 표현 방식](#그래프의-표현-방식)
    * [객체지향 접근법: 구조체와 클래스 활용](#객체지향-접근법:-구조체와-클래스-활용)
    * [이웃 목록(Adjacency List)](#이웃-목록adjacency-list)
    * [이웃 매트릭스(Adjacency Matrix)](#이웃-매트릭스adjacency-matrix)
    * [근접 매트릭스(Incidence Matrix)](#근접-매트릭스incidence-matrix)
* [데이터 구조](#데이터-구조)
    * [꼭지점 구현](#꼭지점-구현)
    * [모서리 구현](#모서리-구현)
    * [이웃 목록 구현](#이웃-목록-구현)


&nbsp;
## 그래프 이론
그래프는 꼭지점들(vertices)의 모음과 모서리들(edges)의 모음으로 구성된다.
* 꼭지점(vertex)은 정보 개체(entity)를 나타내는 단일 노드를 의미하며, 해결하려는 문제에 따라 달라질 수 이다.
* 모서리(edge)는 두 개 꼭지점의 연결선을 의미한다.


&nbsp;
### 보편적으로 활용되는 그래프의 유형
#### 무방향성 그래프(Undirected Graph)
무방향성 그래프는 꼭지점을 연결하는 모서리가 양방향인 그래프를 가리킨다. 즉, 꼭지점 A와 B를 연결하는 모서리를 통해 A에서 B로, B에서 A로 이동할 수 있음을 나타낸다.


![무방향성 그래프]()


#### 방향성 그래프(Directed Graph)
방향성 그래프는 꼭지점을 한 방향으로만 연결한다. A -> B 또는 A <- B와 같이 방향성을 나타내기 위해 모서리 끝 부분에 화살표를 추가한다.


![방향성 그래프]()


각각의 모서리는 연결된 꼭지점을 하나의 방향으로 연결한다.


#### 가중치 그래프(Weighted Graph)
가중치 그래프는 각각의 모서리에 추가적인 정보 또는 서로 다른 값이 매겨진 그래프 유형이다. 보통의 경우, 추가적인 정보는 가중치 또는 두 꼭지점을 잇는 경로의 비용 등을 나타낸다.


![가중치 그래프]()


각 모서리는 출발지 꼭지점에서 목적지 꼭지점으로 이동하는데 드는 시간 또는 비용을 나타낼 수 있다.


&nbsp;
## 그래프의 표현 방식
### 객체지향 접근법: 구조체와 클래스 활용
그래프를 나타내기 위해 구조체와 클래스를 사용하는 방법이다.


꼭지점 개체를 나타내기 위해 (이름, 가중치, 또는 여타의 속성 등) 몇 개의 값으로 구성된 프로퍼티를 지닌 구조체를 정의하거나, (종단점, 연결된 꼭지점에 대한 참조 값 등) 모서리 개체를 나타내기 위해 또 다른 구조체를 정의할 수 있다.


필요에 따라 (모서리 구조체의 가중치 등) 프로퍼티를 얼마든지 늘릴 수 있다.


O(m + n)의 공간을 차지하는데, m은 꼭지점의 수, n은 모서리의 수를 나타낸다.


일반적인 처리 작업을 마치기 위해서는 선형 데이터 구조의 처리 시간과 같은 O(m)의 시간이 소요되며, 이는 데이터 처리를 위해 모든 구조체와 클래스 목록을 일일이 확인해야 하기 때문이다.


&nbsp;
### 이웃 목록(Adjacency List)
이웃 목록은 모든 꼭지점을 포함하며, 각각의 이웃 목록에는 그에 연결된 꼭지점 목록이 포함된다.


![이웃 목록]()


* 하나의 꼭지점이 다른 것과 서로 연결돼 있는지 여부를 즉각적으로 알 수 있으며, 모든 요소가 아닌, 해당 목록만 확인하면 된다.
* A <-> C를 연결하는 모서리가 있을 경우 A 목록에 [C]가 들어있고, C 목록에도 [A...]가 들어있게 된다. 이들 요소를 저장하기 위해서는 O(m + n)의 공간이 필요하다.


&nbsp;
### 이웃 매트릭스(Adjacency Matrix)
이웃 매트릭스는 특정 모서리의 존재 여부를 확인하는데 특히 유용하지만, 이웃 목록에 비해 좀 더 많은 저장 공간을 차지한다.


꼭지점을 열과 행으로 하는 매트릭스 또는 행렬을 만든다. 두 개의 꼭지점을 연결하는 모서리가 있다면, 행렬쌍의 값으로 1을 입력하고, 그렇지 않다면 0을 입력한다.


![이웃 매트릭스]()


&nbsp;
### 근접 매트릭스(Incidence Matrix)
근접 매트릭스에서는 행이 꼭지점을 나타내고, 열이 모서리를 나타낸다.


두 개의 꼭지점이 모서리로 연결돼 있는 열에 1을 입력하므로, 각각의 열에는 1이 두 개, 0이 한 개 있게 된다.


근접 매트릭스에서 각 행을 읽어보면, 어느 모서리와 꼭지점이 연결돼 있는지 즉각 알 수 있다.


![근접 매트릭스]()


&nbsp;
## 데이터 구조
### 꼭지점 구현
```
public struct Vertex<T: Equatable & Hashable>: Equatable {
    public var data: T
    public let index: Int
}

public func ==<T: Equatable>(lhs: Vertex<T>, rhs: Vertex<T>) -> Bool {
    guard lhs.data == rhs.data else {
        return false
    }
    return true
}

extension Vertex: Hashable {
    public var hashValue: Int {
        get {
            return "\(index)".hashValue
        }
    }
}
```


&nbsp;
### 모서리 구현
```
public struct Edge<T: Equatable & Hashable>: Equatable {
    // 모서리로 연결된 꼭지점
    public let from: Vertex<T>
    public let to: Vertex<T>
}

public func ==<T: Equatable>(lhs: Edge<T>, rhs: Edge<T>) -> Bool {
    guard lhs.from == rhs.from else {
        return false
    }
    guard lhs.to == rhs.to else {
        return false
    }
    return true
}

extension Edge: Hashable {
    // Hashable 프로토콜에 부합하도록 하려면 hashValue 변수를 구현해야 하며,
    // 이 변수로 유일한 값을 부여해야 한다.
    public var hashValue: Int {
        get {
            let stringHash = "\(from.index)->\(to.index)"
            return stringHash.hashValue
        }
    }
}
```


&nbsp;
### 이웃 목록 구현
```
public struct VertexEdgeList<T: Equatable & Hashable> {
    // 각각의 VertexEdgeList에는 해당 꼭지점과 그에 연결된 또 다른
    // 꼭지점의 정보를 담고 있는 모서리 배열 데이터가 포함된다.
    public let vertex: Vertex<T>
    public var edges = [Edge<T>]()
    public init(vertex: Vertex<T>) {
        self.vertex = vertex
    }

    public mutating func addEdge(edge: Edge<T>) {
        // 모서리 존재 여부 확인
        if edges.count > 0 {
            let equalEdges = edges.filter { existingEdge -> Bool in
                return existingEdge == edge
            }
            if equalEdges.count > 0 {
                return
            }
        }
        edges.append(edge)
    }
}
```


이웃 목록은 일련의 꼭지점 목록으로 구성된 그래프를 나타내며, 각각의 목록에는 해당 꼭지점에 연결된 또 다른 꼭지점에 대한 정보가 포함돼 있어야 한다. 따라서, 먼저 각각의 꼭지점을 저장할 수 있는 구조체를 만들고 (모서리라는 형식으로) 다른 꼭지점과 연결된 목록 정보를 함께 담을 수 있도록 했다.


```
public struct AdjacencyListGraph<T: Equatable & Hashable> {
    public var adjacencyLists = [VertexEdgeList<T>]()
    public var vertices: [Vertex<T>] {
        get {
            var vertices = [Vertex<T>]()
            for list in adjacencyLists {
                vertices.append(list.vertex)
            }
            return vertices
        }
    }

    public var edges: [Edge<T>] {
        get {
            // 중복 저장을 피하기 위해 Set을 이용
            // 때문에, Edge 구조체가 Hashable에 부합하고,
            // 각각의 모서리가 각자의 유일한 해시값을 지녀야한다.
            var edges = Set<Edge<T>>()
            for list in adjacencyLists {
                for edge in list.edges {
                    edges.insert(edge)
                }
            }
            return Array(edges)
        }
    }

    // 그래프에 새로운 꼭지점 추가
    public mutating func addVertex(data: T) -> Vertex<T> {
        // 꼭지점이 있는지 확인함
        for list in adjacencyLists {
            if list.vertex.data == data {
                return list.vertex
            }
        }

        // 꼭지점을 생성한 뒤 그래프를 업데이트하고 반환함.
        let vertex = Vertex(data: data, index: adjacencyLists.count)
        let adjacencyList = VertexEdgeList(vertex: vertex)
        adjacencyLists.append(adjacencyList)
        return vertex
    }

    // 그래프에 새로운 모서리를 추가
    public mutating func addEdge(from: Vertex<T>, to: Vertex<T>) -> Edge<T> {
        let edge = Edge(from: from, to: to)
        let list = adjacencyLists[from.index]
        // 모서리가 있는지 확인함
        if list.edges.count > 0 {
            for existingEdge in list.edges {
                if existingEdge == edge {
                    return existingEdge
                }
            }
            adjacencyLists[from.index].edges.append(edge)
        } else {
            adjacencyLists[from.index].edges = [edge]
        }
        return edge
    }
}
```


&nbsp;
&nbsp;      
### [by. 0junChoi](https://github.com/0jun0815) email: <0jun0815@gmail.com>
### 출처: [스위프트 데이터 구조와 알고리즘](http://acornpub.co.kr/book/swift-structure-algorithms)
