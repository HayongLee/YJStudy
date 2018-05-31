# 병합 정렬 


* [개요](#개요)
* [배열 기반 병합 정렬](#배열-기반-병합-정렬)
    *[컬렉션 정렬을 위한 분리정복 작업](#컬렉션-정렬을-위한-분리정복-작업)
    * [배열 기반 병합 정렬 구현](#배열-기반-병합-정렬-구현)
* [연결리스트 기반 병합 정렬](#연결리스트-기반-병합-정렬)
    * [연결리스트 기반 병합 정렬 구현](#연결리스트-기반-병합-정렬-구현)
* [알고리즘 성능 비교](#알고리즘-성능-비교)


&nbsp;
## 개요
* 병합 정렬(merge sort, 합병 정렬)은 분리 정복(divide and conquer) 알고리즘
* 재귀적으로 작동, 미정렬 상태의 데이터 세트를 두 개로 나누는 일을 반복해서 데이터 세트에 속한 아이템이 하나인 상태가 되거나 빈 상태가 되면 정렬된 상태로 판단, 이를 더 이상 분해할 수 없는 최소 단위 요소 또는 베이스 케이스(base case)라고 부른다.
* 이후 대부분의 정렬 작업은 merge 함수에서 수행, 나뉘어 있는 두 개 요소를 합치는 일을 반복
* merge 함수는 병합 작업을 위해 동일한 크기의 배열을 임시로 만들어서 사용하므로 O(n) 보다는 큰 공간을 차지, 이러한 이유로 병합 정렬은 배열보다는 연결 리스트의 정렬 작업에서 좀 더 나은 성능을 발휘한다.


&nbsp;
## 배열 기반 병합 정렬
### 컬렉션 정렬을 위한 분리정복 작업
* 분리(Divide): 컬렉션 S가 0또는 1인 경우, 더 이상 정렬할 것이 없으므로 종료. 그렇지 않은 경우, 컬렉션을 S1과 S2 두 개로 나눈다. 이때 S1에는 S의 N/2 만큼의 요소가 포함돼 있고, S2에는 S의 나머지 N/2 만큼의 요소가 포함돼 있다.
* 정복(Conquer): S1과 S2를 재귀적으로 나눠서 (요소의 수가 1인)베이스 케이스 단계까지 나눈 뒤 정렬을 시작한다.
* 결합(Combine): S1과 S2의 하위 목록을 병합해서 정렬된 시퀀스로 만든 뒤 이를 다시 반환한다.


![](https://github.com/0jun0815/YJStudy/blob/master/알고리즘/병합%20정렬/images/merge-sort.jpg)


### 배열 기반 병합 정렬 구현
```
public func mergeSort<T: Comparable>(_ list: [T]) -> [T] {
    if list.count < 2 {
        return list
    }
    // mergeSort가 호출될 때마다 리스트의 크기를 2로 나눈다.
    let center = list.count / 2
    
    // mergeSort 함수를 재귀적으로 호출해서 하위 리스트 S[0..<center]와 S[center..<list.count]를 반복적으로 전달한다.
    return merge(mergeSort([T](list[0 ..< center])), mergeSort([T](list[center ..< list.count])))
}
// mergeSort 함수가 재귀적으로 호출되며, 호출될 때마다 리스트를 반으로 나누기 시작하여 
// 리스트에 포함된 요소가 0 또는 1이 될 때까지 반복한다.

private func merge<T: Comparable>(_ leftHalf: [T], _ rightHalf: [T]) -> [T] {
    // merge 함수는 S1에 대응하는 하위 리스트 leftHalft와 S2에 대응하는 하위 리스트 rightHalf를 인수로 받는다.
    // 초기 인덱스 값은 0으로 설정
    var leftIndex = 0
    var rightIndex = 0
    
    // 정렬 순서대로 연결된 시퀀스를 저장할 수 있는 임시 배열을 생성
    var tmpList = [T]()
    tmpList.reserveCapacity(leftHalf.count + rightHalf.count)
    
    // leftHalf와 rightHalf 범위 내의 인덱스 순회
    while leftIndex < leftHalf.count && rightIndex < rightHalf.count {
    
        // leftHalf 요소가 rightHalf보다 작을 경우 임시 배열에 leftHalf의 요소를 추가하고
        // leftIndex를 1증가
        if leftHalf[leftIndex] < rightHalf[rightIndex] {
            tmpList.append(leftHalf[leftIndex])
            leftIndex += 1
            
        // 클 경우 임시 배열에 rightHalf의 요소를 추가하고
        // rightIndex를 1증가
        } else if leftHalf[leftIndex] > rightHalf[rightIndex] {
            tmpList.append(rightHalf[rightIndex])
            rightIndex += 1
            
        // 그렇지 않을 경우, 요소의 값이 같다는 의미로 둘 다 추가하고 인덱스 1증가
        } else {
            tmpList.append(leftHalf[leftIndex])
            tmpList.append(rightHalf[rightIndex])
            leftIndex += 1
            rightIndex += 1
        }
    }
    // leftHalf와 rightHalf 배열에 남아있는 요소를 임시 배열에 붙인다.
    tmpList += leftHalf[leftIndex ..< leftHalf.count]
    tmpList += rightHalf[rightIndex ..< rightHalf.count]
    return tmpList
}
```


&nbsp;  
## 연결 리스트 기반 병합 정렬
### 연결 리스트 기반 병합 정렬 구현
```
func mergeSort<T: Comparable>(list: inout LinkedList<T>) {
    // frontBackSplit 함수에 의해 반환되는 하위 리스트를 위한 인스턴스 정의
    var left: Node<T>? = nil
    var right: Node<T>? = nil

    // 최소 단위(베이스 케이스), 재귀 절차가 끝나면 정렬된 리스트를 반환하게 한다.
    if list.head == nil || list.head?.next == nil {
        return
    }

    // frontBackSplit 함수를 통해 현재 리스트를 두 개의 시퀀스로 나눈다.
    // 이 함수는 각 시퀀스의 첫 번째 요소를 가리키는 노드 포인터를 반환한다.
    frontBackSplit(list: &list, front: &left, back: &right)

    // 두 개의 새로운 연결 리스트 인스턴스를 만들고 left 시퀀스와 right 시퀀스를 각각 할당한다.
    var leftList = LinkedList<T>()
    leftList.head = left
    var rightList = LinkedList<T>()
    rightList.head = right

    // mergeSort 함수를 재귀적으로 호출해서 베이스 케이스가 될 때까지 반복 실행한다.
    mergeSort(list: &leftList)
    mergeSort(list: &rightList)

    // 베이스 케이스에 도달하면, merge 함수를 호출해서 두 개의 리스트 시퀀스를 정렬된 상태로 결합하고,
    // 이렇게 정렬된 연결 리스트의 노드 포인터를 연결 리스트 헤더 포인터에 할당한다.
    list.head = merge(left: leftList.head, right: rightList.head)
}

private func merge<T: Comparable>(left: Node<T>?, right: Node<T>?) -> Node<T>? {
    var result: Node<T>? = nil
    // merge 함수는 두 개의 Node<T> 레퍼런스를 인수로 받으며 left는 S1에, right는 S2에 각각 대응한다.
    // 두 노드 레퍼런스가 nil인지 확인한 뒤, 함수를 통해 서로의 반대편인 노드 레퍼런스를 반환한다.
    if left == nil {
        return right
    } else if right == nil {
        return left
    }

    // 연결 리스트를 반으로 나눈 하위 리스트의 노드 데이터 요소를 비교한다.
    // left가 right보다 작은 경우 result에 left 노드 레퍼런스를 할당하고
    // merge 함수를 호출해서 left의 next 노드 레퍼런스를 전달한다.
    // merge 함수의 반환값은 result의 next 데이터 레퍼런스에 할당된다.
    if left!.data <= right!.data {
        result = left
        result?.next = merge(left: left?.next, right: right)

        // right 데이터 요소가 더 큰 경우 result에 right 노드 레퍼런스를 할당하고
        // merge 함수를 호출해서 right의 next 노드 레퍼런스를 전달한다.
        // merge 함수의 반환값은 result의 next 데이터 레퍼런스에 할당된다.
    } else {
        result = right
        result?.next = merge(left: left, right: right?.next)
    }

    // 정렬되고, 연결 리스트로 병합된 result 레퍼런스를 반환한다.
    return result
}

private func frontBackSplit<T: Comparable>(list: inout LinkedList<T>, front: inout Node<T>?, back: inout Node<T>?) {
    // 연결 리스트를 반으로 나누기 위한 준비 작업이 필요하다.
    // frontBackSplit 함수는 fast/slow 포인터 전략을 이용해서 연결 리스트를 분할한다.
    // fast 노드는 slow 노드보다 두 배 빠르며, 이들 노드 레퍼런스는 연결 리스트 작업 시 활용한다.
    var fast: Node<T>?
    var slow: Node<T>?

    // 연결 리스트 인스턴스에서 list.head 또는 list.head.next 노드가 nil이면,
    // left-half는 list.head 값으로 설정하고, right-half는 nil로 설정한다.
    if list.head == nil || list.head?.next == nil {
        front = list.head
        back = nil
    } else {
        // slow와 fast 노드 레퍼런스를 연결 리스트에 있는 처음 두 노드로 설정한다.
        slow = list.head
        fast = list.head?.next

        // 연결 리스트의 fast 노드 레퍼런스를 순회하면서 nil 여부를 계속 확인한다.
        // nil이 아닌 경우 fast 노드는 slow 노드보다 두 배 빠르게 앞서 나간다.
        // fast 노드에 nil 값이 포함된 경우 slow 노드 레퍼런스는 리스트의 절반 위치 바로 앞에 놓여진다.
        while fast != nil {
            fast = fast?.next
            if fast != nil {
                slow = slow?.next
                fast = fast?.next
            }
        }

        // 리스트를 둘로 나눠서 slow.next 노드는 back 노드 레퍼런스에 할당하고
        // slow.next 노드 레퍼런스는 nil로 설정한다.
        // list.head 노드를 front 노드 레퍼런스에 할당해서 연결 리스트의 첫 번째 노드가 되도록 설정한다.
        front = list.head
        back = slow?.next
        slow?.next = nil
    }
}
```


&nbsp;
## 알고리즘 성능 비교
* 요소의 크기가 커질수록(데이터가 많을 수록) 연결 리스트 기반 병합 정렬이 훨씬 빠르다.


&nbsp;
&nbsp;      
### [by. 0junChoi](https://github.com/0jun0815) email: <0jun0815@gamil.com>
### 출처: [스위프트 데이터 구조와 알고리즘](http://acornpub.co.kr/book/swift-structure-algorithms)
