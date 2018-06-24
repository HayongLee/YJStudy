# PhotoKit
> iCould 사진 라이브러리 및 라이브 포토의 사진을 포함하여 사진 앱으로 관리되는 이미지 및 동영상 에셋으로 작업한다. 전체 크기의 에셋 또는 미리보기(썸네일) 이미지를 비동기적으로 가져오고 캐시하고, 콘텐츠을 수정하고, 수정본을 여러 장치에 동기화한다.


* [Overview](#overview)
* [Features and Concepts](#features-and-concepts)
* [Creating Photo Editing Extensions](#creating-photo-editing-extensions)
* [Displaying Live Photos](#displaying-live-photos)
* [Topics](#topics)
    * [Interacting with the Photos Library](#interacting-with-the-photos-library)
    * [Retrieving and Examining Assets](#retrieving-and-examining-assets)
    * [Loading Asset Content](#loading-asset-content)
    * [Displaying Live Photos](#displaying-live-photos)
    * [Requesting Changes](#requesting-changes)
    * [Editing Asset Content](#editing-asset-content)
    * [Observing Changes](#observing-changes)
    * [Working with Asset Resources](#working-with-asset-resources)
    * [Creating Photo Editing Extensions](#creating-photo-editing-extensions-1)
    * [Creating Photos Project Extensions](#creating-photos-project-extensions)


&nbsp;    
## Overview
iOS 및 macOS에서 PhotoKit은 Photos 앱의 사진 편집 확장 기능을 지원하는 클래스를 제공한다. iOS 및 tvOS에서 PhotoKit은 iCloud 사진 라이브러리를 포함하여 Photos 애플리케이션에서 관리하는 사진 및 비디오 에셋에 직접 접근할 수도 있다. 디스플레이 및 재생을 위해 에셋을 가져오고, 이미지 또는 비디오 콘텐츠를 편집하거나, 앨범, 순간(모멘트) 및 iCloud 공유 앨범과 같은 에셋 컬렉션으로 작업한다.


> Important
>
> 사용자는 앱에 사진 접근 권한을 명시적으로 부여해야한다. [PHAsset](https://developer.apple.com/documentation/photokit/phasset), [PHPhotoLibrary](https://developer.apple.com/documentation/photokit/phphotolibrary) 및 [PHImageManager](https://developer.apple.com/documentation/photokit/phimagemanager)와 같은 Photos 라이브러리와 상호 작용하는 클래스를 사용하려면 애플리케이션의 info.plit에 사용자에게 허가 여부를 묻는 메시지가 표시될 때 [NSPhotoLibraryUsageDescription](https://developer.apple.com/library/archive/documentation/General/Reference/InfoPlistKeyReference/Articles/CocoaKeys.html#//apple_ref/doc/plist/info/NSPhotoLibraryUsageDescription) 키에 대한 사용자 지향 텍스트가 포함되어야한다.


&nbsp;    
## Features and Concepts
PhotoKit에는 사용자의 Photos 라이브러리에서 직접 작업할 수 있는 다양한 기능이 포함되어 있다.
#### 객체를 가져오고 변경을 요청한다. 
모델 클래스([PHAsset](https://developer.apple.com/documentation/photokit/phasset), [PHAssetCollection](https://developer.apple.com/documentation/photokit/phassetcollection) 및 [PHCollectionList](https://developer.apple.com/documentation/photokit/phcollectionlist))의 인스턴스는 Photos 애플리케이션에서 에셋(이미지, 동영상, 라이브 사진), 에셋의 컬렉션(앨범 또는 순간) 및 컬렉션의 목록(앨범 폴더 또는 순간 클러스터)이다. 이러한 객체는 읽기 전용으로 변경 불가능하며 메타 데이터만 포함한다.


관심있는 데이터를 가져와서 해당 객체를 사용하여 작업해야 하는 데이터를 가져오고 에셋 및 컬렉션 작업을 수행할 수 있다. 변경 요청을 하려면 변경 요청 객체를 만들고 이를 공유 [PHPhotoLibrary](https://developer.apple.com/documentation/photokit/phphotolibrary) 객체에 명시적으로 커밋한다. 이 아키텍처를 사용하면 여러 스레드 또는 여러 앱 및 앱 확장에서 동일한 에셋을 사용하여 쉽고 안전하며 효율적으로 작업할 수 있다.


#### 관찰을 변경한다.
가져온 에셋 및 컬렉션에 대한 변경 핸들러를 등록하려면 공유 [PHPhotoLibrary](https://developer.apple.com/documentation/photokit/phphotolibrary) 객체를 사용한다. Photos는 다른 앱이나 기기가 에셋의 콘텐츠나 메타 데이터 또는 컬렉션의 에셋 목록을 변경할 때마다 앱에 알려준다. [PHChange](https://developer.apple.com/documentation/photokit/phchange) 객체는 변경 사항 전후의 객체 상태에 대한 정보를 제공하여 객체를 쉽게 컬렉션 뷰 또는 유사한 인터페이스로 업데이트 할 수 있게 한다. 


#### Photos 앱 기능을 지원한다.
[PHCollectionList](https://developer.apple.com/documentation/photokit/phcollectionlist) 클래스를 사용하여 Photos 앱의 순간 계층에 해당하는 에셋을 찾는다. 버스트 사진, 파노라마 사진 및 높은 프레임 속도의 비디오를 식별하려면 [PHAsset](https://developer.apple.com/documentation/photokit/phasset) 클래스를 사용한다. iCloud 사진 라이브러리가 활성화되면 Photos 프레임 워크의 에셋과 컬렉션에는 동일한 iCloud 계정의 모든 장치에서 사용할 수 있는 콘텐츠가 반영된다.


#### 에셋 및 미리보기 이미지 로딩 및 캐싱.
[PHImageManager](https://developer.apple.com/documentation/photokit/phimagemanager) 클래스를 사용하여 지정된 크기로 에셋의 이미지를 요청하거나 AVFoundation 객체로 비디오 에셋을 사용할 수 있다. Photos 프레임 워크는 사양에 맞게 이미지를 자동으로 다운로드하거나 생성하여 빠른 재사용을 위해 캐싱한다. 예를 들어 컬렉션 뷰에 미리보기를 채우는 것과 같이 많은 수의 에셋을 가지고 더 빠른 성능을 얻으려면 [PHCachingImageManager](https://developer.apple.com/documentation/photokit/phcachingimagemanager) 서브 클래스가 대량 사전로딩을 추가한다.


#### 에셋 콘텐츠 편집.
[PHAsset](https://developer.apple.com/documentation/photokit/phasset) 및 [PHAssetChangeRequest](https://developer.apple.com/documentation/photokit/phassetchangerequest) 클래스는 편집을 위해 사진 또는 비디오 콘텐츠를 요청하고 Photos 라이브러리에 편집 콘텐츠를 커밋하는 메서드를 정의한다. 서로 다른 앱과 확장 기능 간의 편집 연속성을 지원하기 위해 Photos는 각 에셋의 현재 및 이전 버전을 마지막 편집을 설명하는 [PHAdjustmentData](https://developer.apple.com/documentation/photokit/phadjustmentdata) 객체와 함께 유지한다. 앱이 이전 편집에서 조정 데이터를 지원하는 경우 사용자가 편집을 되돌리거나 변경하도록 허용 할 수 있다.


iOS 및 macOS에서 PhotoKit은 Photos 애플리케이션에서 사용할 수 있도록 사진 편집 확장 프로그램을 개발할 때 사용할 수 있는 클래스를 제공한다. 확장의 주요 클래스는 [PHContentEditingController](https://developer.apple.com/documentation/photokit/phcontenteditingcontroller) 프로토콜을 채택해야 한다. Photos 앱 확장에 대한 자세한 내용은 [App Extension Programming Guide](https://developer.apple.com/library/archive/documentation/General/Conceptual/ExtensibilityPG/index.html#//apple_ref/doc/uid/TP40014214) 참조.


&nbsp;
## Creating Photo Editing Extensions
iOS 또는 macOS에서는 [PHContentEditingController](https://developer.apple.com/documentation/photokit/phcontenteditingcontroller) 프로토콜을 사용하여 Photos 앱에서 사진 편집 옵션과 기능을 추가하는 앱 확장을 만든다. 이러한 확장을 생성하려면 Photos 프레임 워크의 다음 클래스를 사용해야 한다.
* [PHContentEditingInput]() - 편집할 사진이나 비디오를 참조한다.
* [PHContentEditingOutput]() - 편집 결과 저장한다.
* [PHAdjustmentData]() - 편집 작업을 기술한다.


&nbsp;      
## Displaying Live Photos
[PHLivePhotoView](https://developer.apple.com/documentation/photokit/phlivephotoview) 클래스는 호환되는 하드웨어에서 촬영한 라이브 포토 캡쳐 직전과 직후 순간의 모션 및 사운드와 함께 표시하는 방법을 제공한다. 라이브 사진 뷰는 Photos 앱에 있는 것과 동일한 대화형 재생 기능을 제공한다.


iOS 및 tvOS에서 Photos 프레임 워크의 [PHLivePhoto](https://developer.apple.com/documentation/photokit/phlivephoto) 클래스로 라이브 사진 뷰에 표시하기 위해 라이브 사진 객체를 가져올 수 있다. macOS에서 [PHLivePhoto](https://developer.apple.com/documentation/photokit/phlivephoto) 클래스는 Photos 앱의 사진 편집 확장 프로그램에서 편집중인 라이브 사진에 대한 접근을 제공한다.


웹에 라이브 사진 콘텐츠를 표시하려면 [LivePhotosKit JS](https://developer.apple.com/documentation/livephotoskitjs) 프레임 워크를 사용한다.


&nbsp;      
## Topics
### Interacting with the Photos Library
> Photos 라이브러리와 상호 작용

공유 Photos 라이브러리 객체를 사용하여 Photos 콘텐츠에 접근하고, 에셋 및 컬렉션을 변경하고, Photos 라이브러리가 변경 될 때 전송된 업데이트 메시지에 등록하도록 앱의 사용자 권한을 얻는다. 
* `class PHPhotoLibrary`
    * 사용자의 Photos 라이브러리에 대한 접근 및 변경을 관리하는 공유 객체이다.
    

### Retrieving and Examining Assets
> 에셋 검색 및 검사

이 모델 클래스는 Photos 라이브러리의 콘텐츠(에셋 및 컬렉션)을 나타낸다. 이러한 클래스의 인스턴스는 읽기 전용으로 변경 불가능하며 메타 데이터만 포함한다. 에셋 및 컬렉션을 사용하려면 이 클래스를 사용하여 지정된 쿼리와 일치하는 객체 세트를 가져온다.
* `class PHAsset`
    * Photos 라이브러리의 이미지, 비디오 또는 라이브 사진 표현.
* `class PHAssetCollection`
    * 순간, 사용자가 만든 앨범 또는 스마트 앨범과 같은 Photos 에셋 그룹의 표현이다.
* `class PHCollection`
    * Photos 에셋 컬렉션 및 컬렉션 목록의 추상 슈퍼 클래스이다.
* `class PHCollectionList`
    * 순간 연도 또는 사용자가 만든 앨범의 폴더와 같은 Photos 에셋 컬렉션이 포함된 그룹의 표현이다.
* `class PHObject`
    * Photos 모델 객체(에셋 및 컬렉션)의 추상 슈퍼 클래스이다.
* `class PHFetchResult`
    * Photos fetch 메서드에서 반환된 에셋 또는 컬렉션의 정렬된 목록이다.
* `class PHFetchOptions`
    * 에셋 또는 컬렉션 객체를 가져올 때 Photos에서 반환하는 결과의 필터링, 정렬 및 관리에 영향을 주는 옵션의 세트.


### Loading Asset Content
> 에셋 콘텐츠 로딩

이 클래스를 사용하여 Photos 에셋과 관련된 이미지, 비디오 또는 라이브 사진 콘텐츠를 요청한다. Photos는 사양에 맞게 이미지를 자동으로 다운로드하거나 생성하여 빠른 재사용을 위해 캐싱한다. 대량의 에셋으로 더 빠른 성능을 낼 수 있도록 일괄적으로 미리 이미지를 요청할 수도 있다.
* `class PHImageManager`
    * 미리보기 및 Photos 에셋과 관련된 전체 크기의 이미지 또는 비디오 데이터를 검색하거나 생성하는 방법을 제공한다.
* `class PHCachingImageManager`
    * 대량의 에셋을 일괄적으로 미리 로딩하기 위해 최적화된 Photos 에셋과 관련된 미리보기 및 전체 크기 이미지 또는 비디오 데이터를 검색하거나 생성하는 메서드를 제공한다.
* `class PHImageRequestOptions`
    * 이미지 관리자가 요청한 Photos 에셋의 스틸 이미지 표현 제공에 영향을 주는 옵션 세트이다.
* `class PHVideoRequestOptions`
    * 이미지 관리자에서 요청한 동영상 에셋 데이터의 제공에 영향을 주는 옵션 세트이다.
* `class PHLivePhotoRequestOptions`
    * 이미지 관리자가 요청한 라이브 사진 에셋의 제공에 영향을 주는 옵션 세트이다.
* `class PHLivePhoto`
    * 캡처 직전과 직후 순간의 모션 및 사운드가 포함 된 라이브 사진의 표시 가능한 표현이다.


### Displaying Live Photos
> 라이브 사진 표시

* `class PHLivePhotoView`
    * PHLivePhotoView 객체는 캡처 직전과 직후 순간의 동작과 사운드가 포함 된 라이브 포토를 표시하는 뷰이다.


### Requesting Changes
> 변경 요청

에셋이나 컬렉션을 변경하려면 편집 내용을 설명하는 변경 요청 객체를 만들고 명시적으로 Photos 라이브러리에 커밋한다. 이 아키텍처를 사용하면 여러 스레드 또는 여러 앱 및  앱 확장에서 동일한 에셋을 사용하여 쉽고 안전하며 효율적으로 작업할 수 있다.
* `class PHAssetChangeRequest`
    * Photos 라이브러리 변경 블록에서 사용하기 위해 Photos 에셋의 콘텐츠 편집 또는 메타 데이터 생성, 삭제, 변경을 요청한다.
* `class PHAssetCollectionChangeRequest`
    * Photos 라이브러리 변경 블록에서 사용하기 위해 Photos 에셋 컬렉션을 생성, 삭제 또는 수정하라는 요청.
* `class PHCollectionListChangeRequest`
    * Photos 라이브러리 변경 블록에서 사용하기 위해 Photos 컬렉션 목록 생성, 삭제 또는 수정 요청.
* `class PHObjectPlaceholder`
    * 변경 요청으로 아직 생성되지 않은 사진 에셋 또는 컬렉션 객체를 나타내는 읽기 전용 프록시이다.


### Editing Asset Content
> 에셋 콘텐츠 편집

앱 또는 확장 프로그램에서 이러한 클래스를 사용하여 Photos 라이브러리 편집 및 커밋 편집을 위해 에셋 데이터에 접근한다. Photos는 각 편집 사항을 설명하는 여러 버전의 에셋 및 조정 데이터를 관리하므로 앱 또는 확장 프로그램을 사용하여 다른 기기에서도 이전에 편집한 내용을 되돌리거나 계속 사용할 수 있다.
* `class PHContentEditingInput`
    * 편집할 에셋의 이미지, 비디오 또는 라이브 사진 콘텐츠에 대한 정보와 접근 권한을 제공하는 컨테이너.
* `class PHContentEditingOutput`
    * Photos 에셋의 사진, 비디오 또는 라이브 사진 콘텐츠를 편집한 결과를 제공하는 컨테이너이다.
* `class PHAdjustmentData`
    * 앱의 이전 사진 편집 세션의 효과를 재구성하거나 되돌릴 수 있는 에셋의 사진, 동영상 또는 라이브 사진 콘텐츠에 대한 편집 사항에 대한 설명이다.
* `class PHContentEditingInputRequestOptions`
    * Photos 에셋의 콘텐츠를 편집하도록 요청할 때 이미지 또는 동영상 데이터 전송에 영향을 주는 옵션의 세트이다.
* `class PHLivePhotoEditingContext`
    * 라이브 사진의 사진, 비디오 및 오디오 내용을 수정하기 위한 편집 세션.
* `protocol PHLivePhotoFrame`
    * 편집 컨텍스트에서 라이브 사진의 단일 프레임에 대한 이미지 콘텐츠를 제공하는 컨테이너이다.


### Observing Changes
> 관찰 변경

Photos 앱의 다른 앱, 다른 기기 또는 코드가 컬렉션의 에셋 목록 또는 에셋의 메타 데이터 또는 콘텐츠를 변경할 때마다 앱에 알려준다. 이러한 객체는 변경 전후의 객체 상태에 대한 정보를 제공하므로 사용자 인터페이스를 쉽게 업데이트하여 일치시킬 수 있다.
* `protocol PHPhotoLibraryChangeObserver`
    * Photos 라이브러리에서 발생한 변경 사항을 알리기 위해 구현할 수 있는 포로토콜이다.
* `class PHChange`
    * Photos 라이브러리에서 발생한 변경 사항에 대한 설명이다.
* `class PHObjectChangeDetails`
    * 에셋 또는 컬렉션 객체에서 발생한 변경 사항에 대한 설명이다.
* `class PHFetchResultChangeDetails`
    * 페치 결과에 나열된 에셋 또는 컬렉션 객체 세트에서 발생한 변경 사항에 대한 설명이다.


### Working with Asset Resources
> 에셋 자원으로 작업
하나 이상의 에셋 자원 객체가 각 Photos 에셋의 기본 데이터 저장소를 나타낸다. 이러한 객체를 사용하여 에셋을 백업하고 복원하는 것과 같은 자원을 직접 사용할 수 있다.

* `class PHAssetResource`
    * Photos 라이브러리의 사진, 비디오 또는 라이브 사진 에셋과 관련된 기본 데이터 자원이다.
* `class PHAssetCreationRequest`
    * Photos 라이브러리 변경 블록에서 사용하기 위해 기본 데이터 리소스에서 새 Photos 에셋을 생성하라는 요청이다.
* `class PHAssetResourceCreationOptions`
    * 기본 자원에서 새 Photos 에셋을 만드는데 영향을 주는 옵션의 세트이다.
* `class PHAssetResourceManager`
    * Photos 에셋과 관련된 자원에 대한 기본 데이터 저장소에 접근하는 메서드를 제공한다.
* `class PHAssetResourceRequestOptions`
    * 에셋 자원 관리자 요청한 기본 에셋 데이터 전달에 영향을 주는 옵션의 세트이다.


### Creating Photo Editing Extensions
> 사진 편집 확장 기능 생성

* `protocol PHContentEditingController`
    * PHContentEditingController 프로토콜은 커스텀 뷰 컨트롤러 클래스에서 구현하는 메서드를 정의하여 Photos 확장을 만든다. Photos 앱은 확장 프로그램의 뷰 컨트롤러를 호스팅하여 사진 및 비디오 에셋을 편집 할 수 있는 사용자 인터페이스를 제공한다.
* `class PHEditingExtensionContext`


### Creating Photos Project Extensions
> Photos 프로젝트 확장 생성

* `class PHProject`
* `class PHProjectInfo`
* `class PHProjectElement`
* `class PHProjectAssetElement`
* `class PHProjectJournalEntryElement`
* `class PHProjectMapElement [Beta]`
* `class PHProjectTextElement`
* `class PHProjectSection`
* `class PHProjectSectionContent`
* `class PHProjectTypeDescription`
* `class PHProjectChangeRequest`
* `class PHCloudIdentifier`
* `class PHProjectExtensionContext`
* `class PHProjectRegionOfInterest`
* `protocol PHProjectExtensionController`
* `protocol PHProjectTypeDescriptionDataSource [Beta]`
* `protocol PHProjectTypeDescriptionInvalidator [Beta]`
* `struct PHProjectCategory [Beta]`
* `struct PHProjectRegionOfInterest.Identifier`
* `struct PHProjectType`


&nbsp;      
&nbsp;      
### [by. 0junChoi](https://github.com/0jun0815) email: <0jun0815@gmail.com>
### [Apple Developer Documentation PhotoKit](https://developer.apple.com/documentation/photokit)
