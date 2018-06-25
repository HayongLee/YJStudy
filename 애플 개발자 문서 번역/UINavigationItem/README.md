# UINavigationItem
>  연결된 뷰 컨트롤러가 표시 될 때 내비게이션 바에서 표시할 아이템이다.

* [Overview](#overview)
* [Topics](#topics)
    * [Initializing an Item](#initializing-an-item)
    * [Configuring the Title](#configuring-the-title)
    * [Getting and Setting Properties](#getting-and-setting-properties)
    * [Customizing Views](#customizing-views)
    * [Integrating Search Into Your Interface](#integrating-search-into-your-interface)
* [Relationships](#relationships)
* [See Also](#see-also)


&nbsp;      
## Overview
내비게이션 인터페이스를 작성할 때 내비게이션 스택에 푸시된 각 뷰 컨트롤러에는 내비게이션 바에 표시하려는 버튼과 뷰가 포함된 UINavigationItem 객체가 있어야 한다. [UINavigationController](https://developer.apple.com/documentation/uikit/uinavigationcontroller) 객체는 가장 위에 있는 두 개의 뷰 컨트롤러의 내비게이션 아이템을 사용하여 내비게이션 바를 콘텐츠로 채운다.


내비게이션 아이템은 항상 연결된 뷰 컨트롤러에 대한 정보를 반영한다. 내비게이션 아이템은 뷰 컨트롤러가 내비게이션 스택의 최상위에 있을 때 표시할 제목을 제공해야 한다. 또한 아이템에 내비게이션 바의 오른쪽(또는 트레일링)에 표시할 추가 버튼이 포함될 수 있다. [leftBarButtonItems](https://developer.apple.com/documentation/uikit/uinavigationitem/1624946-leftbarbuttonitems) 프로퍼티를 사용하여 툴바의 왼쪽(또는 리딩)에 표시 할 버튼과 뷰를 지정할 수 있지만 사용 가능한 공간이 있을 때만 내비게이션 컨트롤러가 해당 버튼을 표시한다. 


내비게이션 아이템의 [backBarButtonItem](https://developer.apple.com/documentation/uikit/uinavigationitem/1624958-backbarbuttonitem) 프로퍼티는 현재 뷰 컨트롤러가 맨 위의 뷰 컨트롤러 바로 아래에 있을 때 표시 할 뒤로 가기(back)버튼을 나타낸다. 즉 현재 뷰 컨트롤러가 맨 위에 있을 때는 뒤로 가기 버튼이 사용되지 않는다.


내비게이션 아이템에 대한 버튼을 지정할 때 [UIBarButtonItem](https://developer.apple.com/documentation/uikit/uibarbuttonitem) 객체를 사용해야 한다. 내비게이션 바에 커스텀 뷰를 표시하려면 해당 뷰를 내비게이션 아이템에 추가하기 전에 [UIBarButtonItem](https://developer.apple.com/documentation/uikit/uibarbuttonitem) 객체 내에 래핑해야 한다.


&nbsp;      
## Topics
### Initializing an Item
> 아이템 초기화

* `init(title: String)`
    * 지정된 제목으로 초기화 된 내비게이션 아이템을 반환한다.
* `init?(coder: NSCoder)`


### Configuring the Title
> 제목 구성

* `var title: String?`
    * 내비게이션 바에 표시되는 내비게이션 아이템의 제목이다.
* `var largeTitleDisplayMode: UINavigationItem.LargeTitleDisplayMode`
    * 내비게이션 바의 제목을 표시할 때 사용할 모드이다.
* `enum UINavigationItem.LargeTitleDisplayMode`
    * 이 아이템의 타이틀 사이즈를 나타내는 상수이다.
    

### Getting and Setting Properties
> 프로퍼티 가져 오기 및 설정

* `var prompt: String?`
    * 내비게이션 바 맨 위에 한줄의 텍스트가 표시된다.
* `var backBarButtonItem: UIBarButtonItem?`
    * 내비게이션 바에서 뒤로 가기 버튼이 필요할 때 사용할 바 버튼 아이템.
* `var hidesBackButton: Bool`
    * 뒤로 가기 버튼을 숨길지 여부를 결정하는 부울 값.
* `func setHidesBackButton(Bool, animated: Bool)`
    * 뒤로 가기 버튼을 숨길지 여부를 설정하고, 선택적으로 전환 효과에 애니메이션을 적용한다.
* `var leftItemsSupplementBackButton: Bool`
    * 뒤로 가기 버튼 외에도 왼쪽 아이템들을 표시할지 여부를 나타내는 부울 값.


### Customizing Views
> 커스텀 뷰

* `var titleView: UIView?`
    * 리시버가 최상위 아이템일 때 내비게이션 바의 가운데에 표시되는 커스텀 뷰.
* `var leftBarButtonItems: [UIBarButtonItem]?`
    * 리시버가 최상위 내비게이션 아이템일 때 내비게이션 바의 왼쪽(또는 리딩)에 표시 할 커스텀 바 버튼 아이템의 배열. 
* `var leftBarButtonItem: UIBarButtonItem?`
    * 리시버가 최상위 내비게이션 아이템일 때 내비게이션 바의 왼쪽(또는 리딩) 가장자리에 표시되는 커스텀 바 버튼 아이템.
* `var rightBarButtonItems: [UIBarButtonItem]?`
    * 리시버가 최상위 내비게이션 아이템일 때 내비게이션 바의 오른쪽(또는 트레일링)에 표시 할 커스텀 바 버튼 아이템의 배열. 
* `var rightBarButtonItem: UIBarButtonItem?`
    * 리시버가 최상위 내비게이션 아이템일 때 내비게이션 바의 오른쪽(또는 트레일링) 가장자리에 표시되는 커스텀 바 버튼 아이템.
* `func setLeftBarButtonItems([UIBarButtonItem]?, animated: Bool)`
    * 왼쪽 바 버튼 아이템들을 설정하고 선택적으로 새 아이템으로 전환할 때 애니메이션을 적용한다.
* `func setLeftBarButton(UIBarButtonItem?, animated: Bool)`
    * 커스텀 바 버튼 아이템을 설정하고 선택적으로 새 아이템으로 전환할 때 애니메이션을 적용한다.
* `func setRightBarButtonItems([UIBarButtonItem]?, animated: Bool)`
    * 오른쪽 바 버튼 아이템들을 설정하고 선택적으로 새 아이템으로 전환할 때 애니메이션을 적용한다.
* `func setRightBarButton(UIBarButtonItem?, animated: Bool)`
    * 커스텀 바 버튼 아이템을 설정하고 선택적으로 뷰로 전환할 때 애니메이션을 적용한다.

### Integrating Search Into Your Interface
> 인터페이스 통합 검색

* `var searchController: UISearchController?`
    * 검색 컨트롤러가 내비게이션 인터페이스에 통합된다.
* `var hidesSearchBarWhenScrolling: Bool`
    * 기본 콘텐츠를 스크롤 할 때 통합 검색 바를 숨길 지 여부를 나타내는 부울 값.
    

&nbsp;      
## Relationships
### Inherits From
* NSObject


### Conforms To
* CVarArg
* Equatable
* Hashable
* NSCoding


&nbsp;      
## See Also
### Navigation Interface
* class UINavigationController
* class UINavigationBar


&nbsp;      
&nbsp;      
### [by. 0junChoi](https://github.com/0jun0815) email: <0jun0815@gmail.com>
### [Apple Developer Documentation UINavigationItem](https://developer.apple.com/documentation/uikit/uinavigationitem)
