# 깊이 우선 검색


* [깊이 우선 검색(DFS, Depth First Search)](#깊이-우선-검색dfs,-depth-first-search)
* [깊이 우선 검색 구현](#깊이-우선-검색-구현)


&nbsp;
## 깊이 우선 검색(DFS, Depth First Search)
깊이 우선 검색은 트리 상단에서 하단으로 이어지는 노드 순회이다.


오직 한 가지 조건에서만 이뤄지는데 노드를 방문할 때는 첫 번째(좌측) 자식을 방문하고, 다음으로 노드 자체를 방문하며, 다음 (우측) 자식을 방문한다.


![깊이 우선 검색1]()
![깊이 우선 검색2]()


* 그래프 노드를 오름 순서로 방문했다. 그래프를 순위에 다라 방문하고 그 결과값을 가져오는 것이 DFS 기법의 활용 목적 중 하나이다.


&nbsp;
## 깊이 우선 검색 구현
이진 검색 트리 내부에 DFS 메서드를 구현한다.
```
public class BinaryTreeNode<T: Comparable> {
    ...
    
    public class func depthFirstSearch(node: BinaryTreeNode?) {
        // nil인 잎에 도달하면 재귀적인 호출을 중지함
        guard let node = node else {
            return
        }

        // leftChild로 메서드를 재귀적으로 호출한 뒤 해당 값을 출력하고
        // rightChild로 메서드를 재귀적으로 호출한다.
        BinaryTreeNode.depthFirstSearch(node: node.leftChild)
        print(node.value)
        BinaryTreeNode.depthFirstSearch(node: node.rightChild)
    }
}
```


&nbsp;
&nbsp;      
### [by. 0junChoi](https://github.com/0jun0815) email: <0jun0815@gmail.com>
### 출처: [스위프트 데이터 구조와 알고리즘](http://acornpub.co.kr/book/swift-structure-algorithms)
