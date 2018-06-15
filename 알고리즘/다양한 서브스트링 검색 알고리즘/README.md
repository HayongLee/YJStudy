# 다양한 서브스트링 검색 알고리즘


* [텍스트 검색 알고리즘 전제 조건 설정](#텍스트-검색-알고리즘-전제-조건-설정)
* [서브스트링 검색 알고리즘 사례](#서브스트링-검색-알고리즘-사례)
* [나이브(Brute force) 알고리즘](#나이브brute-force-알고리즘)
* [라빈카프 알고리즘](#라빈카프-알고리즘)
    

&nbsp;
## 텍스트 검색 알고리즘 전제 조건 설정
* 텍스트 또는 문자열은 배열 T[1 ... n]으로 정의한다. n은 문자열에 포함된 문자의 수를 나타낸다.
* 검색하려는 패턴은 배열 P[1 ... m]으로 정의한다. m은 문자열에 포함된 문자의 수이며, m <= n이다.
* 배열 T에 문자열의 패턴인 배열 P가 존재한다면, 이를 배열 T에서 S만큼 이동(shift)이라 표현한다. 패턴 배열 P는 배열 T의 S키인 위치에서 찾을 수 있다. 즉, [1 < S < n - m]이라는 조건과 T[S + 1 ... S + m] = P[1 ... m]이라는 조건이 성립한다.


![텍스트 검색]()


* 모든 문자열 매칭 알고리즘의 목표는 배열 T에서 서로 다른 S의 위치값을 찾아내는 것이라 할 수 있다.


&nbsp;
## 서브스트링 검색 알고리즘 사례
### 나이브(Brute force) 알고리즘
부르트 포스(brute force)는 배열 T의 모든 위치를 순환하면서 각각의 위치와 패턴 P를 비교한다.
* 성능 시간의 복잡성은 최악의 경우 (n - m + 1)m에 이를 수 있다.


![브루트 포스]()


* 확인해야 할 위치는 (n - m + 1)개 이다.


#### 나이브 알고리즘 구현
```
// 문자 배열을 활용한 부르트 포스 구현
public static func bruteForce(search pattern: [Character], in text: [Character]) {
    // m과 n을 추출함
    let m = pattern.count - 1
    let n = text.count - 1
    // 텍스트에서 패턴을 검색
    for index in 0 ... n - m {
        let substringToMatch = text[index ... index + m]
        print(substringToMatch)
        if substringToMatch == pattern[0 ... m] {
            print("Pattern found")
        }
    }
}

// 문자열을 활용한 부르트 포스 구현
public static func bruteForce(search pattern: String, in text: String) {
    // m과 n을 추출함
    let m = pattern.count - 1
    let n = text.count - 1
    // 텍스트에서 패턴을 검색
    for index in 0 ... n - m {
        let start = text.index(text.startIndex, offsetBy: index)
        let end = text.index(text.startIndex, offsetBy: index + m)
        let substringToMatch = text[start ... end]
        print(substringToMatch)

        if substringToMatch == pattern {
            print("Pattern found")
        }
    }
}
```


&nbsp;
### 라빈카프 알고리즘
라빈카프 알고리즘은 나머지 연산 모듈로의 동치 이론에 기초한 문자열 검색 알고리즘이다.


다음 절차에 따라 작성한다:
1. 문자열을 숫자열로 변환한다. 패턴 P가 문자열 31415인 경우, 이를 숫자 데이터 31415로 처리한다. 이를 (패턴의 길이인) m 자릿수의 검색 대상 문자열 T에 적용한다.
2. 찾으려는 패턴의 모듈을 modulo 13이라 했을 때 13으로 나눈 나머지를 계산한다. 31415의 mod 13은 7이며, 이 값을 저장해 두었다가 배열 T의 숫자를 modulo 13과 비교해서 일치 여부를 판별한다.


![라빈카프 알고리즘1]()


3. 순환문을 통해 배열 T에서 우리가 찾는 패턴인 mod 13 값과 동일한 숫자 그룹을 반복해서 조회한다.
4. 어떤 숫자 그룹의 mod 13 값이 7과 같으면, 찾으려는 대상일 가능성이 있으며, mod 13이 같더라도 세부적인 자릿수가 다를 수 있으므로, 해당 숫자 그룹의 모든 자릿수르를 하나씩 비교해 나간다. 이렇게 해서 동일한 숫자 그룹을 찾게 되면, 다시 숫자 그룹과 패턴의 일치 여부를 모든 자릿수와 비교한다.
5. mod 13 값이 같지 않다면, 네 번째 단계로 다시 돌아간다.
6. mod 13 값이 같다면, 포인터를 우측으로 한 칸씩 이동시킨다. 모든 자릿수를 비교한 뒤 다음 단계로 넘어간다. 배열 (좌측) 높은 자릿수를 밀어내고 (우측) 낮은 자릿수를 이동시킨다. 새로운 숫자 그룹의 mod 13 값은 다음과 같이 계산한다.


![라빈카프 알고리즘2]()


* 31415의 mod 13은 7이고, 다음 그룹인 14152의 mod 13은 8이다. 이때 다음 그룹은 한 칸 오른쪽으로 이동해서 새로운 자릿수를 만든다.
* 14152 = (31415 - 3 * 10000) * 10 + 2 (mod 13)
* 14152 = (7 - 3 * 3) * 10 + 2 (mod 13)
* 14152 = 8 (mod 13)


#### 라빈카프 알고리즘 구현
```
// 라빈카프 알고리즘
public static func rabinKarpNumbers(search pattern: String, in text: String, modulo: Int, base: Int) {
    // 초기화
    let patternArray = pattern.map { String($0) }
    let textArray = text.map { String($0) }

    let n = textArray.count
    let m = patternArray.count
    let h = Int(pow(Double(base), Double(m - 1))) % modulo
    var patternModulo = 0
    var lastTextModulo = 0
    // 패턴 modulo와 텍스트의 첫 번째 자릿수의 modulo를 계산한다.
    // 이후 modulo 산술 연산 프로퍼티로 다음 자릿수도 계산한다.
    for i in 0 ... (m - 1) {
        guard let nextPatternDigit = Int(patternArray[i]),
            let nextTextDigit = Int(textArray[i]) else {
            print("Error")
            return
        }
        patternModulo = (base * patternModulo + nextPatternDigit) % modulo
        lastTextModulo = (base * lastTextModulo + nextTextDigit) % modulo
    }

    // 동등 여부를 확인하고, 다음 자릿수의 modulo를 계산한다.
    for s in 0 ... (n - m - 1) {
        // 패턴 모듈로를 이용해서 마지막 modulo를 계산한다.
        if patternModulo == lastTextModulo {
            // 동등한 모듈로를 찾았다. 이제 이들 숫자 조합의 모든 자릿수도 같은지 확인한다.
            // 자릿수가 일부 달라도 모듈로는 같을 수 있으므로 확인 작업이 필요하다.
            let substringToMatch = textArray[s ... (s + m - 1)].joined(separator: "")
            if pattern == substringToMatch {
                print("Pattern occurs at shift: \(s)")
            } else {
                print("Same modulo but no same pattern: \(s)")
            }
        }

        // 다음 숫자 그룹의 모듈로를 계산한다.
        if s < n - m {
            guard let highOrderDigit = Int(textArray[s]),
                let lowOrderDigit = Int(textArray[s + m]) else {
                print("Error")
                return
            }

            // 다음 모듈로를 계산하려면 숫자 그룹 왼쪽에 위치한 높은 단위의
            // 모듈로를 빼고, 다음 단계에서 낮은 단위의 모듈로를 더한다.

            // 높은 단위 자릿수의 모듈로를 뺀다.
            var substractedHighOrderDigit = (base * (lastTextModulo - highOrderDigit * h)) % modulo
            if substractedHighOrderDigit < 0 {
                // 모듈로가 음수인 경우, 이를 양수로 바꾼다.
                substractedHighOrderDigit = substractedHighOrderDigit + modulo
            }

            // 새로운 낮은 단위 자릿수를 더한다.
            var next = (substractedHighOrderDigit + lowOrderDigit) % modulo
            if next < 0 {
                // 모듈로가 음수인 경우, 이를 양수로 바꾼다.
                next = next + modulo
            }
            lastTextModulo = next
        }
    }
}
```


&nbsp;
&nbsp;      
### [by. 0junChoi](https://github.com/0jun0815) email: <0jun0815@gmail.com>
### 출처: [스위프트 데이터 구조와 알고리즘](http://acornpub.co.kr/book/swift-structure-algorithms)
