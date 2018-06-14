# 신속 정렬(퀵 정렬) 


* [개요](#개요)
* [로무토의 신속 정렬 알고리즘](#로무토의-신속-정렬-알고리즘)
    * [로무토의 신속 정렬 알고리즘 구현](#로무토의-신속-정렬-알고리즘-구현)
* [호어의 신속 정렬 알고리즘](#호어의-신속-정렬-알고리즘)
    * [호어의 신속 정렬 알고리즘 구현](#호어의-신속-정렬-알고리즘-구현)
    * [피봇 선택 방식](#피봇-선택-방식)
* [신속 정렬 알고리즘을 위한 개선된 피봇 선택 방식](#신속-정렬-알고리즘을-위한-개선된-피봇-선택-방식)
    * [개선된 피봇 선택 방식 구현](#개선된-피봇-선택-방식-구현)


&nbsp;
## 개요
* 신속 정렬(Quick sort, 퀵 정렬) 기법은 분리 정복 알고리즘의 일종이다.
* 인플레이스 정렬 기법을 사용하므로 효율성이 높다.
* 파티션 스킴(Partitioning scheme)에 대한 피봇(Pivot) 규칙에 따라 초기 배열을 하위 시퀀스, 상위 시퀀스 등 두 개의 서브 시퀀스로 나눈다.
* 다른 방식에 비해 훨씬 조밀한 내부 순환문 구조로 인해 평균 실행 시간은 O(nlogn)에 불과하지만, 데이터 구조가 잘 맞지 않을 경우, O(n²)까지 실행 시간이 길어질 수 있으므로, 데이터가 무작위 순위를 유지하도록 하는 것이 중요하다.
* 피봇의 선택 여부에 따라 알고리즘의 성능이 크게 영향을 받는다.


&nbsp;
## 로무토의 신속 정렬 알고리즘
로무토 알고리즘은 quickSort, partition 함수로 구성된다.
* quickSort 함수의 목적은 partition 함수를 호출한 뒤 재귀적으로 스스로를 호출해서 배열 시퀀스의 lo와 hi 요소를 정렬하는 것이다.
* partition 함수는 배열의 서브시퀀스를 재배치하면서 정렬 작업을 진행한다.
* 로무토 파티셔닝 스팀은 피봇으로 항상 hi 요소를 선택한다.


&nbsp;
### 로무토의 신속 정렬 알고리즘 구현
```
func quickSort<T: Comparable>(_ list: inout [T], lo: Int, hi: Int) {
    // lo 인덱스가 hi 인덱스보다 작은지 확인한다.
    if lo < hi {
        // partition 함수를 호출해서 현재의 lo와 hi 인덱스값에 따라 배열의 서브시퀀스를 정렬하기 시작한다.
        let pivot = partition(&list, lo: lo, hi: hi)

        // 좌측 배열 서브시퀀스는 선택된 피봇값에 따라 재귀적으로 정렬된다.
        quickSort(&list, lo: lo, hi: pivot - 1)
        // 우측 배열의 서브시퀀스에 대한 정렬 작업도 마친다.
        quickSort(&list, lo: pivot + 1, hi: hi)
    }
}

func partition<T: Comparable>(_ list: inout [T], lo: Int, hi: Int) -> Int {
    // 피봇 선정은 리스트의 맨 마지막 값을 선택하는 나이브(naive) 기법을 사용한다.
    // partition 함수의 목적은 피봇값을 선택하는 것, 배열의 서브시퀀스를 정렬하는 것이다.

    // 배열 리스트에 있는 가장 높은 인덱스값을 선택하고, 이를 나중에 인덱스 값을 비교하는 기준으로 사용한다.
    let pivot = list[hi]
    // lo의 값을 루프에서 피봇 역할을 하는 i 인덱스 값으로 할당한다.
    var i = lo

    // 피봇값을 기준으로 lo부터 hi-1에 이르는 배열의 인덱스 요소를 반복적으로 비교한다.
    for j in lo ..< hi {
        // 현재 값이 피봇값보다 작으면, lo 인덱스의 시작점인 i 위치에 있는 요소와 비교 대상인 요소를 교환하고,
        // 교환이 일어날 때마다 i 값에 1을 추가한다.
        // i와 j 값을 교환함으로써, 큰 값은 우측으로, 작은 값은 좌측으로 이동시킬 수 있다.
        if list[j] <= pivot {
            list.swapAt(i, j)
            i += 1
        }
    }

    // 배열 리스트에 대한 반복 순회 작업을 마치면서 i와 hi 요소를 교환한다.
    // 이로써, 기준으로 삼았던 요소가 원래의 자리로 돌아간다.
    list.swapAt(i, hi)
    // quickSort 함수에서 피봇이 될 i 값을 반환한다.
    return i
}
```


&nbsp;
## 호어의 신속 정렬 알고리즘
호어의 partition 함수는 로무토의 것에 비해 좀 더 복잡하기는 하지만, 평균적으로 스왑 횟수(배열 요소 교환 횟수)가 세 배나 적고, 배열 요소가 모두 같을 때도 효율적으로 파티션을 만들어낸다는 장점이 있다.


&nbsp;
### 호어의 신속 정렬 알고리즘 구현
```
func quickSort<T: Comparable>(_ list: inout [T], lo: Int, hi: Int) {
    if lo < hi {
        let pivot = partition(&list, lo: lo, hi: hi)
        // 로무토 구현에선 hi: pivot - 1이란 점이 다르다.
        quickSort(&list, lo: lo, hi: pivot)
        quickSort(&list, lo: pivot + 1, hi: hi)
    }
}

func partition<T: Comparable>(_ list: inout [T], lo: Int, hi: Int) -> Int {
    // 로무토는 인덱스 값이 가장 높은 요소를 선택한 반면,
    // 호어는 인덱스 값이 가장 낮은 요소를 선택한 뒤, 이를 인덱스 값 비교에 사용한다.
    let pivot = list[lo]
    // lo 인덱스 값에서 1을 뺀 값을 새로운 변수 i에 저장한다.
    // 이 값은 선택된 피봇보다 작은 배열 요소를 반복적으로 찾을 때 사용한다.
    var i = lo - 1
    // hi 인덱스 값에 1을 더해 또 다른 변수 j에 저장한다.
    // 이 값은 선택된 피봇보다 큰 배열 요소를 반복적으로 찾을 때 사용한다.
    var j = hi + 1

    // 루프는 배열 인덱스 포인터가 서로 만나거나 겹치기 전까지 계속 반복되며,
    // 겹칠 경우 현재 피봇을 기준으로 다음으로 높은 요소를 가리키는 j의 인덱스를 반환한다.
    while true {
        i += 1
        while list[i] < pivot { i += 1 }
        j -= 1
        while list[j] > pivot { j -= 1 }
        if i >= j {
            // 루프를 종료하고 결과값을 반환한다.
            return j
        }
        // 인덱스 포인터가 서로 만나지 못한 경우 i 요소와 j 요소를 서로 교환한 뒤 다시 루프로 돌아간다.
        list.swapAt(i, j)
    }
}
```


이 방식 역시 나름의 문제를 안고 있다:
* 피봇 선정 과정은 여전히 임의적이어서 로무토는 배열 인덱스 중 가장 높은 것을 선택한 반면, 호어는 가장 낮은 것을 선택했다는 차이만 있을 뿐이다.
* 호어 기법의 또 다른 문제는 정렬된 배열 또는 거의 대부분 정렬된 배열을 처리할 때 발생한다. 평균적인 신속 정렬 알고리즘의 효율은 O(nlogn) 수준인데, 정렬된 배열을 만나면 O(n²)수준까지 떨어진다. 이는 임의적인 피봇 선정에서 기안하는 문제이다.


&nbsp;
### 피봇 선택 방식
초기 partition 함수 구현 방식에서 임의로 가장 높은 인덱스 요소를 피봇으로 선택하였는데 이렇게 할 경우 데이터가 이미 일정 수준으로 정렬된 경우 알고리즘 성능에 부정적인 영향을 미치게 된다(최악의 경우 O(n²)).


논리적인 과정을 거쳐 피봇을 선택할 필요가 있으며, 이를 위해 데이터 맥락에 따라 최소, 혹은 최대 인덱스 값을 선택하는 메서드를 사용한다. 임의의 값을 선택해서 사용하는 것도 대안 중 하나이지만, 정렬을 위한 최선의 피봇을 선정하는 데에는 역부족이기 때문이다.


#### 잘못된 방식: 첫 번째 또는 마지막 요소를 선택
* 목록 내의 모든 요소가 무작위로 섞여있을 때는 나쁘지 않은 방법이다.
* 데이터가 이미 정렬돼 있거나 거의 대부분 정렬돼 있을 때, 첫 번째 혹은 마지막 요소를 피봇으로 삼는 경우, 남아 있는 모든 요소가 S1또는 S2 시퀀스 중 어느 한 쪽에 몰려있게 된다. 이렇게 되면 복잡성은 O(n²) 수준에 이르게 되고, 성능은 매우 저하된다.


### 잘못된 방식: 무작위로 요소를 선택
* 무작위 요소 선택은 첫 번째 혹은 마지막 요소 선택보다는 조금 나을 수 있지만 단점이 여전히 존재한다.
* 무작위로 요소를 선택해서 피봇으로 삼을 경우 대부분의 데이터 정렬에서 높은 성능을 발휘하고, 심지어 대부분 정렬된 데이터에서도 만족할 만한 성과를 낼 수 있다. 하지만, 무작위로 요소를 선택하기 위한 난수발생기는 컴퓨터의 성능 자원을 꽤 많이 고갈시킨다는 문제가 있고, 난수발생기에서 나온 값이 진정한 의미에서 난수인지 확인할 필요 또한 있다.


### 올바른 방식
피봇 선정을 위한 좀 더 개선된 방법으로 세 수의 중앙값(Median Of Three) 전략을 활용한다.
* 이 방법은 임의의 수 가운데 선택하거나, 첫 번째 혹은 마지막 인덱스 값을 기준으로 선택하는 방법의 단점을 모두 보완할 수 있다.
* 이 방법은 목록 전체 요소의 중앙값을 선택하는 것보다 훨씬 빠르고, 정렬된 데이터 가운데 포함된 인스턴스라 하더라도 최솟값 혹은 최댓값인 요소를 선택할 수 있는 가능성을 차단한다.
* 중앙값의 요소를 선택함으로써, 좌-우-중앙 요소를 모두 정렬할 수 있으며, 이를 통해 하위 배열에 있는 가장 좌측 위치의 요소가 피봇보다 작다는 사실과 하위 배열의 가장 우측 요소가 피봇보다는 크다는 사실을 미리 알 수 있다.


&nbsp;
## 신속 정렬 알고리즘을 위한 개선된 피봇 선택 방식
세 수와 중앙값 전략을 사용한다. 
* getMedianOfThree 함수는 적절한 방식으로 피봇을 선택하고, 배열이 이미 정렬된 상태인 경우 피봇이 최댓값 또는 최솟값인지 여부를 확인한다.


&nbsp;
### 개선된 피봇 선택 방식 구현
```
func quickSort<T: Comparable>(_ list: inout [T], lo: Int, hi: Int) {
    if lo < hi {
        // 기존 quickSort와 중앙값을 가져오는 부분만 약간 다르다.
        let median = getMedianOfThree(&list, lo: lo, hi: hi)
        let pivot = partition(&list, lo: lo, hi: hi, median: median)

        quickSort(&list, lo: lo, hi: pivot)
        quickSort(&list, lo: pivot + 1, hi: hi)
    }
}

func partition<T: Comparable>(_ list: inout [T], lo: Int, hi: Int, median: T) -> Int {
    var i = lo - 1
    var j = hi + 1

    while true {
        i += 1
        // pivot 대신 median이 사용되었다.
        while list[i] < median { i += 1 }

        j -= 1
        while list[j] > median { j -= 1 }

        if j >= i {
            return j
        }

        list.swapAt(i, j)
    }
}

func getMedianOfThree<T: Comparable>(_ list: inout [T], lo: Int, hi: Int) -> T {
    // 배열의 중앙에 위치한 요소를 계산한다.
    let center = lo + (hi - lo) / 2

    // lo 인덱스의 요소가 center 인덱스의 요소보다 큰 경우 서로의 위치를 바꾼다.
    if list[lo] > list[center] {
        list.swapAt(lo, center)
    }
    // lo와 hi 인덱스의 요소를 비교한다.
    if list[lo] > list[hi] {
        list.swapAt(lo, hi)
    }
    // center와 hi 인덱스의 요소를 비교한다.
    if list[center] > list[hi] {
        list.swapAt(center, hi)
    }

    // 마지막 교환 작업으로 center 인덱스 요소와 hi 인덱스 요소릐 자리를 바꾼다.
    // 이렇게 함으로써 미리 정렬돼 있는 배열일지라도 순서를 바꿔놓을 수 있다.
    list.swapAt(center, hi)

    return list[hi]
}
```


&nbsp;
&nbsp;      
### [by. 0junChoi](https://github.com/0jun0815) email: <0jun0815@gmail.com>
### 출처: [스위프트 데이터 구조와 알고리즘](http://acornpub.co.kr/book/swift-structure-algorithms)
