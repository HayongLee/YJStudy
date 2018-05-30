# 큐 


* [개요](#개요)
* [구현](#구현)


&nbsp;
## 개요
* 큐는 먼저 입력된 데이터가 먼저 출력되는 FIFO(First In First Out) 데이터 구조
* 큐의 뒤에 요소를 추가하고 큐의 앞에서 요소를 제거한다.
    

### 큐는 다음과 같은 임무를 수행한다.
* `enqueue()`: 큐의 맨 뒤에 새로운 요소를 추가
* `dequeue()`: 큐에서 첫 번째 요소를 제거한 뒤 반환
* `peek()`: 큐의 첫 번째 요소를 반환하되, 제거하지 않음
* `clear()`: 큐를 재설정해 빈 상태가 되게 함
* `count`: 큐에 있는 요소의 수를 반환
* `isEmpty()`: 큐가 비어있으면 true를, 그렇지 않을 경우 false를 반환
* `isFull()`: 큐가 꽉 차있으면 true를, 그렇지 않은 경우 false를 반환
* `capacity`: 큐 용량을 가져오거나 설정하기 위한 read/write 프로퍼티


### 큐를 활용한 애플리케이션
* 큐는 입력된 순서대로 데이터를 처리할 때 보편적으로 활용된다.
* 음식점에서 주문 및 계산에 활용하는 POS(Point-of-sale) 시스템


&nbsp;
## 구현
### 구현 방법
* enqueue(), dequeue(), peek(), isEmpty(), isFull(), clear() 메서드와 count 프로퍼티를 구현
* 기본 저장 방식으로 배열을 사용


### 큐 구조 정의
```
// 큐는 데이터를 FIFO로 저장하는 고정된 크기의 데이터 구조이다.
public struct Queue<T> {

    fileprivate var data = [T]()
    // 빈 큐 구조를 정의
    public init() {}

    // 큐에서 첫 번째 요소를 제거하고 반환
    // - 반환값:
    // - 큐가 빈 상태가 아닌 경우, 첫 번째 요소의 타입은 'T'
    // - 큐가 빈 상태인 경우, 'nil'을 반환
    public mutating func dequeue() -> T? {
        return data.removeFirst()
    }

    // 큐에서 첫 번째 요소를 제거하지 않고 반환
    // - 반환값:
    // - 큐가 빈 상태가 아닌 경우, 첫 번째 요소의 타입은 'T'
    // - 큐가 빈 상태인 경우, 'nil'을 반환
    public func peek() -> T? {
        return data.first
    }

    // 큐의 맨 뒤에 요소를 추가
    // - 복잡성: O(1)
    // - 파라미터 요소: 'T' 타입의 요소
    public mutating func enqueue(element: T) {
        data.append(element)
    }

    // 버퍼를 재설정해 빈 상태가 되게 함
    public mutating func clear() {
        data.removeAll()
    }

    // 큐에 있는 요소의 수를 반환
    public var count: Int {
        return data.count
    }

    // 큐의 용량을 반환
    public var capacity: Int {
        get {
            return data.capacity
        }
        set {
            data.reserveCapacity(newValue)
        }
    }

    // 큐가 꽉 찼는지 확인
    // - 반환값: 큐가 꽉 찬 경우 `True`를 반환하고, 그렇지 않은 경우 'False'를 반환
    public func isFull() -> Bool {
        return count == data.capacity
    }

    // 큐가 비었는지를 확인
    // - 반환값: 큐가 비어있는 경우 `True`를 반환하고, 그렇지 않은 경우 'False'를 반환
    public func isEmpty() -> Bool {
        return data.isEmpty
    }
}
```


### 큐 구조의 활용
```
var queue = Queue<Int>()

queue.enqueue(element: 100)
queue.enqueue(element: 120)
queue.enqueue(element: 125)
queue.enqueue(element: 130)

let x = queue.dequeue()     // x = 100
let y = queue.peek()        // y = 120
let z = queue.dequeue()     // z = 120
```


&nbsp;
&nbsp;      
### [by. 0junChoi](https://github.com/0jun0815) email: <0jun0815@gamil.com>
### 출처: [스위프트 데이터 구조와 알고리즘](http://acornpub.co.kr/book/swift-structure-algorithms)

