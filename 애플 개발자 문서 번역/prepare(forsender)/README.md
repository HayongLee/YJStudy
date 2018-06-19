# prepare(for:sender:)
> segue가 수행되고 있음을 뷰 컨트롤러에 알린다.


* [Declaration](#declaration)
* [Parameters](#parameters)
* [Discussion](#discussion)
* [See Also](#see-also)


&nbsp;
## Declaration
```
func prepare(for segue: UIStoryboardSegue, sender: Any?)
```


&nbsp;
## Parameters
* segue
    * segue에 관여하는 뷰 컨트롤러에 관한 정보를 포함한 segue 객체.
* sender
    * segue를 시작한 객체이다. 이 매개 변수를 사용하여 segue를 시작한 컨트롤(또는 다른 객체)에 따라 다른 액션을 수행할 수 있다.


&nbsp;
## Discussion
이 메서드의 기본 구현에서는, 아무것도 하지 않는다. 서브 클래스는 이 메서드를 오버라이드(재정의)해, 새로운 뷰 컨트롤러를 표시하기 전에 구성하기 위해서 사용한다. segue 객체에는 관련된 두 뷰 컨트롤러에 대한 참조를 포함하여 전환에 대한 정보가 들어있다.


segue는 여러 출발지에서 트리거 될 수 있기 때문에 segue 및 sender 매개 변수의 정보를 사용하여 앱의 서로 다른 논리 경로 사이의 모호성을 제거할 수 있다. 예를 들어, segue가 테이블 뷰에서 시작된 경우 sender 매개 변수는 사용자가 탭한 테이블 뷰 셀을 식별한다. 그런 다음 해당 정보를 사용하여 목적지 뷰 컨트롤러에서 데이터를 설정할 수 있다.


&nbsp;     
## See Also
### Interacting with Storyboards and Segues
* var storyboard: UIStoryboard?
* func shouldPerformSegue(withIdentifier: String, sender: Any?) -> Bool
* func performSegue(withIdentifier: String, sender: Any?)
* func allowedChildrenForUnwinding(from: UIStoryboardUnwindSegueSource) -> [UIViewController]
* func childContaining(UIStoryboardUnwindSegueSource) -> UIViewController?
* func canPerformUnwindSegueAction(Selector, from: UIViewController, withSender: Any) -> Bool
* func unwind(for: UIStoryboardSegue, towards: UIViewController)


&nbsp;      
&nbsp;      
### [by. 0junChoi](https://github.com/0jun0815) email: <0jun0815@gmail.com>
### [Apple Developer Documentation prepare(for:sender:)](https://developer.apple.com/documentation/uikit/uiviewcontroller/1621490-prepare)
