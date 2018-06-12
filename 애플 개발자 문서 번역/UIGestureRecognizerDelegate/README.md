# UIGestureRecognizerDelegate
> 제스처 인식기의 델리게이트가 구현한 일련의 메서드로, 앱의 제스처 인식 동작을 미세 조정한다.


* [Overview](#overview)
* [Topics](#topics)

* [Relationships](#relationships)
* [See Also](#see-also)
    

&nbsp;      
## Overview
델리게이트는 제스처 인식기에서 메시지를 받으며 이 메시지에 대한 응답을 통해 제스처 인식기의 작동에 영향을 미치거나 동적 인식을 허용하거나 동적 실패 요구 사항을 설정하는 것과 같은 다른 제스처 인식기와의 관계를 지정할 수 있다.


동적 실패 요구 사항이 유용한 상황의 예로 화면 가장자리 팬 제스처 인식기를 뷰에 연결하는 앱이 있다. 이 경우 화면 가장자리 제스처 인식기가 인식 프로세스를 시작한 후 다른 인식기가 취소 될 때 발생할 수 있는 그래픽 오류를 방지할 수 있도록 해당 뷰의 하위 트리와 관련된 다른 모든 제스처 인식기를 사용하려고 할 수 있다. 이렇게하려면 다음과 비슷한 코드를 사용할 수 있다:
```
let myScreenEdgePanGestureRecognizer = UIScreenEdgePanGestureRecognizer(target: self, action: #selector(handleScreenEdgePan))
myScreenEdgePanGestureRecognizer.delegate = self

// Configure the gesture recognizer and attach it to the view.
...

func gestureRecognizer(_ gestureRecognizer: UIGestureRecognizer, shouldBeRequiredToFailBy otherGestureRecognizer: UIGestureRecognizer) -> Bool {
    guard let myView = myScreenEdgePanGestureRecognizer.view,
    let otherView = otherGestureRecognizer.view else { 
        return false 
    }

    return gestureRecognizer == myScreenEdgePanGestureRecognizer && otherView.isDescendant(of: myView)
}
```


&nbsp;
## Topics
### Regulating Gesture Recognition
> 제스처 인식 규제

* `func gestureRecognizerShouldBegin(UIGestureRecognizer) -> Bool`
    * 제스처 인식기가 터치를 해석해야 하는 경우 델리게이트에게 요청한다.
* `func gestureRecognizer(UIGestureRecognizer, shouldReceive: UITouch) -> Bool`
    * 제스처 인식기가 터치를 나타내는 객체를 받아야 하는 경우 델리게이트에게 요청한다.
* `func gestureRecognizer(UIGestureRecognizer, shouldReceive: UIPress) -> Bool`
    * 제스처 인식기가 프레스를 나타내는 객체를 받아야 하는 경우 델리게이트에게 요청한다.


### Controlling Simultaneous Gesture Recognition
> 동시 제스처 인식 제어

* `func gestureRecognizer(UIGestureRecognizer, shouldRecognizeSimultaneouslyWith: UIGestureRecognizer) -> Bool`
    * 두 제스처 인식기가 제스처를 동시에 인식하도록 허용해야 하는 경우 델리게이트에게 요청한다.


### Setting Up Failure Requirements
> 실패 요구사항 설정

* `func gestrueRecognizer(UIGestureRecognizer, shouldRequireFailureOf: UIGestureRecognizer) -> Bool`
    * 제스처 인식기가 다른 제스처 인식기를 실패해야 하는 경우 델리게이트에게 요청한다.
* `func gestureRecognizer(UIGestureRecognizer, shouldBeRequiredToFailBy: UIGestureRecognizer) -> Bool`
    * 제스처 인식기가 다른 제스처 인식기에 의해 실패해야 하는 경우 델리게이트에게 요청한다.


&nbsp;      
## Relationships
### Inherits From
* NSObjectProtocol


### Adopted By
* PDFView, UITableViewCell


&nbsp;
## See Also
### Custom Gestures
* Implementing a Custom Gesture Recognizer
* class UIGestureRecognizer


&nbsp;      
&nbsp;      
### [by. 0junChoi](https://github.com/0jun0815) email: <0jun0815@gmail.com>
### [Apple Developer Documentation UIGestureRecognizerDelegate](https://developer.apple.com/documentation/uikit/uigesturerecognizer)
