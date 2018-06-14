# 이진 트리


* [개요](#개요)
* [타입과 종류](#타입과-종류)
    * [풀 이진 트리(Full binary tree)](#풀-이진-트리full-binary-tree)
    * [퍼팩트 이진 트리(Perfect binary tree)](#퍼팩트-이진-트리perfect-binary-tree)
    * [컴플리트 이진 트리(Complete binary tree)](#컴플리트-이진-트리complete-binary-tree)
    * [균형 이진 트리(Balanced binary tree)](#균형-이진-트리balanced-binary-tree)
* [이진 트리 구현](#이진-트리-구현)


&nbsp;
## 개요
최대 두 개의 자식 노드를 지닐 수 있는 트리 데이터 구조로, 이런 속성은 이진 트리와 모든 노드가 (무한대는 아닌) 일정한 수의 자식 노드만을 지닌다는 점을 확신할 수 있게 해준다.


&nbsp;
## 타입과 종류
### 풀 이진 트리(Full binary tree)
트리 내의 특정 노드 N이 있을 때, N은 0개 혹은 2개의 자식 노드를 지닌다(1개의 자식 노드를 지니는 경우는 없다).


![풀 이진 트리](https://github.com/0jun0815/YJStudy/blob/master/알고리즘/이진%20트리/images/풀%20이진%20트리.jpg)


### 퍼팩트 이진 트리(Perfect binary tree)
모든 내부 노드는 두 개의 자식 노드를 지니며, 모든 잎은 동일한 깊이를 지닌다.


![퍼팩트 이진 트리](https://github.com/0jun0815/YJStudy/blob/master/알고리즘/이진%20트리/images/퍼팩트%20이진%20트리.jpg)


### 컴플리트 이진 트리(Complete binary tree)
마지막 레벨을 제외한 모든 레벨이 노드로 완전하게 찬 상태다. 마지막 레벨의 노드가 좌측으로 몰려 있다.


![컴플리트 이진 트리](https://github.com/0jun0815/YJStudy/blob/master/알고리즘/이진%20트리/images/컴플리트%20이진%20트리.jpg)


### 균형 이진 트리(Balanced binary tree)
잎 노드까지 이어지기 위한 최소한의 높이만을 지닌다.


![균형 이진 트리](https://github.com/0jun0815/YJStudy/blob/master/알고리즘/이진%20트리/images/균형%20이진%20트리.jpg)


&nbsp;
## 이진 트리 구현
노드는 다음과 같은 조건을 갖추고 있어야 한다:
* 키 데이터 값을 포함한 컨테이너
* 좌, 우측 자식 노드에 대한 두 개의 참조값
* 부모 노드에 대한 참조값


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
}
```


&nbsp;
&nbsp;      
### [by. 0junChoi](https://github.com/0jun0815) email: <0jun0815@gmail.com>
### 출처: [스위프트 데이터 구조와 알고리즘](http://acornpub.co.kr/book/swift-structure-algorithms)
