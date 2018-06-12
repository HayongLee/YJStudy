# 우선순위 큐 


* [개요](#개요)
* [구현](#구현)


&nbsp;
## 개요
* 우선순위 큐(Priority queue)는 보통의 큐와 비슷하지만, 각각의 요소가 우선순위 값을 지니고 있다는 점이 다르다.
* 더 높은 우선순위를 지닌 요소가 낮은 순위 요소보다 먼저 큐에서 빠져나와 출력된다.


### 우선순위 큐는 다음과 같은 메서드와 프로퍼티를 구현한다.
* `push()`: O(long)의 우선순위 큐에 요소를 추가함
* `pop()`: 큐에서 가장 높은 순위의 요소를 제거하고 반환하거나, 큐가 빈 경우 nil을 반환
* `peek()`: 큐에서 가장 높은 순위의 요소를 반환하거나, 큐가 빈 경우 nil을 반환
* `clear()`: 우선순위 큐를 빈 상태로 재설정함
* `count`: 우선순위 큐에 있는 요소의 수를 반환
* `isEmpty`: 우선순위 큐가 비어있는 경우 true를, 그렇지 않은 경우 false를 반환


### 우선순위 큐의 활용
* 우선순위 큐는 큐에 놓인 데이터의 처리 순서를 조절해야 할 때 특히 유용하다.
* 최선/최초 검색 알고리즘(Best-first search algorithm)
    * 가중치가 적용된 그래프에 있는 두 개의 노트 중 최단 거리를 찾는데 활용되며, 우선순위 큐는 미탐험 경로를 추적할 때 사용된다.
* 프림 알고리즘(Prim algoritm)
    * 가중치가 적용된 비지도학습 그래프에서 폭이 최소인 트리(minimum spanning tree)를 찾는데 활용된다.
* 우리 주변에서 적용되는 대표적인 곳은 응급실이다. 보통 순서대로 진료를 대기하지만 긴급 환자 발생시 환자 진료의 우선순위를 결정하기 위해 우선순위 큐 데이터 구조가 사용된다.


&nbsp;
## 구현
### 구현 방법
* 예제는 요소를 밀어 넣을 때(push), 그리고 요소를 빼낼 때(pop), O(logn) 복잡성을 지닌 이진 힙(Binary heap) 방식을 사용하는 데이비드 코펙의 구현 방식을 따른다.


### 우선순위 큐 구조
```
public struct PriorityQueue<T: Comparable> {
    fileprivate var heap = [T]()
    private let ordered: (T, T) -> Bool

    public init(ascending: Bool = false, startingValues: [T] = []) {
        if ascending {
            ordered = { $0 > $1 }
        } else {
            ordered = { $0 < $1 }
        }
        // 세자윅 힙 구조
        heap = startingValues
        var i = heap.count/2 - 1
        while i >= 0 {
            sink(i)
            i -= 1
        }
    }
    // 우선순위 큐에 몇 개의 요소가 저장돼 있는지 확인
    public var count: Int { return heap.count }
    
    // 우선순위 큐가 빈 경우 true를 반환
    public var isEmpty: Bool { return heap.isEmpty }
    
    // 우선순위 큐에 새 요소를 추가 O(lg n)
    // - 파라미터 요소: 해당 요소는 우선순위 큐에 삽입돼야 함
    public mutating func push(_ element: T) {
        heap.append(element)
        swim(heap.count - 1)
    }

    // 최우선순위의 요소를 큐에서 제거하고 반환(하강순위인 경우 순위가 가장 낮은 요소를 제거 및 반환) O(lg n)
    // - 반환값: 큐에 있는 우선순위의 요소를 반환하거나 빈 경우 nil을 반환
    public mutating func pop() -> T? {
        if heap.isEmpty { return nil }
        if heap.count == 1 { return heap.removeFirst() }
        
        // 동일한 위치에 있는 두 개의 요소를 swap()으로 호출하지 않도록
        heap.swapAt(0, heap.count - 1)
        let temp = heap.removeLast()
        sink(0)
        return temp
    }

    // 특정 아이템의 첫 번째 반환 내용을 삭제하고 == 기호를 이용해서 값을 비교 O(n)
    // 반환 내용이 없을 경우 그냥 넘어감
    // - 파라미터 요소: 삭제할 첫 번째 반환 아이템
    public mutating func remove(_ item: T) {
        if let index = heap.index(of: item) {
            heap.swapAt(index, heap.count - 1)
            heap.removeLast()
            swim(index)
            sink(index)
        }
    }

    // 특정 아이템의 모든 반환 내용을 삭제하고 ==기호를 이용해서 값을 찾음 O(n)
    // 반환 내용이 없을 경우 그냥 넘어감
    // - 파라미터 아이템: 삭제할 모든 아이템
    public mutating func removeAll(_ item: T) {
        var lastCount = heap.count
        remove(item)
        while heap.count < lastCount {
            lastCount = heap.count
            remove(item)
        }
    }

    // 현재 최우선순위 아이템을 찾아 삭제하지 않고 가져옴 O(1)
    // - 반환값: 큐에 있는 우선순위의 요소를 반환하거나 빈 경우 nil을 반환
    public func peek() -> T? {
        return heap.first
    }

    // 우선순위 큐에서 모든 요소를 제거
    public mutating func clear() {
        heap.removeAll(keepingCapacity: false)
    }

    private mutating func sink(_ index: Int) {
        var index = index
        while 2 * index + 1 < heap.count {
            var j = 2 * index + 1
            if j < (heap.count - 1) && ordered(heap[j], heap[j + 1]) {
                j += 1
            }
            if !ordered(heap[index], heap[j]) {
                break
            }
            heap.swapAt(index, j)
            index = j
        }
    }

    private mutating func swim(_ index: Int) {
        var index = index
        while index > 0 && ordered(heap[(index - 1) / 2], heap[index]) {
            heap.swapAt((index - 1) / 2, index)
            index = (index - 1) / 2
        }
    }
}
```


### 우선순위 큐의 활용
```
var priorityQueue = PriorityQueue<String>(ascending: true)

priorityQueue.push("OneRepublic")
priorityQueue.push("Coldplay")
priorityQueue.push("Marron5")
priorityQueue.push("Imagine Dragons")

var x = priorityQueue.pop() // x = "Coldplay"
x = priorityQueue.pop()     // x = "Imagine Dragons"
```


&nbsp;
&nbsp;      
### [by. 0junChoi](https://github.com/0jun0815) email: <0jun0815@gmail.com>
### 출처: [스위프트 데이터 구조와 알고리즘](http://acornpub.co.kr/book/swift-structure-algorithms)
