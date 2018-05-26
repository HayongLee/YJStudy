# Adopting Cocoa Design Patterns


* [Delegation](#delegation)
* [Lazy Initialization](#lazy-initialization)
* [Key-Value Observing](#key-value-observing)
* [Target-Action](#target-action)
* [Singleton](#singleton)

## Delegation
델리게이션은 종종 상호 작용을 정의하는 프로토콜과 준수하는 델리게이션 프로퍼티로 표현된다. 델리게이션이 응답하지 않을 수도 있다는 메시지를 보내기 전에 델리게이션에게 셀렉터에 응답하는지를 묻는다. Swift에서 옵셔널 체이닝을 사용하여 `nil` 객체에 옵셔널 프로토콜 메서드를 호출하고 `if-let` 구문을 사용하여 긍정적인 결과를 언래핑할 수 있다. 아래 코드는 다음 과정을 보여준다:


1. `myDelegate`가 `nil`인지 확인한다.
2. `myDelegate`가 `window:willUseFullScreenContentSize:` 메서드를 구현했는지 확인한다.
3. 1과 2가 true이면 메서드를 호출하고 메서드 결과를 `fullScreenSize`라는 값에 할당한다.
4. 메서드의 반환 값을 출력한다.
```
class MyDelegate: NSObject, NSWindowDelegate {
    func window(_ window: NSWindow, willUseFullScreenContentSize proposedSize: NSSize) -> NSSize {
        return proposedSize
    }
}
myWindow.delegate = MyDelegate()
if let fullScreenSize = myWindow.delegate?.window(myWindow, willUseFullScreenContentSize: mySize) {
    print(NSStringFromSize(fullScreenSize))
}
```


&nbsp;
## Lazy Initialization


lazy 프로퍼티는 프로퍼티에 처음 접근될 때만 기본 값이 초기화되는 프로퍼티이다. lazy 프로퍼티는 프로퍼티의 초깃값이 복잡하거나 계산 비용이 많이 드는 설정을 필요로 하거나 인스턴스 초기화가 완료될 때까지 결정할 수 없는 경우에 유용하다.


Swift에서 초깃값을 가진 저장 프로퍼티는 lazy 수식어로 선언되어 프로퍼티에 처음 접근할 때만 평가되는 초깃값을 계산하는 표현식을 가질 수 있다: 
```
lazy var XML: XMLDocument = try! XMLDocument(contentsOf: Bundle.main.url(forResource: "document", withExtension: "xml")!)
```
lazy 프로퍼티는 완전히 초기화된 인스턴스에 접근할 때만 계산되기 때문에 기본값 초기화 표현식에서 같은 인스턴스의 다른 상수 또는 변수 프로퍼티를 사용할 수 있다:
```
var pattern: String
lazy var regex: NSRegularExpression = try! NSRegularExpression(pattern: self.pattern)
```
초기화 이상의 추가 설정이 필요한 값의 경우, 프로퍼티의 기본 값에 초기화된 값을 반환하는 클로저를 할당할 수 있다:
```
lazy var currencyFormatter: NumberFormatter = {
    let formatter = NumberFormatter()
    formatter.numberStyle = .currency
    formatter.currencySymbol = "¤"
    return formatter
}()
```
> lazy 프로퍼티가 아직 초기화되지 않은 상태에서 하나 이상의 스레드가 동시에 접근하는 경우 프로퍼티가 한 번만 초기화된다는 보장이 없다.


&nbsp;      
## Key-Value Observing
키-값 감시는 다른 객체의 특정 프로퍼티에 대한 변경 사항을 객체에 알릴 수 있는 메커니즘이다. 클래스가 `NSObject` 클래스를 상속한다면 Swift 클래스로 키-값 감시를 사용할 수 있다. 이 두 단계를 사용하여 Swift에서 키-값 감시를 구현할 수 있다.


1. 감시하려는 모든 프로퍼티에 `dynamic` 및 `@objc`수식어를 추가한다.
```
class MyObjectToObserve: NSObject {
    @objc dynamic var myDate = NSDate()
    func updateDate() {
        myDate = NSDate()
    }
}
```
2. 키 경로에 대한 감시자를 만들고 `observe(_:options:changeHandler)` 메서드를 호출한다.
```
class MyObserver: NSObject {
    @objc var objectToObserve: MyObjectToObserve
    var observation: NSKeyValueObservation?
    
    init(object: MyObjectToObserve) {
        objectToObserve = object
        super.init()
        
        observation = observe(\.objectToObserve.myDate) { object, change in
            print("Observed a change to \(object.objectToObserve).myDate, updated to: \(object.objectToObserve.myDate)")
        }
    }
}

let observed = MyObjectToObserve()
let observer = MyObserver(object: observed)

observed.updateDate()
```


&nbsp;     
## Target-Action
타겟-액션은 특정 이벤트가 발생할 때 한 객체가 다른 객체에 메시지를 보내는 일반적인 코코아 디자인 패턴이다. 타겟-액션 모델은 Swift와 Objective-C에서 근본적으로 유사하다. Swift에서는 Selector 타입을 사용하여 Objective-C 셀렉터를 참조한다.



&nbsp;     
## Singleton
싱글톤은 전역적으로 접근 가능한 객체의 공유 인스턴스를 제공한다. 사운드 효과를 재생하는 오디오 채널이나 HTTP 요청을 하는 네트워크 관리자와 같이 앱에서 공유되는 자원 또는 서비스에 통합 접근점을 제공하는 방법으로 싱글톤을 만들 수 있다. 


Swift에서 static 타입 프로퍼티를 사용하면 여러 스레드에서 동시에 접근 할 때에도 한 번만 지연 초기화될 수 있다:
```
class Singleton {
    static let sharedInstance = Singleton()
}
```
만약 초기화 이상의 추가 설정을 수행해야 하는 경우, 클로저 구문을 전역 상수에 할당할 수 있다:
```
class Singleton {
    static let sharedInstance: Singleton = {
        let instance = Singleton()
        // setup code
        return instance
    }()
}
```


&nbsp;      
&nbsp;      
### [Apple Developer Documentation Adopting Cocoa Design Patterns](https://developer.apple.com/library/content/documentation/Swift/Conceptual/BuildingCocoaApps/AdoptingCocoaDesignPatterns.html#//apple_ref/doc/uid/TP40014216-CH7-ID6)
