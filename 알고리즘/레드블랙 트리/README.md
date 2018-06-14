# 레드블랙 트리


* [개요](#개요)
* [레드블랙 트리 노드의 구현](#레드블랙-트리-노드의-구현)
* [회전](#회전)
    * [우측 회전](#우측-회전)
    * [좌측 회전](#좌측-회전)
* [삽입](#삽입)
* [레드블랙 트리 구현](#레드블랙-트리-구현)


&nbsp;
## 개요
레드블랙 트리는 이진 검색 트리와 유사하며, 모든 노드에 컬러라는 새로운 파라미터를 추가한다는 점만 다르다. 노드에는 키값, 컬러, 부모에 대한 참조값, 좌측 자식과 우측 자식에 대한 참조값이 포함돼야 한다.


레드블랙 트리는 다음과 같은 컬러 조건을 충족해야 한다:
1. 모든 노드는 레드 또는 블랙 컬러 중 하나가 된다.
2. 루트는 블랙이다.
3. 모든 NULL/nil 잎은 블랙이다.
4. 모든 레드 노드의 자식은 블랙 노드가 된다.
5. 트리 내 모든 노드에 대해, 노드에서 자손 잎으로 이어지는 경로에는 동일한 수의 블랙 노드가 포함된다.


레드블랙 트리 데이터 구조


![레드블랙 트리](https://github.com/0jun0815/YJStudy/blob/master/알고리즘/레드블랙%20트리/images/레드블랙%20트리.png)


레드블랙 트리는 트리 높이가 같은 상황에서 데이터와 관련된 주요 작업인 검색, 삽입, 삭제 등에서 최악의 시나리오를 보장한다. 따라서 최악의 시나리오 상황을 미리 파악해야 하는 실시간 데이터 처리 작업 및 관련 애플리케이션 구현에 자주 활용된다.


레드블랙 트리는 다음과 같은 시간과 공간의 복잡성을 지닌다(n은 트리 내 노드의 수):
* 검색 시간: 평균 및 최악의 상황에서의 시간 = O(logn)
* 삽입 시간: 평균 및 최악의 상황에서의 시간 = O(logn)
* 삭제 시간: 평균 및 최악의 상황에서의 시간 = O(logn)
* 작업 공간: 평균 및 최악의 상황에서의 공간 = O(n)


&nbsp;
## 레드블랙 트리 노드의 구현
```
// 노드에 적용 가능한 컬러를 열거형으로 정의
public enum RedBlackTreeColor: Int {
    case red = 0
    case black = 1
}

// 키값, 자식, 부모 참조값, 컬러 속성이 포함된 레드블랙 트리 노드
public class RedBlackTreeNode<T: Comparable> {
    // 키값과 자식-부모 변수
    public var value: T
    public var leftChild: RedBlackTreeNode?
    public var rightChild: RedBlackTreeNode?
    public weak var parent: RedBlackTreeNode?
    // 컬러 변수
    public var color: RedBlackTreeColor
    
    // 초기화
    public convenience init(value: T) {
        self.init(value: value, left: nil, right: nil, parent: nil, color: RedBlackTreeColor.black)
    }

    public init(value: T, left: RedBlackTreeNode?, right: RedBlackTreeNode?, parent: RedBlackTreeNode?, color: RedBlackTreeColor) {
        self.value = value
        self.color = color
        leftChild = left
        rightChild = right
        self.parent = parent
    }

    // MARK: - 도우미 메서드
    // 노드의 조부모 노드를 반환하거나, 해당 노드가 없을 경우 nil을 반환함
    public func grandParentNode() -> RedBlackTreeNode? {
        guard let grandParent = parent?.parent else {
            return nil
        }
        return grandParent
    }

    // 노드의 삼촌 노드를 반환하거나, 해당 노드가 없을 경우 nil을 반환함
    // 삼촌 노드는 부모 노드의 형제를 의미함
    public func uncleNode() -> RedBlackTreeNode? {
        guard let grandParent = grandParentNode() else {
            return nil
        }
        if parent === grandParent.leftChild {
            return grandParent.rightChild
        } else {
            return grandParent.leftChild
        }
    }

    // 트리의 상단에서 하단에 이르는 모든 계층을
    // 그에 포함된 노드의 값과 컬러를 포함해서 출력
    public static func printTree(nodes: [RedBlackTreeNode]) {
        var children = [RedBlackTreeNode]()
        for node in nodes {
            print("\(node.value) \(node.color)")
            if let leftChild = node.leftChild {
                children.append(leftChild)
            }
            if let rightChild = node.rightChild {
                children.append(rightChild)
            }
        }
        if children.count > 0 {
            printTree(nodes: children)
        }
    }
    
    ...
```


&nbsp;
## 회전
트리 회전은 트리에 포함된 노드를 이동시키는 방법으로, (모든 자식 노드에 균일하게 적용됨과 동시에) 해당 노드의 높이를 다른 위치로 변경할 수 있다.


&nbsp;
### 우측 회전


![우측 회전](https://github.com/0jun0815/YJStudy/blob/master/알고리즘/레드블랙%20트리/images/우측%20회전.jpg)


다음 단계에 따라 우측 회전을 시행한다:
1. 노드 X는 회전 후 새로운 트리의 루트 노드가 되기 위해 위로 올라간다. 노드 X의 부모 노드 Y는 우측 자식 요소가 된다(Y의 값이 더 크므로 우측 서브트리에 있어야 한다).
2. 노드 Y의 부모 노드가 있는 경우 노드 X의 부모 요소가 된다.
3. 노드 X의 우측 자식 노드는 새로운 자식 요소인 노드 Y의 좌측 자식이 된다.


#### 우측 회전 구현
```
// 우측 회전
public func rotateRight() {
    guard let parent = parent else {
        return
    }

    // 나중의 사용을 위해 임시 참조값을 저장함
    let grandParent = grandParentNode() // parent.parent
    let newRightChildsLeftChild = rightChild
    var wasLeftChild = false
    if parent === grandParent?.leftChild {
        wasLeftChild = true
    }

    // 기존의 부모 노드가 새 우측 자식 노드가 됨
    rightChild = parent
    rightChild?.parent = self

    // 기존의 조부모 노드가 새 부모 노드가 됨
    self.parent = grandParent
    if wasLeftChild {
        grandParent?.leftChild = self
    } else {
        grandParent?.rightChild = self
    }

    // 기존 우측 자식 노드가 새로운 우측 자식의 좌측 자식 노드가 됨
    rightChild?.leftChild = newRightChildsLeftChild
    rightChild?.leftChild?.parent = rightChild
}
```


우측 회전의 주요 절차는 다음과 같다:
1. 초깃값 설정에서 나중의 사용을 위해 참조값을 저장해둔다.
2. 노드 X의 부모였던 노드 Y는 이제 노드 X의 우측 자식 요소가 된다.
3. 노드 Y의 기존의 부모 요소가 있다면, 이를 노드 X의 새로운 부모 요소로 삼는다.
4. 노드 X의 우측 자식 요소를 노드 Y의 좌측 자식 요소로 삼는다.


&nbsp;
### 좌측 회전


![좌측 회전](https://github.com/0jun0815/YJStudy/blob/master/알고리즘/레드블랙%20트리/images/좌측%20회전.jpg)


다음 단계에 따라 좌측 회전을 시행한다:
1. 회전 후 노드 X는 새로운 트리의 좌측 자식 노드가 된다. 노드 X의 우측 자식 요소였던 노드 Y는 노드 X의 부모가 된다(노드 Y의 값이 더 크므로 노드 X는 노드 Y의 좌측 서브트리에 위치한다).
2. 노드 X가 부모 요소를 지닌 경우 노드 Y의 부모가 된다.
3. 노드 Y의 좌측 자식 요소는 그 자식 노드인 X의 우측 자식 요소가 된다.


#### 좌측 회전 구현
```
// 좌측 회전
public func rotateLeft() {
    guard let parent = parent else {
        return
    }

    // 나중의 사용을 위해 임시 참조값을 저장함
    let grandParent = grandParentNode()
    let newLeftChildsRightChild = leftChild
    var wasLeftChild = false
    if parent === grandParent?.leftChild {
        wasLeftChild = true
    }

    // 기존의 부모 노드가 새 좌측 자식 노드가 됨
    leftChild = parent
    leftChild?.parent = self

    // 기존의 조부모 노드가 새로운 부모 노드가 됨
    self.parent = grandParent
    if wasLeftChild {
        grandParent?.leftChild = self
    } else {
        grandParent?.rightChild = self
    }

    // 기존의 좌측 자식 요소는 새로운 좌측 자식의 우측 자식 노드가 됨
    leftChild?.rightChild = newLeftChildsRightChild
    leftChild?.rightChild?.parent = leftChild
}
```


좌측 회전의 주요 절차는 다음과 같다:
1. 초깃값 설정에서 나중의 사용을 위해 참조값을 저장해 둔다.
2. 노드 Y의 부모였던 노드 X는 이제 노드 Y의 좌측 자식 요소가 된다.
3. 노드 X의 기존의 부모 요소가 있다면, 이를 노드 Y의 새로운 부모 요소로 삼는다.
4. 노드 Y의 좌측 자식 요소를 노드 X의 우측 자식 요소로 삼는다.


&nbsp;
## 삽입
다섯 가지 컬러 조건을 충족해야 하기 때문에, 레드블랙 트리에서의 삽입 작업은 꽤 복잡한 편이다. 삽입 작업은 컬러 조건에 따라 다른 시나리오가 적용되며, 어떤 경우에도 컬러 조건에 부합한 상태에서 삽입 작업이 진행되도록 해야 한다.


다음과 같은 두 가지 단계로 삽입 작업을 진행한다:
1. 기본 컬러를 레드로 설정한 상태에서 이진 검색 트리의 방식으로 노드를 삽입한다.
2. 첫 번째 단계가 진행되면서 컬러 조건중 일부가 깨졌다면, 트리 컬러 구조와 노드를 수정해서 깨진 조건을 바로 잡는다.


#### 삽입 구현
```
// 삽입 메서드
public func insertNodeFromRoot(value: T) {
    // 이진 검색 트리의 속성을 유지하기 위해
    // 루트 노드에서 insertNode 작업을 수행해야 함
    if let _ = parent {
        // 부모 노드가 있다면, 그 노드는 루트가 아님
        return
    }
    addNode(value: value)
}

private func addNode(value: T) {
    if value < self.value {
        // 해당 값이 루트의 값보다 작은 경우,
        // 좌측 서브트리에 노드를 삽입
        // 좌측 서브트리가 존재한다면 해당 위치에 삽입하고,
        // 그렇지 않은 경우, 새로운 노드 생성 후 좌측 자식 요소로 추가
        if let leftChild = leftChild {
            leftChild.addNode(value: value)
        } else {
            let newNode =  RedBlackTreeNode(value: value)
            newNode.parent = self
            newNode.color = .red
            leftChild = newNode
            // 트리 컬러 구조를 확인
            insertionReviewStep1(node: newNode)
        }
    } else {
        // 해당 값이 루트의 값보다 큰 경우,
        // 우측 서브트리에 노드를 삽입
        // 우측 서브트리가 존재한다면 해당 위치에 삽입하고,
        // 그렇지 않은 경우, 새로운 노드 생성 후 우측 자식 요소로 추가
        if let rightChild = rightChild {
            rightChild.addNode(value: value)
        } else {
            let newNode = RedBlackTreeNode(value: value)
            newNode.parent = self
            newNode.color = .red
            rightChild = newNode
            // 트리 컬러 구조를 확인
            insertionReviewStep1(node: newNode)
        }
    }
}
```


#### 트리 컬러 구조의 확인 작업은 다섯 가지 시나리오를 따른다.


1. 추가하려는 노드가 트리의 첫 번째 노드인 경우, 해당 요소는 루트 노드가 된다. 레드 블랙 트리의 루트 노드는 블랙이어야 한다. 이번 메서드는 그런 상황을 확신한 상태에서 사용된다.
```
// 1. 루트 노드는 블랙이다.
private func insertionReviewStep1(node: RedBlackTreeNode) {
    if let _ = node.parent {
        insertionReviewStep2(node: node)
    } else {
        node.color = .black
    }
}
```


2. 두 번째 단계에서, 추가하려는 노드의 부모 컬러가 레드 혹은 블랙인지 확인한다. 만일 블랙이라면, 아무 문제 없이 노드를 추가할 수 있다(컬러 조건에 따라, 올바른 레드블랙 트리라면 부모는 블랙, 자식은 레드이면 된다).
```
// 2. 부모 노드가 블랙인가?
private func insertionReviewStep2(node: RedBlackTreeNode) {
    if node.parent?.color == .black {
        return
    }
    insertionReviewStep3(node: node)
}
```


3. 세 번째 단계에서, 추가하려는 노드의 부모와 삼촌이 레드인지 확인한다. 레드라면 이들 요소의 컬러를 블랙으로 바꾸고 조부모의 컬러는 레드로 바꾼다. 이렇게 하면 해당 부분은 레드블랙 트리의 규칙에 부합하게 된다. 하지만, (루트 노드일지도 모르는) 조부모 노드를 레드로 바꾸면, 루트는 블랙이어야 한다는 두 번째 규칙을 어기게 된다. 이를 바로잡기 위해 조부모 요소를 있는 그대로 놔둔채, 해당 노드를 삽입하고 첫 번째 단계와 동일한 과정을 거친다.


![세 번째 단계](https://github.com/0jun0815/YJStudy/blob/master/알고리즘/레드블랙%20트리/images/세%20번째%20단계.jpg)


```
// 3. 부모와 삼촌이 레드인가?
private func insertionReviewStep3(node: RedBlackTreeNode) {
    if let uncle = node.uncleNode() {
        if uncle.color == .red {
            node.parent?.color = .black
            uncle.color = .black
            if let grandParent = node.grandParentNode() {
                grandParent.color = .red
                insertionReviewStep1(node: grandParent)
            }
            return
        }
    }
    insertionReviewStep4(node: node)
}
```


4. 네 번째 단계에 이르면 남은 가능성은 부모는 레드, 삼촌은 블랙일 수 있다는 것이다. 이번에는 조부모 G의 좌측 자식 요소인 부모 P의 우측 자식 노드가 n이 되도록 한다(그 반대의 경우도 동일하다).


![네 번째 단계](https://github.com/0jun0815/YJStudy/blob/master/알고리즘/레드블랙%20트리/images/네%20번째%20단계.jpg)


* 회전을 한 다음 n과 P의 역할을 바꾼다. n은 P의 부모가 된다. 그래서 다음 단계를 시행하면 n과 P의 라벨이 바뀌게 된다.


```
// 4. 부모는 레드, 삼촌은 블랙인 경우, 해당 노드는
// 우측 자식의 좌측 자식 또는 좌측 자식의 우측 자식 노드임
private func insertionReviewStep4(node: RedBlackTreeNode) {
    var node = node
    guard let grandParent = node.grandParentNode() else {
        return
    }
    if node === node.parent?.rightChild && node.parent === grandParent.leftChild {
        node.parent?.rotateLeft()
        node = node.leftChild!
    } else if node === node.parent?.leftChild && node.parent === grandParent.rightChild {
        node.parent?.rotateRight()
        node = node.rightChild!
    }
    insertionReviewStep5(node: node)
}
```


5. 마지막 단계에 이르면 다음과 같은 모습이 된다.


![다섯 번째 단계](https://github.com/0jun0815/YJStudy/blob/master/알고리즘/레드블랙%20트리/images/다섯%20번째%20단계.jpg)


* 노드 n과 부모 노드 P 모두 레드이고, 이들은 각각 부모 요소의 좌측 자식 요소가 된다(만일 이들 요소가 우측 자식인 경우 반대의 회전 작업을 시행한다).
* G를 우측으로 회전시키고 P와 G의 컬러를 교환하면 다음과 같은 모습이 된다:


![마지막 단계](https://github.com/0jun0815/YJStudy/blob/master/알고리즘/레드블랙%20트리/images/마지막%20단계.jpg)


```
// 5. 부모는 레드, 삼촌은 블랙인 경우, 노드는 좌측 자식의 좌측 자식 노드
// 또는 우측 자식의 우측 자식 노드가 된다.
private func insertionReviewStep5(node: RedBlackTreeNode) {
    guard let grandParent = node.grandParentNode() else {
        return
    }
    node.parent?.color = .black
    grandParent.color = .red
    if node === node.parent?.leftChild {
        grandParent.rotateRight()
    } else {
        grandParent.rotateLeft()
    }
}
```


다섯 단계를 거치면서 노드를 삽입하고 레드블랙 트리의 고유의 속성을 유지할 수 있게 되었다.


&nbsp;
## 레드블랙 트리 구현
```
// 노드에 적용 가능한 컬러를 열거형으로 정의
public enum RedBlackTreeColor: Int {
    case red = 0
    case black = 1
}

// 키값, 자식, 부모 참조값, 컬러 속성이 포함된 레드블랙 트리 노드
public class RedBlackTreeNode<T: Comparable> {
    // 키값과 자식-부모 변수
    public var value: T
    public var leftChild: RedBlackTreeNode?
    public var rightChild: RedBlackTreeNode?
    public weak var parent: RedBlackTreeNode?
    // 컬러 변수
    public var color: RedBlackTreeColor
    
    // 초기화
    public convenience init(value: T) {
        self.init(value: value, left: nil, right: nil, parent: nil, color: RedBlackTreeColor.black)
    }

    public init(value: T, left: RedBlackTreeNode?, right: RedBlackTreeNode?, parent: RedBlackTreeNode?, color: RedBlackTreeColor) {
        self.value = value
        self.color = color
        leftChild = left
        rightChild = right
        self.parent = parent
    }

    // MARK: - 도우미 메서드
    // 노드의 조부모 노드를 반환하거나, 해당 노드가 없을 경우 nil을 반환함
    public func grandParentNode() -> RedBlackTreeNode? {
        guard let grandParent = parent?.parent else {
            return nil
        }
        return grandParent
    }

    // 노드의 삼촌 노드를 반환하거나, 해당 노드가 없을 경우 nil을 반환함
    // 삼촌 노드는 부모 노드의 형제를 의미함
    public func uncleNode() -> RedBlackTreeNode? {
        guard let grandParent = grandParentNode() else {
            return nil
        }
        if parent === grandParent.leftChild {
            return grandParent.rightChild
        } else {
            return grandParent.leftChild
        }
    }

    // 트리의 상단에서 하단에 이르는 모든 계층을
    // 그에 포함된 노드의 값과 컬러를 포함해서 출력
    public static func printTree(nodes: [RedBlackTreeNode]) {
        var children = [RedBlackTreeNode]()
        for node in nodes {
            print("\(node.value) \(node.color)")
            if let leftChild = node.leftChild {
                children.append(leftChild)
            }
            if let rightChild = node.rightChild {
                children.append(rightChild)
            }
        }
        if children.count > 0 {
            printTree(nodes: children)
        }
    }

    // MARK: - 트리 회전
    // 우측 회전
    public func rotateRight() {
        guard let parent = parent else {
            return
        }

        // 나중의 사용을 위해 임시 참조값을 저장함
        let grandParent = grandParentNode() // parent.parent
        let newRightChildsLeftChild = rightChild
        var wasLeftChild = false
        if parent === grandParent?.leftChild {
            wasLeftChild = true
            }

        // 기존의 부모 노드가 새 우측 자식 노드가 됨
        rightChild = parent
        rightChild?.parent = self

        // 기존의 조부모 노드가 새 부모 노드가 됨
        self.parent = grandParent
        if wasLeftChild {
            grandParent?.leftChild = self
        } else {
            grandParent?.rightChild = self
        }

        // 기존 우측 자식 노드가 새로운 우측 자식의 좌측 자식 노드가 됨
        rightChild?.leftChild = newRightChildsLeftChild
        rightChild?.leftChild?.parent = rightChild
    }

    // 좌측 회전
    public func rotateLeft() {
        guard let parent = parent else {
            return
        }

        // 나중의 사용을 위해 임시 참조값을 저장함
        let grandParent = grandParentNode()
        let newLeftChildsRightChild = leftChild
        var wasLeftChild = false
        if parent === grandParent?.leftChild {
            wasLeftChild = true
        }

        // 기존의 부모 노드가 새 좌측 자식 노드가 됨
        leftChild = parent
        leftChild?.parent = self

        // 기존의 조부모 노드가 새로운 부모 노드가 됨
        self.parent = grandParent
        if wasLeftChild {
            grandParent?.leftChild = self
        } else {
            grandParent?.rightChild = self
        }

        // 기존의 좌측 자식 요소는 새로운 좌측 자식의 우측 자식 노드가 됨
        leftChild?.rightChild = newLeftChildsRightChild
        leftChild?.rightChild?.parent = leftChild
    }

    // MARK: - 삽입
    // 삽입 메서드
    public func insertNodeFromRoot(value: T) {
        // 이진 검색 트리의 속성을 유지하기 위해
        // 루트 노드에서 insertNode 작업을 수행해야 함
        if let _ = parent {
            // 부모 노드가 있다면, 그 노드는 루트가 아님
            return
        }
        addNode(value: value)
    }

    private func addNode(value: T) {
        if value < self.value {
            // 해당 값이 루트의 값보다 작은 경우,
            // 좌측 서브트리에 노드를 삽입
            // 좌측 서브트리가 존재한다면 해당 위치에 삽입하고,
            // 그렇지 않은 경우, 새로운 노드 생성 후 좌측 자식 요소로 추가
            if let leftChild = leftChild {
                leftChild.addNode(value: value)
            } else {
                let newNode =  RedBlackTreeNode(value: value)
                newNode.parent = self
                newNode.color = .red
                leftChild = newNode
                // 트리 컬러 구조를 확인
                insertionReviewStep1(node: newNode)
            }
        } else {
            // 해당 값이 루트의 값보다 큰 경우,
            // 우측 서브트리에 노드를 삽입
            // 우측 서브트리가 존재한다면 해당 위치에 삽입하고,
            // 그렇지 않은 경우, 새로운 노드 생성 후 우측 자식 요소로 추가
            if let rightChild = rightChild {
                rightChild.addNode(value: value)
            } else {
                let newNode = RedBlackTreeNode(value: value)
                newNode.parent = self
                newNode.color = .red
                rightChild = newNode
                // 트리 컬러 구조를 확인
                insertionReviewStep1(node: newNode)
            }
        }
    }

    // 1. 루트 노드는 블랙이다.
    private func insertionReviewStep1(node: RedBlackTreeNode) {
        if let _ = node.parent {
            insertionReviewStep2(node: node)
        } else {
            node.color = .black
        }
    }

    // 2. 부모 노드가 블랙인가?
    private func insertionReviewStep2(node: RedBlackTreeNode) {
        if node.parent?.color == .black {
            return
        }
        insertionReviewStep3(node: node)
    }

    // 3. 부모와 삼촌이 레드인가?
    private func insertionReviewStep3(node: RedBlackTreeNode) {
        if let uncle = node.uncleNode() {
            if uncle.color == .red {
                node.parent?.color = .black
                uncle.color = .black
                if let grandParent = node.grandParentNode() {
                    grandParent.color = .red
                    insertionReviewStep1(node: grandParent)
                }
                return
            }
        }
        insertionReviewStep4(node: node)
    }

    // 4. 부모는 레드, 삼촌은 블랙인 경우, 해당 노드는
    // 우측 자식의 좌측 자식 또는 좌측 자식의 우측 자식 노드임
    private func insertionReviewStep4(node: RedBlackTreeNode) {
        var node = node
        guard let grandParent = node.grandParentNode() else {
            return
        }
        if node === node.parent?.rightChild && node.parent === grandParent.leftChild {
            node.parent?.rotateLeft()
            node = node.leftChild!
        } else if node === node.parent?.leftChild && node.parent === grandParent.rightChild {
            node.parent?.rotateRight()
            node = node.rightChild!
        }
        insertionReviewStep5(node: node)
    }

    // 5. 부모는 레드, 삼촌은 블랙인 경우, 노드는 좌측 자식의 좌측 자식 노드
    // 또는 우측 자식의 우측 자식 노드가 된다.
    private func insertionReviewStep5(node: RedBlackTreeNode) {
        guard let grandParent = node.grandParentNode() else {
            return
        }
        node.parent?.color = .black
        grandParent.color = .red
        if node === node.parent?.leftChild {
            grandParent.rotateRight()
        } else {
            grandParent.rotateLeft()
        }
    }
}
```


&nbsp;
&nbsp;      
### [by. 0junChoi](https://github.com/0jun0815) email: <0jun0815@gmail.com>
### 출처: [스위프트 데이터 구조와 알고리즘](http://acornpub.co.kr/book/swift-structure-algorithms)
