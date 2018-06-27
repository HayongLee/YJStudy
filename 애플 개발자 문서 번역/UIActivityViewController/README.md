# UIActivityViewController
> 앱에 표준 서비스를 제공하는데 사용하는 뷰 컨트롤러이다.


* [Overview](#overview)
* [Topics](#topics)
    * [Initializing the Activity View Controller](#initializing-the-activity-view-controller)
    * [Accessing the Completion Handler](#accessing-the-completion-handler)
    * [Excluding Specific Activity Types](#excluding-specific-activity-types)
    * [Constants](#constants)
* [Relationships](#relationships)
* [See Also](#see-also)


&nbsp;    
## Overview
이 시스템은 아이템을 페이스트보드에 복사하거나, 소셜 미디어 사이트에 콘텐츠를 게시하거나 또는 이메일이나 SMS를 통해 아이템을 보내는 것과 같은 몇 가지 표준 서비스를 제공한다. 앱은 커스텀 서비스를 정의할 수도 있다.


이 뷰 컨트롤러를 구성, 표시 및 해제하는 것은 앱의 책임이다. 뷰 컨트롤러를 구성하려면 뷰 컨트롤러가 작동해야 하는 데이터 객체를 지정한다(앱이 지원하는 커스텀 서비스 리스트를 지정할 수도 있다). 뷰 컨트롤러를 표시 할 때 현재 장치에 따라 적절한 방법을 사용해야 한다. iPad에서는 팝오버로, iPhone에서는 모달로 뷰 컨트롤러를 표시해야 한다.


&nbsp;      
## Topics
### Initializing the Activity View Controller
> 액티비티 뷰 컨트롤러 초기화

* `init(activityItems: [Any], applicationActivities: [UIActivity]?)`
    * 지정된 데이터에 대해 작동하는 새 액티비티 뷰 컨트롤러 객체를 초기화하고 반환한다.


### Accessing the Completion Handler
> 완료 핸들러 접근

* `var completionWithItemsHandler: UIActivityViewController.CompletionWithItemsHandler?`
    * 액티비티 뷰 컨트롤러를 닫은 후에 실행할 완료 핸들러이다.


### Excluding Specific Activity Types
> 지정된 액티비티 타입 제외

* `var excludedActivityTypes: [UIActivity.ActivityType]?`
    * 표시해서는 안되는 서비스 목록이다.
    

### Constants
* `typealias UIActivityViewController.CompletionWithItemsHandler`
    * 액티비티 뷰 컨트롤러를 닫은 후에 실행할 완료 핸들러이다.
* `typealias UIActivityViewController.CompletionHandler`
    * 액티비티 뷰 컨트롤러를 닫은 후에 실행할 완료 핸들러이다.


&nbsp;      
## Relationships
### Inherits From
* UIViewController


### Conforms To
* CVarArg
* Equatable
* Hashable
* NSExtensionRequestHandling
* UIPasteConfigurationSupporting
* UIStateRestoring
* UIUserActivityRestoring


&nbsp;
## See Also
### Activities Interface
* class UIActivityItemProvider
* protocol UIActivityItemSource
* class UIActivity


&nbsp;      
&nbsp;      
### [by. 0junChoi](https://github.com/0jun0815) email: <0jun0815@gmail.com>
### [Apple Developer Documentation UIActivityViewController](https://developer.apple.com/documentation/uikit/uiactivityviewcontroller)
