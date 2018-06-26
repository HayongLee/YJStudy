# UICollectionView
> 데이터 아이템의 정의된 컬렉션을 관리하고 커스텀 레이아웃을 사용하여 데이터 아이템을 제공하는 객체이다.


* [Overview](#overview)
* [Collection Views and Layout Objects](#collection-views-and-layout-objects)
* [Creating Cells and Supplementary Views](#creating-cells-and-supplementary-views)
* [Reordering Items Interactively](#reordering-items-interactively)
* [Interface Builder Attributes](#interface-builder-attributes)
* [Internationalization](#internationalization)
* [Accessibility](#accessibility)
* [Topics](#topics)
    * [Initializing a Collection View](#initializing-a-collection-view)
    * [Providing the Collection View Data](#providing-the-collection-view-data)
    * [Managing Collection View Interactions](#managing-collection-view-interactions)
    * [Configuring the Background View](#configuring-the-background-view)
    * [Prefetching Collection View Cells and Data](#prefetching-collection-view-cells-and-data)
    * [Creating Collection View Cells](#creating-collection-view-cells)
    * [Changing the Layout](#changing-the-layout)
    * [Getting the State of the Collection View](#getting-the-state-of-the-collection-view)
    * [Inserting, Moving, and Deleting Items](#inserting-moving-and-deleting-items)
    * [Inserting, Moving, and Deleting Sections](#inserting-moving-and-deleting-sections)
    * [Reordering Items Interactively](#reordering-items-interactively-1)
    * [Managing Drag Interactions](#managing-drag-interactions)
    * [Managing Drop Interactions](#managing-drop-interactions)
    * [Managing the Selection](#managing-the-selection)
    * [Managing Focus](#managing-focus)
    * [Locating Items and Views in the Collection View](#locating-items-and-views-in-the-collection-view)
    * [Getting Layout Information](#getting-layout-information)
    * [Scrolling an Item Into View](#scrolling-an-item-into-view)
    * [Animating Multiple Changes to the Collection View](#animating-multiple-changes-to-the-collection-view)
    * [Reloading Content](#reloading-content)
    * [Constants](#constants)
    * [Type Properties](#type-properties)
    * [Enumerations](#enumerations)
* [Relationships](#relationships)
* [See Also](#see-also)


&nbsp;    
## Overview
![](https://docs-assets.developer.apple.com/published/a84db79dea/50390428-f9f2-4cbc-bd99-1cacca4f0617.png)


사용자 인터페이스에 컬렉션 뷰를 추가할 때 앱의 주된 업무는 해당 컬렉션 뷰와 관련된 데이터를 관리하는 것이다. 컬렉션 뷰는 [UICollectionViewDataSource](https://developer.apple.com/documentation/uikit/uicollectionviewdatasource) 프로토콜을 준수하고 앱에서 제공하는 객체인 데이터 소스 객체에서 데이터를 가져온다. 컬렉션 뷰의 데이터는 개별 아이템으로 구성되며, 각 아이템을 그룹화하여 표시 할 수 있다. 아이템은 표시 할 데이터의 최소 단위이다. 예를 들어 사진 앱에서 아이템은 단일 이미지 일 수 있다. 컬렉션 뷰는 데이터 소스가 구성하고 제공하는 [UICollectionViewCell](https://developer.apple.com/documentation/uikit/uicollectionviewcell) 클래스의 인스턴스인 셀을 사용하여 화면에 아이템을 표시한다.


셀 외에도 컬렉션 뷰는 다른 뷰 타입을 사용하여 데이터를 표시할 수 있다. 이러한 보충 뷰는 개별 셀과 구분되어 있지만 여전히 정보를 전달하는 섹션 헤더 및 푸터와 같은 것일 수 있다. 보충 뷰에 대한 지원은 선택적이며 컬렉션 뷰의 레이아웃 객체에 의해 정의되며 뷰의 배치를 정의하는 역할도 한다.


사용자 인터페이스에 포함시키는 것 외에도 UICollectionView 객체의 메서드를 사용하여 아이템의 시각적 표현이 데이터 소스 객체의 순서와 일치하는지 확인한다. 따라서 컬레션의 데이터를 추가, 삭제 또는 재정렬 할 때마다 이 클래스의 메서드를 사용하여 해당 셀을 삽입, 삭제 및 재정렬한다. 또한 컬렉션 뷰 객체를 사용하여 선택한 아이템을 관리한다. 이 동작의 경우 컬렉션 뷰는 연관된 [delegate](https://developer.apple.com/documentation/uikit/uicollectionview/1618033-delegate) 객체와 함께 작동한다.


&nbsp;      
## Collection Views and Layout Objects
컬렉션 뷰와 연관된 매우 중요한 객체는 [UICollectionViewLayout](https://developer.apple.com/documentation/uikit/uicollectionviewlayout) 클래스의 서브 클래스인 레이아웃 객체이다. 레이아웃 객체는 컬렉션 뷰 내부의 모든 셀 및 보충 뷰의 위치와 조직을 정의한다. 위치를 정의하더라도 레이아웃 객체는 실제로 해당 정보를 해당 뷰에 적용하지 않는다. 셀 및 보충 뷰 작성에는 컬렉션 뷰와 데이터 소스 객체 간의 조정이 필요하기 때문에, 컬렉션 뷰는 실제 레이아웃 정보를 뷰에 적용한다. 따라서 어떤 의미에서 레이아웃 객체는 다른 데이터 소스와 같으며 아이템 데이터 대신 시각적 정보만 제공한다.


일반적으로 컬렉션 뷰를 만들 때 레이아웃 객체를 지정하지만 컬렉션 뷰의 레이아웃을 동적으로 변경할 수도 있다. 레이아웃 객체는 [collectionViewLayout](https://developer.apple.com/documentation/uikit/uicollectionview/1618047-collectionviewlayout) 프로퍼티에 저장된다. 이 프로퍼티를 직접 설정하면 변경 내용에 애니메이션을 적용하지 않고 즉시 레이아웃이 업데이트 된다. 변경 사항을 애니메이션으로 적용하려면 [setCollectionViewLayout(_:animated:completion:)](https://developer.apple.com/documentation/uikit/uicollectionview/1618017-setcollectionviewlayout) 메서드를 대신 호출해야 한다.


제스처 인식기 또는 터치 이벤트에 의해 구동되는 상호 작용하는 전환을 만들려면 [startInteractiveTransition(to:completion:)](https://developer.apple.com/documentation/uikit/uicollectionview/1618098-startinteractivetransition) 메서드를 사용하여 레이아웃 객체를 변경한다. 이 메서드는 중간 레이아웃 객체를 설치한다. 이 객체의 목적은 동작 진행을 추적하기 위해 제스처 인식기 또는 이벤트 처리 코드를 사용하는 것이다. 이벤트 처리 코드에서 전환이 완료되었다고 판단하면 [finishInteractiveTransition()](https://developer.apple.com/documentation/uikit/uicollectionview/1618080-finishinteractivetransition) 또는 [cancelInteractiveTransition()](https://developer.apple.com/documentation/uikit/uicollectionview/1618075-cancelinteractivetransition) 메서드를 호출하여 중간 레이아웃 객체를 제거하고 의도한 타겟 레이아웃 객체를 설치한다.


&nbsp;      
## Creating Cells and Supplementary Views
컬렉션 뷰의 데이터 소스 객체는 아이템의 콘텐츠와 해당 콘텐츠를 제공하는데 사용되는 뷰를 모두 제공한다. 컬렉션 뷰는 먼저 콘텐츠를 로드할 때 데이터 소스에 각 보이는 아이템에 대한 뷰를 제공하도록 요청한다. 코드 작성 프로세스를 간소화하려면 코드에서 명시적으로 뷰를 작성하는 대신 컬렉션 뷰에서 항상 뷰를 큐에서 제거(dequeue)해야 한다. 뷰를 큐에서 제거하는 메서드에는 두 가지가 있다. 사용하는 뷰 타입은 요청한 뷰 타입에 따라 다르다:
* [dequeueReusableCell(withReuseIdentifier:for:)](https://developer.apple.com/documentation/uikit/uicollectionview/1618063-dequeuereusablecell)을 사용하여 컬렉션 뷰에서 아이템의 셀을 가져온다.
* [dequeueReusableSupplementaryView(ofKind:withReuseIdentifier:for:)](https://developer.apple.com/documentation/uikit/uicollectionview/1618068-dequeuereusablesupplementaryview) 메서드를 사용하여 레이아웃 객체가 요청한 보충 뷰를 가져온다.


이 메서드 중 하나를 호출하기 전에 컬렉션 뷰에 이미 존재하지 않는 경우 해당 뷰를 생성하는 방법을 알려야한다. 이를 위해서는 클래스 또는 nib 파일을 컬렉션 뷰에 등록해야 한다. 예를 들어, 셀을 등록할 때 [register(_:forCellWithReuseIdentifier:)](https://developer.apple.com/documentation/uikit/uicollectionview/1618089-register) 또는 [register(_:forCellWithReuseIdentifier:](https://developer.apple.com/documentation/uikit/uicollectionview/1618083-register) 메서드를 사용한다. 등록 프로세스의 일부로 뷰의 목적을 식별하는 재사용 식별자를 지정한다. 이 식별자는 나중에 뷰를 큐에서 제거할 때 사용하는 것과 동일한 문자열이다.


델리게이트 메서드에서 적절한 뷰를 큐에서 제거한 후 콘텐츠를 구성하고 컬렉션 뷰로 반환하여 사용한다. 레이아웃 객체에서 레이아웃 정보를 가져온 후 컬렉션 뷰는 이를 뷰에 적용하고 표시한다.


뷰를 만들고 구성하기 위한 데이터 소스 메서드를 구현하는 방법에 대한 자세한 내용은 [UICollectionViewDataSource](https://developer.apple.com/documentation/uikit/uicollectionviewdatasource)를 참조.


&nbsp;      
## Reordering Items Interactively
컬렉션 뷰를 사용하면 사용자 상호 작용을 기반으로 아이템을 이동할 수 있다. 일반적으로 컬렉션 뷰의 아이템 순서는 데이터 소스에 의해 정의된다. 사용자가 아이템을 재정렬하는 기능을 지원하면 컬렉션 뷰 아이템과의 사용자 상호 작용을 추적하고 해당 아이템의 위치를 업데이트하도록 제스처 인식기를 구성 할 수 있다.


아이템의 상호 작용하는 위치 변경을 시작하려면 컬렉션 뷰의 [beginInteractiveMovementForItem(at:)](https://developer.apple.com/documentation/uikit/uicollectionview/1618019-begininteractivemovementforitem) 메서드를 호출한다. 제스처 인식기가 터치 이벤트를 추적하는 동안 [updateInteractiveMovementTargetPosition(_:)](https://developer.apple.com/documentation/uikit/uicollectionview/1618079-updateinteractivemovementtargetp) 메서드를 호출하여 터치 위치의 변경사항을 보고한다. 제스처 추적을 마쳤으면 [endInteractiveMovement()](https://developer.apple.com/documentation/uikit/uicollectionview/1618082-endinteractivemovement) 또는 [cancelInteractiveMovement](https://developer.apple.com/documentation/uikit/uicollectionview/1618076-cancelinteractivemovement) 메서드를 호출하여 상호 작용을 완료하고 컬렉션 뷰를 업데이트한다.


사용자 상호 작용 중에 컬렉션 뷰는 레이아웃을 동적으로 무효화하여 아이템의 현재 위치를 반영한다. 아무것도 하지 않으면 기본 레이아웃 동작이 아이템의 위치를 변경하지만 필요에 따라 레이아웃 애니메이션을 커스텀화 할 수 있다. 상호 작용이 끝나면 데이터 소스 객체가 아이템의 새 위치로 업데이트된다.


UICollectionViewController 클래스는 관리되는 컬렉션 뷰에서 아이템을 다시 배열하는데 사용할 수 있는 기본 제스처 인식기를 제공한다. 이 제스처 인식기를 설치하려면 컬렉션 뷰 컨트롤러의 [installsStandardGestureForInteractiveMovement]() 프로퍼티를 true로 설정한다.


&nbsp;      
## Interface Builder Attributes
아래 표는 인터페이스 빌더에서 컬렉션 뷰에 대해 구성하는 속성을 나열한 것이다.
Attribute | Description
----- | -----
Items | 프로토타입 셀의 수. 이 프로퍼티는 스토리보드에서 구성할 프로토타입 셀의 지정된 수를 제어한다. 커렉션 뷰에는 항상 하나 이상의 셀이 있어야 하며 다른 타입의 콘텐츠를 표시하거나 동일한 콘텐츠를 다른 방식으로 표시하기 위해 여러 개의 셀이 있을 수 있다.
Layout | 사용할 레이아웃 객체이다. 이 컨트롤을 사용하여 [UICollectionViewFlowLayout](https://developer.apple.com/documentation/uikit/uicollectionviewflowlayout) 객체와 사용자가 정의한 커스텀 레이아웃 객체 중에서 선택한다. 플로우 레이아웃을 선택하면 컬렉션 뷰의 콘텐츠에 대한 스크롤 방향과 플로우 레이아웃의 헤더 및 푸터가 있는지 여부를 구성할 수도 있다. 헤더 및 푸터를 사용하면 헤더 및 푸터 콘텐츠로 구성 할 수 있고 재사용할 수 있는 뷰가 스토리보드에 추가된다. 프로그래밍 방식으로 이러한 뷰를 만들 수도 있다. 커스텀 레이아웃을 선택하면 사용할 [UICollectionViewLayout](https://developer.apple.com/documentation/uikit/uicollectionviewlayout) 서브 클래스를 지정해야 한다.


플로우 레이아웃을 선택하면 컬렉션 뷰의 사이즈 인스팩터에 흐름 레이아웃의 메트릭을 구성하기 위한 추가 속성이 포함된다. 이러한 속성을 사용하여 셀 크기, 헤더와 푸터의 크기, 셀 간의 최소 간격 및 셀의 각 섹션 주위 여백을 구성한다. 흐름 레이아웃 메트릭의 의미에 대한 자세한 내용은 [UICollectionViewFlowLayout](https://developer.apple.com/documentation/uikit/uicollectionviewflowlayout)을 참조.


&nbsp;
## Internationalization
컬렉션 뷰에는 국제화할 자체 콘텐츠가 없다. 대신 컬렉션 뷰의 셀과 재사용 가능한 뷰를 국제화한다. 국제화에 대한 자세한 내용은 [Internationalization and Localization Guide](https://developer.apple.com/library/archive/documentation/MacOSX/Conceptual/BPInternational/Introduction/Introduction.html#//apple_ref/doc/uid/10000171i)를 참조.


&nbsp;
## Accessibility
컬렉션 뷰에는 접근 가능하게 하는 자체 콘텐츠가 없다. 셀 및 재사용 가능한 뷰에 UILabel 및 UITextField와 같은 표준 UIKit 컨트롤이 포함되어 있을 경우 해당 컨트롤에 접근 할 수 있게 만들 수 있다. 컬렉션 뷰가 화면 레이아웃을 변경하면 UIAccessibilityLayoutChangedNotification 알림을 게시한다.


인터페이스에 접근 할 수 있게하는 방법에 대한 일반 정보는 [Accessibility Programming Guide for iOS](https://developer.apple.com/library/archive/documentation/UserExperience/Conceptual/iPhoneAccessibility/Introduction/Introduction.html#//apple_ref/doc/uid/TP40008785) 참조.


&nbsp;      
## Topics
### Initializing a Collection View
> 컬렉션 뷰 초기화

* `init(frame: CGRect, collectionViewLayout: UICollectionViewLayout)`
    * 지정된 프레임 및 레이아웃을 사용하여 새로 할당 된 컬렉션 뷰 객체를 초기화하고 반환한다.
* `init?(coder: NSCoder)`


### Providing the Collection View Data
> 컬렉션 뷰 데이터 제공

* `var dataSource: UICollectionViewDataSource?`
    * 컬렉션 뷰의 데이터를 제공하는 객체이다.
* `protocol UICollectionViewDataSource`
    * UICollectionViewDataSource 프로토콜을 채택한 객체는 컬렉션 뷰에 필요한 데이터 및 뷰를 제공한다. 데이터 소스 객체는 앱의 데이터 모델을 나타내며 필요에 따라 컬렉션 뷰에 정보를 제공한다. 또한 데이터를 표시하기 위해 컬렉션 뷰에서 사용되는 셀 및 보충 뷰의 작성 및 구성을 처리한다.
* `protocol UICollectionViewDataSourcePrefetching`
    * 컬렉션 뷰에 대한 데이터 요구 사항에 대한 사전 경고를 제공하여 비동기 데이터 로드 작업의 트리거링을 허용하는 프로토콜이다.


### Managing Collection View Interactions
> 컬렉션 뷰 상호 작용 관리

* `var delegate: UICollectionViewDelegate?`
    * 컬렉션 뷰의 델리게이트 역할을 하는 객체이다.
* `protocol UICollectionViewDelegate`
    * UICollectionViewDelegate 프로토콜은 컬렉션 뷰에서 아이템의 선택 및 강조 표시를 관리하고 해당 아이템에 대한 작업을 수행할 수 있는 메서드를 정의한다. 이 프로토콜의 메서드는 모두 선택 사항이다.
    

### Configuring the Background View
> 백그라운드 뷰 구성

* `var backgroundView: UIView?`
    * 백그라운드 모양을 제공하는 뷰이다.
    

### Prefetching Collection View Cells and Data
> 컬렉션 셀 및 데이터 프리페칭

UICollectionView는 응답성을 향상시키는 데 사용할 수 있는 두 가지 프리페칭 기술을 제공한다:
* **셀 프리페칭**은 필요한 시간보다 앞서 셀을 준비한다. 컬렉션 뷰에 많은 수의 셀이 동시에 필요하면(예: 그리드 레이아웃의 새 셀 행) 셀이 표시에 필요한 시간보다 일찍 요청된다. 따라서 셀 렌더링은 여러 레이아웃 패스에 분산되어 보다 부드러운 스크롤 경험을 제공한다. 셀 프리페칭은 기본적으로 사용 가능하다.
* **데이터 프리페칭**은 셀 요청보다 먼저 컬렉션 뷰의 데이터 요구 사항을 알리는 메커니즘을 제공한다. 이는 셀 콘텐츠가 네트워크 요청과 같은 값 비싼 데이터 로드 프로세스에 의존하는 경우에 유용하다. [UICollectionViewDataSourcePrefetching](https://developer.apple.com/documentation/uikit/uicollectionviewdatasourceprefetching) 프로토콜을 준수하는 객체를 [prefetchDataSource](https://developer.apple.com/documentation/uikit/uicollectionview/1771768-prefetchdatasource) 프로퍼티에 할당하여 셀의 데이터를 프리페치할 때 알림을 받는다.
* `var isPrefetchingEnabled: Bool`
    * 셀 및 데이터 프리페치가 사용 가능한지 여부를 표시한다.
* `var prefetchDataSource: UICollectionViewDataSourcePrefetching?`
    * 컬렉션 뷰의 프리페치 데이터 소스 역할을 하는 객체. 다가오는 셀 데이터 요구 사항에 대한 알림을 수신한다.
    

### Creating Collection View Cells
> 컬렉션 뷰 셀 생성

* `func register(AnyClass?, forCellWithReuseIdentifier: String)`
    * 새 컬렉션 뷰 셀을 만드는 데 사용할 클래스를 등록한다.
* `func register(UINib?, forCellWithReuseIdentifier: String)`
    * 새 컬렉션 뷰 셀을 만드는 데 사용할 nib 파일을 등록한다.
* `func register(AnyClass?, forSupplementaryViewOfKind: String, withReuseIdentifier: String)`
    * 컬렉션 뷰의 보충 뷰의 생성에 사용하는 클래스를 등록한다.
* `func register(UINib?, forSupplementaryViewOfKind: String, withReuseIdentifier: String)`
    * 컬렉션 뷰의 보충 뷰의 생성에 사용하는 nib 파일을 등록한다.
* `func dequeueReusableCell(withReuseIdentifier: String, for: IndexPath) -> UICollectionViewCell`
    * 식별자로 지정된 재사용 가능한 셀 객체를 반환한다.
* `func dequeueReusableSupplementaryView(ofKind: String, withReuseIdentifier: String, for: IndexPath) -> UICollectionReusableView`
    * 식별자와 종류에 의해 재사용 가능한 보충 뷰를 반환한다.
    

### Changing the Layout
> 레이아웃 변경

* `var collectionViewLayout: UICollectionViewLayout`
    * 컬렉션 뷰의 아이템을 구성하는 데 사용 된 레이아웃.
* `func setCollectionViewLayout(UICollectionViewLayout, animated: Bool)`
    * 컬렉션 뷰의 레이아웃을 변경하고 선택적으로 변경 사항을 애니메이션화한다.
* `func setCollectionViewLayout(UICollectionViewLayout, animated: Bool, completion: ((Bool) -> Void)? = nil)`
    * 컬렉션 뷰의 레이아웃을 변경하고 애니메이션이 완료되면 알려준다.
* `func startInteractiveTransition(to: UICollectionViewLayout, completion: UICollectionView.LayoutInteractiveTransitionCompletion? = nil) -> UICollectionViewTransitionLayout`
    * 상호 작용 전환 효과를 사용하여 컬렉션 뷰의 현재 레이아웃을 변경한다.
* `func finishInteractiveTransition()`
    * 의도한 타겟 레이아웃을 설치하여 컬렉션 뷰에 상호 작용 전환을 완료하도록 지시한다.
* `func cancelInteractiveTransition()`
    * 컬렉션 뷰에 상호 작용 전환을 중단하고 원래 레이아웃 객체로 돌아가도록 지시한다.
    

### Getting the State of the Collection View
> 컬렉션 뷰 상태 얻기

* `var numberOfSections: Int`
    * 컬렉션 뷰로 표시되는 섹션의 수를 반환한다.
* `func numberOfItems(inSection: Int) -> Int`
    * 지정된 섹션의 아이템 수를 반환한다.
* `var visibleCells: [UICollectionViewCell]`
    * 컬렉션 뷰로 현재 표시되고 있는 보이는 셀의 배열을 반환한다.


### Inserting, Moving, and Deleting Items
> 아이템 삽입, 이동 및 삭제

* `func insertItems(at: [IndexPath])`
    * 지정된 인덱스 경로에 새 아이템을 삽입한다.
* `func moveItem(at: IndexPath, to: IndexPath)`
    * 컬렉션 뷰에서 한 위치에서 다른 위치로 아이템을 이동한다.
* `func deleteItems(at: [IndexPath])`
    * 지정된 인덱스 경로에 아이템을 삭제한다.


### Inserting, Moving, and Deleting Sections
> 섹션 삽입 이동 및 삭제

* `func insertSections(IndexSet)`
    * 지정된 인덱스에 새로운 섹션을 삽입한다.
* `func moveSection(Int, toSection: Int)`
    * 컬렉션 뷰에서 한 위치에서 다른 위치로 섹션을 이동한다.
* `func deleteSections(IndexSet)`
    * 지정된 인덱스의 섹션을 삭제한다.
    

### Reordering Items Interactively
> 상호 작용적으로 아이템 순서 변경

* `func beginInteractiveMovementForItem(at: IndexPath) -> Bool`
    * 지정된 인덱스 경로에서 아이템의 상호 작용적 동작을 시작한다.
* `func updateInteractiveMovementTargetPosition(CGPoint)`
    * 컬렉션 뷰의 범위 내에서 아이템의 위치를 업데이트한다.
* `func endInteractiveMovement()`
    * 상호 작용 동작 추적을 끝내고 타겟 아이템을 새 위치로 이동한다.
* `func cancelInteractiveMovement()`
    * 상호 작용 동작 추적을 끝내고 타겟 아이템을 원래 위치로 되돌린다.
    

### Managing Drag Interactions
> 드래그 상호 작용 관리

* `var dragDelegate: UICollectionViewDragDelegate?`
    * 컬렉션 뷰에서 아이템 드래그를 관리하는 델리게이트 객체이다.
* `protocol UICollectionViewDragDelegate`
    * 컬렉션 뷰로부터 드래그를 개시하기 위한 인터페이스.
* `var hasActiveDrag: Bool`
    * 아이템이 컬렉션 뷰에서 해제되어 아직 삭제되지 않았는지 여부를 나타내는 부울 값.
* `var dragInteractionEnabled: Bool`
    * 컬렉션 뷰가 앱 간의 드래그 앤 드롭을 지원하는지 여부를 나타내는 부울 값.
    

### Managing Drop Interactions
> 드롭 상호 작용 관리

* `var dropDelegate: UICollectionViewDropDelegate?`
    * 컬렉션 뷰로 아이템을 드롭하는 것을 관리하는 델리게이트 객체. 
* `var hasActiveDrop: Bool`
    * 컬렉션 뷰가 현재 드롭 세션을 추적 중인지 여부를 나타내는 부울 값.
* `var reorderingCadence: UICollectionView.ReorderingCadence`
    * 잠재적인 드롭 위치를 표시하기 위해 컬렉션 뷰의 아이템을 재정렬하는 속도.
* `enum UICollectionView.ReorderingCadence`
    * 드롭시에 컬렉션 뷰 아이템이 재구성되는 속도를 나타내는 상수.
    

### Managing the Selection
> 선택 관리

* `var allowsSelection: Bool`
    * 사용자가 컬렉션 뷰에서 아이템을 선택할 수 있는지 여부를 나타내는 부울 값.
* `var allowsMultipleSelection: Bool`
    * 사용자가 컬렉션 뷰에서 둘 이상의 아이템을 선택할 수 있는지 여부를 결정하는 부울 값.
* `var indexPathsForSelectedItems: [IndexPath]?`
    * 선택된 아이템의 인덱스 경로.
* `func selectItem(at: IndexPath?, animated: Bool, scrollPosition: UICollectionView.ScrollPosition)`
    * 지정된 인덱스 경로에서 아이템을 선택하고 선택적으로 뷰를 스크롤한다.
* `func deselectItem(at: IndexPath, animated: Bool)`
    * 지정된 인덱스의 아이템을 선택 취소한다.
    

### Managing Focus
> 포커스 관리

* `var remembersLastFocusedIndexPath: Bool`
    * 컬렉션 뷰가 마지막 포커스가 있는 인덱스 경로의 아이템에 자동으로 포커스를 할당하는지 여부를 나타내는 부울 값.
    

### Locating Items and Views in the Collection View
> 컬렉션 뷰에서 아이템 및 뷰 찾기

* `func indexPathForItem(at: CGPoint) -> IndexPath?`
    * 컬렉션 뷰의 지정된 포인터에 있는 아이템의 인덱스 경로를 반환한다.
* `var indexPathsForVisibleItems: [IndexPath]`
    * 컬렉션 뷰에 표시되는 아이템의 배열이다.
* `func indexPath(for: UICollectionViewCell) -> IndexPath?`
    * 지정된 셀의 인덱스 경로를 반환한다.
* `func cellForItem(at: IndexPath) -> UICollectionViewCell?`
    * 지정된 인덱스 경로에 있는 표시 가능한 셀 객체를 반환한다.
* `func indexPathsForVisibleSupplementaryElements(ofKind: String) -> [IndexPath]`
    * 지정된 타입의 모든 보충 뷰의 인덱스 경로를 반환한다.
* `func supplementaryView(forElementKind: String, at: IndexPath) -> UICollectionReusableView?`
    * 지정된 인덱스 경로의 보충 뷰를 반환한다.
* `func visibleSupplementaryViews(ofKind: String) -> [UICollectionReusableView]`
    * 지정된 종류의 표시 가능한 보충 뷰의 배열을 반환한다.
    

### Getting Layout Information
> 레이아웃 정보 가져오기

* `func layoutAttributesForItem(at: IndexPath) -> UICollectionViewLayoutAttributes?`
    * 지정된 인덱스 경로에 있는 아이템의 레이아웃 정보를 반환한다.
* `func layoutAttributesForSupplementaryElement(ofKind: String, at: IndexPath) -> UICollectionViewLayoutAttributes?`
    * 지정된 보충 뷰의 레이아웃 정보를 반환한다.
    

### Scrolling an Item Into View
> 뷰에서 아이템 스크롤

* `func scrollToItem(at: IndexPath, at: UICollectionView.ScrollPosition, animated: Bool)`
    * 지정된 아이템이 표시 될 때까지 컬렉션 뷰 콘텐츠를 스크롤한다.
    

### Animating Multiple Changes to the Collection View
> 컬렉션 뷰에 여러 변경 사항 애니메이션

* `func performBatchUpdates((() -> Void)?, completion: ((Bool) -> Void)? = nil)`
    * 여러 삽입, 삭제, 리로드 및 이동 작업을 그룹으로 애니메이션 처리한다.


### Reloading Content
> 콘텐츠 재정렬

* `var hasUncommittedUpdates: Bool`
    * 컬렉션 뷰에 드롭 플레이스 홀더가 포함되어 있는지, 드롭을 처리할 때 아이템의 순서가 바뀌었는지를 나타내는 부울 값.
* `func reloadData()`
    * 컬렉션 뷰의 모든 데이터를 리로드한다.
* `func reloadSections(IndexSet)`
    * 컬렉션 뷰의 지정된 섹션의 데이터를 리로드한다.
* `func reloadItems(at: [IndexPath])`
    * 지정된 인덱스 경로에 있는 아이템만 리로드한다.
    

### Constants
* `struct UICollectionView.ScrollPosition`
    * 아이템을 컬렉션 뷰의 표시 가능한 부분에 스크롤하는 방법을 나타내는 상수.
* `typealias UICollectionView.LayoutInteractiveTransitionCompletion`
    * 완료 블록은 컬렉션 뷰의 상호 작용 전환 끝에서 호출된다.
    

### Type Properties
* `class let elementKindSectionFooter: String`
* `class let elementKindSectionHeader: String`

### Enumerations
* `enum UICollectionView.ElementCategory`
    * 뷰의 타입을 지정하는 상수.
* `enum UICollectionView.ScrollDirection`
    * 레이아웃의 스크롤 방향을 나타내는 상수.


&nbsp;      
## Relationships
### Inherits From
* UIScrollView


### Conforms To
* CVarArg
* Equatable
* Hashable
* UIAccessibilityIdentification
* UIDataSourceTranslating
* UIPasteConfigurationSupporting
* UISpringLoadedInteractionSupporting
* UIUserActivityRestoring


&nbsp;      
## See Also
### View
* class UICollctionViewController


&nbsp;      
&nbsp;      
### [by. 0junChoi](https://github.com/0jun0815) email: <0jun0815@gmail.com>
### [Apple Developer Documentation UICollectionView](https://developer.apple.com/documentation/uikit/uicollectionview)
