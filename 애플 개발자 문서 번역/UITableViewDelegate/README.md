# UITableViewDelegate
> UITableView 객체의 델리게이트는 UITableViewDelegate 프로토콜을 채택해야 한다. 프로토콜의 선택적 메서드를 사용하여 델리게이트의 선택 사항을 관리하고, 섹션 헤더와 푸터를 구성하고, 셀을 삭제하고 순서를 변경하는 등의 작업을 수행할 수 있다.


* [Overview](#overview)
* [Topic](#topic)
    * [Configuring Rows for the Table View](#configuring-rows-for-the-table-view)
    * [Managing Accessory Views](#managing-accessory-views)
    * [Managing Selections](#managing-selections)
    * [Modifying the Header and Footer of Sections](#modifying-the-header-and-footer-of-sections)
    * [Editing Table Rows](#editing-table-rows)
    * [Reordering Table Rows](#reordering-table-rows)
    * [Tracking the Removal of Views](#tracking-the-removal-of-views)
    * [Copying and Pasting Row Content](#copying-and-pasting-row-content)
    * [Managing Table View Highlighting](#managing-table-view-highlighting)
    * [Managing Table View Focus](#managing-table-view-focus)
    * [Handling Swipe Actions](#handling-swipe-actions)
* [Relationships](#relationships)
* [See Also](#see-also)


&nbsp;      
## Overview
UITableViewDelegate 프로토콜의 많은 메서드는 [NSIndexPath](https://developer.apple.com/documentation/foundation/nsindexpath) 객체를 매개 변수 및 반환 값으로 사용한다. UIKit은 NSIndexPath에서 표현된 행 인덱스([row](https://developer.apple.com/documentation/foundation/nsindexpath/1614853-row) 프로퍼티) 및 섹션 인덱스([section](https://developer.apple.com/documentation/foundation/nsindexpath/1528298-section) 프로퍼티)를 가져오고 지정된 행 인덱스와 섹션 인덱스 ([init(row:section:)](https://developer.apple.com/documentation/foundation/nsindexpath/1614934-init) 메서드)에서 인덱스 경로를 구성할 수 있는 카테고리를 선언한다. 행은 섹션 내에 위치하기 때문에 일반적으로 섹션 인덱스 번호를 평가해야 인덱스 번호로 행을 식별할 수 있다.


&nbsp;      
## Topic
### Configuring Rows for the Table View
> 테이블 뷰에 대한 행 구성

* `func tableView(UITableView, heightForRowAt: IndexPath) -> CGFloat`
    * 델리게이트에게 지정된 위치의 행에 대해 사용할 높이를 요청한다.
* `func tableView(UITableView, estimatedHeightForRowAt: IndexPath) -> CGFloat`
    * 델리게이트에게 지정된 위치의 행의 예상 높이를 요청한다. 
* `func tableView(UITableView, indentationLevelForRowAt: IndexPath) -> Int`
    * 델리게이트에게 지정된 섹션에서 행의 들여쓰기 레벨을 반환하도록 요청한다.
* `func tableView(UITableView, willDisplay: UITableViewCell, forRowAt: IndexPath)`
    * 델리게이트에게 테이블 뷰가 특정 행에 대해 셀을 그리려고 한다는 것을 알린다.
* `func tableView(UITableView, shouldSpringLoadRowAt: IndexPath, with: UISpringLoadedInteractionContext) -> Bool`
    * 테이블의 행의 스프링-로딩 동작을 미세 조정 할 수 있도록 호출한다.


### Managing Accessory Views
> 액세서리 뷰 관리

* `func tableView(UITableView, editActionsForRowAt: IndexPath) -> [UITableViewRowAction]?`
    * 델리게이트에게 지정된 행의 스와이프에 대한 응답으로 표시할 액션을 요청한다.
* `func tableView(UITableView, accessoryButtonTappedForRowWith: IndexPath)`
    * 델리게이트에게 지정된 행과 연관된 액세서리(디스클로저) 뷰를 사용자가 탭한 것을 알린다.


### Managing Selections
> 선택 항목 관리

* `func tableView(UITableView, willSelectRowAt: IndexPath) -> IndexPath?`
    * 지정된 행이 선택되고 있음을 델리게이트에게 알린다.
* `func tableView(UITableView, didSelectRowAt: IndexPath)`
    * 지정된 행이 현재 선택되었다고 델리게이트에게 알린다.
* `func tableView(UITableView, willDeselectRowAt: IndexPath) -> IndexPath?` 
    * 지정된 행의 선택을 해제하려 한다고 델리게이트에게 알린다.
* `func tableView(UITableView, didDeselectRowAt: IndexPath)`
    * 지정된 행의 선택이 해제되었음을 델리게이트에게 알린다.


### Modifying the Header and Footer of Sections
> 섹션의 헤더와 푸터 수정

* `func tableView(UITableView, viewForHeaderInSection: Int) -> UIView?`
    * 테이블 뷰의 지정된 섹션의 헤더에 표시할 뷰 객체에 대해 델리게이트에 요청한다.
* `func tableView(UITableView, viewForFooterInSection: Int) -> UIView?`
    * 테이블 뷰의 지정된 섹션의 푸터에 표시할 뷰 객체에 대해 델리게이트에 요청한다.
* `func tableView(UITableView, heightForHeaderInSection: Int) -> CGFloat`
    * 특정 섹션의 헤더에 사용할 높이에 대해 델리게이트에게 요청한다.
* `func tableView(UITableView, estimatedHeightForHeaderInSection: Int) -> CGFloat`
    * 특정 섹션의 헤더의 예상 높이를 델리게이트에게 요청한다.
* `func tableView(UITableView, heightForFooterInSection: Int) -> CGFloat`
    * 특정 섹션의 푸터에 사용할 높이에 대해 델리게이트에게 요청한다.
* `func tableView(UITableView, estimatedHeightForFooterInSection: Int) -> CGFloat`
    * 특정 섹션의 푸터의 예상 높이를 델리게이트에게 요청한다.
* `func tableView(UITableView, willDisplayHeaderView: UIView, forSection: Int)`
    * 지정된 섹션에 대해 헤더 뷰가 표시될 것임을 델리게이트에게 알린다.
* `func tableView(UITableView, willDisplayFooterView: UIView, forSection: Int)`
    * 지정된 섹션에 대해 푸터 뷰가 표시될 것임을 델리게이트에게 알린다.


### Editing Table Rows
> 테이블 행 편집

* `func tableView(UITableView, willBeginEditingRowAt: IndexPath)`
    * 테이블 뷰가 편집 모드로 전환 될 것을 델리게이트에게 알린다.
* `func tableView(UITableView, didEndEditingRowAt: IndexPath?)`
    * 테이블 뷰가 편집 모드를 떠났다는 것을 델리게이트에게 알린다.
* `func tableView(UITableView, editingStyleForRowAt: IndexPath) -> UITableViewCell.EditingStyle`
    * 테이블 뷰의 특정 위치에서 행의 편집 스타일에 대해 델리게이트에게 요청한다.
* `func tableView(UITableView, titleForDeleteConfirmationButtonForRowAt: IndexPath) -> String?`
    * 삭제-확인 버튼의 기본 타이틀을 변경한다.
* `func tableView(UITableView, shouldIndentWhileEditingRowAt: IndexPath) -> Bool`
    * 테이블 뷰가 편집 모드에 있는 동안 지정된 행의 백그라운드가 들여 쓰기되어야 하는지 여부를 델리게이트에게 요청한다.


### Reordering Table Rows
> 테이블 행 재정렬

* `func tableView(UITableView, targetIndexPathForMoveFromRowAt: IndexPath, toProposedIndexPath: IndexPath) -> IndexPath`
    * 델리게이트에게 새 인덱스 경로를 반환하여 제안된 행 이동 대상을 다시 지정하도록 한다.
    

### Tracking the Removal of Views
> 뷰 제거 추적

* `func tableView(UITableView, didEndDisplaying: UITableViewCell, forRowAt: IndexPath)`
    * 지정된 셀이 테이블에서 제거되었음을 델리게이트에게 알린다.
* `func tableView(UITableView, didEndDisplayingHeaderView: UIView, forSection: Int)`
    * 지정된 헤더 뷰가 테이블에서 제거되었음을 델리게이트에게 알린다.
* `func tableView(UITableView, didEndDisplayingFooterView: UIView, forSection: Int)`
    * 지정된 푸터 뷰가 테이블에서 제거되었음을 델리게이트에게 알린다.
    

### Copying and Pasting Row Content
> 행 콘텐츠 복사 및 붙여 넣기

* `func tableView(UITableView, shouldShowMenuForRowAt: IndexPath) -> Bool`
    * 특정 행에 대해 편집 메뉴가 표시되어야 하는 경우 델리게이트에게 요청한다.
* `func tableView(UITableView, canPerformAction: Selector, forRowAt: IndexPath, withSender: Any?) -> Bool`
    * 편집 메뉴가 지정된 행에 대해 복사 또는 붙여 넣기 명령을 생략해야 하는 경우 델리게이트에게 요청한다.
* `func tableView(UITableView, performAction: Selector, forRowAt: IndexPath, withSender: Any?)`
    * 지정된 행의 내용에 대해 복사 또는 붙여 넣기 작업을 수행하도록 델리게이트에게 지시한다.


### Managing Table View Highlighting
> 테이블 뷰 강조 표시 관리

* `func tableView(UITableView, shouldHighlightRowAt: IndexPath) -> Bool`
    * 지정된 행을 강조 표시해야 하는 경우 델리게이트에게 요청한다.
* `func tableView(UITableView, didHighlightRowAt: IndexPath)`
    * 지정된 행이 강조 표시되어졌음을 델리게이트에게 알린다.
* `func tableView(UITableView, didUnhighlightRowAt: IndexPath)`
    * 특정 인덱스 경로의 행에서 강조 표시가 제거되었다고 델리게이트에게 알린다.


### Managing Table View Focus
> 테이블 뷰 포커스 관리

* `func tableView(UITableView, canFocusRowAt: IndexPath) -> Bool`
    * 지정된 인덱스 경로에 있는 셀 자체에 포커스가 있는지 여부를 델리게이트에게 요청한다.
* `func tableView(UITableView, shouldUpdateFocusIn: UITableViewFocusUpdateContext) -> Bool`
    * 컨텍스트에서 지정된 포커스 업데이트가 발생할 수 있는지 여부를 델리게이트에게 요청한다.
* `func tableView(UITableView, didUpdateFocusIn: UITableViewFocusUpdateContext, with: UIFocusAnimationCoordinator)`
    * 컨텍스트에 의해 지정된 포커스 업데이트가 방금 발생했음을 델리게이트에게 알린다.
* `func indexPathForPreferredFocusedView(in: UITableView) -> IndexPath?`
    * 델리게이트에게 기본 포커스 뷰의 테이블 뷰 인덱스 경로를 요청한다.


### Handling Swipe Actions
> 스와이프 액션 처리

* `func tableView(UITableView, leadingSwipeActionsConfigurationForRowAt: IndexPath) -> UISwipeActionsConfiguration?`
    * 행의 리딩(왼쪽) 가장자리에 표시할 스와이프 액션을 반환한다. 
* `func tableView(UITableView, trailingSwipeActionsConfigurationForRowAt: IndexPath) -> UISwipeActionsConfiguration?`
    * 행의 트레일링(오른쪽) 가장자리에 표시할 스와이프 액션을 반환한다.


&nbsp; 
## Relationships
### Inherits From
* NSObjectProtocol, UIScrollViewDelegate


### Adopted By
* UITableViewController


&nbsp; 
## See Also
### Customizing the Table View Behavior
* `var delegate: UITableViewDelegate?`


&nbsp;      
&nbsp;      
### [by. 0junChoi](https://github.com/0jun0815) email: <0jun0815@gmail.com>
### [Apple Developer Documentation UITableViewDelegate](https://developer.apple.com/documentation/uikit/uitableviewdelegate)
