# UICollectionViewFlowLayout
> 각 섹션에 대한 선택적인 헤더 및 푸터 뷰를 사용하여 아이템을 그리드로 구성하는 구체적인 레이아웃 객체이다.


* [Overview](#overview)
* [Topics](#topics)
    * [Configuring the Flow Layout](#configuring-the-flow-layout)
    * [Configuring the Scroll Direction](#configuring-the-scroll-direction)
    * [Configuring the Item Spacing](#configuring-the-item-spacing)
    * [Configuring the Supplementary Views](#configuring-the-supplementary-views)
    * [Constants](#constants)
* [Relationships](#relationships)
* [See Also](#see-also)


&nbsp;    
## Overview
컬렉션 뷰의 아이템은 한 행 또는 열(스크롤 방향에 따라 다름)에서 다음 행으로 흐르고 각 행은 맞는 만큼의 셀을 포함한다. 셀은 동일한 크기 또는 다른 크기 일 수 있다. 


플로우 레이아웃은 컬렉션 뷰의 델리게이트 객체와 함께 작동하여 각 섹션과 그리드의 아이템, 헤더 및 푸터 크기를 결정한다. 이 델리게이트 객체는 [UICollectionViewDelegateFlowLayout](https://developer.apple.com/documentation/uikit/uicollectionviewdelegateflowlayout) 프로토콜을 준수해야 한다. 델리게이트를 사용하면 레이아웃 정보를 동적으로 조정할 수 있다. 예를 들어, 그리드의 아이템에 다른 크기를 지정하려면 델리게이트 객체를 사용해야 한다. 델리게이트를 제공하지 않으면 플로우 레이아웃은 이 클래스의 프로퍼티를 사용하여 설정한 기본값을 사용한다.


플로우 레이아웃은 한 방향으로 고정 된 거리를 사용하고 다른 방향으로 이동 가능한 거리를 사용하여 콘텐츠를 배치한다. 예를 들어 세로로 스크롤하는 그리드에서 그리드 콘텐츠의 너비는 해당 컬렉션 뷰의 너비로 제한되지만 콘텐츠 높이는 그리드의 섹션 및 아이템 수와 동적으로 조정된다. 레이아웃은 기본적으로 세로로 스크롤되도록 구성되어 있지만 [scrollDirection](https://developer.apple.com/documentation/uikit/uicollectionviewflowlayout/1617720-scrolldirection) 프로퍼티를 사용하여 스크롤 방향을 구성할 수 있다.


플로우 레이아웃의 각 섹션에는 커스텀 헤더와 푸터가 있을 수 있다. 뷰의 헤더나 푸터를 구성하려면 헤더나 푸터의 크기를 0이 아니도록 구성해야 한다. 적절한 델리게이트 메서드를 구현하거나 [headerReferenceSize](https://developer.apple.com/documentation/uikit/uicollectionviewflowlayout/1617710-headerreferencesize) 및 [footerReferenceSize](https://developer.apple.com/documentation/uikit/uicollectionviewflowlayout/1617703-footerreferencesize) 프로퍼티에 적절한 값을 할당하여 이 작업을 수행할 수 있다. 헤더 또는 푸터 글 크기가 0이면 해당 뷰가 컬렉션 뷰에 추가되지 않는다.


&nbsp;      
## Topics
### Configuring the Flow Layout
> 플로우 레이아웃 구성

* `protocol UICollectionViewDelegateFlowLayout`
    * UICollectionViewDelegateFlowLayout 프로토콜은 UICollectionViewFlowLayout 객체와 함께 조정할 수 있는 메서드를 정의하여 그리드 기반 레이아웃을 구현한다. 이 프로토콜의 메서드는 아이템의 크기와 그리드의 아이템 사이의 간격을 정의한다.
    

### Configuring the Scroll Direction
> 스크롤 방향 구성

* `var scrollDirection: UICollectionView.ScrollDirection`
    * 그리드의 스크롤 방향
    

### Configuring the Item Spacing
> 아이템 간격 구성

* `var minimumLineSpacing: CGFloat`
    * 그리드의 아이템 라인 사이에 사용할 최소 간격.
* `var minimumInteritemSpacing: CGFloat`
    * 같은 행의 아이템 사이에 사용할 최소 간격.
* `var itemSize: CGSize`
    * 셀에 사용할 기본 크기.
* `var estimatedItemSize: CGSize`
    * 컬렉션 뷰에서 예상되는 셀 크기.
* `var sectionInset: UIEdgeInsets`
    * 섹션 콘텐츠를 배치하는 데 사용된 여백(마진).
* `var sectionInsetReference: UICollectionViewFlowLayout.SectionInsetReference`
* `enum UICollectionViewFlowLayout.SectionInsetReference`


### Configuring the Supplementary Views
> 보충 뷰 구성

* `var headerReferenceSize: CGSize`
    * 섹션 헤더에 사용할 기본 크기.
* `var footerReferenceSize: CGSize`
    * 섹션 푸터에 사용할 기본 크기.
    

### Pinning Headers and Footers
> 헤더 및 푸터 고정

* `var sectionHeadersPinToVisibleBounds: Bool`
    * 스크롤하는 동안 헤더가 컬렉션 뷰 범위의 위쪽에 고정되는지 여부를 나타내는 부울 값.
* `var sectionFootersPinToVisibleBounds: Bool`
    * 스크롤하는 동안 푸터가 컬렉션 뷰 범위의 아래쪽에 고정되는지 여부를 나타내는 부울 값.
    

### Constants
* `enum UICollectionView.ScrollDirection`
    * 레이아웃의 스크롤 방향을 나타내는 상수.
* [Flow Layout Supplementary Views](https://developer.apple.com/documentation/uikit/uicollectionviewflowlayout/flow_layout_supplementary_views)
    * 플로우 레이아웃을 사용해 표시할 수 있는 보충 뷰의 타입을 지정하는 상수.
* `class let automaticSize: CGSize`


&nbsp;      
## Relationships
### Inherits From
* UICollectionViewLayout


### Conforms To
* CVarArg, Equatable, Hashable


&nbsp;      
## See Also
### Layouts
* class UICollectionViewLayout
* class UICollectionViewTransitionLayout
* class UICollectionViewLayoutAttributes


&nbsp;      
&nbsp;      
### [by. 0junChoi](https://github.com/0jun0815) email: <0jun0815@gmail.com>
### [Apple Developer Documentation UICollectionViewFlowLayout](https://developer.apple.com/documentation/uikit/uicollectionviewflowlayout)
