# 순환 버퍼 


* [개요](#개요)
* [구현](#구현)


&nbsp;
## 개요
* 순환 버퍼(Circular buffer)는 버퍼의 시작 부분을 연결 해주는 헤드 인덱스(head index)와 테일 인덱스(tail index) 두 개의 인덱스를 사용하는 고정 크기의 데이터 구조다.
* 버퍼가 데이터로 꽉 차면 헤드 인덱스는 0으로 되돌아 간다.
* 순환 버퍼는 지정된 용량까지 데이터를 받아들이고, 기존의 데이터는 새로운 데이터로 대체된다.
* FIFO 데이터 구조를 구현할 때 유용하다.
* 큐 역시 FIFO이지만 순환 버퍼는 헤드 인덱스와 테일 인덱스가 맞물려 있다는 점이 다르다.
* 순환 버퍼는 크기가 고정돼 있으므로, 새로운 데이터로 교체될 기존 데이터로 항상 가득 차 있는 상태다.
* 크기가 고정돼 있기 때문에 내부적으로 데이터를 저장할 때 배열 데이터 구조보다 훨씬 효율적이다.
* 순환 버퍼를 만들고 나면 그 크기는 증가하지 않으므로, 버퍼의 메모리 크기 역시 안정적 상태를 유지한다.


### 순환 버퍼는 다음 메서드와 프로퍼티로 구현한다.
* `push()`: 버퍼의 끝에 요소를 추가함
* `pop()`: 버퍼의 첫 번째 요소를 반환하고 버퍼에서 삭제함
* `peek()`: 버퍼의 첫 번째 요소를 반환하되 삭제하지는 않음
* `clear()`: 버퍼를 재설정해 빈 상태로 만듦
* `isEmpty()`: 비어있는 경우 true를, 그렇지 않은 경우 false를 반환
* `isFull()`: 가득 차있는 경우 true를, 그렇지 않은 경우 false를 반환
* `count`: 버퍼에 포함된 요소의 수를 반환
* `capacity`: 버퍼의 용량을 반환 또는 설정할 수 있는 read/write 프로퍼티


### 순환 버퍼를 활용한 애플리케이션
* 순환 버퍼는 비디오와 오디오 처리 분야에서 가장 보편적으로 활용된다.
* 실시간 동영상을 녹화하는 비디오 캡처 애플리케이션
* 실시간 오디오 처리 작업


&nbsp;
## 구현
### 구현 방법
* push(), pop(), peek(), isEmpty(), isFull(), clear() 메서드와 count 프로퍼티를 초기화
* 데이터 저장을 위한 기본 구조는 배열을 사용


### 순환 버퍼 구조
```
public struct CircularBuffer<T> {
    fileprivate var data: [T]
    fileprivate var head: Int = 0, tail: Int = 0
    fileprivate var internalCount: Int = 0

    public init() {
        data = [T]()
        data.reserveCapacity(8)
    }
    // 'count' 프로퍼티의 CircularBuffer를 생성
    // - 주의: 'count' 만큼 2를 거듭제곱하지 않은 경우,
    // 그에 가장 가까운 수만큼 2를 거듭제곱함
    public init(_ count: Int){
        var capacity = count
        if capacity < 1 {
            capacity = 8
        }
        // 'count'만큼 2를 거듭제곱으로 함
        if (capacity & (~capacity + 1)) != capacity {
            var b = 1
            while b < capacity {
                b = b << 1
            }
            capacity = b
        }
        data = [T]()
        data.reserveCapacity(capacity)
    }
    // 버퍼에서 첫 번째 요소를 삭제한 뒤 반환
    public mutating func pop() -> T? {
        if isEmpty) {
            return nil
        }
        let el = data[head]
        head = incrementPointer(pointer: head)
        internalCount -= 1
        return el
    }

    public func peek() -> T? {
        if isEmpty() {
            return nil
        }
        return data[head]
    }
    // 'element'를 버퍼 맨 뒤에 추가
    public mutating func push(element: T) {
        if isFull() {
            pop()
        }
        if data.endIndex < data.capacity {
            data.append(element)
        } else {
            data[tail] = element
        }   
        tail = incrementPointer(pointer: tail)
        internalCount += 1
    }
    // 버퍼를 빈 상태로 재설정
    public mutating func clear() {
        head = 0
        tail = 0
        internalCount = 0
        data.removeAll(keepingCapacity: true)
    }
    // 버퍼 내 요소의 수를 반환
    // 'count'는 버퍼 내 요소의 수임
    public var count: Int {
        return internalCount
    }
    // 버퍼의 용량을 반환
    public var capacity: Int {
        get {
            return data.capacity
        }
        set {
            data.reserveCapacity(newValue)
        }
    }
    // 버퍼가 가득 찼는지 확인
    // - 반환값: 버퍼가 가득 찬 경우 'true', 그렇지 않은 경우 'false'를 반환
    public func isFull() -> Bool {
        return count == data.capacity
    }
    // 버퍼가 비어있는지 확인
    // - 반환값: 버퍼가 빈 경우 'true', 그렇지 않은 경우 'false'를 반환
    public func isEmpty() -> Bool {
        return count < 1
    }
    // 포인터 값을 1씩 증가시킴
    // - 주의: 이 메서드는 증가된 값이 배열의 마지막 요소를 넘을 경우를 대비
    fileprivate func incrementPointer(pointer: Int) -> Int {
        return (pointer + 1) & (data.capacity - 1)
    }
    // 포인터 값을 1씩 감소시킴
    // - 주의: 이 메서드는 감소된 값이 배열의 첫 번째 요소에 미치지 못할 경우를 대비
    fileprivate func decrementPointer(pointer: Int) -> Int {
        return (pointer - 1) & (data.capacity - 1)
    }
}
```


### 순환 버퍼 구조의 활용
```
var circularBuffer = CircularBuffer<Int>(8)
circularBuffer.push(element: 100)
circularBuffer.push(element: 120)
circularBuffer.push(element: 125)
circularBuffer.push(element: 130)

let x = circularBuffer.pop()    // x = 100
let y = circularBuffer.peek()   // y = 120
let z = circularBuffer.pop()    // z = 120

circularBuffer.push(element: 150)
circularBuffer.push(element: 155)
circularBuffer.push(element: 160)   // 순환 버퍼의 용량은 4이므로, 새로운 요소는 125를 덮어쓰게 됨
```


&nbsp;
&nbsp;      
### [by. 0junChoi](https://github.com/0jun0815) email: <0jun0815@gmail.com>
### 출처: [스위프트 데이터 구조와 알고리즘](http://acornpub.co.kr/book/swift-structure-algorithms)
