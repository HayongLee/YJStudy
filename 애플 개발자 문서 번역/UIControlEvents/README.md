# UIControlEvents
> 컨트롤 가능한 이벤트 타입을 기술한 상수이다.


* [Overview](#overview)
* [Topics](#topics)
    * [Initializers](#Initializers)
    * [Constants](#Constants)
* [Relationships](#relationships)
    * [Conforms To](#conforms-to)
    

&nbsp;      
## Overview
타겟 및 액션을 하나 이상의 제어 이벤트와 연결하여 타겟 객체에 액션 메시지를 보내도록 컨트롤을 설정한다. 이렇게하려면 [addTarget(_:action:for:)](https://developer.apple.com/documentation/uikit/uicontrol/1618259-addtarget)을 지정하려는 각 타겟-액션 쌍의 컨트롤에 보낸다.

&nbsp;
## Topics
### Initializers
> 초기화

* `init(rawValue: UInt)`


### Constants
> 상수

* `static var touchDown: UIControlEvents`
    * 컨트롤의 터치 다운 이벤트
* `static var touchDownRepeat: UIControlEvents`
    * 컨트롤에서 반복되는 터치 다운 이벤트. 이 이벤트의 경우 UITouch tapCount 메서드의 값이 1보다 크다.
* `static var touchDragInside: UIControlEvents`
    * 컨트롤의 경계 내에서 손가락을 드래그하는 이벤트
* `static var touchDragOutside: UIControlEvents`
    * 컨트롤의 바깥 쪽에서 손가락을 드래그하는 이벤트
* `static var touchDragEnter: UIControlEvents`
    * 손가락이 컨트롤의 경계로 드래그되는 이벤트
* `static var touchDragExit: UIControlEvents`
    * 컨트롤 내에서 손가락이 경계 밖으로 드래그되는 이벤트
* `static var touchUpInside: UIControlEvents`
    * 손가락이 컨트롤의 경계 안에 있는 컨트롤의 터치 업 이벤트
* `static var touchUpOutside: UIControlEvents`
    * 손가락이 컨트롤 경계 밖에 있는 컨트롤의 터치 업 이벤트
* `static var touchCancel: UIControlEvents`
    * 컨트롤의 현재 터치를 취소하는 시스템 이벤트 
* `static var valueChanged: UIControlEvents`
    * 터치를 드래그하거나 다른 방식으로 조작하여 일련의 다른 값을 방출하도록 하는 컨트롤
* `static var primaryActionTriggered: UIControlEvents`
    * 버튼에 의해 트리거되는 의미론적 액션
* `static var editingDidBegin: UIControlEvents`
    * 경계에 들어가 UITextField 객체에서 편집 세션을 시작하는 터치
* `static var editingChanged: UIControlEvnets`
    * UITextField 객체에서 편집 변경을 만드는 터치
* `static var editingDidEnd: UiControlEvents`
    * 경계를 벗어나 UITextField 객체의 편집 세션을 끝내는 터치
* `static var editingDidEndOnExit: UiControlEvents`
    * UITextField 객체에서 편집 세션을 끝내는 터치
* `static var allTouchEvents: UIControlEvents`
    * 모든 터치 이벤트
* `static var allEditingEvents: UIControlEvents`
    * UITextField 객체에 대한 모든 편집 터치
* `static var applicationReserved: UIControlEvents`
    * 애플리케이션 사용에 이용할 수 있는 일련의 제어 이벤트 값
* `static var systemReserved: UIControlEvents`
    * 내부 프레임워크 사용을 위해 예약된 일련의 제어 이벤트 값
* `static var allEvents: UIControlEvents`
    * 시스템 이벤트를 포함한 모든 이벤트


&nbsp;      
## Relationships
### Conforms To
* OptionSet


&nbsp;      
&nbsp;      
### [by. 0junChoi](https://github.com/0jun0815) email: <0jun0815@gamil.com>
### [Apple Developer Documentation UIControlEvents](https://developer.apple.com/documentation/uikit/uicontrolevents)
