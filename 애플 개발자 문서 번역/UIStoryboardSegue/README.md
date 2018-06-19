# UIStoryboardSegue
> 2개의 뷰 컨트롤러간의 시각적 전환을 준비하고 실행하는 객체이다.


* [Overview](#overview)
* [Subclassing Notes](#subclassing-notes)
    * [Methods to Override](#methods-to-override)
    * [Alternatives to Subclassing](#alternatives-to-subclassing)
* [Topic](#topic)
    * [Initializing a Storyboard Segue](#initializing-a-storyboard-segue)
    * [Accessing the Segue Attributes](#accessing-the-segue-attributes)
    * [Performing the Segue](#performing-the-segue)
    * [Creating a Custom Segue](#creating-a-custom-segue)
* [Relationships](#relationships)
* [See Also](#see-also)


&nbsp;      
## Overview
UIStoryboardSegue 클래스는 UIKit에서 사용할 수 있는 표준 시각적 전환을 지원한다. 스토리보드 파일의 뷰 컨트롤러간에 커스텀 전환을 정의하기 위해 서브 클래스로 지정할 수도 있다.


Segue(세그) 객체에는 전환과 관련된 뷰 컨트롤러에 대한 정보가 들어 있다. segue가 트리거 될 때 시각적 전환이 발생하기 전에 스토리보드 런타임은 현재 뷰 컨트롤러의 [prepare(for:sender:)](https://developer.apple.com/documentation/uikit/uiviewcontroller/1621490-prepare) 메서드를 호출하여 필요한 데이터를 곧 표시될 뷰 컨트롤러로 전달할 수 있다.


segue 객체를 직접 생성하지 않는다. 대신 스토리보드 런타임은 두 개의 뷰 컨트롤러 사이에서 segue를 수행해야 할 때 segue 객체를 만든다. 원하는 경우 UIViewController의 [perFormSegue(withIdentifier:sender:)](https://developer.apple.com/documentation/uikit/uiviewcontroller/1621413-performsegue) 메서드를 사용하여 프로그래밍 방식으로 segue를 시작할 수 있다. 프로그래밍 방식으로 추가되었으므로 출발지로부터 segue를 시작하기 위해 인터페이스 빌더를 사용할 수 없다.


&nbsp;      
## Subclassing Notes
애플리케이션의 뷰 컨트롤러간에 커스텀 전환을 제공하려는 상황에서 UIStoryboardSegue의 서브 클래스를 만들 수 있다. 커스텀 segue를 사용하려면, 인터페이스 빌더에서 적절한 뷰 컨트롤러 사이에 segue 라인을 생성하고inspector에서 그 타입을 Custom으로 설정한다. inspector에서 사용할 segue의 클래스 이름도 지정해야 한다.


스토리보드 런타임이 커스텀 segue를 감지하면 클래스의 새 인스턴스를 만들고 뷰 컨트롤러 객체로 구성한 후, 뷰 컨트롤러 출발지에 segue를 준비하도록 요청한 다음 segue를 수행한다.


&nbsp;
### Methods to Override
커스텀 segues의 경우, 오버라이드(재정의)할 필요가 있는 주요 메서드는 [perform()](https://developer.apple.com/documentation/uikit/uistoryboardsegue/1621912-perform) 메서드이다. 스토리보드 런타임은 뷰 컨트롤러의 출발지에서 뷰 컨트롤러의 목적지로 시각적 전환을 수행할 때 이 메서드를 호출한다. 커스텀 segue 서브 클래스의 변수를 초기화해야 한다면, [init(identifier:source:destination:)](https://developer.apple.com/documentation/uikit/uistoryboardsegue/1621908-init) 메서드를 오버라이드하여 커스텀 구현에서 초기화할 수도 있다.


&nbsp;
### Alternatives to Subclassing
segue가 추가 정보를 저장하거나 [perform()](https://developer.apple.com/documentation/uikit/uistoryboardsegue/1621912-perform) 메서드 이외의 것을 제공할 필요가 없다면 대신 [init(identifier:source:detination:performHandler:)](https://developer.apple.com/documentation/uikit/uistoryboardsegue/1621910-init) 메서드를 사용할 것을 고려한다. 


&nbsp;      
## Topic
### Initializing a Storyboard Segue
> 스토리보드 Segue 초기화

* `init(identifier: String?, source: UIViewController, destination: UIViewController)`
    * segue 수행에 사용하기 위해 스토리보드 segue 객체를 초기화하고 반환한다.


### Accessing the Segue Attributes
> Segue 속성에 접근

* `var source: UIViewController`
    * segue의 출발지 뷰 컨트롤러이다.
* `var destination: UIViewController`
    * segue의 목적지 뷰 컨트롤러이다.
* `var identifier: String?`
    * segue 객체의 식별자.


### Performing the Segue
> Segue 수행

* `func perform()`
    * segue에 대한 시각적 전환을 수행한다.


### Creating a Custom Segue
> 커스텀 Segue 생성

* `init(identifier: String?, source: UIViewController, destination: UIViewController, performHandler: () -> Void)`
    * segue 전환을 수행하기 위해 블록을 호출하는 segue를 생성한다.


&nbsp; 
## Relationships
### Inherits From
* NSObject


### Conforms To
* CVarArg, Equatable, Hashable


&nbsp; 
## See Also
### Storyboards
* class UIStoryboard
* class UIToryboardUnwindSegueSource


&nbsp;      
&nbsp;      
### [by. 0junChoi](https://github.com/0jun0815) email: <0jun0815@gmail.com>
### [Apple Developer Documentation UIStoryboardSegue](https://developer.apple.com/documentation/uikit/uistoryboardsegue)
