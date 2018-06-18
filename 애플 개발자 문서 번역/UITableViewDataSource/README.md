# UITableViewDataSource
> UITableViewDataSource 프로토콜은 UITableView 객체에 대한 애플리케이션의 데이터 모델을 조정하는 객체에서 사용된다. 데이터 소스는 테이블 뷰를 생성하고 수정하는데 필요한 정보를 테이블 뷰 객체에 제공한다.


* [Overview](#overview)
* [Topic](#topic)
* [Relationships](#relationships)
* [See Also](#see-also)


&nbsp;      
## Overview
데이터 모델의 대리자로서, 데이터 소스는 테이블 뷰의 외관에 대한 최소한의 정보를 제공한다. 테이블 뷰 객체의 델리게이트([UITableViewDelegate](https://developer.apple.com/documentation/uikit/uitableviewdelegate) 프로토콜을 사용하는 객체)는 해당 정보를 제공한다. 


프로토콜의 필수 메서드는 테이블 뷰에 의해 표시될 셀을 제공하고 UITableView 객체에 각 섹션의 섹션 수 및 행 수를 알린다. 데이터 소스는 테이블 뷰의 다양한 측면을 구성하고 행을 삽입, 삭제 및 재정렬하는 선택적 메서드를 구현할 수 있다.


> **Note**
>
> 사용자가 행에서 가로로 스와이프하여 삭제 버튼을 표시하는 테이블 뷰의 스와이프-삭제 기능을 사용하려면 [tableView(_:commit:forRowAt:)](https://developer.apple.com/documentation/uikit/uitableviewdatasource/1614871-tableview) 메서드를 구현해야 한다.


많은 메서드가 [NSIndexPath](https://developer.apple.com/documentation/foundation/nsindexpath) 객체를 매개 변수로 사용한다. UITableView는 NSIndexPath에서 표현된 행 인덱스([row](https://developer.apple.com/documentation/foundation/nsindexpath/1614853-row) 프로퍼티) 및 섹션 인덱스([section](https://developer.apple.com/documentation/foundation/nsindexpath/1528298-section) 프로퍼티)를 가져오고 지정된 행 인덱스 및 섹션 인덱스([init(row:section:) class 메서드](https://developer.apple.com/documentation/foundation/nsindexpath/1614934-init))에서 인덱스 경로를 구성할 수 있는 카테고리를 선언한다. 각 인덱스 경로의 첫 번째 인덱스는 섹션을 식별하고 다음 인덱스는 행을 식별한다. 


&nbsp;      
## Topic
### Configuring a Table View
> 테이블 뷰 구성

* `func tableView(UITableView, cellForRowAt: IndexPath) -> UITableViewCell`
    * 셀이 테이블 뷰의 특정 위치에 삽입되도록 데이터 소스에 요청한다. **필수 사항**
* `func numberOfSections(in: UITableView) -> Int`
    * 테이블 뷰의 섹션 수를 반환하도록 데이터 소스에 요청한다.
* `func tableView(UITableView, numberOfRowsInSection: Int) -> Int`
    * 테이블 뷰의 지정된 섹션에서 행 수를 반환하도록 데이터 소스에 지시한다. **필수 사항**
* `func tableView(UITableView, titleForHeaderInSection: Int) -> String?`
    * 테이블 뷰의 지정된 섹션의 헤더 타이틀에 대해 데이터 소스에 요청한다.
* `func tableView(UITableView, titleForFooterInSection: Int) -> String?`
    * 테이블 뷰의 지정된 섹션의 푸터 타이틀에 대해 데이터 소스에 요청한다.


### Inserting or Deleting Table Rows
> 테이블 행 삽입 또는 삭제

* `func tableView(UITableView, commit: UITableViewCell.EditingStyle, forRowAt: IndexPath)`
    * 데이터 소스에 리시버의 지정된 행을 삽입하거나 삭제하도록 요청한다.
* `func tableView(UITableView, canEditRowAt: IndexPath) -> Bool`
    * 데이터 소스에 지정된 행이 편집 가능한지 확인을 요청한다.


### Reordering Table Rows
> 테이블 행 재정렬

* `func tableView(UITableView, canMoveRowAt: IndexPath) -> Bool`
    * 지정된 행을 테이블 뷰의 다른 위치로 이동할 수 있는지 여부를 데이터 소스에 요청한다.
* `func tableView(UITableView, moveRowAt: IndexPath, to: IndexPath)`
    * 테이블 뷰의 특정 위치에 있는 행을 다른 위치로 이동하도록 데이터 소스에 지시한다.


### Configuring an Index
> 인덱스 구성

* `func sectionIndexTitles(for: UITableView) -> [String]?`
    * 테이블 뷰의 섹션들의 타이틀을 반환하도록 데이터 소스에 요청한다.
* `func tableView(UITableView, sectionForSectionIndexTitle: String, at: Int) -> Int`
    * 주어진 타이틀과 섹션 타이틀 인덱스를 가진 섹션의 인덱스를 반환하도록 데이터 소스에 요청한다.


&nbsp; 
## Relationships
### Inherits From
* NSObjectProtocol


### Adopted By
* UITableViewController


&nbsp; 
## See Also
### Providing the Table View Data
* `var dataSource: UITableViewDataSource?`
* `protocol UITableViewDataSourcePrefetching`


&nbsp;      
&nbsp;      
### [by. 0junChoi](https://github.com/0jun0815) email: <0jun0815@gmail.com>
### [Apple Developer Documentation UITableViewDataSource](https://developer.apple.com/documentation/uikit/uitableviewdatasource)
