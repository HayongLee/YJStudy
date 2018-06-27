# UICollectionViewDelegate
> UICollectionViewDelegate 프로토콜은 컬렉션 뷰에서 아이템의 선택 및 강조 표시를 관리하고 해당 아이템에 대한 작업을 수행 할 수 있는 메서드를 정의한다. 이 프로토콜의 메서드는 모두 선택 사항이다.


* [Overview](#overview)
* [Topics](#topics)
    * [Managing the Selected Cells](#managing-the-selected-cells)
    * [Managing Cell Highlighting](#managing-cell-highlighting)
    * [Tracking the Addition and Removal of Views](#tracking-the-addition-and-removal-of-views)
    * [Handling Layout Changes](#handling-layout-changes)
    * [Managing Actions for Cells](#managing-actions-for-cells)
    * [Managing Focus in a Collection View](#managing-focus-in-a-collection-view)
    * [Controlling the Spring-Loading Behavior](#controlling-the-spring-loading-behavior)
* [Relationships](#relationships)
* [See Also](#see-also)


&nbsp;    
## Overview
이 프로토콜의 많은 메서드는 [NSIndexPath](https://developer.apple.com/documentation/foundation/nsindexpath) 객체를 매개 변수로 사용한다. 컬렉션 뷰를 지원하기 위해 UIKit은 NSIndexPath에 대한 카테고리를 선언한다. 이 카테고리를 사용하면 표현된 아이템 인덱스 및 섹션 인덱스를 가져올 수 있으며 아이템 및 인덱스 값에서 새 인덱스 경로 객체를 구성 할 수 있다. 아이템은 섹션 내에 있으므로 일반적으로 섹션 인덱스 번호를 평가 해야 인덱스 번호로 아이템을 식별할 수 있다.


컬렉션 뷰 객체를 구성 할 때 델리게이트 객체를 [delegate](https://developer.apple.com/documentation/uikit/uicollectionview/1618033-delegate) 프로퍼티에 할당한다. 자세한 내용은 [UICollectionView](https://developer.apple.com/documentation/uikit/uicollectionview) 참조.


&nbsp;      
## Topics
### Managing the Selected Cells
> 선택된 셀 관리

* `func collectionView(UICollectionView, shouldSelectItemAt: IndexPath) -> Bool`
    * 지정된 아이템을 선택해야 하는 경우 델리게이트에 요청한다.
* `func collectionView(UICollectionView, didSelectItemAt: IndexPath)`
    * 델리게이트에게 지정된 인덱스 경로의 아이템이 선택되었음을 알린다.
* `func collectionView(UICollectionView, shouldDeselectItemAt: IndexPath) -> Bool`
    * 지정된 아이템의 선택을 취소해야 하는 경우 델리게이트에게 요청한다.
* `func collectionView(UICollectionView, didDeselectItemAt: IndexPath)`
    * 델리게이트에게 지정된 경로에 있는 아이템의 선택이 취소되었음을 알린다.
    

### Managing Cell Highlighting
> 셀 강조 표시 관리

* `func collectionView(UICollectionView, shouldHighlightItemAt: IndexPath) -> Bool`
    * 추적 중에 아이템을 강조 표시해야 하는 경우 델리게이트에게 요청한다.
* `func collectionView(UICollectionView, didHighlightItemAt: IndexPath)`
    * 지정된 인덱스 경로의 아이템이 강조 표시되었음을 델리게이트에게 알린다.
* `func collectionView(UICollectionView, didUnhighlightItemAt: IndexPath)`
    * 특정 인덱스 경로의 아이템에서 강조 표시가 제거되었다고 델리게이트에게 알린다.
    

### Tracking the Addition and Removal of Views
> 뷰 추가 및 제거 추적

* `func collectionView(UICollectionView, willDisplay: UICollectionViewCell, forItemAt: IndexPath)`
    * 지정된 셀이 컬렉션 뷰에 표시 될 것임을 델리게이트에게 알린다.
* `func collectionView(UICollectionView, willDisplaySupplementaryView: UICollectionReusableView, forElementKind: String, at: IndexPath)`
    * 지정된 보충 뷰가 컬렉션 뷰에 표시 될 것임을 델리게이트에게 알린다.
* `func collectionView(UICollectionView, didEndDisplaying: UICollectionViewCell, forItemAt: IndexPath)`
    * 지정된 셀이 컬렉션 뷰에서 제거되었음을 델리게이트에게 알린다.
* `func collectionView(UICollectionView, didEndDisplayingSupplementaryView: UICollectionReusableView, forElementOfKind: String, at: IndexPath)`
    * 지정된 보충 뷰가 컬렉션 뷰에서 제거되었음을 델리게이트에게 알린다.
    

### Handling Layout Changes
> 레이아웃 변경 처리

* `func collectionView(UICollectionView, transitionLayoutForOldLayout: UICollectionViewLayout, newLayout: UICollectionViewLayout) -> UICollectionViewTransitionLayout`
    * 지정된 레이아웃들 사이를 이동할 때 사용할 커스텀 전환 레이아웃을 요청한다.
* `func collectionView(UICollectionView, targetContentOffsetForProposedContentOffset: CGPoint) -> CGPoint`
    * 델리게이트에게 레이아웃 변경 및 애니메이션 업데이트에 대한 콘텐츠 오프셋을 커스텀화 할 수 있는 기회를 제공한다.
* `func collectionView(UICollectionView, targetIndexPathForMoveFromItemAt: IndexPath, toProposedIndexPath: IndexPath) -> IndexPath`
    * 델리게이트에게 아이템을 이동할 때 사용할 인덱스 경로를 요청한다.
    

### Managing Actions for Cells
> 셀 액션 관리

* `func collectionView(UICollectionView, shouldShowMenuForItemAt: IndexPath) -> Bool`
    * 지정된 아이템에 대해 액션 메뉴가 표시되어야 하는 경우 델리게이트에게 요청한다.
* `func collectionView(UICollectionView, canPerformAction: Selector, forItemAt: IndexPath, withSender: Any?) -> Bool`
    * 델리게이트가 컬렉션 뷰의 아이템에서 지정된 액션을 수행 할 수 있는지 여부를 묻는다.
* `func collectionView(UICollectionView, performAction: Selector, forItemAt: IndexPath, withSender: Any?)`
    * 델리게이트에게 컬렉션 뷰의 아이템에 대해 지정된 액션을 수행하도록 지시한다.
    

### Managing Focus in a Collection View
> 컬렉션 뷰 포커스 관리

* `func collectionView(UICollectionView, canFocusItemAt: IndexPath) -> Bool`
    * 지정된 인덱스 경로의 아이템에 포커스를 설정할 수 있는지 여부를 델리게이트에게 요청한다.
* `func indexPathForPreferredFocusedView(in: UICollectionView) -> IndexPath?`
    * 델리게이트에게 포커스를 맞추어야하는 셀의 인덱스 경로를 요청한다.
* `func collectionView(UICollectionView, shouldUpdateFocusIn: UICollectionViewFocusUpdateContext) -> Bool`
    * 포커스 변경이 발생해야 하는지 여부를 델리게이트에게 요청한다.
* `func collectionView(UICollectionView, didUpdateFocusIn: UICollectionViewFocusUpdateContext, with: UIFocusAnimationCoordinator)`
    * 델리게이트에게 포커스 업데이트가 발생했음을 알린다.
    

### Controlling the Spring-Loading Behavior
> 스프링-로딩 동작 제어

* `func collectionView(UICollectionView, shouldSpringLoadItemAt: IndexPath, with: UISpringLoadedInteractionContext) -> Bool`
    * 지정된 아이템에 대해 스프링-로드 상호 작용 효과를 표시할지 여부를 나타내는 부울 값을 반환한다.
    

&nbsp;      
## Relationships
### Inherits From
* UIScrollViewDelegate


### Inherited By
* UICollectionViewDelegateFlowLayout


### Adopted By
* UICollectionViewController


&nbsp;      
## See Also
### Managing Collection View Interactions
* var delegate: UICollectionViewDelegate?


&nbsp;      
&nbsp;      
### [by. 0junChoi](https://github.com/0jun0815) email: <0jun0815@gmail.com>
### [Apple Developer Documentation UICollectionViewDelegate](https://developer.apple.com/documentation/uikit/uicollectionviewdelegate)
