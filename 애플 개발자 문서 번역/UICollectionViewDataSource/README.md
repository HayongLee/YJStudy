# 을
> UICollectionViewDataSource 프로토콜을 채택한 객체는 컬렉션 뷰에 필요한 데이터 및 뷰를 제공한다. 데이터 소스 객체는 앱의 데이터 모델을 나타내며 필요에 따라 컬렉션 뷰에 정보를 제공한다. 또한 데이터를 표시하기 위해 컬렉션 뷰에서 사용되는 셀 및 보충 뷰의 작성 및 구성을 처리한다.


* [Overview](#overview)
* [Topics](#topics)
    * [Getting Item and Section Metrics](#getting-item-and-section-metrics)
    * [Getting Views for Items](#getting-views-for-items)
    * [Reordering Items](#reordering-items)
    * [Configuring an Index](#configuring-an-index)
* [Relationships](#relationships)
* [See Also](#see-also)


&nbsp;    
## Overview
최소한 모든 데이터 소스 객체는 [contentView(_:numberOfItemsInSection:)](https://developer.apple.com/documentation/uikit/uicollectionviewdatasource/1618058-collectionview) 및 [conllectionView(_:cellForItemAt:)](https://developer.apple.com/documentation/uikit/uicollectionviewdatasource/1618029-collectionview) 메서드를 구현해야 한다. 이러한 메서드는 컬렉션 뷰의 아이템 수와 아이템 자체를 반환한다. 프로토콜의 나머지 메서드는 선택적이며 컬렉션 뷰가 아이템을 여러 섹션으로 구성하거나 주어진 섹션에 대해 헤더와 푸터를 제공하는 경우에만 필요하다.


컬렉션 뷰 객체를 구성 할 때 데이터 소스를 [dataSource](https://developer.apple.com/documentation/uikit/uicollectionview/1618091-datasource) 프로퍼티에 할당한다. 컬렉션 뷰가 데이터 소스와 함께 작동하며 콘텐츠를 표시하는 방법에 대한 자세한 내용은 [UICollectionView](https://developer.apple.com/documentation/uikit/uicollectionview)를 참조.


&nbsp;      
## Topics
### Getting Item and Section Metrics
> 아이템 및 섹션 메트릭 얻기

* `func collectionView(UICollectionView, numberOfItemsInSection: Int) -> Int`
    * 데이터 소스 객체에 지정된 섹션에 있는 아이템 수를 요청한다. **필수**
* `func numberOfSections(in: UICollectionView) -> Int`
    * 데이터 소스 객체에 컬렉션 뷰의 섹션 수를 요청한다.


### Getting Views for Items
> 아이템 뷰 얻기

* `func collectionView(UICollectionView, cellForItemAt: IndexPath) -> UICollectionViewCell`
    * 데이터 소스 객체에 컬렉션 뷰의 지정된 아이템에 해당하는 셀을 요청한다. **필수**
* `func co을lectionView(UICollectionView, viewForSupplementaryElementOfKind: String, at: IndexPath) -> UICollectionReusableView`
    * 데이터 소스 객체에 컬렉션 뷰에 표시 할 보충 뷰를 제공하도록 요청한다.
    

### Reordering Items
> 아이템 재정렬

* `func collectionView(UICollectionView, canMoveItemAt: IndexPath) -> Bool`
    * 지정된 아이템을 컬렉션 뷰의 다른 위치로 이동할 수 있는지 여부를 데이터 소스 객체에 확인한다.
* `func collectionView(UICollectionView, moveItemAt: IndexPath, to: IndexPath)`
    * 데이터 소스 객체에 지정된 아이템을 새 위치로 이동하도록 지시한다.
    

### Configuring an Index
> 인덱스 구성

* `func indexTitles(for: UICollectionView) -> [String]?`
    * 컬렉션 뷰에 표시 할 인덱스 아이템의 제목을 반환하도록 데이터 소스에 요청한다.
* `func collectionView(UICollectionView, indexPathForIndexTitle: String, at: Int) -> IndexPath`
    * 인덱스 아이템 중 하나에 해당하는 컬렉션 뷰 아이템의 인덱스 경로를 반환하도록 데이터 소스에 요청한다.


&nbsp;      
## Relationships
### Inherits From
* NSObjectProtocol


### Adopted By
* UICollectionViewController


&nbsp;      
## See Also
### Providing the Collection View Data
* var dataSource: UICollectionViewDataSource?
* protocol UICollectionViewDataSourcePrefetching


&nbsp;      
&nbsp;      
### [by. 0junChoi](https://github.com/0jun0815) email: <0jun0815@gmail.com>
### [Apple Developer Documentation UICollectionViewDataSource](https://developer.apple.com/documentation/uikit/uicollectionviewdatasource)
