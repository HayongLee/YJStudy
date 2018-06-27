# UIActivityItemProvider
> 액티비티 뷰 컨트롤러에 전달 된 데이터를 위한 프록시.


* [Overview](#overview)
* [Subclassing Notes](#subclassing-notes)
* [Topics](#topics)
    * [Initializing the Provider](#initializing-the-provider)
    * [Accessing the Provider Attributes](#accessing-the-provider-attributes)
* [Relationships](#relationships)
* [See Also](#see-also)


&nbsp;    
## Overview
액티비티가 데이터를 사용할 수 있게 만들고 싶지만 실제로 필요할 때까지 데이터를 제공하는 것을 지연하려는 경우 프로바이더 객체를 사용할 수 있다. 예를 들어 프로바이더 객체를 사용하여 큰 비디오 파일을 사용자의 소셜 미디어 계정에 공유되기 전에 처리해야 하는 경우가 있다.


[UIActivityViewController](https://developer.apple.com/documentation/uikit/uiactivityviewcontroller) 객체를 초기화 할 때 다른 데이터 객체와 함께 프로바이더 객체를 전달할 수 있다. 사용자가 액티비티를 선택하면 액티비티 뷰 컨트롤러는 필요한 데이터를 수집하거나 처리 할 수 있도록 프로바이더 객체(연산 객체이기도 함)를 연산 큐에 추가한다.


&nbsp;
## Subclassing Notes
UIActivityItemProvider를 서브 클래스화 하고 아이템 데이터를 생성하기 위해 호출되는 [item](https://developer.apple.com/documentation/uikit/uiactivityitemprovider/1620457-item) 메서드를 구현해야 한다. 이 메서드는 연산 객체에 대해 구현할 일반 main() 메서드 대신에 구현한다. (main() 메서드는 연산 객체가 실행될 때 item 메서드를 호출한다.) item 메서드를 구현하면 데이터를 만들고 반환하는 데 필요한 모든 작업을 수행해야 한다.


&nbsp;      
## Topics
### Initializing the Provider
> 프로바이더 초기화

* `init(placeholderItem: Any)`
    * 지정된 플레이스 홀더 데이터를 사용하여 프로바이더 객체를 초기화하고 반환한다.
    

### Accessing the Provider Attributes
> 프로바이더 속성 접근

* `var item: Any`
    * 실제 데이터가 포함 된 객체를 생성하고 반환한다.
* `var placeholderItem: Any?`
    * 초기화 할 때 지정한 플레이스 홀더 객체이다.
* `var activityType: UIActivity.ActivityType?`
에

&nbsp;      
## Relationships
### Inherits From
* Operation


### Conforms To
* CVarArg
* Equatable
* Hashable
* UIActivityItemSource


&nbsp;
## See Also
### Activities Interface
* class UIActivityViewController
* protocol UIActivityItemSource
* class UIActivity


&nbsp;      
&nbsp;      
### [by. 0junChoi](https://github.com/0jun0815) email: <0jun0815@gmail.com>
### [Apple Developer Documentation UIActivityItemProvider](https://developer.apple.com/documentation/uikit/uiactivityitemprovider)
