# UICollectionViewCell
> 해당 아이템이 컬렉션 뷰의 가시 범위 내에 있는 단일 데이터 아이템이다.


* [Overview](#overview)
* [Topics](#topics)
    * [Accessing the Cell’s Views](#accessing-the-cells-views)
    * [Managing the Cell’s State](#managing-the-cells-state)
    * [Managing Drag State Changes](#managing-drag-state-changes)
* [Relationships](#relationships)
* [See Also](#see-also)


&nbsp;    
## Overview
UICollectionViewCell을 그대로 사용하거나 서브클래싱하여 추가 프로퍼티나 메서드를 추가할 수 있다. 셀의 레이아웃과 표현은 컬렉션 뷰와 해당 레이아웃 객체에 의해 관리된다.


셀의 모양(appearance)을 구성하려면 데이터 아이템의 콘텐츠를 서브 뷰로 표시하는 데 필요한 뷰를 [contentView](https://developer.apple.com/documentation/uikit/uicollectionviewcell/1620133-contentview) 프로퍼티의 뷰에 추가한다. 셀 자체에 직접 서브 뷰를 추가하면 안된다. 셀은 여러 개의 콘텐츠 레이어를 관리하며 그 중 콘텐츠 뷰는 하나뿐이다. 콘텐츠 뷰 외에도 셀은 셀을 선택된 상태와 선택되지 않은 상태로 표시하는 두 개의 백그라운드 뷰를 관리한다.


일반적으로 이 클래스의 인스턴스는 직접 만들지 않는다. 대신 특정 셀 서브 클래스(또는 클래스의 구성된 인스턴스가 포함 된 nib 파일)를 컬렉션 뷰 객체에 등록한다. 셀 클래스의 새 인스턴스를 원하면 컬렉션 뷰 객체의 [dequeueReusableCell(withReuseIdentifier:for:)](https://developer.apple.com/documentation/uikit/uicollectionview/1618063-dequeuereusablecell) 메서드를 호출하여 컬렉션 클래스 객체를 가져온다. 


&nbsp;      
## Topics
### Accessing the Cell’s Views
> 셀의 뷰에 접근

* `var contentView: UIView`
    * 셀의 커스텀 콘텐츠를 추가 할 메인 뷰이다.
* `var backgroundView: UIView?`
    * 셀의 다른 콘텐츠 뒤에 표시되는 뷰이다.
* `var selectedBackgroundView: UIView?`
    * 셀을 선택하면 백그라운드 뷰 바로 위에 표시되는 뷰이다.
    

### Managing the Cell’s State
> 셀의 상태 관리

* `var isSelected: Bool`
    * 셀의 선택 상태.
* `var isHighlighted: Bool`
    * 셀의 강조 표시 상태.
    

### Managing Drag State Changes
> 드래그 상태 변화 관리

* `func dragStateDidChange(UICollectionViewCell.DragState)`
    * 셀의 드래그 상태가 변경되면 호출된다.
* `enum UICollectionViewCell.DragState`
    * 드래그 조작의 현재 상태를 나타내는 상수이다.


&nbsp;      
## Relationships
### Inherits From
* UICollectionReusableView


### Conforms To
* CVarArg
* Equatable
* Hashable
* UIAccessibilityIdentification
* UIPasteConfigurationSupporting
* UIUserActivityRestoring


&nbsp;      
## See Also
### Cells
* class UICollectionReusableView


&nbsp;      
&nbsp;      
### [by. 0junChoi](https://github.com/0jun0815) email: <0jun0815@gmail.com>
### [Apple Developer Documentation UICollectionViewCell](https://developer.apple.com/documentation/uikit/uicollectionviewcell)
