# UIBarButtonItem
>  툴바 또는 탭 바에 배치 할 수 있는 버튼이다.


* [Overview](#overview)
* [Customizing Appearance](#customizing-appearance)
* [Topics](#topics)
    * [Initializing an Item](#initializing-an-item)
    * [Getting and Setting Properties](#getting-and-setting-properties)
    * [Customizing Appearance](#customizing-appearance-1)
    * [Getting the Shortcuts Group Information](#getting-the-shortcuts-group-information)
    * [Constants](#constants)
* [Relationships](#relationships)
* [See Also](#see-also)


&nbsp;      
## Overview
일반적으로 인터페이스 빌더를 사용하여 바 버튼 아이템을 만들고 구성한다.


&nbsp;
## Customizing Appearance
[Customizing Appearance](https://developer.apple.com/documentation/uikit/uibarbuttonitem#1656861)에 나열된 메서드를 사용하여 버튼의 모양(Appearance)을 커스텀화한다. setter 메시지를 appearance(모양) 프록시 ([UIBarButtonItem appearance])로 보내 모든 버튼을 커스텀화 하거나 특정 UIBarButtonItem 인스턴스로 커스텀화한다. [UINavigationItem](https://developer.apple.com/documentation/uikit/uinavigationitem) 객체(backBarButtonItem, leftBarButtonItem, rightBarButtonItem) 또는 [UIToolbar](https://developer.apple.com/documentation/uikit/uitoolbar) 인스턴스의 표준 위치에서 커스텀화 된 버튼을 사용할 수 있다.


일반적으로 커스텀 값이 설정되지 않은 다른 상태에서 일반 상태 값을 사용하도록 지정해야 한다. 마찬가지로 프로퍼티의 바 메트릭(iPhone에서 가로 방향 바의 높이가 표준과 다른 경우)에 따라 달라지는 경우 [UIBarMetrics.default](https://developer.apple.com/documentation/uikit/uibarmetrics/default) 값을 지정해야 한다.


모양 및 동작 구성에 대한 자세한 내용은 [Toolbars](https://developer.apple.com/library/archive/documentation/UserExperience/Conceptual/UIKitUICatalog/UIToolbar.html#//apple_ref/doc/uid/TP40012857-UIToolbar) 참조.


&nbsp;      
## Topics
### Initializing an Item
> 아이템 초기화

* `init(barButtonSystemItem: UIBarButtonItem.SystemItem, target: Any?, action: Selector?)`
    * 지정된 시스템 아이템을 포함하는 새 아이템을 초기화한다.
* `init(customView: UIView)`
    * 지정된 커스텀 뷰를 사용하여 새 아이템을 초기화한다.
* `init(image: UIImage?, style: UIBarButtonItem.Style, target: Any?, action: Selector?)`
    * 지정된 이미지 및 기타 프로퍼티를 사용하여 새 아이템을 초기화한다.
* `init(title: String?, style: UIBarButtonItem.Style, target: Any?, action: Selector?)`
    * 지정된 제목 및 기타 프로퍼티를 사용하여 새 아이템을 초기화한다.
* `init(image: UIImage?, landscapeImagePhone: UIImage?, style: UIBarButtonItem.Style, target: Any?, action: Selector?)`
    * 지정된 이미지 및 기타 프로퍼티를 사용하여 새 아이템을 초기화한다.
* `init()`
    * 바 버튼 아이템을 기본 상태로 초기화한다.
* `init?(coder: NSCoder)`


### Getting and Setting Properties
> 프로퍼티 가져 오기 및 설정
* `var target: AnyObject?`
    * 아이템이 선택 될 때 액션을 받는 객체이다.
* `var action: Selector?`
    * 사용자가 이 바 버튼 아이템을 누를 때 타겟 객체에 보낼 액션 메시지를 정의하는 셀렉터이다.
* `var style: UIBarButtonItem.Style`
    * 아이템의 스타일.
* `var possibleTitles: Set<String>?`
    * 바 버튼에 표시할 수 있는 제목의 집합.
* `var width: CGFloat`
    * 아이템의 너비.
* `var customView: UIView?`
    * 아이템을 나타내는 커스텀 뷰.
    

### Customizing Appearance
> 모양 커스터마이징

* `var tintColor: UIColor?`
    * 버튼 아이템에 적용 할 틴트 컬러.
* `func backButtonBackgroundImage(for: UIControl.State, barMetrics: UIBarMetrics) -> UIImage?`
    * 지정된 컨트롤 상태 및 바 메트릭에 대한 뒤로 가기 버튼 백그라운드 이미지를 반환한다.
* `func setBackButtonBackgroundImage(UIImage?, for: UIControl.State, barMetrics: UIBarMetrics)`
    * 지정된 컨트롤 상태 및 바 메트릭에 대한 뒤로 가기 버튼 백그라운드 이미지를 설정한다.
* `func backButtonTitlePositionAdjustment(for: UIBarMetrics) -> UIOffset`
    * 지정된 바의 메트릭에 대한 뒤로 가기 버튼 제목 오프셋을 반환한다. 
* `func setBackButtonTitlePositionAdjustment(UIOffset, for: UIBarMetrics)`
    * 지정된 바의 메트릭에 대한 뒤로 가기 버튼 제목 오프셋을 설정한다.
* `func backButtonBackgroundVerticalPositionAdjustment(for: UIBarMetrics) -> CGFloat`
    * 지정된 바의 메트릭에 대한 뒤로 가기 버튼의 수직 위치 오프셋을 반환한다.
* `func setBackButtonBackgroundVerticalPositionAdjustment(CGFloat, for: UIBarMetrics)`
    * 지정된 바의 메트릭에 대한 뒤로 가기 버튼의 수직 위치 오프셋을 설정한다.
* `func backgroundVerticalPositionAdjustment(for: UIBarMetrics) -> CGFloat`
    * 지정된 바의 메트릭의 백그라운드 수직 위치 오프셋을 반환한다.
* `func setBackgroundVerticalPositionAdjustment(CGFloat, for: UIBarMetrics)`
    * 지정된 바의 메트릭의 백그라운드 수직 위치 오프셋을 설정한다.
* `func backgroundImage(for: UIControl.State, barMetrics: UIBarMetrics) -> UIImage?`
    * 지정된 상태 및 바 메트릭에 대한 백그라운드 이미지를 반환한다.
* `func setBackgroundImage(UIImage?, for: UIControl.State, barMetrics: UIBarMetrics)`
    * 지정된 상태 및 바 메트릭에 대한 백그라운드 이미지를 설정한다.
* `func backgroundImage(for: UIControl.State, style: UIBarButtonItem.Style, barMetrics: UIBarMetrics) -> UIImage?`
    * 지정된 상태, 스타일 및 메트릭에 대한 백그라운드 이미지를 반환한다.
* `func setBackgroundImage(UIImage?, for: UIControl.State, style: UIBarButtonItem.Style, barMetrics: UIBarMetrics)`
    * 지정된 상태, 스타일 및 메트릭에 대한 백그라운드 이미지를 설정한다.
* `func titlePositionAdjustment(for: UIBarMetrics) -> UIOffset`
    * 지정된 바의 메트릭의 타이틀 오프셋을 반환한다.
* `func setTitlePositionAdjustment(UIOffset, for: UIBarMetrics)`
    * 지정된 바의 메트릭의 타이틀 오프셋을 설정한다.


### Getting the Shortcuts Group Information
> 바로 가기 그룹 정보 얻기

* `var buttonGroup: UIBarButtonItemGroup?`
    * 버튼이 속한 바로 가기 바의 그룹이다.
    

### Constants
* `enum UIBarButtonItem.SystemItem`
    * 바 버튼 아이템에 대한 시스템 제공 이미지를 정의한다.
* `enum UIBarButtonItem.Style`
    * 아이템의 스타일을 지정한다.
    

&nbsp;      
## Relationships
### Inherits From
* UIBarItem


### Conforms To
* CVarArg
* Equatable
* Hashable
* NSCoding
* UIAccessibilityIdentification
* UISpringLoadedInteractionSupporting


&nbsp;      
## See Also
### Bars
* class UIBarItem
* class UIBarButtonItemGroup
* class UINavigationBar
* class UISearchBar
* class UIToolbar
* class UITabBar
* class UITabBarItem
* protocol UIBarPositioning
* protocol UIBarPositioningDelegate


&nbsp;      
&nbsp;      
### [by. 0junChoi](https://github.com/0jun0815) email: <0jun0815@gmail.com>
### [Apple Developer Documentation UIBarButtonItem](https://developer.apple.com/documentation/uikit/uibarbuttonitem)
