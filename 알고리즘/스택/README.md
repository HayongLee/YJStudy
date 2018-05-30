# 스택 


* [개요](#개요)
* [구현](#구현)


&nbsp;
## 개요
* 스택은 나중에 입력된 것이 먼저 출력되는 LIFO(Last In First Out) 데이터 구조
* 배열과 유사하지만 개별 요소에 접근하기 위한 메서드가 좀 더 제한적
    * 개별 요소에 대한 무작위 접근을 허용하는 배열과 달리, 스택은 개별 요소에 접근하는 방법을 강하게 제한한 인터페이스를 제공
    

### 스택은 다음과 같은 메서드를 구현한다
* `push()`: 스택의 상단에 요소를 추가
* `pop()`: 스택의 상단의 요소를 삭제한 뒤 반환
* `peek()`: 스택의 상단의 요소를 삭제하지 않고 반환


### 스택을 활용한 대표적인 애플리케이션
* 표현식(expression) 평가 및 표현식 문법 파싱
* 정수형 데이터의 이진수 변환
* 역추적(back tracking) 알고리즘
* 보편적인 디자인 패턴을 활용한 실행 취소/재실행 기능 제공


&nbsp;
## 구현
### 구현 방법
* push(), pop(), peek(), isEmpty() 네 개의 메서드와 count를 구현한다.
* 예비 스토리지는 배열로 만든다.


### 스택 구조 정의
```
public struct ArrayStack<T> {
    fileprivate var elements = [T]()

    public init() {}

    mutating public func pop() -> T? {
        return self.elements.popLast()
    }
    mutating public func push(element: T){
        self.elements.append(element)
    }
    public func peek() -> T? {
        return self.elements.last
    }
    public func isEmpty() -> Bool {
        return self.elements.isEmpty
    }
    public var count: Int {
        return self.elements.count
    }
}
```


### 스택 구조의 활용
```
var myStack = ArrayStack<Int>()

myStack.push(element: 5)    // [5]
myStack.push(element: 44)   // [5, 44]
myStack.push(element: 23)   // [5, 44, 23]

var x = myStack.pop()       // x = 23
```


&nbsp;
&nbsp;      
### [by. 0junChoi](https://github.com/0jun0815) email: <0jun0815@gamil.com>
### 출처: [스위프트 데이터 구조와 알고리즘](http://acornpub.co.kr/book/swift-structure-algorithms)

