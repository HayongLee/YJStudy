# UIActivityItemSource
> 액티비티 뷰 컨트롤러가 작동할 데이터 아이템을 검색하는 데 사용하는 메서드 세트.


* [Overview](#overview)
* [Topics](#topics)
    * [Getting the Data Items](#getting-the-data-items)
    * [Providing Information About the Data Items](#providing-information-about-the-data-items)
* [Relationships](#relationships)
* [See Also](#see-also)


&nbsp;    
## Overview
별도의 [UIActivityItemProvider](https://developer.apple.com/documentation/uikit/uiactivityitemprovider) 객체를 만드는 대신 앱의 기존 객체 중 하나에서 데이터를 제공하려는 경우 이 프로토콜을 사용할 수 있다. 이 프로토콜을 구현할 때 객체가 데이터 프로바이더(공급자)가 되어 뷰 컨트롤러에 아이템에 대한 접근 권한을 제공한다.


이 프로토콜의 메서드는 앱의 메인 스레드에서 실행되기 때문에 데이터 객체를 생성하는 데 상당한 시간이 걸릴 수 있는 경우 이 프로토콜을 사용하지 않아야한다. 대형 데이터 객체를 만들 때는 대신 UIActivityItemProvider 객체를 사용하는 것이 좋다.


&nbsp;      
## Topics
### Getting the Data Items
> 데이터 아이템 얻기

* `func activityViewControllerPlaceholderItem(UIActivityViewController) -> Any`
    * 데이터의 플레이스홀더 객체를 반환한다. **필수**
* `func activityViewController(UIActivityViewController, itemForActivityType: UIActivity.ActivityType?) -> Any?`
    * 처리할 데이터 객체를 반환한다. **필수**
    

### Providing Information About the Data Items
> 데이터 아이템에 대한 정보 제공

* `func activityViewController(UIActivityViewController, subjectForActivityType: UIActivity.ActivityType?) -> String`
    * 제목 필드를 지원하는 액티비티의 경우 아이템의 제목을 반환한다.
* `func activityViewController(UIActivityViewController, dataTypeIdentifierForActivityType: UIActivity.ActivityType?) -> String`
    * NSData로 제공되는 아이템의 경우 아이템에 대한 UTI를 반환한다.
* `func activityViewController(UIActivityViewController, thumbnailImageForActivityType: UIActivity.ActivityType?, suggestedSize: CGSize) -> UIImage?`
    * 미리보기 이미지를 지원하는 액티비티의 경우 아이템에 대한 썸네일 미리보기 이미지를 반환한다. 


&nbsp;      
## Relationships
### Inherits From
* NSObjectProtocol


&nbsp;
## See Also
### Activities Interface
* class UIActivityViewController
* class UIActivityItemProvider
* class UIActivity


&nbsp;      
&nbsp;      
### [by. 0junChoi](https://github.com/0jun0815) email: <0jun0815@gmail.com>
### [Apple Developer Documentation UIActivityItemSource](https://developer.apple.com/documentation/uikit/uiactivityitemsource)
