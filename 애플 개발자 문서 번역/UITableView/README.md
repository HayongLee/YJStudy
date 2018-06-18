# UITableView
> 단일 열에 정렬된 행을 사용하여 데이터를 표시하는 뷰


* [Overview](#overview)
* [State Preservation](#state-preservation)
* [Topic](#topic)
    * [Initializing a UITableView Object](#initializing-a-uitableview-object)
    * [Providing the Table View Data](#providing-the-table-view-data)
    * [Customizing the Table View Behavior](#customizing-the-table-view-behavior)
    * [Configuring a Table View](#configuring-a-table-view)
    * [Creating Table View Cells](#creating-table-view-cells)
    * [Accessing Header and Footer Views](#accessing-header-and-footer-views)
    * [Accessing Cells and Sections](#accessing-cells-and-sections)
    * [Estimating Element Heights](#estimating-element-heights)
    * [Scrolling the Table View](#scrolling-the-table-view)
    * [Managing Selections](#managing-selections)
    * [Inserting, Deleting, and Moving Rows and Sections](#inserting-deleting-and-moving-rows-and-sections)
    * [Managing Drag Interactions](#managing-drag-interactions)
    * [Managing Drop Interactions](#managing-drop-interactions)
    * [Managing the Editing of Table Cells](#managing-the-editing-of-table-cells)
    * [Reloading the Table View](#reloading-the-table-view)
    * [Accessing Drawing Areas of the Table View](#accessing-drawing-areas-of-the-table-view)
    * [Prefetching Data](#prefetching-data)
    * [Configuring the Table Index](#configuring-the-table-index)
    * [Managing Focus](#managing-focus)
    * [Constants](#constants)
    * [Notifications](#notifications)
    * [Instance Properties](#instance-properties)
* [Relationships](#relationships)
* [See Also](#see-also)




&nbsp;      
## Overview
테이블 뷰는 항목의 목록을 단일 열에 표시한다. UITableView는 [UIScrollView](https://developer.apple.com/documentation/uikit/uiscrollview)의 하위 클래스로, 사용자가 테이블을 스크롤 할 수 있지만 UITableView는 수직 스크롤만 허용한다. 테이블의 개별 항목을 구성하는 셀은 [UITableViewCell](https://developer.apple.com/documentation/uikit/uitableviewcell) 객체이다. UITableView는 이러한 객체를 사용하여 테이블의 보이는 행을 그린다. 셀의 콘텐츠는 타이틀과 이미지가 있으며 오른쪽 가장자리 근처에 액세서리 뷰가 있다. 표준 액세서리 뷰는 디스클로저 인디케이터 또는 디테일 디스클로저 버튼이다. 전자는 데이터 계층에서 다음 단계로 이어지고 후자는 선택한 항목에 대해 디테일 뷰로 연결된다. 액세서리 뷰는 스위치 및 슬라이더와 같은 프레임워크 컨트롤일 수도 있고 사용자 정의 뷰일 수도 있다. 테이블 뷰는 사용자가 테이블의 행을 삽입, 삭제 및 재정렬 할 수 있는 편집 모드로 들어갈 수 있다.


테이블 뷰는 0개 이상의 섹션으로 구성되며 각 섹션에는 자체 행이 있다. 섹션은 테이블 뷰 내의 인덱스 번호로 식별되며 행은 섹션 내의 인덱스 번호로 식별된다. 모든 섹션은 선택적으로 섹션 헤더로 시작될 수 있으며 선택적으로 섹션 푸터가 뒤에 올 수 있다.


테이블 뷰는 [UITableView.Style.plain]()과 [UITableView.Style.grouped]()의 두 가지 스타일 중 하나를 가질 수 있다. UITableView 인스턴스를 만들 때 테이블 스타일을 지정해야 하며 이 스타일을 변경할 수 없다. plain 스타일에서는 전체 섹션의 일부가 보이는 경우 섹션 헤더와 푸터가 콘텐츠 위에 떠있게 된다. 테이블 뷰에는 표의 오른쪽에 막대 모양으로 나타나는 인덱스가 있다(예: "A"에서 "Z"까지). 특정 라벨을 터치하여 대상 섹션으로 이동할 수 있다. grouped 스타일에서는 모든 셀의 기본 백그라운드 컬러와 기본 백그라운드 뷰를 제공한다. 백그라운드 뷰는 특정 섹션의 모든 셀에 대한 시각적 그룹화를 제공한다. 예를 들어, 한 그룹은 개인의 이름과 제목, 그 사람이 사용하는 전화 번호를 위한 또 다른 그룹, 이메일 계정을 위한 또 다른 그룹 등이 될 수 있다. 그룹화된 테이블의 예는 설정 애플리케이션을 참조한다. grouped 스타일의 테이블뷰는 인덱스(표의 오른쪽에 막대 모양으로 나타나는)를 가질 수 없다.


UITableView의 많은 메서드는 [NSIndexPath](https://developer.apple.com/documentation/foundation/nsindexpath) 객체를 매개변수 및 반환 값으로 사용한다. UITableView는 NSIndexPath에서 표현된 행 인덱스([row](https://developer.apple.com/documentation/foundation/nsindexpath/1614853-row) 프로퍼티) 및 섹션 인덱스([section](https://developer.apple.com/documentation/foundation/nsindexpath/1528298-section) 프로퍼티)를 가져오고 지정된 행 인덱스 및 섹션 인덱스 ([init(row:section:)](https://developer.apple.com/documentation/foundation/nsindexpath/1614934-init)) 메서드에서 인덱스 경로를 구성할 수 있는 카테고리를 선언한다.


UITableView 객체에는 데이터 소스 역할을하는 객체와 델리게이트 역할을하는 객체가 있어야한다. 일반적으로 이러한 객체는 애플리케이션 델리게이트 또는 사용자 정의 [UITableViewController](https://developer.apple.com/documentation/uikit/uitableviewcontroller) 객체이다. 데이터 소스는 [UITableViewDataSource](https://developer.apple.com/documentation/uikit/uitableviewdatasource) 프로토콜을 채택해야 하며 델리게이트는 [UITableViewDelegate](https://developer.apple.com/documentation/uikit/uitableviewdelegate) 프로토콜을 채택해야 한다. 데이터 소스는 UITableView가 테이블을 생성하고 테이블 행을 삽입, 삭제 또는 재정렬 할 때 데이터 모델을 관리해야 한다는 정보를 제공한다. 델리게이트는 테이블 행 구성 및 선택, 행 순서 변경, 강조 표시, 액세서리 뷰 및 편집 조작을 관리한다.


[setEditing(_:animated:)](https://developer.apple.com/documentation/uikit/uitableview/1614876-setediting) 메시지를 보내면(첫 번째 매개 변수는 true), 테이블 뷰는 각 연관된 UITableViewCell의 [editingStyle](https://developer.apple.com/documentation/uikit/uitableviewcell/1623234-editingstyle)에 따라 각 보이는 행의 편집 또는 재정렬 제어를 보여주는 편집 모드로 들어간다. 삽입 또는 삭제 컨트롤을 클릭하면 데이터 소스가 [tableView(_:commit:forRowAt:)](https://developer.apple.com/documentation/uikit/uitableviewdatasource/1614871-tableview) 메시지를 받는다. [deleteRows(at:with:)](https://developer.apple.com/documentation/uikit/uitableview/1614960-deleterows) 또는 [insertRows(at:with:)](https://developer.apple.com/documentation/uikit/uitableview/1614879-insertrows)를 적절하게 호출하여 삭제 또는 삽입을 커밋한다. 또한 편집 모드에서 테이블 뷰 셀의 [showsReorderControl](https://developer.apple.com/documentation/uikit/uitableviewcell/1623243-showsreordercontrol) 프로퍼티가 true로 설정된 경우 데이터 소스는 [tableView(_:moveRowAt:to:)](https://developer.apple.com/documentation/uikit/uitableviewdatasource/1614867-tableview) 메시지를 받는다. 데이터 소스는 [tableView(_:canMoveRowAt:)](https://developer.apple.com/documentation/uikit/uitableviewdatasource/1614927-tableview)을 구현하여 셀의 재정렬 제어를 선택적으로 제거할 수 있다.


UITableView는 보이는 행에 대해 테이블 뷰 셀을 캐시한다. 기본 셀과 다른 콘텐츠 또는 동작 특성을 사용하여 사용자 지정 [UITableViewCell](https://developer.apple.com/documentation/uikit/uitableviewcell) 객체를 만들 수 있다. [A Closer Look at Table View Cells](https://developer.apple.com/library/archive/documentation/UserExperience/Conceptual/TableView_iPhone/TableViewCells/TableViewCells.html#//apple_ref/doc/uid/TP40007451-CH7)에 방법이 설명돼 있다.


UITableView는 UIView의 [layoutSubviews()](https://developer.apple.com/documentation/uikit/uiview/1622482-layoutsubviews) 메서드를 재정의하여 UITableView의 새 인스턴스를 만들거나 새 데이터 소스를 할당할 때만 reloadData()를 호출한다. 테이블 뷰를 다시 로드하면 현재 선택을 포함하여 현재 상태가 지워진다. 그러나 [reloadData()](https://developer.apple.com/documentation/uikit/uitableview/1614862-reloaddata)를 명시적으로 호출하면 상태가 지워지고 layoutSubview()에 대한 이후의 모든 직접 또는 간접 호출이 리로드를 트리거하지 않는다.


&nbsp;
## State Preservation
테이블 뷰의 [restorationIdentifier](https://developer.apple.com/documentation/uikit/uiviewcontroller/1621499-restorationidentifier) 프로퍼티에 값을 할당하면 현재 선택된 행과 첫 번째 표시된 행이 보존된다. 테이블의 데이터 소스는 [UIDataSourceModelAssociation](https://developer.apple.com/documentation/uikit/uidatasourcemodelassociation) 프로토콜을 채택할 수 있다. 이 프로토콜은 테이블의 해당 행의 위치와 관계없이 행의 내용을 식별할 수 있는 방법을 제공한다. 테이블의 데이터 소스가 [UIDataSourceModelAssociation](https://developer.apple.com/documentation/uikit/uidatasourcemodelassociation) 프로토콜을 채택하면 상태를 저장할 때 데이터 소스가 참조되어 맨 위의 보이는 행과 선택된 셀의 인덱스 경로를 식별자로 변환한다. 복원 중 데이터 소느는 해당 식별자를 다시 인덱스 경로로 변환하고 맨 위의 보이는 행을 다시 설정하고 셀을 다시 선택하는데 사용된다. 테이블의 데이터 소스가 [UIDataSourceModelAssociation](https://developer.apple.com/documentation/uikit/uidatasourcemodelassociation) 프로토콜을 구현하지 않으면 스크롤 위치가 저장되고 선택된 셀의 인덱스 경로를 마찬가지로 직접 복원된다.


상태 보존 및 복원의 작동 방식에 대한 자세한 내용은 [App Programming Guide for iOS](https://developer.apple.com/library/archive/documentation/iPhone/Conceptual/iPhoneOSProgrammingGuide/Introduction/Introduction.html#//apple_ref/doc/uid/TP40007072)를 참조.


&nbsp;      
## Topic
### Initializing a UITableView Object
> UITableView 객체 초기화

* `init(frame: CGRect, style: UITableView.style)`
    * 주어진 프레임 및 스타일을 갖는 테이블 뷰 객체를 초기화하고 반환한다.
* `init?(coder: NSCoder)`


### Providing the Table View Data
> 테이블 뷰 데이터 제공

* `var dataSource: UITableViewDataSource?`
    * 테이블 뷰의 데이터 소스로 사용되는 객체이다.
* `protocol UITableViewDataSource`
    * UITableViewDataSource 프로토콜은 UITableView에 대한 애플리케이션의 데이터 모델을 조정하는 객체에서 사용된다. 데이터 소스는 테이블 뷰를 생성하고 수정하는데 필요한 정보를 테이블 뷰 객체에 제공한다.
* `protocol UITableViewDataSourcePrefetching`
    * 비동기 데이터 로드 작업의 트리거를 허용하는 테이블 뷰에 대한 데이터 요구 사항의 사전 경고를 제공하는 프로토콜이다.


### Customizing the Table View Behavior
> 테이블 뷰 동작 사용자 정의

* `var delegate: UITableViewDelegate?`
    * 테이블 뷰 델리게이트 역할을하는 객체이다.
* `protocol UITableViewDelegate`
    * UITableView 객체의 델리게이트는 UITableViewDelegate 프로토콜을 채택해야 한다. 프로토콜의 옵셔널 메서드를 사용하여 델리게이트가 선택 사항을 관리하고, 셀을 삭제하고 순서를 변경하는 등의 작업을 수행할 수 있다.


### Configuring a Table View
> 테이블 뷰 구성

* `var style: UITableView.Style`
    * 테이블 뷰의 스타일을 반환한다.
* `func numberOfRows(inSection: Int) -> Int`
    * 지정된 섹션의 행(테이블 셀) 수를 반환한다.
* `var numberOfSections: Int`
    * 테이블 뷰의 섹션 수이다.
* `var rowHeight: CGFloat`
    * 테이블 뷰의 각 행(즉, 테이블 셀)의 높이이다.
* `var separatorStyle: UITableViewCell.SeparatorStyle`
    * 구분 기호로 사용되는 테이블 셀의 스타일이다.
* `var separatorColor: UIColor?`
    * 테이블 뷰에서 구분 기호 행의 색상이다.
* `var separatorEffect: UIVisualEffect?`
    * 테이블 구분 기호에 적용되는 효과이다.
* `var backgroundView: UIView?`
    * 테이블 뷰의 백그라운드 뷰.
* `var separatorInset: UIEdgeInsets`
    * 셀 구분 기호의 기본 인셋을 지정한다.
* `var separatorInsetReference: UITableView.separatorInsetReference`
    * 구분 기호 인셋 값을 해석하는 방법을 나타내는 인디케이터.
* `enum UITableView.SeparatorInsetReference`
    * 테이블 뷰의 구분 기호의 인셋 값을 해석하는 방법을 나타내는 상수.
* `var cellLayoutMarginsFollowReadableWidth: Bool`
    * 셀 여백이 읽을 수 있는 콘텐츠 가이드의 너비에서 파생되는지 여부를 나타내는 부울 값이다.
    

### Creating Table View Cells
> 테이블 뷰 셀 생성

* `func register(UINib?, forCellReuseIdentifier: String)`
    * 셀을 포함하는 nib 객체를 지정된 식별자 아래에 테이블 뷰에 등록한다.
* `func register(AnyClass?, forCellReuseIdentifier: String)`
    * 새 테이블 셀을 만드는데 사용할 클래스를 등록한다.
* `func dequeueReusableCell(withIdentifier: String, for: IndexPath)`
    * 지정된 재사용 식별자에 대한 재사용 가능한 테이블 뷰 셀 객체를 반환하고 이를 테이블에 추가한다.
* `func dequeueReusableCell(withIdentifier: String) -> UITableViewCell?`
    * 식별자로 지정된 재사용 가능한 테이블 뷰 셀 객체를 반환한다.


### Accessing Header and Footer Views
> 해더 및 푸터 뷰 접근

* `func register(UINib?, forHeaderFooterViewReuseIdentifier: String)`
    * 헤더 또는 푸터를 포함하는 nil 객체를 지정된 식별자 아래의 테이블 뷰에 등록한다.
* `func register(AnyClass?, forHeaderFooterViewReuseIdentifier: String)`
    * 새로운 테이블 헤더 또는 푸터 뷰를 만드는데 사용할 클래스를 등록한다.
* `func dequeueReusableHeaderFooterView(withIdentifier: String) -> UITableViewHeaderFooterView?`
    * 식별자로 찾아 볼 수 있는 재사용 가능한 헤더 또는 푸터 뷰를 반환한다.
* `var tableHeaderView: UIView?`
    * 테이블 위에 표시되는 액세서리 뷰를 반환한다.
* `var tableFooterView: UIView?`
    * 테이블 아래에 표시되는 액세서리 뷰를 반환한다.
* `var sectionHeaderHeight: CGFloat`
    * 테이블 뷰의 섹션 헤더의 높이
* `var sectionFooterHeight: CGFloat`
    * 테이블 뷰의 섹션 푸터의 높이
* `func headerView(forSection: Int) -> UITableViewHeaderFooterView?`
    * 지정된 섹션에 관련된 헤더 뷰를 반환한다.
* `func footerView(forSection: Int) -> UITableViewHeaderFooterView?`
    * 지정된 섹션에 관련된 푸터 뷰를 반환한다.


### Accessing Cells and Sections
> 셀 및 섹션 접근

* `func cellForRow(at: IndexPath) -> UITableViewCell?`
    * 지정된 인덱스 경로에 있는 테이블 셀을 반환한다.
* `func indexPath(for: UITableViewCell) -> IndexPath?`
    * 주어진 테이블 뷰 셀의 행과 섹션을 나타내는 인덱스 경로를 반환한다.
* `func indexPathForRow(at: CGPoint) -> IndexPath?`
    * 주어진 포인트의 행과 섹션을 식별하는 인덱스 경로를 반환한다.
* `func indexPathsForRows(in: CGRect) -> [IndexPath]?`
    * 주어진 구형으로 둘러싸인 행을 나타내는 인덱스 경로의 배열이다.
* `var visibleCells: [UITableViewCell]`
    * 테이블 뷰에 표시되는 테이블 셀이다.
* `var indexPathsForVisibleRows: [IndexPath]?`
    * 테이블 뷰에서 보이는 행을 식별하는 인덱스 경로의 배열이다.


### Estimating Element Heights
> 요소 높이 추정

* `var estimatedRowHeight: CGFloat`
    * 테이블 뷰에서 예상되는 행 높이이다.
* `var estimatedSectionHeaderHeight: CGFloat`
    * 테이블 뷰에서 섹션 헤더의 예상 높이이다.
* `var estimatedSectionFooterHeight: CGFloat`
    * 테이블 뷰에서 섹션 푸터의 예상 높이이다.


### Scrolling the Table View
> 테이블 뷰 스크롤

* `func scrollToRow(at: IndexPath, at: UITableView.ScrollPosition, animated: Bool)`
    * 인덱스 경로로 식별된 행이 화면의 특정 위치에 있을 때까지 테이블 뷰를 스크롤한다.
* `func scrollToNearestSelectedRow(at: UITableView.ScrollPosition, animated: Bool)`
    * 테이블 뷰에서 지정된 위치에 가장 가까운 선택된 행이 해당 위치에 있도록 테이블 뷰를 스크롤한다.


### Managing Selections
> 선택 항목 관리

* `var indexPathForSelectedRow: IndexPath?`
    * 선택된 행의 행과 섹션을 식별하는 인덱스 경로
* `var indexPathsForSelectedRows: [IndexPath]?`
    * 선택된 행을 나타내는 인덱스 경로
* `func selectRow(at: IndexPath?, animated: Bool, scrollPosition: UITableView.ScrollPosition)`
    * 인덱스 경로로 식별되는 테이블 뷰에서 행을 선택하고, 선택적으로 행을 테이블 뷰의 위치로 스크롤한다.
* `func deselectRow(at: IndexPath, animated: Bool)`
    * 선택 해제를 애니메이션화하는 옵션을 사용하여 인덱스 경로로 식별된 행의 선택을 취소한다.
* `var allowsSelection: Bool`
    * 사용자가 행을 선택할 수 있는지 여부를 결정하는 부울 값.
* `var allowsMultipleSelection: Bool`
    * 사용자가 편집 모드 외부에서 둘 이상의 행을 선택할 수 있는지 여부를 결정하는 부울 값.
* `var allowsSelectionDuringEditing: Bool`
    * 테이블 뷰가 편집 모드에 있는 동안 셀을 선택할 수 있는지 여부를 결정하는 부울 값.
* `var allowsMultipleSelectionDuringEditing: Bool`
    * 사용자가 편집 모드에서 둘 이상의 셀을 동시에 선택할 수 있는지 여부를 제어하는 부울 값.


### Inserting, Deleting, and Moving Rows and Sections
> 행 및 섹션 삽입, 삭제 및 이동

* `func insertRows(at: [IndexPath], with: UITableView.RowAnimation)`
    * 삽입을 애니메이션화하는 옵션을 사용하여 인덱스 경로 배열로 식별되는 위치에 테이블 뷰에 행을 삽입한다.
* `func deleteRows(at: [IndexPath], with: UiTableView.RowAnimation)`
    * 삭제를 애니메이션화하는 옵션을 사용하여 인덱스 경로 배열로 지정된 행을 삭제한다.
* `fun moveRow(at: IndexPath, to: IndexPath)`
    * 지정된 위치에 있는 행을 목적 위치로 이동한다.
* `func insertSections(IndexSet, with: UITableView.RowAnimation)`
    * 삽입을 애니메이션화하는 옵션과 함께 테이블 뷰에 하나 이상의 섹션을 삽입한다.
* `func deleteSections(IndexSet, with: UITableView.RowAnimation)`
    * 테이블 뷰에서 삭제를 애니메이션화하는 옵션을 사용하여 하나 이상의 섹션을 삭제한다.
* `func moveSection(Int, toSection: Int)`
    * 섹션을 테이블 뷰의 새 위치로 이동한다.
* `func performBatchUpdates((() -> Void)?, completion: ((Bool) -> Void)? = nil)`
    * 여러 삽입, 삭제, 리로드 및 이동 작업을 그룹으로 애니메이션 처리한다.
* `func beginUpdates()`
    * 테이블 뷰의 행 및 섹션을 삽입, 삭제 또는 선택하는 일련의 메서드 호출을 시작한다.
* `func endUpdates()`
    * 테이블 뷰의 행 및 섹션을 삽입, 삭제, 선택 또는 리로드 하는 일련의 메서드 호출을 완료한다.


### Managing Drag Interactions
> 드래그 상호 작용 관리

* `var dragDelegate: UITableViewDragDelegate?`
    * 테이블 뷰에서 항목 드래그를 관리하는 델리게이트 객체이다.
* `protocol UITableViewDragDelegate`
    * 테이블 뷰로부터 드래그를 개시하기 위한 인터페이스이다.
* `var hasActiveDrag: Bool`
    * 테이블 뷰에서 행을 들어 올리고 아직 놓지 않았는지 여부를 나타내는 부울 값.
* `var dragInteractionEnabled: Bool`
    * 테이블 뷰가 앱 간의 드래그 앤 드롭을 지원하는지 여부를 나타내는 부울 값.


### Managing Drop Interactions
> 드롭 상호 작용 관리

* `var dropDelegate: UITableViewDropDelegate?`
    * 테이블 뷰에 콘텐츠를 드롭하는데 사용되는 델리게이트 객체이다.
* `protocol UITableViewDropDelegate`
    * 테이블 뷰에서 드롭 처리를 위한 인터페이스
* `var hasActiveDrop: Bool`


### Managing the Editing of Table Cells
> 테이블 셀의 편집 관리

* `var isEditing: Bool`
    * 테이블 뷰가 편집 모드에 있는지 여부를 결정하는 부울 값
* `func setEditing(Bool, animated: Bool)`
    * 테이블 뷰를 편집 모드로 전환하거나 해제한다.


### Reloading the Table View
> 테이블 뷰 리로드

* `var hasUncommittedUpdates: Bool`
    * 테이블 뷰에 드롭 placeholder가 포함되는지, 드롭을 처리할 때 행의 순서가 바뀌는지를 나타내는 부울 값.
* `func reloadData()`
    * 테이블 뷰의 행과 섹션을 리로드한다.
* `func reloadRows(at: [IndexPath], with: UITableView.RowAnimation)`
    * 애니메이션 효과를 사용하여 지정된 행을 리로드한다.
* `func reloadSections(IndexSet, with: UITableView.RowAnimation)`
    * 주어진 애니메이션 효과를 사용하여 지정된 섹션을 리로드한다.
* `func reloadSectionIndexTitles()`
    * 인덱스 바의 항목을 테이블 뷰의 오른쪽에 리로드한다.


### Accessing Drawing Areas of the Table View
> 테이블 뷰의 드로잉 영역 접근

* `func rect(forSection: Int) -> CGRect`
    * 테이블 뷰의 지정된 섹션에 대한 드로잉 영역을 반환한다.
* `func rectForRow(at: IndexPath) -> CGRect`
    * 인덱스 경로에 의해 식별되는 행의 드로잉 영역을 반환한다.
* `func rectForFooter(inSection: Int) -> CGRect`
    * 지정된 섹션의 푸터에 대한 드로잉 영영을 반환한다.
* `func rectForHeader(inSection: Int) -> CGRect`
    * 지정된 섹션의 헤더에 대한 드로잉 영영을 반환한다.


### Prefetching Data
> 데이터 프리 페치

테이블 뷰가 값 비싼 데이터 로딩 프로세스에 의존하는 경우 표시하기 전에 데이터를 프리페치하여 사용자 경험을 향상시킬 수 있다. [UITableViewDataSourcePrefetching](https://developer.apple.com/documentation/uikit/uitableviewdatasourceprefetching) 프로토콜을 준수하는 객체를 [prefetchDataSource](https://developer.apple.com/documentation/uikit/uitableview/1771763-prefetchdatasource) 프로퍼티에 할당하여 셀의 데이터를 미리 가져올 때의 알림을 받는다.

* `var prefetchDataSource: UITableViewDataSourcePrefetching?`
    * 다가오는 셀 데이터 요구 사항에 대한 알림을 수신하여 테이블 뷰의 프리페치 데이터 소스로 작동하는 객체이다.


### Configuring the Table Index
> 테이블 인덱스 구성

* `var sectionIndexMinimumDisplayRowCount: Int`
    * 테이블의 오른쪽 가장자리에 인덱스 목록에 표시할 테이블 행 수이다.
* `var sectionIndexColor: UIColor?`
    * 테이블 뷰의 인덱스 텍스트에 사용할 색상이다.
* `var sectionIndexBackgroundColor: UIColor?`
    * 터치되지 않는 동안 테이블 뷰의 섹션 인덱스 배경에 사용할 컬러이다.
* `var sectionIndexTrackingBackgroundColor: UIColor?`
    * 테이블 뷰의 인덱스 백그라운드 영역에 사용할 컬러이다.


### Managing Focus
> 포커스 관리

* `var remembersLastFocusedIndexPath: Bool`
    * 테이블 뷰가 마지막으로 포커스가 있는 인덱스 경로에서 셀에 자동으로 포커스를 반환해야 하는지 여부를 나타내는 부울 값.


### Constants
* `enum UITableView.Style`
    * 테이블 뷰의 스타일.
* `enum UITableView.ScrollPosition`
    * 지정된 행이 스크롤되는 테이블 뷰(상단, 중앙, 하단)의 위치.
* `enum UITableView.RowAnimation`
    * 행을 삽입하거나 삭제할 때의 애니메이션 타입.
* [Section Index Icons]()
    * 테이블 뷰의 섹션 인덱스에 아이콘이 표시되도록 요청한다.
* [Default 수]()
    * 지정된 치수의 기본값이다.
    

### Notifications
* `class let selectionDidChangeNotification: NSNotification.Name`
    * 테이블 뷰에서 선택한 행이 변경되면 게시된다.


### Instance Properties
* `var insetsContentViewsToSafeArea: Bool`


&nbsp; 
## Relationships
### Inherits From
* UIScrollView


### Conforms To
* CVarArg
* Equatable
* Hashable
* NSCoding
* UIAccessibilityIdentification
* UIDataSourceTranslating
* UIPasteConfigurationSupporting
* UISpringLoadedInteractionSupporting
* UIUserActivityRestoring


&nbsp; 
## See Also
### View
* class UITableViewController
* class UITableViewFocusUpdateContext
* class UILocalizedIndexedColleation


&nbsp;      
&nbsp;      
### [by. 0junChoi](https://github.com/0jun0815) email: <0jun0815@gmail.com>
### [UITableView](https://developer.apple.com/documentation/uikit/uitableview)
