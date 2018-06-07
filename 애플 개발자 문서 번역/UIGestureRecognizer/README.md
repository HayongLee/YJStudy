# UIGestureRecognizer
> 구체적인 제스처 인식기의 기본 클래스이다.


* [Overview](#overview)
* [Subclassing Notes](#subclassing-notes)
    * [Methods to Override](#methods-to-override)
    * [Special Considerations](#special-considerations)
* [Topics](#topics)
    * [Initializing a Gesture Recognizer](#initializing-a-gesture-recognizer)
    * [Managing Gesture-Related Interactions](#managing-gesture-related-interactions)
    * [Adding and Removing Targets and Actions](#adding-and-removing-targets-and-actions)
    * [Getting the Touches and Location of a Gesture](#getting-the-touches-and-location-of-a-gesture)
    * [Getting the Recognizer's State and View](#getting-the-recognizer's-state-and-view)
    * [Canceling and Delaying Touches](#canceling-and-delaying-touches)
    * [Specifying Dependencies Between Gesture Recognizers](#specifying-dependencies-between-gesture-recognizers)
    * [Recognizing Different Gestures](#recognizing-different-gestures)
    * [Methods for Subclasses](#methods-for-subclasses)
    * [Debugging Gesture Recognizers](#debugging-gesture-recognizers)
    * [Constants](#constants)
* [Relationships](#relationships)
* [See Also](#see-also)
    

&nbsp;      
## Overview
제스처 인식기 객체 또는 간단히 제스처 인식기는 일련의 터치(또는 다른 입력)를 인식하고 그 인식에 작용하는 로직을 분리한다. 이러한 객체 중 하나가 공통 제스처 또는 일부 경우에는 제스처의 변경을 인식하면 지정된 각 타겟 객체에 액션 메시지를 보낸다.


UIGestureRecognizer의 구체적인 서브 클래스는 다음과 같다:
* [UITapGestureRecognizer](https://developer.apple.com/documentation/uikit/uitapgesturerecognizer)
* [UIPinchGestureRecognizer](https://developer.apple.com/documentation/uikit/uipinchgesturerecognizer)
* [UIRotationGestureRecognizer](https://developer.apple.com/documentation/uikit/uirotationgesturerecognizer)
* [UISwipeGestureRecognizer](https://developer.apple.com/documentation/uikit/uiswipegesturerecognizer)
* [UIPanGestureRecognizer](https://developer.apple.com/documentation/uikit/uipangesturerecognizer)
* [UIScreenEdgePanGestureRecognizer](https://developer.apple.com/documentation/uikit/uiscreenedgepangesturerecognizer)
* [UILongPressGestureRecognizer](https://developer.apple.com/documentation/uikit/uilongpressgesturerecognizer)


UIGestureRecognizer 클래스는 모든 구체적인 제스처 인식기에 대해 구성 할 수 있는 공통 행동(Behaviors) 집합을 정의한다. 또한 델리게이트([UIGestureRecognizerDelegate](https://developer.apple.com/documentation/uikit/uigesturerecognizerdelegate) 프로토콜을 채택한 객체)와 통신 할 수 있으므로 일부 행동을 더욱 세밀하게 사용자 지정할 수 있다.


제스처 인식기는 특정 뷰 및 해당 뷰의 모든 서브 뷰들에 히트-테스트된 터치로 작동한다. 따라서 이 뷰와 연관되어야 한다. 해당 연결을 만들려면 [UIView](https://developer.apple.com/documentation/uikit/uiview) 메서드 [addGestureRecognizer(_:)](https://developer.apple.com/documentation/uikit/uiview/1622496-addgesturerecognizer)를 호출해야 한다. 제스처 인식기는 뷰의 응답자 체인(responder chain)에 참여하지 않는다.


제스처 인식기에는 이와 관련된 하나 이상의 타겟-액션 쌍이 있다. 타겟-액션 쌍이 여러 개인 경우 누적이 아닌 개별적이다. 제스처를 인식하면 관련된 쌍 각각에 대해 타겟에 액션 메시지가 전달된다. 호출되는 액션 메서드는 다음 시그니처 중 하나를 준수해야 한다.
```
@IBAction func myActionMethod()
@IBAction func myActionMethod(_ sender: UIGestureRecognizer)
```


후자의 시그니처를 따르는 메서드는 경우에 따라 타겟이 추가 정보를 위해 메시지를 보내는 제스처 인식기를 쿼리 할 수 있다. 예를 들어, 타겟은 이 제스처에 대한 액션 메서드의 마지막 호출 이후 [UIRotationGestureRecognizer](https://developer.apple.com/documentation/uikit/uirotationgesturerecognizer) 객체에 회전 각도(라디안)를 요청할 수 있다. 제스처 인식기의 클라이언트는 [location(in:)](https://developer.apple.com/documentation/uikit/uigesturerecognizer/1624219-location) 또는 [location(ofTouch:in:)](https://developer.apple.com/documentation/uikit/uigesturerecognizer/1624201-location)를 호출하여 제스처의 위치를 요청할 수도 있다. 


제스처 인식기로 해석되는 제스처는 개별 또는 연속 일 수 있다. 더블 탭과 같은 개별 제스처는 멀티 터치 시퀀스에서 한 번 발생하지만 단일 액션이 전송된다. 그러나 제스처 인식기가 회전 제스처와 같은 연속 제스처를 해석하면 멀티 터치 시퀀스가 끝날 때까지 점진적 변경마다 액션 메시지를 보낸다.


윈도우는 제스처 인식기에 연결된 히트-테스트된 뷰로 터치 이벤트를 전달하기 전에 터치 이벤트를 제스처 인식기에 전달한다. 일반적으로 제스처 인식기가 멀티 터치 시퀀스에서 터치 스트림을 분석하고 제스처를 인식하지 못하는 경우 뷰는 전체 터치 보완을 받는다. 제스처 인식기가 제스처를 인식하면 뷰에 대한 나머지 터치가 취소된다. 제스처 인식의 일반적인 동작 시퀀스는 [cancelsTouchesInView](https://developer.apple.com/documentation/uikit/uigesturerecognizer/1624218-cancelstouchesinview), [delaysTouchesBegan](https://developer.apple.com/documentation/uikit/uigesturerecognizer/1624234-delaystouchesbegan), [delaysTouchesEnded](https://developer.apple.com/documentation/uikit/uigesturerecognizer/1624209-delaystouchesended) 프로퍼티의 기본 값에 따라 결정되는 경로를 따른다:

* cancelTouchesInView - 제스처 인식기가 제스처를 인식하면 해당 제스처의 나머지 터치를 뷰에서 바인딩 해제한다(그래서 윈도우에서 전달되지 않는다). 윈도우는 [touchesCancelled(_:with:)](https://developer.apple.com/documentation/uikit/uiresponder/1621116-touchescancelled) 메시지를 사용하여 이전에 전달된 터치를 취소한다. 제스처 인식기가 제스처를 인식하지 못하면 뷰는 멀티 터치 시퀀스에서 모든 터치를 받는다.  
* delaysTouchesBegan - 제스처 인식기가 터치 이벤트를 분석할 때 제스처 인식에 실패하지 않는 한 윈도우는 [UITouch.Phase.began](https://developer.apple.com/documentation/uikit/uitouch/phase/began) 단계에서 터치 객체를 첨부된 뷰로 전달하는 것을 보류한다. 제스처 인식기가 이후 제스처를 인식하면 뷰는 이러한 터치 객체를 수신하지 않는다. 제스처 인식기가 제스처를 인식하지 못하면 윈도우는 뷰의 [touchesBegan(_:with:)](https://developer.apple.com/documentation/uikit/uiresponder/1621142-touchesbegan) 메서드를 호출하여 이러한 객체를 전달한다(가능한 경우 후속 [touchesMoved(_:with:)](https://developer.apple.com/documentation/uikit/uiresponder/1621107-touchesmoved)를 호출하여 현재 위치를 터치한다).
* delaysTouchesEnded - 제스처 인식기가 터치 이벤트를 분석할 때 제스처 인식에 실패하지 않는 한 윈도우는 [UITouch.Phase.ended](https://developer.apple.com/documentation/uikit/uitouch/phase/ended) 단계에서 터치 객체를 첨부된 뷰로 전달하는 것을 보류한다. 제스처 인식기가 이 후에 제스처를 인식하면 터치가 취소된다([touchesCancelled(_:with:)](https://developer.apple.com/documentation/uikit/uiresponder/1621116-touchescancelled) 메시지). 제스처 인식기가 제스처를 인식하지 못하면 윈도우는 뷰의 [touchesEnded(_:with:)](https://developer.apple.com/documentation/uikit/uiresponder/1621084-touchesended) 메서드를 호출하여 이러한 객체를 전달한다.


위의 설명에서 "recognize(인식)"은 반드시 Recognized state(인식 상태)로의 전환과 동일한 것은 아니다.


&nbsp;
## Subclassing Notes
UIGestureRecognizer의 서브 클래스(예: "확인 표시" 제스처)를 식별하는 제스처를 만들 수 있다. 그런 구체적인 제스처 인식기를 만들려면 UIGestureRecognizerSubclass.h 헤더 파일을 가져와야 한다. 이 헤더 파일은 서브 클래스가 재정의, 호출 또는 재설정해야 하는 모든 메서드와 속성을 선언한다.


제스처 인식기는 사전 정의된 상태 시스템 내에서 작동하여 멀티 터치 이벤트를 처리 할때 후속 상태로 전환한다. 상태 및 가능한 전환은 연속 및 개별 제스처에 따라 다르다. 모든 제스처 인식기는 가능한 상태([UIGestureRecognizer.State.possible](https://developer.apple.com/documentation/uikit/uigesturerecognizer/state/possible))에서 멀티 터치 시퀀스를 시작한다. 개별 제스처는 성공적으로 제스처를 해석하는지 여부에 따라 가능에서 인식([recognized](https://developer.apple.com/documentation/uikit/uigesturerecognizer/state/1624228-recognized)) 또는 실패([UIGestureRecognizer.State.failed](https://developer.apple.com/documentation/uikit/uigesturerecognizer/state/failed))로 전환된다. 제스처 인식기가 Recognized로 전환하면 해당 액션 메시지가 타겟에 전송된다.


연속 제스처의 경우 다음 그림과 같이 상태가 전환되면 제스처 인식자가 더 많아 질 수 있다:
* Possible ----> Began ----> [Changed] ----> Cancelled
* Possible ----> Began ----> [Changed] ----> Ended


Changed 상태는 선택 사항이며 Canceled 또는 Ended 상태에 도달하기 전에 여러 번 발생할 수 있다. 제스처 인식기는 각 상태 전환시 액션 메시지를 보낸다. 따라서 핀치(pinch)와 같은 연속적인 제스처의 경우, 두 손가락이 서로를 향해 또는 멀어지면서 액션 메시지가 전송된다. 이러한 상태를 나타내는 열거형 상수는 [UIGestureRecognizer.State](https://developer.apple.com/documentation/uikit/uigesturerecognizer/state) 타입이다(Recognized 및 Ended 상태의 상수는 동의어이다).


서브 클래스는 상태간 전환할 때 [state](https://developer.apple.com/documentation/uikit/uigesturerecognizer/1619998-state) 프로퍼티를 적절한 값으로 설정해야 한다.


### Methods to Override
서브 클래스가 재정의할 필요가 있는 메서드는 [Methods for Subclasses](https://developer.apple.com/documentation/uikit/uigesturerecognizer#1658520)에 설명되어 있다. 서브 클래스는 또한 위에서 설명한대로 [state](https://developer.apple.com/documentation/uikit/uigesturerecognizer/1619998-state) 프로퍼티를 주기적으로 재설정해야 하며 [ignore(_:for:)](https://developer.apple.com/documentation/uikit/uigesturerecognizer/1620010-ignore) 메서드를 호출할 수 있다.


### Special Considerations
state 프로퍼티는 UIGestureRecognizer.h에서 읽기 전용으로 선언된다. 이 프로퍼티 선언은 제스처 인식기의 클라이언트를 대상으로한다. UIGestureRecognizer의 서브 클래스는 UiGestureRecognizerSubclass.h를 임포트해야 한다. 이 헤더 파일에는 읽기-쓰기 상태의 재선언이 포함되어 있다.


&nbsp;
## Topics
### Initializing a Gesture Recognizer
> 제스처 인식기 초기화

* `init(target: Any?, action: Selector?)`
    * 할당 된 제스처 인식기 객체를 타겟 및 액션 셀렉터로 초기화한다.
    
    
### Managing Gesture-Related Interactions
> 제스처 관련 상호작용 관리

* `var delegate: UIGestureRecognizerDelegate?`
    * 제스처 인식기의 델리게이트
* `protocol UIGestureRecognizerDelegate`
    * 제스처 인식기의 델리게이트가 구현한 일련의 메서드로, 앱의 제스처 인식 행동을 미세 조정한다.
    
    
### Adding and Removing Targets and Actions
> 타겟 및 액션 추가 및 제거

* `func addTarget(Any, action: Selector)`
    * 제스처 인식기 객체에 타겟과 액션을 추가한다.
* `func removeTarget(Any?, action: Selector?)`
    * 제스처 인식기 객체에서 타겟과 액션을 제거한다.
    
    
### Getting the Touches and Location of a Gesture
> 제스처의 위치와 터치 얻기

* `func location(in: UIView?) -> CGPoint`
    * 리시버가 나타내는 제스처의 지정된 뷰 내의 위치로서 계산된 점을 반환한다.
* `func location(ofTouch: Int, in: UIView?) -> CGPoint`
    * 지정된 뷰의 로컬 좌표 체계에서 제스처 터치 중 하나의 위치를 반환한다.
* `var numberOfTouches: Int`
    * 리시버가 나타내는 제스처에 포함되는 터치의 수를 반한한다.
    
    
### Getting the Recognizer's State and View
> 인식기의 상태 및 뷰 얻기

* `var state: UIGestureRecognizer.State`
    * 제스처 인식기의 현재 상태
* `var view: UIView?`
    * 제스처 인식기에 연관된 뷰
* `var isEnabled: Bool`
    * 제스처 인식기가 활성화되었는지 여부를 나타내는 부울 프로퍼티
    
    
### Canceling and Delaying Touches
> 터치 취소 및 지연

* `var cancelsTouchesInView: Bool`
    * 제스처가 인식될 때 터치가 뷰로 전달되는지 여부에 영향을 주는 부울 값
* `var delaysTouchesBegan: Bool`
    * 리시버가 시작 단계에서 해당 뷰로 전송 터치를 지연하는지 여부를 결정하는 부울 값
* `var delaysTouchesEnded: Bool`
    * 리시버가 종료 단계에서 해당 뷰로 전송 터치를 지연시키는지 여부를 결정하는 부울 값
    
    
### Specifying Dependencies Between Gesture Recognizers
> 제스처 인식기 간의 종속성 지정

* `func require(toFail: UIGestureRecognizer)`
    * 객체가 만들어질 때 리시버와 다른 제스처 인식자 사이에 종속 관계를 만든다.


### Recognizing Different Gestures
> 다른 제스처 인식하기

* `var allowedPressTypes: [NSNumber]`
    * 버튼 프레스 타입을 구별하는 데 사용되는 프레스 타입의 배열이다.
* `var allowedTouchTypes: [NSNumber]`
    * 터치 타입을 구분하는데 사용되는 터치 타입의 배열이다.
* `var requiresExclusiveTouchType: Bool`
    * 제스처 인식기가 다른 타입의 터치를 동시에 고려하는지 여부를 나타내는 부울


### Methods for Subclasses
> 서브 클래스를 위한 메서드  

UIGestureRecognizerSubclass.h 헤더 파일에는 UIGestureRecognizer의 서브 클래스에 의해서만 호출되거나 재정의되는 메서드를 선언하는 클래스 익스텐션(확장)이 포함된다. UIGestureRecognizer의 구체적인 서브 클래스만을 사용하는 클라이언트는 이러한 메서드를 절대로 호출할 수 없다.


* `func touchesBegan(Set<UITouch>, with: UIEvent)`
    * 하나 이상이 손가락이 연관된 뷰에서 눌려질 때 제스처 인식기로 보낸다.
* `func touchesMoved(Set<UITouch>, with: UIEvent)`
    * 하나 이상의 손가락이 연관된 뷰에서 움직일 때 제스처 인식기로 보낸다.
* `func touchesEnded(Set<UITouch>, with: UIEvent)`
    * 하나 이상의 손가락이 연관된 뷰에서 들어 올려질 때 제스처 인식기로 보낸다.
* `func touchesCancelled(Set<UITouch>, with: UIEvent)`
    * 시스템 이벤트(수신 전화 통화 등)가 터치 이벤트를 취소하면 제스처 인식기로 보낸다.
* `func touchesEstimatedPropertiesUpdated(Set<UITouch>)`
    * 터치의 예상 프로퍼티가 변경되어 더 이상 추정되지 않거나 또는 업데이트가 더 이상 필요하지 않는 경우 제스처 인식기로 보낸다.
* `func reset()`
    * 재스처 인식 시도가 완료되면 내부 상태를 다시 설정하기 위해 재정의된다.
* `func ignore(UITouch, with: UIEvent)`
    * 제스처 인식기에 지정된 이벤트의 특정 터치를 무시하도록 지시한다.
* `func canBePrevented(by: UIGestureRecognizer) -> Bool`
    * 지정된 제스처 인식기가 리시버가 제스처를 인식하는 것을 방지할 수 있음을 나타내기 위해 재정의된다.
* `func canPrevent(UIGestureRecognizer) -> Bool`
    * 리시버가 지정된 제스처 인식기가 제스처를 인식하는 것을 방지할 수 있음을 나타내기 위해 재정의된다.
* `func shouldRequireFailure(of: UIGestureRecognizer) -> Bool`
    * 리시버가 지정된 제스처 인식기가 실패할 것을 요구함을 나타내기 위해 재정의된다.
* `func shouldBeRequiredToFail(by: UIGestureRecognizr) -> Bool`
    * 리시버가 지정된 제스처 인식기로 실패해야 함을 나타내기 위해 재정의된다.
* `func ignore(UIPress, for: UIPressesEvent)`
    * 제스처 인식기에 지정된 이벤트의 특정 프레스를 무시하도록 한다.
* `func pressesBegan(Set<UIPress>, with: UIPressesEvent)`
    * 연관된 뷰에서 실제 버튼을 누르면 리시버에게 보낸다.
* `func pressesChanged(Set<UIPress>, with: UIPressesEvent)`
    * 연관된 뷰에서 프레스의 [force](https://developer.apple.com/documentation/uikit/uipress/1620364-force)가 변경되면 리시버로 보낸다.
* `func pressesEnded(Set<UIPress>, with: UIPressesEvent)`
    * 연관된 뷰에서 버튼을 놓을 때 리시버로 보낸다.
* `func pressesCancelled(Set<UIPress>, with: UIPressesEvent)`
    * 시스템 이벤트(예: 메모리 부족 경고)가 프레스 이벤트를 취소할 때 리시버로 보낸다. 


### Debugging Gesture Recognizers
> 제스처 인식기 디버깅

* `var name: String?`
    * 제스처 인식기와 관련된 이름


### Constants
* `enum UIGestureRecognizer.State`
    * 제스처 인식기가 있는 현재 상태


&nbsp;      
## Relationships
### Inherits From
* NSObject


### Conforms To
* CVarArg, Equatable, Hashable


&nbsp;
## See Also
### Custom Gesture
* Implementing a Custom Gesture Recognizer
* protocol UIGestureRecognizerDelegate



&nbsp;      
&nbsp;      
### [by. 0junChoi](https://github.com/0jun0815) email: <0jun0815@gamil.com>
### [Apple Developer Documentation UIGestureRecognizer](https://developer.apple.com/documentation/uikit/uigesturerecognizer)
