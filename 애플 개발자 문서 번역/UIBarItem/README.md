# UIBarItem
>  화면 아래에 나타나는 바에 추가 할 수 있는 아이템에 대한 추상 수퍼 클래스이다.


* [Overview](#overview)
* [Customizing Appearance](#customizing-appearance)
* [Topics](#topics)
    * [Initializing a Bar Item](#initializing-a-bar-item)
    * [Getting and Setting Properties](#getting-and-setting-properties)
    * [Customizing Appearance](#customizing-appearance-1)
* [Relationships](#relationships)
* [See Also](#see-also)


&nbsp;      
## Overview
바의 아이템은 버튼([UIButton](https://developer.apple.com/documentation/uikit/uibutton) 인스턴스)과 비슷한 방식으로 작동한다. 제목, 이미지, 액션 및 타겟이 있다. 바의 아이템을 활성화 및 비활성화 할 수도 있다.


&nbsp;
## Customizing Appearance
[image](https://developer.apple.com/documentation/uikit/uibaritem/1616415-image) 및 [imageInsets](https://developer.apple.com/documentation/uikit/uibaritem/1616413-imageinsets)을 각각 사용하여 아이템 및 이미지의 위치를 나타내는 이미지를 커스텀화 할 수 있다.


iOS v5.0 이상에서는 각각 [landscapeImagePhone](https://developer.apple.com/documentation/uikit/uibaritem/1616421-landscapeimagephone) 및 [landscapeImagePhoneInsets](https://developer.apple.com/documentation/uikit/uibaritem/1616420-landscapeimagephoneinsets)을 사용하여 iPhone 모양(appearance) 표현법(idiom)을 사용할 때 가로 방향으로 사용할 커스텀 이미지와 위치를 지정할 수도 있다. 또한 단일 아이템에 대해서는 [setTitleTextAttributes(_:for:)](https://developer.apple.com/documentation/uikit/uibaritem/1616414-settitletextattributes)를 사용하거나 모양(appearance) 프록시([UIBarItem apperance])를 사용하여 모든 아이템에 대해 제목의 텍스트 속성을 커스텀화 할 수 있다.


&nbsp;      
## Topics
### Initializing a Bar Item
> 바 아이템 초기화

* `init()`
    * 바 아이템을 기본 상태로 초기화한다.
* `init?(coder: NSCoder)`


### Getting and Setting Properties
> 프로퍼티 가져 오기 및 설정

* `var title: String?`
    * 아이템에 표시된 제목.
* `var image: UIImage?`
    * 아이템을 나타내는 데 사용되는 이미지.
* `var landscapeImagePhone: UIImage?`
    * iPhone 모양(appearance) 표현법(idiom)을 사용할 때 가로 방향으로 아이템을 나타내는 데 사용할 이미지.
* `var largeContentSizeImage: UIImage?`
    * 시각 장애가 있는 사용자에게 표시할 이미지.
* `var imageInsets: UIEdgeInsets`
    * 각 가장자리 이미지 인셋 또는 아웃셋.
* `var landscapeImagePhoneInsets: UIEdgeInsets`
    * iPhone 모양(appearance) 표현법(idiom)을 사용할 때 가로 방향 이미지의 각 가장자리 이미지 인셋 또는 아웃셋.
* `var largeContentSizeImageInsets: UIEdgeInsets`
    * 보조 UI에서 이미지를 표시 할 때 바 아이템의 큰 이미지에 적용할 인셋.
* `var isEnabled: Bool`
    * 아이템이 활성화되었는지 여부를 나타내는 부울 값.
* `var tag: Int`
    * 애플리케이션에서 바 아이템 객체를 식별하는 데 사용할 수 있는 애플리케이션 제공 정수인 리시버 태그.


### Customizing Appearance
> 모양 커스터마이징

* `func setTitleTextAttributes([NSAttributedString.Key : Any]?, for: UIControl.State)`
    * 지정된 컨트롤 상태에 대한 제목의 텍스트 속성을 설정한다.
* `func titleTextAttributes(for: UIControl.State) -> [NSAttributedString.Key : Any]?`
    * 지정된 컨트롤 상태에 대한 제목의 텍스트 속성을 반환한다.
    

&nbsp;      
## Relationships
### Inherits From
* NSObject


### Conforms To
* CVarArg
* Equatable
* Hashable
* NSCoding
* UIAccessibilityIdentification
* UIAppearance


&nbsp;      
## See Also
### Bars
* class UIBarButtonItem
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
### [Apple Developer Documentation UIBarItem](https://developer.apple.com/documentation/uikit/uibaritem)
