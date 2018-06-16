# 너비 우선 검색


* [너비 우선 검색(BFS, Breadth First Search)](#너비-우선-검색bfs-breadth-first-search)
* [BFS 순회 작업을 수행할 메서드 구현](#bfs-순회-작업을-수행할-메서드-구현)



&nbsp;
## 너비 우선 검색(BFS, Breadth First Search)
너비 우선 검색은 그래프의 아래로 깊이(이웃의 이웃들 속으로) 들어가기 전에, 동일 레벨(혹은 이웃) 노드를 방문하는 방법에 초점을 맞춘 순회 기법이다.


특징은 각각의 노드를 단 한번만 방문한다는 것이다.


![너비 우선 검색](https://github.com/0jun0815/YJStudy/blob/master/알고리즘/너비%20우선%20검색/images/너비%20우선%20검색.jpg)


* 노드 A부터 방문할 경우, A -> B -> C -> D -> E -> F 순으로 방문한다.


BFS 기법을 활용하려면 다음과 같은 정보를 포함한 데이터 구조가 필요하다:
* 노드를 식별하기 위한 값
* 연결 노드의 목록(또는 맥락에 따라 연결될 수 있는 자식, 이웃 등)
* 특정 노드에 대한 방문 여부 표시. BFS는 각각의 노드를 단 한번만 방문해야 한다.


&nbsp;
## 너비 우선 검색 구현
```
public class BFSNode<T> {
    // value, 이웃 노드 목록, 방문 상태
    public var value: T
    public var neighbours: [BFSNode]
    public var visited: Bool

    public init(value: T, neighbours: [BFSNode], visited: Bool) {
        self.value = value
        self.neighbours = neighbours
        self.visited = visited
    }

    public func addNeighbour(node: BFSNode) {
        neighbours.append(node)
        node.neighbours.append(self)
    }
    ...
```


&nbsp;
### BFS 순회 작업을 수행할 메서드 구현
각각의 노드를 한 번만 방문하고, 방문한 노드의 이웃을 확인하기 위해 먼저 입력된 값을 먼저 출력하는 FIFO 속성의 큐 데이터 구조를 사용한다.


BFS 작업은 첫 번째 노드를 방문하는 것으로 시작한다. 그리고 이 노드의 모든 이웃 노드를 큐에 저장한 뒤, 하나씩 꺼내서 방문했음을 나타내는 표식을 추가한다. 그리고 이들 이웃 노드에 인접한 (아직 방문하지 않은) 이웃을 큐에 저장한다. 이런 방식으로, 모든 노드를 한 번씩만 우리가 원하는 순서대로 방문할 수 있다.


스위프트로 큐를 구현하는 방법 대신 동일한 기능을 수행할 수 있는 보통의 배열을 이용해서 구현한다.
```
    ...
    // BFS 순회 작업 메서드
    public static func breadthFirstSearch(first: BFSNode) {
        // 큐 초기화
        var queue = [BFSNode]()
        // 루트 노드에서 시작
        queue.append(first)
        // 큐에서 노드 방문을 시작
        while queue.isEmpty == false {
            if let node = queue.first {
                // 현재 노드의 값을 출력하고 방문 표식 남기기
                print(node.value)
                node.visited = true
                // 큐에 아직 방문하지 않은 이웃을 추가
                for neighbour in node.neighbours {
                    if neighbour.visited == false {
                        queue.append(neighbour)
                    }
                }
                // 이미 처리한 노드는 삭제하고,
                // 큐의 나머지 요소에 대한 처리 지속
                queue.removeFirst()
            }
        }
    }
}
```


* 원하는 순서대로 각각의 노드를 방문하기 위해 큐(배열)을 사용한다. 하나의 노드를 처리한 후, 그래프 하단으로 이동하기 전에 그 이웃에 있는 모든 노드를 큐에 집어 넣고, 하나씩 방문해 나간다.


m개의 노드를 큐에 저장하며, 모든 노드를 한 번씩만 방문해야 하므로 저장 공간과 시간 복잡성은 O(m)에 가까우며, 이 때 m은 그래프에서 노드의 수를 나타낸다.


BFS와 DFS 기법은 그래프의 스패닝 트리를 발견하는데 주로 이용된다.


&nbsp;
&nbsp;      
### [by. 0junChoi](https://github.com/0jun0815) email: <0jun0815@gmail.com>
### 출처: [스위프트 데이터 구조와 알고리즘](http://acornpub.co.kr/book/swift-structure-algorithms)
