# 이진 검색 트리


* [개요](#개요)
* [노드 삽입](#노드-삽입)
* [트리 워크(순회 방식)](#트리-워크순회-방식)
    * [인오더 트리 워크(In-order traversal)](#인오더-트리-워크in-order-traversal)
    * [프리오더 트리 워크(Pre-order traversal)](#프리오더-트리-워크pre-order-traversal)
    * [포스트오더 트리 워크(Post-order traversal)](#포스트오더-트리-워크post-order-traversal)
* [검색](#검색)
* [삭제](#삭제)
* [이진 검색 트리 구현](#이진-검색-트리-구현)


&nbsp;
## 개요
* 이진 검색 트리는 O(n)에서 O(logn) 정도의 시간 동안 데이터 접근, 검색, 삽입, 삭제 등의 작업을 수행한다.
* 이진 검색 트리의 성능 시간은 트리의 높이 자체에 영향을 받는다. 데이터 삽입 또는 검색과 같은 기본 작업을 수행하기 위해서는, 가장 먼저 트리의 루트부터 잎에 이르는 모든 노드를 스캔해야 한다. 바로 이 때문의 트리의 높이를 추정하는 작업이 기본 작업을 수행하는 시간에 영향을 미치게 된다.


&nbsp;
## 노드 삽입
루트 노드부터 시작해서 재귀적으로 새로운 노드를 삽입해야 하고, 이때 삽입하게 될 노드의 값에 따라 좌측, 또는 우측으로 내려오게 된다. 
* 트리의 중간 부분에 새로운 노드를 삽입하면 이진 검색 트리가 제 기능을 수행할 수 없게 되므로 항상 루트 노드에 삽입 작업을 처리해야 한다.


#### 노드 삽입 구현
```
// 노드 삽입
public func insertNodeFromRoot(value: T) {
    // 이진 검색 트리의 프로퍼티를 유지하기 위해서는
    // 반드시 루트 노드에서부터 insertNode 작업이 실행되어야 함
    if let _ = self.parent {
        // 부모 노드가 있다면 트리의 루트 노드가 아님
        print("루트 노드가 아닙니다.")
        return
    }
    // 루트 노드에서부터 새로운 노드 삽입은 private 함수인 addNode를 사용한다.
    self.addNode(value: value)
}

private func addNode(value: T) {
    // 재귀적으로 나머지 노드를 순회하면서 새로운 노드를 삽입할 적절한 위치를 찾는다.
    if value < self.value {
        // value가 루트 키값보다 작은 경우: 좌측 서브트리에 삽입
        // 노드가 존재하는 경우 좌측 서브트리에 삽입하고,
        // 노드가 없는 경우 새로운 노드를 만들어서 좌측 자식 노드로 삽입
        if let leftChild = leftChild {
            leftChild.addNode(value: value)
        } else {
            let newNode = BinaryTreeNode(value: value)
            newNode.parent = self
            leftChild = newNode
        }
    } else {
        // value가 루트 키값보다 큰 경우: 우측 서브트리에 삽입
        // 노드가 존재하는 경우 우측 서브트리에 삽입하고,
        // 노드가 없는 경우 새로운 노드를 만들어서 우측 자식 노드로 삽입
        if let rightChild = rightChild {
            rightChild.addNode(value: value)
        } else {
            let newNode = BinaryTreeNode(value: value)
            newNode.parent = self
            rightChild = newNode
        }
    }
}
```


&nbsp;
## 트리 워크(순회 방식)
### 인오더 트리 워크(In-order traversal)
인오더 트리 워크를 하고 나면 오름차순으로 정렬된 트리 노드의 값이 목록으로 반환된다.


다음 순서에 따라 루트 노드에 속한 각각의 서브트리를 재귀적으로 방문한다:
* 좌측 서브트리 -> 루트 노드 값 확인 -> 우측 서브트리


#### 인오더 트리 워크 구현
```
// 재귀적으로 노드를 순회하는 인오더 트리 워크
public class func traverseInOrder(node: BinaryTreeNode?) {
    // nil인 잎에 도달하면 재귀적인 함수 호출이 중단됨
    guard let node = node else {
        return
    }

    // leftChild에서 재귀적으로 메서드를 호출하고
    // 노드의 값을 출력한 뒤, rightChild로 이동
    BinaryTreeNode.traverseInOrder(node: node.leftChild)
    print(node.value)
    BinaryTreeNode.traverseInOrder(node: node.rightChild)
}
```


&nbsp;
###  프리오더 트리 워크(Pre-order traversal)
다음 순서에 따라 서브트리를 순회한다:
* 루트 노드 값 확인 -> 좌측 서브트리 -> 우측 서브트리


프리 오더 트리 워크는 이진 검색 트리 노드를 차례대로 복사하려 할 때 유용하다.
* 트리의 노드를 순회할 때 좌측 상단부터 하단까지 이동한 뒤 우측으로 이동하며 복사한다.


#### 프리오더 트리 워크 구현
```
// 재귀적으로 노드를 순회하는 프리오더 트리 워크
public class func traversePreOrder(node: BinaryTreeNode?) {
    // nil인 잎에 도달하면 재귀적인 함수 호출이 중단됨
    guard let node = node else {
        return
    }

    // 재귀적으로 메서드를 호출하면서 노드의 값을 출력한 뒤
    // leftChild와 rightChild를 순회
    print(node.value)
    BinaryTreeNode.traversePreOrder(node: node.leftChild)
    BinaryTreeNode.traversePreOrder(node: node.rightChild)
}
```


&nbsp;
### 포스트오더 트리 워크(Post-order traversal)
다음 순서에 따라 서브트리를 순회한다:
* 좌측 서브트리 -> 우측 서브트리 -> 루트 노드 값 확인


좌측 하단에서 시작하여 우측 상단으로 이동해 올라가면서 노드를 순회하기 때문에 트리에서 삭제 작업을 할 때 유용하다.
* 위와 같은 방식으로 이동하면서 단 하나의 노드도 그냥 지나치지 않고 필요에 따라 모든 레퍼런스를 삭제할 수 있다.


#### 포스트오더 트리 워크 구현
```
// 재귀적으로 노드를 순회하는 포스트오더 트리 워크
public class func traversePostOrder(node: BinaryTreeNode?) {
// nil인 잎에 도달하면 재귀적인 함수 호출이 중단됨
    guard let node = node else {
        return
    }

    // 재귀적으로 메서드를 호출하면서 leftChild에서 시작해서
    // rightChild를 순회한 뒤, 노드의 값을 출력
    BinaryTreeNode.traversePostOrder(node: node.leftChild)
    BinaryTreeNode.traversePostOrder(node: node.rightChild)
    print(node.value)
}
```


&nbsp;
## 검색
노드에 포함돼 있는 값을 키로 삼아 특정 노드를 검색한다.


이진 검색 트리에서 검색 작업은 n이 트리의 높이라 했을 때, 컴플리트 트리에서 최악의 경우 O(logn)의 시간이 소요되며, (연결 리스트와 비슷한 형태의) 선형 트리에서 O(n)의 시간이 소요된다.


#### 검색 구현
```
// 검색
public func search(value: T) -> BinaryTreeNode? {
    // 키값을 찾은 경우
    if value == self.value {
        return self
    }

    // 해당 키값이 현재 노드의 키값보다 작은 경우
    // 좌측 서브트리에서 재귀적으로 검색을 시작
    // 그렇지 않은 경우 우측 서브트리에서 검색 시작
    // 값이 없다면 nil을 반환
    if value < self.value {
        guard let left = leftChild else {
            return nil
        }
        return left.search(value: value)
    } else {
        guard let right = rightChild else {
            return nil
        }
        return right.search(value: value)
    }
}
```


&nbsp;
## 삭제
삭제 작업은 노드 삽입이나 검색에 비해 훨씬 까다로운 편인데, 이는 트리에서 특정 노드를 삭제하기 위해서는 그에 따르는 다양한 상황을 미리 구체적으로 알고 있어야 하기 때문이다.


#### 삭제 시나리오1: 노드 x가 자식 요소를 지니지 않은 경우


![삭제 시나리오1](https://github.com/0jun0815/YJStudy/blob/master/알고리즘/이진%20검색%20트리/images/삭제%20시나리오1.jpg)


* 노드 x에 대한 참조값에 nil을 할당해서 부모 노드와 노드 x의 연결을 끊는다.


#### 삭제 시나리오2: 노드 x가 단 하나의 자식 요소만 지닌 경우


![삭제 시나리오2](https://github.com/0jun0815/YJStudy/blob/master/알고리즘/이진%20검색%20트리/images/삭제%20시나리오2.jpg)


#### 삭제 시나리오3: 노드 x가 두 개의 자식 요소를 지닌 경우
1. 삭제 대상 노드보다 큰 값 중 가장 작은 요소(우측 서브트리 최솟값) 또는 삭제 대상 노드보다 작은 값 중 가장 큰 요소(좌측 서브트리 최댓값)을 찾는다.
2. 트리 내에서, 1에서 찾은 후손 노드를 삭제하려는 노드의 위치로 이동시킨다.
3. 후손 노드 내에서 재귀적으로 삭제 함수를 호출한다.


![삭제 시나리오3](https://github.com/0jun0815/YJStudy/blob/master/알고리즘/이진%20검색%20트리/images/삭제%20시나리오3.jpg)


#### 삭제 구현
```
//삭제
public func delete() {
    if let left = leftChild {
        if let _ = rightChild {
            // 대상 노드가 좌측 및 우측, 두 개의 자식 요소를 모두 지닌 경우 ->
            // 후손 교환 작업 수행
            self.exchangeWithSuccessor()
        } else {
            // 대상 노드가 좌측 자식 요소를 지닌 경우 ->
            // 대상 노드의 parent와 child를 바로 연결함
            // 이를 위해서는 먼저 대상 노드가 부모 노드의 우측 서브트리에
            // 속한 자식의 좌측 노드인지 알아야 함
            self.connectParentTo(child: left)
        }
    } else if let right = rightChild {
        // 대상 노드가 우측 자식 요소를 지닌 경우 ->
        // 대상 노드의 parent와 child를 바로 연결함
        // 이를 위해서는 먼저 대상 노드가 부모 노드의 좌측 서브트리에
        // 속한 자식의 우측 노드인지 알아야 함
        self.connectParentTo(child: right)
    } else {
        self.connectParentTo(child: nil)
    }

    // 노드 참조값을 삭제
    parent = nil
    leftChild = nil
    rightChild = nil
}

// 삭제 대상 노드의 후손을 위해 노드 교환을 수행
private func exchangeWithSuccessor() {
    guard let right = rightChild, let left = leftChild else {
        return
    }

    let successor = right.minimum()
    successor.delete()

    // 대상 노드와 교환 작업
    successor.leftChild = left
    left.parent = successor

    if right !== successor {
        successor.rightChild = right
        right.parent = successor
    } else {
        successor.rightChild = nil
    }
    self.connectParentTo(child: successor)
}

// 대상 노드의 부모와 자식을 연결
private func connectParentTo(child: BinaryTreeNode?) {
    guard let parent = self.parent else {
        child?.parent = self.parent
        return
    }

    if parent.leftChild === self {
        parent.leftChild = child
        child?.parent = parent
    } else if parent.rightChild === self {
        parent.rightChild = child
        child?.parent = parent
    }
}
```


&nbsp;
## 이진 검색 트리 구현
```
public class BinaryTreeNode<T: Comparable> {
    // 키값과 자식 노드를 위한 변수
    public var value: T
    public var leftChild: BinaryTreeNode?
    public var rightChild: BinaryTreeNode?
    public weak var parent: BinaryTreeNode?

    // 초기화
    public convenience init(value: T) {
        self.init(value: value, left: nil, right: nil, parent: nil)
    }

    public init(value: T, left: BinaryTreeNode?, right: BinaryTreeNode?, parent: BinaryTreeNode?) {
        self.value = value
        self.leftChild = left
        self.rightChild = right
        self.parent = parent
    }

    // MARK: - 이진 검색 트리 삽입
    public func insertNodeFromRoot(value: T) {
        // 이진 검색 트리의 프로퍼티를 유지하기 위해서는
        // 반드시 루트 노드에서부터 insertNode 작업이 실행되어야 함
        if let _ = self.parent {
            // 부모 노드가 있다면 트리의 루트 노드가 아님
            print("루트 노드가 아닙니다.")
            return
        }
        // 루트 노드에서부터 새로운 노드 삽입은 private 함수인 addNode를 사용한다.
        self.addNode(value: value)
    }

    private func addNode(value: T) {
        // 재귀적으로 나머지 노드를 순회하면서 새로운 노드를 삽입할 적절한 위치를 찾는다.
        if value < self.value {
            // value가 루트 키값보다 작은 경우: 좌측 서브트리에 삽입
            // 노드가 존재하는 경우 좌측 서브트리에 삽입하고,
            // 노드가 없는 경우 새로운 노드를 만들어서 좌측 자식 노드로 삽입
            if let leftChild = leftChild {
                leftChild.addNode(value: value)
            } else {
                let newNode = BinaryTreeNode(value: value)
                newNode.parent = self
                leftChild = newNode
            }
        } else {
            // value가 루트 키값보다 큰 경우: 우측 서브트리에 삽입
            // 노드가 존재하는 경우 우측 서브트리에 삽입하고,
            // 노드가 없는 경우 새로운 노드를 만들어서 우측 자식 노드로 삽입
            if let rightChild = rightChild {
                rightChild.addNode(value: value)
            } else {
                let newNode = BinaryTreeNode(value: value)
                newNode.parent = self
                rightChild = newNode
            }
        }
    }

    // MARK: - 이진 검색 트리 순회
    // 재귀적으로 노드를 순회하는 인오더 트리 워크
    public class func traverseInOrder(node: BinaryTreeNode?) {
        // nil인 잎에 도달하면 재귀적인 함수 호출이 중단됨
        guard let node = node else {
            return
        }

        // leftChild에서 재귀적으로 메서드를 호출하고
        // 노드의 값을 출력한 뒤, rightChild로 이동
        BinaryTreeNode.traverseInOrder(node: node.leftChild)
        print(node.value)
        BinaryTreeNode.traverseInOrder(node: node.rightChild)
    }

    // 재귀적으로 노드를 순회하는 프리오더 트리 워크
    public class func traversePreOrder(node: BinaryTreeNode?) {
        // nil인 잎에 도달하면 재귀적인 함수 호출이 중단됨
        guard let node = node else {
            return
        }

        // 재귀적으로 메서드를 호출하면서 노드의 값을 출력한 뒤
        // leftChild와 rightChild를 순회
        print(node.value)
        BinaryTreeNode.traversePreOrder(node: node.leftChild)
        BinaryTreeNode.traversePreOrder(node: node.rightChild)
    }

    // 재귀적으로 노드를 순회하는 포스트오더 트리 워크
    public class func traversePostOrder(node: BinaryTreeNode?) {
        // nil인 잎에 도달하면 재귀적인 함수 호출이 중단됨
        guard let node = node else {
            return
        }

        // 재귀적으로 메서드를 호출하면서 leftChild에서 시작해서
        // rightChild를 순회한 뒤, 노드의 값을 출력
        BinaryTreeNode.traversePostOrder(node: node.leftChild)
        BinaryTreeNode.traversePostOrder(node: node.rightChild)
        print(node.value)
    }

    // MARK: - 이진 검색 트리 검색
    public func search(value: T) -> BinaryTreeNode? {
        // 키값을 찾은 경우
        if value == self.value {
            return self
        }

        // 해당 키값이 현재 노드의 키값보다 작은 경우
        // 좌측 서브트리에서 재귀적으로 검색을 시작
        // 그렇지 않은 경우 우측 서브트리에서 검색 시작
        // 값이 없다면 nil을 반환
        if value < self.value {
            guard let left = leftChild else {
                return nil
            }
            return left.search(value: value)
        } else {
            guard let right = rightChild else {
                return nil
            }
            return right.search(value: value)
        }
    }

    // MARK: - 이진 검색 트리 삭제
    public func delete() {
        if let left = leftChild {
            if let _ = rightChild {
                // 대상 노드가 좌측 및 우측, 두 개의 자식 요소를 모두 지닌 경우 ->
                // 후손 교환 작업 수행
                self.exchangeWithSuccessor()
            } else {
                // 대상 노드가 좌측 자식 요소를 지닌 경우 ->
                // 대상 노드의 parent와 child를 바로 연결함
                // 이를 위해서는 먼저 대상 노드가 부모 노드의 우측 서브트리에
                // 속한 자식의 좌측 노드인지 알아야 함
                self.connectParentTo(child: left)
            }
        } else if let right = rightChild {
            // 대상 노드가 우측 자식 요소를 지닌 경우 ->
            // 대상 노드의 parent와 child를 바로 연결함
            // 이를 위해서는 먼저 대상 노드가 부모 노드의 좌측 서브트리에
            // 속한 자식의 우측 노드인지 알아야 함
            self.connectParentTo(child: right)
        } else {
            self.connectParentTo(child: nil)
        }

        // 노드 참조값을 삭제
        parent = nil
        leftChild = nil
        rightChild = nil
    }

    // 삭제 대상 노드의 후손을 위해 노드 교환을 수행
    private func exchangeWithSuccessor() {
        guard let right = rightChild, let left = leftChild else {
            return
            }

        let successor = right.minimum()
        successor.delete()

        // 대상 노드와 교환 작업
        successor.leftChild = left
        left.parent = successor

        if right !== successor {
            successor.rightChild = right
            right.parent = successor
        } else {
            successor.rightChild = nil
        }
        self.connectParentTo(child: successor)
    }

    // 대상 노드의 부모와 자식을 연결
    private func connectParentTo(child: BinaryTreeNode?) {
        guard let parent = self.parent else {
            child?.parent = self.parent
            return
        }

        if parent.leftChild === self {
            parent.leftChild = child
            child?.parent = parent
        } else if parent.rightChild === self {
            parent.rightChild = child
            child?.parent = parent
        }
    }

    // MARK: - 도우미 메서드
    // 트리 내 최솟값 확인
    public func minimumValue() -> T {
        if let left = leftChild {
            return left.minimumValue()
        } else {
            return value
        }
    }

    // 트리 내 최댓값 확인
    public func maximumValue() -> T {
        if let right = rightChild {
            return right.maximumValue()
        } else {
            return value
        }
    }

    // 트리 내 최소 노드 반환
    public func minimum() -> BinaryTreeNode {
        if let left = leftChild {
            return left.minimum()
        } else {
            return self
        }
    }

    // 트리 내 최대 노드 반환
    public func maximum() -> BinaryTreeNode {
        if let right = rightChild {
            return right.maximum()
        } else {
            return self
        }
    }

    // 트리의 높이
    public func height() -> Int {
        if leftChild == nil && rightChild == nil {
            return 0
        }
        return 1 + max(leftChild?.height() ?? 0, rightChild?.height() ?? 0)
    }

    // 트리의 깊이
    public func depth() -> Int {
        guard var node = parent else {
            return 0
        }

        var depth = 1
        while let parent = node.parent {
            depth += 1
            node = parent
        }
        return depth
    }
}
```

&nbsp;
&nbsp;      
### [by. 0junChoi](https://github.com/0jun0815) email: <0jun0815@gmail.com>
### 출처: [스위프트 데이터 구조와 알고리즘](http://acornpub.co.kr/book/swift-structure-algorithms)
