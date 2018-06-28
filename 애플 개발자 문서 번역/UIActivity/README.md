# UIActivity
> 앱 특정 서비스를 구현하기 위해 서브 클래스를 만드는 추상 클래스이다.


* [Overview](#overview)
* [Subclassing Notes](#subclassing-notes)
    * [Methods to Override](#methods-to-override)
* [Topics](#topics)
    * [Getting the Activity Information](#getting-the-activity-information)
    * [Performing the Activity](#performing-the-activity)
* [Relationships](#relationships)
* [See Also](#see-also)


&nbsp;    
## Overview
사용자에게 커스텀 서비스를 제공하려는 경우에만 UIActivity를 서브 클래스화해야 한다. 서비스는 전달 된 데이터를 취하여 해당 데이터를 처리하고 결과를 반환한다. 예를 들어 소셜 미디어 서비스는 텍스트, 이미지 또는 기타 콘텐츠가 제공되는대로 가져와서 사용자 계정에 게시 할 수 있다. 액티비티 객체는 사용자에게 서비스를 제공하는 [UIActivityViewController](https://developer.apple.com/documentation/uikit/uiactivityviewcontroller) 객체와 함께 사용된다.


이 시스템은 이미 많은 표준 서비스에 대한 지원을 제공하고 [UIActivityViewController](https://developer.apple.com/documentation/uikit/uiactivityviewcontroller) 객체를 통해 사용할 수 있도록한다. 예를 들어, 표준 액티비티 뷰 컨트롤러는 데이터 이메일 전송, 사용자의 소셜 미디어 계정 중 하나에 아이템 게시 및 기타 여러 옵션을 지원한다. 기본 제공 타입에 대해 커스텀 서비스를 제공할 필요는 없다.


&nbsp;      
## Subclassing Notes
이 클래스는 서브 클래싱되어 사용해야 사용할 수 있다. 액티비티 객체의 작업은 iOS가 제공할 수 있는 메타 정보를 사용자에게 제공하는 것이다. 좀 더 복잡한 서비스의 경우, 액티비티 객체는 커스텀 사용자 인터페이스를 표시하고 이를 사용하여 사용자로부터 추가 정보를 수집 할 수 있다.


&nbsp;      
### Methods to Override
서브 클래스화를 수행할 때는 항상 다음 메서드를 재정의하여 서비스에 대한 정보를 제공해야 한다:
* [activityType](https://developer.apple.com/documentation/uikit/uiactivity/1620671-activitytype)
* [activityTitle](https://developer.apple.com/documentation/uikit/uiactivity/1620674-activitytitle)
* [activityImage](https://developer.apple.com/documentation/uikit/uiactivity/1620658-activityimage)
* [canPerform(withActivityItems:)](https://developer.apple.com/documentation/uikit/uiactivity/1620677-canperform)
* [prepare(withActivityItems:)](https://developer.apple.com/documentation/uikit/uiactivity/1620668-prepare)
* [activityCategory](https://developer.apple.com/documentation/uikit/uiactivity/1620656-activitycategory)


canPerform(withActivityItems:) 메서드가 서브 클래스가 지정된 데이터에서 작동할 수 있다고 나타내면 활성화된 [UIActivityViewController](https://developer.apple.com/documentation/uikit/uiactivityviewcontroller) 객체는 사용자에게 서비스를 표시한다. 사용자가 서비스를 선택하면 액티비티 뷰 컨트롤러가 [prepare(withActivityItems:)](https://developer.apple.com/documentation/uikit/uiactivity/1620668-prepare) 메서드 다음에 아래 메서드 중 하나만을 호출한다:
* [activityViewController](https://developer.apple.com/documentation/uikit/uiactivity/1620678-activityviewcontroller) - 사용자에게 표시할 뷰 컨트롤러를 반환한다. 서비스에서 사용자의 추가 입력이 필요한 경우 이 메서드를 재정의하고 이 메서드를 사용하여 커스텀 UI를 표시하는 뷰 컨트롤러 객체를 반환한다. 뷰 컨트롤러 객체는 필요한 입력을 수집 한 후 서비스와 관련된 작업을 시작하는 역할을 담당한다.
* [perform()](https://developer.apple.com/documentation/uikit/uiactivity/1620659-perform) - 추가 UI를 표시하지 않고 서비스를 수행한다. 서비스가 사용자로부터 추가 입력이 필요하지 않은 경우, 이 메서드를 재정의하고 서비스와 연관된 작업을 수행한다.


&nbsp;      
## Topics
### Getting the Activity Information
> 액티비티 정보 얻기

* `class var activityCategory: UIActivity.Category`
    * UI의 액티비티를 그룹화하는 데 사용할 수 있는 액티비티 카테고리를 반환한다.
* `enum UIActivity.Category`
    * 액티비티에는 정의 된 카테고리가 있으며 액티비티 UI에는 카테고리별로 그룹화 된 액티비티가 표시 될 수 있다.
* `var activityType: UIActivity.ActivityType?`
    * 제공된 서비스 타입에 대한 식별자.
* `struct UIActivity.ActivityType`
    * 시스템에 내장 된 액티비티 타입.
* `var activityTitle: String?`
    * 서비스를 설명하는 사용자가 읽을 수 있는 문자열.
* `var activityImage: UIImage?`
    * 사용자에게 서비스를 식별하는 이미지.


### Performing the Activity
> 액티비티 수행

* `func canPerform(withActivityItems: [Any]) -> Bool`
    * 서비스가 지정된 데이터 아이템에서 작동 할 수 있는지 여부를 나타내는 부울 값을 반환한다.
* `func prepare(withActivityItems: [Any])`
    * 지정된 데이터에 대한 서비스를 준비한다.
* `var activityViewController: UIViewController?`
    * 사용자에게 표시 할 뷰 컨트롤러를 반환한다.
* `func perform()`
    * 커스텀 뷰 컨트롤러가 제공되지 않을 때 서비스를 수행한다.
* `func activityDidFinish(Bool)`
    * 액티비티 객체가 작업을 완료했음을 시스템에 알린다.
    

&nbsp;      
## Relationships
### Inherits From
* NSObject


### Conforms To
* CVarArg, Equatable, Hashable


&nbsp;
## See Also
### Activities Interface
* class UIActivityViewController
* class UIActivityItemProvider
* protocol UIActivityItemSource


&nbsp;      
&nbsp;      
### [by. 0junChoi](https://github.com/0jun0815) email: <0jun0815@gmail.com>
### [Apple Developer Documentation UIActivity](https://developer.apple.com/documentation/uikit/uiactivity)
