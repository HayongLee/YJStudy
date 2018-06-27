# UICollectionViewDelegateFlowLayout
> UICollectionViewDelegateFlowLayout 프로토콜은 [UICollectionViewFlowLayout](https://developer.apple.com/documentation/uikit/uicollectionviewflowlayout) 객체와 함께 조정할 수 있는 메서드를 정의하여 그리드 기반 레이아웃을 구현한다. 이 프로토콜의 메서드는 아이템의 크기와 그리드의 아이템 사이의 간격을 정의한다.


* [Overview](#overview)
* [Topics](#topics)
    * [Getting the Size of Items](#getting-the-size-of-items)
    * [Getting the Section Spacing](#getting-the-section-spacing)
    * [Getting the Header and Footer Sizes](#getting-the-header-and-footer-sizes)
* [Relationships](#relationships)


&nbsp;    
## Overview
이 프로토콜의 모든 메서드는 선택 사항이다. 특정 메서드를 구현하지 않으면, 플로우 레이아웃 델리게이트는 적절한 간격 정보에 대해 자체 프로퍼티 값을 사용한다.


플로우 레이아웃 객체는 컬렉션 뷰의 델리게이트 객체가 이 프로토콜을 채택할 것으로 기대한다. 따라서 컬렉션 뷰의 delegate 프로퍼티에 할당 된 객체에 이 프로토콜을 구현한다.


&nbsp;      
## Topics
### Getting the Size of Items
> 아이템 크기 얻기

* `func collectionView(UICollectionView, layout: UICollectionViewLayout, sizeForItemAt: IndexPath) -> CGSize`
    * 델리게이트에게 지정된 아이템 셀의 크기를 요청한다.


### Getting the Section Spacing
> 섹션 간격 얻기

* `func collectionView(UICollectionView, layout: UICollectionViewLayout, insetForSectionAt: Int) -> UIEdgeInsets`
    * 델리게이트에게 지정된 섹션의 콘텐츠에 적용 할 여백을 요청한다.
* `func collectionView(UICollectionView, layout: UICollectionViewLayout, minimumLineSpacingForSectionAt: Int) -> CGFloat`
    * 델리게이트에게 섹션의 연속되는 행이나 열 사이의 간격을 요청한다.
* `func collectionView(UICollectionView, layout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt: Int) -> CGFloat`
    * 델리게이트에게 섹션의 행 또는 열에 있는 연속적인 아이템 사이의 간격을 요청한다.
    

### Getting the Header and Footer Sizes
> 헤더와 푸터 크기 얻기

* `func collectionView(UICollectionView, layout: UICollectionViewLayout, referenceSizeForHeaderInSection: Int) -> CGSize`
    * 지정된 섹션에서 헤더 뷰의 크기에 대해 델리게이트에게 요청한다.
* `func collectionView(UICollectionView, layout: UICollectionViewLayout, referenceSizeForFooterInSection: Int) -> CGSize`
    * 지정된 섹션에서 푸터 뷰의 크기에 대해 델리게이트에게 요청한다.


&nbsp;      
## Relationships
### Inherits From
* UICollectionViewDelegate


&nbsp;      
&nbsp;      
### [by. 0junChoi](https://github.com/0jun0815) email: <0jun0815@gmail.com>
### [Apple Developer Documentation UICollectionViewDelegateFlowLayout](https://developer.apple.com/documentation/uikit/uicollectionviewdelegateflowlayout)
