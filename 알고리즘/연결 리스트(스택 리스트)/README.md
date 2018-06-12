# 연결 리스트(스택 리스트) 


* [개요](#개요)
* [구현](#구현)


&nbsp;
## 개요
* 연결 리스트는 순서대로 정렬된 세트의 일종으로서, 각각의 요소가 이전 요소와 연결되어 있다는 특징이 있다.
* 요소로 구성된 세트를 지닌다는 점에서 배열과 유사한 데이터 구조지만, 배열은 여러 개의 요소를 저장하기 위해 일정 규모의 연속된 메모리 범위를 할당 받는 반면, 연결 리스트는 그렇지 않다는 차이점이 있다.
* 저장해야 할 요소의 크기를 모른채 데이터 구조를 만들어야 한다면, 배열 보다는 연결 리스트가 훨씬 효율적인 구조가 될 수 있다.
* 연결 리스트의 노드는 개별적으로 할당되므로 개별 요소에 저장된 내용에 무작위로 접근할 수 없다. 다섯 번째 요소에 접근해야 할 경우, 첫 번째 요소에서 출발하여 차례대로 접근해야 한다.
* 연결 리스트는 O(1) 복잡성을 지니고 요소의 빠른 삽입과 삭제를 장점으로 한다.


### 연결 리스트 종류
* 이중 연결 리스트(Doubly linked list)
    * 양방향으로 이동하고자 할 때 사용할 수 있는 데이터 구조, 각 노드에는 두 개의 링크가 포함돼 있다. next 링크는 다음 요소로 previous 링크는 이전 요소로 연결된다.
* 순환 연결 리스트(Circular linked list)
    * 마지막 노드와 연결 리스트의 첫 번째 요소와 연결되는 데이터 구조
    

### 애플리케이션 개요
* 데이터의 삽입과 삭제가 빈번하게 발생하는 경우, 데이터의 규모가 무척 큰 경우 연결 리스트는 좋은 대안이 될 수 있다.
* 연결 리스트의 각 노드는 서로 연속된 메모리를 할당받지 않으므로, 연결 리스트의 구조를 미리 최적화해서 관리하지 않을 경우 리스트의 인덱싱 성능은 낮은 수준으로 유지될 수 밖에 없다는 단점이 있다.
* 노드의 관리에 일정량의 메모리가 소진된다는 단점이 있다.


&nbsp;
## 구현
* push(), pop(), peek(), isEmpty(), count 구현


### 연결리스트 구조
```
public class Node<T: Comparable> {
    public var next: Node<T>?
    public var data: T

    init(data: T) {
        next = nil
        self.data = data
    }
}
```
```
public struct LinkedList<T: Comparable> {
    private var _head: Node<T>? = nil
    private var _count: Int = 0
    public init() { }

    public var head: Node<T>? {
        get {
            return _head
        }
        set {
            _head = newValue
        }
    }

    public var count: Int {
        return _count
    }

    public mutating func push(_ element: T) {
        let node = Node<T>(data: element)
        node.next = head
        head = node
        _count += 1
    }

    public mutating func pop() -> T? {
        if isEmpty() {
            return nil
        }
        let item = head?.data
        head = head?.next
        _count -= 1
        return item
    }

    public func peek() -> T? {
        return head?.data
    }

    public func isEmpty() -> Bool {
        return count == 0
    }
}
```


### 연결 리스트 활용
```
var linkedList = LinkedList<Int>()
linkedList.push(34)     // [34]
linkedList.push(77)     // [77, 34]
linkedList.push(67)     // [67, 77, 34]
let x = linkedList.pop()    // x = 67
let y = linkedList.pop()    // y = 77
```


### 스택 리스트 구현
* 스택 데이터 구조를 이용해서 연결 리스트로 내부 저장소를 구현


### 스택 리스트 구조
```
public struct StackList<T> {
    fileprivate var head: Node<T>? = nil
    private var _count: Int = 0
    public init() {}

    public mutating func push(element: T) {
        let node = Node<T>(data: element)
        node.next = head
        head = node
        _count += 1
    }

    public mutating func pop() -> T? {
        if isEmpty() {
            return nil
        }
        // head 노드의 아이템을 가져옴
        let item = head?.data
        // head 노드를 삭제함
        head = head?.next
        // 요소의 수를 1만큼 감소시킴
        _count -= 1
        return item
    }

    public func peek() -> T? {
        return head?.data
    }

    public func isEmpty() -> Bool {
        return count == 0
    }

    public var count: Int {
        return _count
    }
}
```


&nbsp;
&nbsp;      
### [by. 0junChoi](https://github.com/0jun0815) email: <0jun0815@gmail.com>
### 출처: [스위프트 데이터 구조와 알고리즘](http://acornpub.co.kr/book/swift-structure-algorithms)
