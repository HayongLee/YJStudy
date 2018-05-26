# Naming


* [Promote Clear Usage](#promote-clear-usage)
* [Strive for Fluent Usage](#strive-for-fluent-usage)


&nbsp;      
## Promote Clear Usage


### 모호성을 피하기 위해 필요한 모든 단어를 포함한다.


이름이 사용된 코드를 읽는 사람을 위해 **모호성을 피하기 위해 필요한 모든 단어를 포함한다.**


예를 들어, 컬렉션 내의 주어진 위치에서 요소를 제거하는 메서드를 생각해보면:
```
extenstion List {
    public mutating func remove(at position: Index) -> Element 
}
employees.remove(at: x)
```
여기서 `at`을 생략한다면 `x`를 사용하여 제거할 요소의 위치를 나타내는 것이 아니라 `x`와 동일한 요소를 검색하고 제거한다는 것을 암시할 수 있다.
```
employees.remove(x) // unclear: are we removing x?
```


&nbsp;      
### 불필요한 단어는 생략한다.


**불필요한 단어는 생략한다.** 이름에 나오는 모든 단어는 사용 장소에서 중요한 정보를 전달해야 한다.


의도와 의미를 명확하게 하기 위해 더 많은 단어가 필요할 수 있지만 독자가 이미 소유하고 있는 정보같은 중복되는 단어는 생략해야 한다. 특히 타입 정보만 반복하는 단어는 생략한다.
```
public mutating func removeElement(_ member: Element) -> Element?
allViews.removeElement(cancelButton)
```
이 경우, `Element`라는 단어는 호출 장소에서 중요한 부분을 추가하지 않는다. 다음 API가 더 좋을 것이다:
```
public mutating func remove(_ member: Element) -> Element?
allViews.remove(cancelButton) // clearer
```
흔히 모호성을 피하기 위해 반복되는 타입 정보가 필요하지만 일반적으로 매개변수의 타입보다는 매개변수의 역할을 설명하는 단어를 사용하는 것이 좋다.


&nbsp;  
### 역할에 따라 변수, 매개변수 이름 및 관련 타입을 지정한다.


타입 제약 조건보다는 **역할에 따라 변수, 매개변수 이름 및 관련 타입을 지정한다.**
```
// 잘못된 방법
var string = "Hello"
protocol ViewController {
    associatedtype ViewType: View
}
class ProductionLine {
    func restock(from widgetFactory: WidgetFactory)
}
```
이런 식으로 타입 이름을 용도 변경하는 것은 명확성과 표현력을 최적화하지 못한다. 대신 엔티티의 역할을 나타내는 이름을 선택하려고 노력한다.
```
var greeting = "Hello"
protocol ViewController {
    associatedtype ContentView: View
}
class ProductionLine {
    func restock(from supplier: WidgetFactory)
}
```
만약 관련 타입이 프로토콜 제약 조건에 너무 밀접하게 바인딩되어 프로토콜 이름이 역할인 경우, 관련 타입 이름에 `Type`을 추가하여 충돌을 방지한다:
```
protocol Sequence {
    associatedtype IteratorType: Iterator
}
```


&nbsp;  
### 취약한 타입 정보를 보완한다.


매개변수의 역할을 명확히하기 위해 **취약한 타입 정보를 보완한다.**


특히 매개변수 타입이 `NSObject`, `Any`, `AnyObject` 또는 `Int`와 `String`과 같은 기본 타입인 경우 사용 시점에서 타입 정보와 문맥이 의도를 충분히 전달하지 못할 수 있다.
```
func add(_ observer: NSObject, for keyPath: String)
grid.add(self, for: graphics) // vague
```
명확성을 복원하려면, **각 취약한 타입 매개변수 앞에 그 역할을 설명하는 명사를 붙인다:**
```
func addObserver(_ observer: NSObject, forKeyPath path: String)
grid.addObserver(self, forKeyPath: graphics) // clear
```


&nbsp;     
&nbsp;  
## Strive for Fluent Usage


### 메서드 및 함수 이름은 사용 장소가 문법적 영어 구를 형성하는 것을 선호한다.


**메서드 및 함수 이름은 사용 장소가 문법적 영어 구를 형성하는 것을 선호한다.**
```
x.isert(y, at: z)       // "x, insert y at z"
x.subView(havingColor: y)   	// "x's subviews having color y"
x. capitalizingNouns()		// "x, capitalizing nouns"
```
```
// 잘못된 방법
x.isert(y, position: z)
x.subViews(color: y)
x.nounCapitalizer()
```
첫 번째 인수 또는 두 번째 인수가 호출의 의미에서 핵심이 아닐 때 유창성이 저하될 수 있다:
```
AudioUnit.instantiate(
    with: description,
    options: [.inProcess], completionHandler: stopProgressBar)
```

    
&nbsp;  
### make를 사용하여 팩토리 메서드 이름을 시작


"make"를 사용하여 **팩토리 메서드 이름을 시작한다**(e.g. `x.makeIterator()`).


&nbsp;  
### 초기화 및 팩토리 메서드 호출


**초기화 및 팩토리 메서드 호출**의 첫 번째 인수는 기본 이름으로 시작하는 구를 형성해서는 안된다(e.g. `x.makeWidget(cogCount: 47)`).


예를 들어, 이 호출에 대한 첫 번째 인수는 기본 이름과 동일한 구문의 일부로 읽지 않는다:
```
let foreground = Color(red: 32, green: 64, blue: 128)
let newPart = factory. makeWidget(gears: 42, spindles: 14)
let ref = Link(target: destination)
```
다음에서, API 작성자는 첫 번째 인수와 함께 문법적 연속성을 만들려고 했다.
```
// 잘못된 방법
let foreground = Color(havingRGBValuesRed: 32, green: 64, andBlue: 128)
let newPart = factory.makeWidget(havingGearCount: 42, andSpindleCount: 14)
let ref = Link(to: destination)
```
실제로, 이 인수 레이블에 대한 가이드라인은 호출이 값 보존 타입 변환을 수행하지 않는 한 첫 번째 인수에 레이블이 있음을 의미한다.
```
let rgbForeground = RGBColor(cmykForeground)
```

   
&nbsp;  
### 부가 효과에 따라 함수 및 메서드 이름을 지정한다.


**부가 효과(값의 변화)에 따라 함수 및 메서드 이름을 지정한다.**


* 부가 효과가 없을 경우 명사구로 읽어야 한다(e.g. `x.distance(to: y), i.successor()`).
* 부가 효과가 있을 경우 필수 동사구로 읽어야 한다(e.g. `print(x)`, `x.sort()`, `x.append(y)`).
* **이름 변형/비변형 메서드 쌍**은 일관되어야 한다. 변형 메서드는 종종 비변형과 유사한 의미를 가지지만 비변형은 인스턴스를 현재 위치에서 업데이트하는 대신 새로운 값을 반환한다.
* 동작이 동사에 의해 자연스럽게 기술될 때, 반드시 변형 메서드에 동사를 사용하고 비변형 메서드 이름에는 "ed" 또는 "ing" 접미사를 적용한다.

Nonmutating | Mutating
------------ | -------------
`z = x.sorted()` | `x.sort()`  
`z = x.appending(y)` | `x.append(y)`

* 동사의 과거 분사("ed")를 사용하여 비변형 메서드의 이름을 지정하는 것이 좋다:
```
// Reverses 'self' in-place.
mutating func reverse()
// Return a reversed copy of 'self'.
func reversed() -> Self
...
x.reverse()
let y = x.reversed()
```
* 동사에 직접 객체가 있을 때는 "ed"를 추가해도 문법적이 아니므로 동사의 현재 분사를 사용하여 비변형 메서드에 "ing"를 추가하여 이름을 지정한다.
```
// Strips all the newlines from 'self'
mutating func stripNewlines()
// Return a copy of 'self' with all the newlines stripped.
func strippingNewlines() -> String
...
s.stripNewlines()
let oneLine = t.strippingNewlines()
```
* 동작이 명사에 의해 자연스럽게 기술될 때, 비변형 메서드에 명사를 사용하고 번형 메서드에는 "form" 접두사를 적용하여 명명한다.

Nonmutating | Mutating
------------ | -------------
`x = y.union(z)` | `y.formUnion(z)`
`j = c.successor(i)` | `c.formSuccessor(&i)`


&nbsp;  
### 부울 메서드 및 프로퍼티의 사용은 비변형일 때 수신자에 대한 단언으로 읽어야 한다.


**부울 메서드 및 프로퍼티의 사용은 비변형일 때 수신자에 대한 단언으로 읽어야 한다**(e.g. `x.isEmpty`, `line1.intersects(line2)`).


&nbsp;  
### 어떤 무언가를 설명하는 프로토콜은 명사로 읽어야 한다.


**어떤 무언가를를 설명하는 프로토콜은 명사로 읽어야 한다**(e.g. `Collection`).


&nbsp;  
### 기능을 설명하는 프로토콜은 접미어 able, ible, ing를 사용하여 명명한다.


**기능을 설명하는 프로토콜은 접미어 able, ible, ing를 사용하여 명명한다**(e.g. `Equatable`, `ProgressReporting`).


&nbsp;  
### 다른 타입, 프로퍼티, 변수 및 상수의 이름은 명사로 읽어야 한다.


**다른 타입, 프로퍼티, 변수 및 상수의 이름은 명사로 읽어야 한다.** 


&nbsp;
&nbsp;      
### [by. 0junChoi](https://github.com/0jun0815)     email: <0jun0815@gamil.com>
### [Swift API Design Guidelines Naming](https://swift.org/documentation/api-design-guidelines/#naming)
