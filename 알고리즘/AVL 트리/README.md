# AVL 트리


* [개요](#개요)
    * [AVL 트리 노드 구현](#avl-트리-노드-구현)
* [AVL 트리 회전](#avl-트리-회전)
    * [좌측 단순 회전](#좌측-단순-회전)
    * [우측 단순 회전](#우측-단순-회전)
    * [우좌 이중 회전](#우좌-이중-회전)
    * [좌우 이중 회전](#좌우-이중-회전)
* [검색](#검색)
* [삽입](#삽입)



&nbsp;
## 개요
AVL 트리는 최초의 자체 균형 이진 검색 트리이다.


특징은 서브트리 노드의 높이가 N일 때, 동일한 노드의 또 다른 서브트리의 높이는 [N - 1, N + 1] 범위 내에 있어야만 한다는 것이다. 이는 좌우의 자식 요소의 높이가 항상 달라야 함을 의미한다.


두 서브트리의 높이차를 균형 요소 또는 밸런스 팩터라 한다.
* Balance factor = Height(RightSubtree) - Height(LeftSubtree)


![AVL트리](https://github.com/0jun0815/YJStudy/blob/master/알고리즘/AVL%20트리/images/AVL트리.jpg)


위 그림에서, AVL 트리의 균형 요소는 모든 노드에 대해 [-1, 1]의 범위에 있고, 잎들은 각각 0의 균형 요소를 가진다.
* 균형 요소가 < 0인 경우, 해당 노드는 좌측이 무겁다고 하고
* 균형 요소가 = 0인 경우, 해당 노드는 균형이 잡혔다고 하고
* 균형 요소가 > 0인 경우, 해당 노드는 우측이 무겁다고 한다.


AVL 트리는 아래와 같은 성능 특성을 지닌다(n은 트리의 노드 수).
* 검색: 평균 및 최악의 복잡성 하에서 시간 = O(logn)
* 삽입: 평균 및 최악의 복잡성 하에서 시간 = O(logn)
* 삭제: 평균 및 최악의 복잡성 하에서 시간 = O(logn)
* 공간: 평균 및 최악의 복잡성 = O(n)


검색과 같은 읽기 작업은 레드블랙 트리보다 빠른데, 이는 AVL 트리가 좀 더 균형이 맞는 구조이기 때문이다.


삽입과 삭제 작업은 레드블랙 트리보다 느리며, 이는 AVL 트리가 [-1, 1]이라는 균형 조건에 따라 데이터 구조의 균형을 잡는 작업을 함께 수행해야 하기 때문이다.


&nbsp;
### AVL 트리 노드 구현
```
public class AVLTreeNode<T: Comparable> {
    // 키값과 자식-부모 변수
    public var value: T
    public var leftChild: AVLTreeNode?
    public var rightChild: AVLTreeNode?
    public weak var parent: AVLTreeNode?
    public var balanceFactor: Int = 0

    // 초기화
    public convenience init(value: T) {
        self.init(value: value, left: nil, right: nil, parent: nil)
    }

    public init(value: T, left: AVLTreeNode?, right: AVLTreeNode?, parent: AVLTreeNode?) {
        self.value = value
        leftChild = left
        rightChild = right
        self.parent = parent
        balanceFactor = 0
    }
    ...
```


* 이진 검색 트리와 매우 유사하고 단지 balanceFactor라는 프로퍼티를 통해 균형 요소를 저장한 부분만 다르다.
* 기본적으로 균형 요소 값은 0이고, 이는 트리에 새로운 AVL 노드를 추가할 때 해당 트리에서 서브트리가 없는 경우 높이는 처음부터 0이기 때문이다.


&nbsp;
## AVL 트리 회전
트리 회전은 (다른 모든 자식 요소의 속성을 균등하게 유지하면서) 특정 노드의 높이를 변경하기 위해 트리의 노드를 다른 위치로 이동시킬 수 있는 기법이다.


AVL 트리 회전은 다음 두 단계에 따라 이뤄진다:
1. 스스로 회전한다.
2. 회전 과정에 포함된 노드의 balanceFactor를 업데이트한다.


회전 동작에는 다음과 같은 네 가지 타입이 있다.
* 좌측 단순 회전(Simple rotation left)
* 우측 단순 회전(Simple rotation right)
* 우좌 이중 회전(Double rotation-right-left)
* 좌우 이중 회전(Double rotation-left-right)


&nbsp;
### 좌측 단순 회전
다음 조건이 충족되면 좌측 단순 회전을 시행한다:
1. 노드 X가 노드 Y의 부모이다.
2. 노드 Y가 노드 X의 우측 자식이다.
3. 노드 Y는 좌측이 무겁지 않다(따라서 높이는 0보다 작지 않음).
4. 노드 X의 균형 요소는 +2 이다.


![좌측 회전](https://github.com/0jun0815/YJStudy/blob/master/알고리즘/AVL%20트리/images/좌측%20회전.jpg)


#### 좌측 단순 회전 구현
```
// 좌측 단순 회전
public func rotateLeft() -> AVLTreeNode {
    guard let parent = parent else {
        return self
    }

    // 1단계: 회전
    // 나중에 사용할 수 있도록 임시 참조값을 저장
    let grandParent = parent.parent
    let newLeftChildsRightChild = leftChild
    var wasLeftChild = false
    if parent === grandParent?.leftChild {
        wasLeftChild = true
    }

    // 기존의 부모 노드가 새로운 좌측 자식 노드가 됨
    leftChild = parent
    leftChild?.parent = self

    // 기존의 조부모 노드가 새로운 부모 노드가 됨
    self.parent = grandParent
    if wasLeftChild {
        grandParent?.leftChild = self
    } else {
        grandParent?.rightChild = self
    }

    // 기존의 좌측 자식 노드가 새로운 좌측 자식의 우측 자식 노드가 됨
    leftChild?.rightChild = newLeftChildsRightChild
    leftChild?.rightChild?.parent = leftChild

    // 2단계: 높이 업데이트
    if balanceFactor == 0 {
        balanceFactor = -1
        leftChild?.balanceFactor = 1
    } else {
        balanceFactor = 0
        leftChild?.balanceFactor = 0
    }

    return self
}
```


&nbsp;
### 우측 단순 회전
좌측 단순 회전의 반대의 경우 사용된다.


![우측 회전](https://github.com/0jun0815/YJStudy/blob/master/알고리즘/AVL%20트리/images/우측%20회전.jpg)


#### 우측 단순 회전 구현
```
// 우측 단순 회전
public func rotateRight() -> AVLTreeNode {
    guard let parent = parent else {
        return self
    }

    // 1단계: 회전
    // 나중에 사용할 수 있도록 임시 참조값을 저장
    let grandParent = parent.parent
    let newRightChildsLeftChild = rightChild
    var wasLeftChild = false
    if parent === grandParent?.leftChild {
        wasLeftChild = true
    }

    // 기존의 부모 노드가 새로운 우측 자식 노드가 됨
    rightChild = parent
    rightChild?.parent = self

    // 기존의 조부모 노드가 새로운 부모 노드가 됨
    self.parent = grandParent
    if wasLeftChild {
        grandParent?.leftChild = self
    } else {
        grandParent?.rightChild = self
    }

    // 기존의 우측 자식 노드가 새로운 우측 자식의 좌측 자식 노드가 됨
    rightChild?.leftChild = newRightChildsLeftChild
    rightChild?.leftChild?.parent = rightChild

    // 2단계: 높이 업데이트
    if balanceFactor == 0 {
        balanceFactor = 1
        rightChild?.balanceFactor = -1
    } else {
        balanceFactor = 0
        rightChild?.balanceFactor = 0
    }

    return self
}
```


&nbsp;
### 우좌 이중 회전
좌측 단순 회전에서는 다음 조건이 충족되었어야 했다:
1. 노드 X가 노드 Y의 부모이다.
2. 노드 Y가 노드 X의 우측 자식이다.
3. 노드 Y는 좌측이 무겁지 않다(따라서 높이는 0보다 작지 않음).
4. 노드 X의 균형 요소는 +2 이다.


하지만, 만일 노드 Y의 좌측이 무거운 경우에는 어떻게 해야 할까? 바로 이때 우좌 이중 회전을 시행한다.


![우좌 회전](https://github.com/0jun0815/YJStudy/blob/master/알고리즘/AVL%20트리/images/우좌%20회전.jpg)


* 총 2단계로 회전을 시행하며, 마지막 단계에서 모든 균형 요소는 범위 [-1, 1]의 적정값을 지니게 된다.


#### 우좌 이중 회전 구현
```
// 우좌 이중 회전
public func rotateRightLeft() -> AVLTreeNode {
    // 이중 회전
    _ = rotateRight()
    _ = rotateLeft()

    // 균형 요소 업데이트
    if balanceFactor > 0 {
        leftChild?.balanceFactor = -1
        rightChild?.balanceFactor = 0
    } else if balanceFactor == 0 {
        leftChild?.balanceFactor = 0
        rightChild?.balanceFactor = 0
    } else {
        leftChild?.balanceFactor = 0
        rightChild?.balanceFactor = 1
    }

    balanceFactor = 0
    return self
}
```


&nbsp;
### 좌우 이중 회전
좌우 이중 회전은 우좌 이중 회전의 반대 경우에 시행한다.


#### 좌우 이중 회전 구현
```
// 좌우 이중 회전
public func rotateLeftRight() -> AVLTreeNode {
    // 이중 회전
    _ = rotateLeft()
    _ = rotateRight()

    // 균형 요소 업데이트
    if balanceFactor > 0 {
        leftChild?.balanceFactor = -1
        rightChild?.balanceFactor = 0
    } else if balanceFactor == 0 {
        leftChild?.balanceFactor = 0
        rightChild?.balanceFactor = 0
    } else {
        leftChild?.balanceFactor = 0
        rightChild?.balanceFactor = 1
    }

    balanceFactor = 0
    return self
}
```


&nbsp;
## 검색
AVL 트리의 검색은 이진 검색 트리와 동일하다.


&nbsp;
## 삽입
삽입 작업은 이진 검색 트리에 비해 훨씬 복잡하다. AVL 트리는 균형 요소라는 엄격한 규칙을 따르며, 삽입 작업 과정에서 이러한 균형 상태가 깨질 수 있기 때문이다.


올바른 서브트리에 새로운 노드를 삽입한 뒤엔, 그 조상 노드의 균형 요소가 모두 유지되고 있는지 확인해야 하며, 이러한 작업을 재검토 또는 리트레이싱(retracing)이라고 한다.


만일 적절하지 못한 ([-1, 1] 범위를 벗어난) 값을 지닌 균형 요소가 있다면, 회전을 통해 이를 바로 잡아야 한다.


AVL 트리에서의 삽입 및 재검토 작업의 진행 방식은 다음과 같다:
* 모든 균형 요소가 [-1, 1] 범위에 있는 AVL 트리에 새로운 노드 Z를 삽입한다.
* 삽입된 노드 Z를 노드 X의 서브트리에 추가하려 한다.
* 트리의 하단에서부터 서브트리에 이르기까지 균형 요소를 확인한다. 적절하지 못한 값이 있는 경우, 회전을 통해 이를 바로잡는다. 다음, 균형 요소가 0이 되거나, 혹은 루트 노드에 다다를 때까지 트리 상단으로 이동한다.


&nbsp;
&nbsp;      
### [by. 0junChoi](https://github.com/0jun0815) email: <0jun0815@gmail.com>
### 출처: [스위프트 데이터 구조와 알고리즘](http://acornpub.co.kr/book/swift-structure-algorithms)
