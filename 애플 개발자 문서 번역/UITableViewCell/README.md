# UITableViewCell
> 테이블 뷰의 셀.


* [Overview](#overview)
* [Topic](#topic)
    * [Initializing a UITableViewCell Object](#initializing-a-uitableviewcell-object)
    * [Reusing Cells](#reusing-cells)
    * [Managing the Predefined Content](#managing-the-predefined-content)
    * [Accessing Views of the Cell Object](#accessing-views-of-the-cell-object)
    * [Managing Accessory Views](#managing-accessory-views)
    * [Managing Cell Selection and Highlighting](#managing-cell-selection-and-highlighting)
    * [Editing the Cell](#editing-the-cell)
    * [Dragging the Row](#dragging-the-row)
    * [Adjusting to State Transitions](#adjusting-to-state-transitions)
    * [Managing Content Indentation](#managing-content-indentation)
    * [Managing Focus](#managing-focus)
    * [Constants](#constants)
* [Relationships](#relationships)
* [See Also](#see-also)


&nbsp;      
## Overview
이 클래스에는 셀 콘텐츠와 백그라운드(텍스트, 이미지 및 커스텀 뷰 포함) 설정 및 관리, 셀 선택 및 강조 표시 상태 관리, 액세서리 뷰 관리 및 셀 콘텐츠 편집 시작을 위한 프로퍼티와 메서드가 포함되어 있다.


셀을 만들 때 직접 셀을 커스터마이징 하거나 미리 정의 된 여러 스타일 중 하나를 사용할 수 있다. 미리 정의 된 셀 스타일은 가장 간단한 옵션이다. 미리 정의 된 스타일을 사용하여 셀은 위치와 스타일이 고정 된 레이블 및 이미지 서브 뷰를 제공한다. 고정된 뷰에 들어가기 위해 텍스트 및 이미지 콘텐츠를 제공하기만 하면 된다. 미리 정의 된 스타일로 셀을 사용하려면 [init(style:reuseIdentifier:)](https://developer.apple.com/documentation/uikit/uitableviewcell/1623276-init) 메서드를 사용하여 초기화하거나 Xcode에서 해당 스타일로 셀을 구성한다. 셀의 텍스트와 이미지를 설정하려면 [textLabel](https://developer.apple.com/documentation/uikit/uitableviewcell/1623210-textlabel), [detailTextLabel](https://developer.apple.com/documentation/uikit/uitableviewcell/1623273-detailtextlabel) 및 [imageView](https://developer.apple.com/documentation/uikit/uitableviewcell/1623270-imageview) 프로퍼티를 사용한다.


미리 정의된 스타일을 벗어나고 싶다면 셀의 [contentView](https://developer.apple.com/documentation/uikit/uitableviewcell/1623229-contentview) 프로퍼티에 서브 뷰를 추가할 수 있다. 서브 뷰를 추가 할 때 뷰를 배치하고 자신의 콘텐츠를 설정해야 한다.


미리 정의된 셀을 사용하든 사용자 정의 셀을 사용하든 관계없이 [backgroundView](https://developer.apple.com/documentation/uikit/uitableviewcell/1623260-backgroundview) 프로퍼티를 사용하거나 상속 된 [backgroundColor](https://developer.apple.com/documentation/uikit/uiview/1622591-backgroundcolor) 프로퍼티를 변경하여 셀의 백그라운드를 변경할 수 있다. iOS 7에서는 기본적으로 셀 백그라운드가 흰색이다. 이전 버전의 iOS에서 셀은 둘러싼 테이블 뷰의 백그라운드 컬러를 상속한다. 셀의 백그라운드 컬러를 변경하려면 테이블 뷰 델리게이트의 [tableView(_:willDisplay:forRowAt:)](https://developer.apple.com/documentation/uikit/uitableviewdelegate/1614883-tableview) 메서드를 사용한다. 


&nbsp;      
## Topic
### Initializing a UITableViewCell Object
> UITableViewCell 객체 초기화

* `init(style: UITableViewCell.CellStyle, reuseIdentifier: String?)`
    * 스타일 및 재사용 식별자로 표 셀을 초기화하고 호출자에게 반환한다.
* `init?(coder: NSCoder)`


### Reusing Cells
> 셀 재사용

* `var reuseIdentifier: String?`
    * 재사용 가능한 셀을 식별하는 데 사용되는 문자열.
* `func prepareForReuse()`
    * 테이블 뷰의 델리게이트가 재사용 할 수 있도록 재사용 가능한 셀을 준비한다.


### Managing the Predefined Content
> 사전 정의 된 콘텐츠 관리

* `var textLabel: UILabel?`
    * 테이블 셀의 주요 텍스트 콘텐츠에 사용 된 레이블을 반환한다.
* `var detailTextLabel: UILabel?`
    * 테이블 셀이있는 경우 테이블 셀의 보조 레이블을 반환한다.
* `var imageView: UIImageView?`
    * 테이블 셀의 이미지 뷰를 반환한다.


### Accessing Views of the Cell Object
> 셀 객체의 뷰에 접근

* `var contentView: UIView`
    * 셀 객체의 콘텐츠 뷰를 반환한다.
* `var backgroundView: UIView?`
    * 뷰는 셀의 백그라운드로 사용된다.
* `var selectedBackgroundView: UIView?`
    * 셀을 선택한 경우 셀의 백그라운드로 사용되는 뷰.
* `var multipleSelectionBackgroundView: UIView?`
    * 테이블 뷰에서 여러 행을 선택할 수 있는 경우 선택한 셀에 사용할 백그라운드 뷰이다.


### Managing Accessory Views
> 액세서리 뷰 관리

* `var accessoryType: UITableViewCell.AccessoryType`
    * 셀이 사용해야 하는 표준 액세서리 뷰의 타입(일반 상태).
* `var accessoryView: UIView?`
    * 일반적으로 셀의 오른쪽에서 컨트롤로 사용되는 뷰 이다(일반 상태).
* `var editingAccessoryType: UITableViewCell.AccessoryType`
    * 셀의 테이블 뷰의 편집 상태로 사용하는 표준 액세서리 뷰의 타입이다.
* `var editingAccessoryView: UIView?`
    * 일반적으로 편집 모드에 있을 때 셀 오른쪽의 컨트롤로 사용되는 뷰이다.


### Managing Cell Selection and Highlighting
> 셀 선택 및 강조 표시 관리

* `var isSelected: Bool`
    * 셀이 선택되었는지 여부를 나타내는 부울 값.
* `var selectionStyle: UITableViewCell.SelectionStyle`
    * 셀 선택 스타일.
* `func setSelected(Bool, animated: Bool)`
    * 셀의 선택 상태를 설정한다. 선택적으로 상태 간 전환을 애니메이션으로 표시한다.
* `var isHighlighted: Bool`
    * 셀이 강조 표시되는지 여부를 나타내는 부울 값.
* `func setHighlighted(Bool, animated: Bool)`
    * 셀의 강조 표시 상태를 설정하고 선택적으로 상태 간 전환 효과를 애니메이션으로 표시한다.


### Editing the Cell
> 셀 편집

* `var isEditing: Bool`
    * 셀이 편집 가능한 상태인지 여부를 나타내는 부울 값.
* `func setEditing(Bool, animated: Bool)`
    * 리시버를 편집 모드로 전환 또는 해제한다.
* `var editingStyle: UITableViewCell.EditingStyle`
    * 셀의 편집 스타일.
* `var showingDeleteConfirmation: Bool`
    * 셀이 현재 삭제-확인 버튼을 표시하는지 여부를 반환한다.
* `var showsReorderControl: Bool`
    * 셀에 재정렬 컨트롤이 표시되는지 여부를 결정하는 부울 값.


### Dragging the Row 
> 행 드래그

* `var userInteractionEnabledWhileDragging: Bool`
    * 드래그되는 동안 사용자가 셀과 상호 작용할 수 있는지 여부를 나타내는 부울 값.
* `func dragStateDidChange(UITableViewCell.DragState)`
    * 드래그 상태가 변경되었음을 셀에 알린다.
* `enum UITableViewCell.DragState`
    * 드래그 작업에 관련된 행의 현재 상태를 나타내는 상수.


### Adjusting to State Transitions
> 상태 전환 조정

* `func willTransition(to: UITableViewCell.StateMask)`
    * 셀 상태간에 전환되기 직전에 셀에서 호출된다.
* `func didTransition(to: UITableViewCell.StateMask)`
    * 셀 상태간에 전환 한 직후에 셀에서 호출된다.


### Managing Content Indentation
> 콘텐츠 들여 쓰기 관리

* `var indentationLevel: Int`
    * 셀 콘텐츠의 들여 쓰기 레벨.
* `var indentationWidth: CGFloat`
    * 셀 콘텐츠의 각 들여 쓰기 수준의 너비이다.
* `var shouldIndentWhileEditing: Bool`
    * 테이블 뷰가 편집 모드일 때 셀 백그라운드가 들여 쓰기되는지 여부를 제어하는 부울 값.
* `var separatorInset: UIEdgeInsets`
    * 셀의 콘텐츠에 대한 인셋 값.


### Managing Focus
> 포커스 관리

* `var focusStyle: UITableViewCell.FocusStyle`
    * 포커스를 맞출 때 셀의 모양.


### Constants
* `enum UITableViewCell.CellStyle`
    * 다양한 스타일의 셀에 대한 열거형.
* `enum UITableViewCell.SelectionStyle`
    * 선택된 셀의 스타일.
* `enum UITableViewCell.EditingStyle`
    * 셀에서 사용하는 편집 컨트롤.
* `enum UITableViewCell.AccessoryType`
    * 셀에 사용되는 표준 액세서리 컨트롤의 타입.
* `struct UITableViewCell.StateMask`
    * 상태간에 전환 할 때 셀의 새 상태를 결정하는 데 사용되는 상수.
* `enum UITableViewCell.SeparatorStyle`
    * 구분 기호로 사용되는 셀의 스타일.
* `enum UITableViewCell.FocusStyle`
    * 포커스된 셀의 스타일.


&nbsp; 
## Relationships
### Inherits From
* UIView


### Conforms To
* CVarArg
* Equatable
* Hashable
* NSCoding
* UIAccessibilityIdentification
* UIGestureRecognizerDelegate
* UIPasteConfigurationSupporting
* UIUserActivityRestoring


&nbsp; 
## See Also
### Rows
* class UISwipeActionsConfiguration
* class UIContextualAction
* class UITableViewRowAction
* enum UIContextualAction.Style
* [Creating Self-Sizing Table View Cells](https://developer.apple.com/documentation/uikit/uifont/creating_self_sizing_table_view_cells)


&nbsp;      
&nbsp;      
### [by. 0junChoi](https://github.com/0jun0815) email: <0jun0815@gmail.com>
### [Apple Developer Documentation UITableViewCell](https://developer.apple.com/documentation/uikit/uitableviewcell)
