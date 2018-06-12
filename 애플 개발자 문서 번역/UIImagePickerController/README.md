# UIImagePickerController
> 사진을 찍고, 동영상을 녹화하고, 사용자의 미디어 라이브러리에서 항목 선택을 위한 시스템 인터페이스를 관리하는 뷰 컨트롤러


* [Overview](#overview)
* [Providing a Delegate Object](#providing-a-delegate-object)
* [Adjusting Flash Mode](#adjusting-flash-mode)
* [Working with Movies](#working-with-movies)
* [Working with Live Photos](#working-with-live-photos)
* [Fully-Customized Media Capture and Browsing](#fully--customized-media-capture-and-browsing)
* [Topics](#topics)
    * [Responding to Interactions with the Picker](#responding-to-interactions-with-the-picker)
    * [Setting the Picker Source](#setting-the-picker-source)
    * [Configuring the Picker](#configuring-the-picker)
    * [Configuring the Video Capture Options](#configuring-the-video-capture-options)
    * [Customizing the Camera Controls](#customizing-the-camera-controls)
    * [Capturing Still Images or Movies](#capturing-still-images-or-movies)
    * [Configuring the Camera to Use](#configuring-the-camera-to-use)
    * [Configuring the Camera Capture Mode](#configuring-the-camera-capture-mode)
    * [Configuring the Flash Behavior](#configuring-the-flash-behavior)
    * [Configuring the Export Presets](#configuring-the-export-presets)
* [Relationships](#relationships)
    * [Inherits From](#inherits-from)
    * [Conforms To](#conforms-to)
* [See Also](#see-also)    
    * [Images and Video](#images-and-video)
    

&nbsp;      
## Overview
이미지 피커 컨트롤러는 사용자 상호 작용을 관리하고 이러한 상호 작용의 결과를 델리게이트 객체에 전달한다. 이미지 피커 컨트롤러의 역할과 모양은 나타내기 전에 할당한 *소스 타입* 에 따라 다르다.
* 카메라의 [sourceType](https://developer.apple.com/documentation/uikit/uiimagepickercontroller/1619167-sourcetype?changes=_5)은 새 사진이나 동영상을 찍을 수 있는 사용자 인터페이스를 제공한다(미디어 캡처를 지원하는 장치에서).
* [photoLibrary](https://developer.apple.com/documentation/uikit/uiimagepickercontrollersourcetype/photolibrary?changes=_5) 또는 [savedPhotosAlbum](https://developer.apple.com/documentation/uikit/uiimagepickercontrollersourcetype/savedphotosalbum?changes=_5)의 sourceType은 저장된 사진 및 동영상 중에서 선택할 수 있는 사용자 인터페이스를 제공한다.


기본 컨트롤이 포함 된 이미지 피커 컨트롤러를 사용하려면 다음 단계를 수행한다:
1. 장치가 원하는 소스에서 컨텐츠를 선택할 수 있는지 확인한다. [UIImagePickerControllerSourceType](https://developer.apple.com/documentation/uikit/uiimagepickercontrollersourcetype?changes=_5) 열거형에서 제공하는 상수로 [isSourceTypeAvailable(_:)](https://developer.apple.com/documentation/uikit/uiimagepickercontroller/1619144-issourcetypeavailable?changes=_5) 클래스 메서드를 호출하여 이 작업을 수행한다.
2. [availableMediaTypes(for:)](https://developer.apple.com/documentation/uikit/uiimagepickercontroller/1619169-availablemediatypes?changes=_5) 클래스 메서드를 호출하여 사용중인 소스 타입에 사용할 수 있는 미디어 타입을 확인한다.
3. [mediaTypes](https://developer.apple.com/documentation/uikit/uiimagepickercontroller/1619173-mediatypes?changes=_5) 프로퍼티를 설정하여 사용 가능하게 만들 미디어 타입(스틸 이미지, 동영상 또는 둘 다)에 따라 UI를 조정하도록 이미지 피커 컨트롤러에 지시한다.
4. 사용자 인터페이스를 나타낸다. iPhone 또는 iPod touch에서 현재 활성화된 뷰 컨트롤러의 [present(_:animated:completion:)](https://developer.apple.com/documentation/uikit/uiviewcontroller/1621380-present?changes=_5) 메서드를 호출하여 모달(전체 화면)로 이 작업을 수행하고 구성된 이미지 피커 컨트롤러를 새 뷰 컨트롤러로 전달한다.


iPad에서 이미지 피커를 나타내는 올바른 방법은 이 표에 요약 된대로 소스 타입에 따라 다르다:


Camera | Photo Library | Saved Photos Album
------------ | ------------- | -------------
Use full screen | Must use a popover | Must use a popover


이 테이블은 iPad에서 [photoLibrary](https://developer.apple.com/documentation/uikit/uiimagepickercontrollersourcetype/photolibrary?changes=_5) 또는 [savedPhotosAlbum](https://developer.apple.com/documentation/uikit/uiimagepickercontrollersourcetype/savedphotosalbum?changes=_5)의 소스 타입을 지정하는 경우 팝오버 컨트롤러를 사용하여 이미지 피커를 나타내야 함을 보여준다(이를 수행하는 방법은 [UIPopoverPresentationController](https://developer.apple.com/documentation/uikit/uipopoverpresentationcontroller?changes=_5) 참조). 저장된 사진과 동영상 중에서 이미지 피커를 모달(전체 화면)으로 나타내려고 하면 시스템에서 예외가 발생한다.


iPad에서 카메라의 소스 타입을 지정하면 모달(전체 화면) 또는 팝 오버를 사용하여 이미지 피커를 나타낼 수 있다. 그러나 Apple은 카메라 인터페이스를 전체 화면으로만 나타낼 것을 권장한다.


5. 사용자가 버튼을 탭하여 새로 캡처한 이미지나 동영상을 선택하거나 작업을 취소하면 델리게이트 객체를 사용하여 이미지 피커를 닫는다. 새로 캡처한 미디어의 경우 델리게이트가 이를 장치의 카메라 롤에 저장할 수 있다. 이전에 저장한 미디어의 경우 델리게이트가 앱의 용도에 따라 이미지 데이터를 사용할 수 있다.


사용자 상호 작용을 직접 관리하기 위해 이미지 피커 컨트롤러를 사용자 정의할 수 있다. 이것을 하기 위해, 표시할 컨트롤이 들어있는 오버레이 뷰를 제공하고 [Capturing Still Images or Movies](https://developer.apple.com/documentation/uikit/uiimagepickercontroller#1658493)에 설명된 메서드를 사용한다. 기본 컨트롤에 추가하거나 기본 컨트롤 대신 사용자 지정 오버레이 뷰를 표시할 수 있다. UIImagePickerController 클래스의 사용자 정의 오버레이 뷰는 [cameraOverlayView](https://developer.apple.com/documentation/uikit/uiimagepickercontroller/1619113-cameraoverlayview?changes=_5) 프로퍼티를 통해 iOS 3.1 이상에서 사용할 수 있다. 코드 예를 보려면 [PhotoPicker: Using UIImagePickerController to Select Pictures and Take Photos](https://developer.apple.com/library/content/samplecode/PhotoPicker/Introduction/Intro.html#//apple_ref/doc/uid/DTS40010196) 샘플 코드 프로젝트를 참조한다.


> **Important**
>
> UIImagePickerController 클래스는 세로 모드만 지원한다. 이 클래스는 그대로 사용하도록 설계되어있어 서브 클래스화를 지원하지 않는다. 이 클래스의 뷰 계층 구조는 비공개이며 한 가지 예외를 제외하고는 수정해서는 안된다. 사용자 정의 뷰를 [cameraOverlayView](https://developer.apple.com/documentation/uikit/uiimagepickercontroller/1619113-cameraoverlayview?changes=_5) 프로퍼티에 할당하고 해당 뷰를 사용하여 추가 정보를 제공하거나 카메라 인터페이스와 코드 간의 상호 작용을 관리할 수 있다.


&nbsp;
## Providing a Delegate Object
이미지 피커 컨트롤러를 사용하려면 [UIImagePickerControllerDelegate](https://developer.apple.com/documentation/uikit/uiimagepickercontrollerdelegate?changes=_5) 프로토콜을 준수하는 델리게이트를 제공해야 한다. iOS 4.1부터 델리게이트를 사용하여 스틸 이미지 메타 데이터를 이미지와 함께 카메라 롤에 저장할 수 있다.


&nbsp;
## Adjusting Flash Mode
iOS 4.0 이상에서는 사용자가 플래시 모드(플래시 LED가 있는 장치)를 조정하고 사용할 카메라(앞면 및 뒷면 카메라가 있는 장치에서)를 선택하고 스틸 이미지와 동영상 캡처를 전환할 수 있도록 사용자 정의 컨트롤을 제공할 수 있다. 프로그래밍 방식으로 이러한 설정을 관리 할 수도 있다. 스트로브 라이트와 같은 효과를 제공하기 위해 플래시를 직접 조작할 수도 있다. 비디오 캡처 모드를 사용하도록 설정된 피커 인터페이스를 제공한다. 그런 다음 [cameraFlashMode](https://developer.apple.com/documentation/uikit/uiimagepickercontroller/1619124-cameraflashmode?changes=_5) 프로퍼티를 on 또는 off로 설정하여 플래시 LED를 켜거나 끈다. 


&nbsp;
## Working with Movies
동영상 캡처의 기본 재생 시간은 10분이지만 [videoMaximumDuration](https://developer.apple.com/documentation/uikit/uiimagepickercontroller/1619146-videomaximumduration?changes=_5) 프로퍼티를 사용하여 조정할 수 있다. 사용자가 MMS, MobileMe, YouTube 또는 다른 대상으로 동영상을 보내려면 공유 단추를 누를 때 적절한 지속 시간과 적절한 비디오 품질이 적용된다.


기본 카메라 인터페이스는 이전에 저장된 동영상 편집을 지원한다. 편집에는 동영상의 처음부터 끝까지 트리밍한 다음 트리밍한 동영상을 저장하는 작업이 포함된다. 새 동영상 녹화를 지원하는 것이 아닌 동영상 편집 전용 인터페이스를 표시하려면 이 대신 [UIVideoEditorController](https://developer.apple.com/documentation/uikit/uivideoeditorcontroller?changes=_5) 클래스를 사용한다.


&nbsp;
## Working with Live Photos
라이브 사진은 지원되는 장치의 카메라 앱 기능으로, 사진을 한 순간에 촬영하는 것이 아니라 캡처 직전과 직후 순간의 모션과 사운드를 포함할 수 있다. [PHLivePhoto](https://developer.apple.com/documentation/photos/phlivephoto?changes=_5) 객체는 라이브 사진을 나타내며 [PHLivePhotoView](https://developer.apple.com/documentation/photosui/phlivephotoview?changes=_5) 클래스는 라이브 사진을 표시하고 내용을 재생하기 위한 시스템 표준 대화형 사용자 인터페이스를 제공한다.


라이브 사진에는 사운드 및 모션이 포함되지만 사진은 그대로 유지된다. 이미지 피커 컨트롤러를 사용하여 스틸 이미지([mediaTypes](https://developer.apple.com/documentation/uikit/uiimagepickercontroller/1619173-mediatypes?changes=_5) 배열에 [kUTTypeImage](https://developer.apple.com/documentation/coreservices/kuttypeimage?changes=_5) 타입만 포함)를 캡처하거나 선택하면 라이브 사진으로 캡처된 에셋이 계속해서 피커에 나타난다. 그러나 사용자가 에셋을 선택하면 델리게이트 객체는 라이브 사진의 스틸 이미지 표현이 포함 된 [UIImage](https://developer.apple.com/documentation/uikit/uiimage?changes=_5) 객체만 받는다.


사용자가 이미지 피커로 라이브 사진을 선택할 때 전체 동작 및 사운드 내용을 얻으러면 kTypeImage 및 kUTTypeLivePhoto 타입을 모두 mediaTypes 배열에 포함시켜야 한다. 자세한 내용은 [UIImagePickerControllerDelegate](https://developer.apple.com/documentation/uikit/uiimagepickercontrollerdelegate?changes=_5)의 [UIImagePickerControllerLivePhoto](https://developer.apple.com/documentation/uikit/uiimagepickercontrollerlivephoto?changes=_5)를 참조한다.


&nbsp;
## Fully-Customized Media Capture and Browsing
완전히 사용자 정의된 이미지 또는 동영상 캡처를 수행하려면 [Still and Video Media Capture](https://developer.apple.com/library/content/documentation/AudioVideo/Conceptual/AVFoundationPG/Articles/00_Introduction.html#//apple_ref/doc/uid/TP40010188-CH1-SW10)에 설명 된대로 AVFoundation 프레임 워크를 사용한다.


사진 라이브러리를 탐색할 수 있도록 완전히 사용자 정의된 이미지 피커를 만들려면 Photos 프레임 워크의 클래스를 사용한다. 예를 들어, iOS에서 생성 및 캐시하고 타임 스탬프 및 위치 정보를 포함한 이미지 메타 데이터를 사용하거나 MapKit 및 iCloud 사진 공유와 같은 다른 기능과 통합되는 더 큰 섬네일 이미지를 표시하는 커스텀 이미지 피커를 만들 수 있다. 자세한 내용은 [Photos](https://developer.apple.com/documentation/photos?changes=_5)를 참조. Photos 프레임 워크를 사용한 미디어 탐색은 iOS 8.0부터 사용할 수 있다. 


&nbsp;
## Topics
### Responding to Interactions with the Picker
> 피커와의 상호 작용에 대한 응답
* `var delegate: (UIImagePickerControllerDelegate & UINavigationControllerDelegate)?`
    * 이미지 피커의 델리게이트 객체
* `protocol UIImagePickerControllerDelegate`
    * 이미지 피커 인터페이스와 상호 작용하기 위해 델리게이트 객체가 구현해야 하는 메서드 집합이다.


### Setting the Picker Source
> 피커 소스 설정
* `class func availableMediaTypes(for: UIImagePickerControllerSourceType)`
    * 지정된 소스 타입에 사용할 수 있는 미디어 타입의 배열을 반환한다.
* `class func isSourceTypeAvailable(UIImagePickerControllerSourceType)`
    * 장치가 지정된 소스 타입을 사용하여 미디어를 가져올 수 있는지 여부를 나타내는 부울 값을 반환한다.
* `var sourceType: UIImagePickerControllerSourceType`
    * 컨트롤러가 표시할 피커 인터페이스 타입이다.
* `enum UIImagePickerControllerSourceType`
    * 이미지를 선택할 때 또는 사용 가능한 미디어 타입을 결정할 때 사용할 소스


### Configuring the Picker
> 피커 구성
* `var mediaTypes: [String]`
    * 미디어 피커 컨트롤러가 접근할 미디어 타입을 나타내는 배열
* `var allowsEditing: Bool`
    * 사용자가 선택한 스틸 이미지 또는 동영상을 편집할 수 있는지 여부를 나타내는 부울 값


### Configuring the Video Capture Options
> 비디오 캡처 오션 구성
* `var videoQuality: UIImagePickerControllerQualityType`
    * 비디오 녹화 및 트랜스코딩 품질
* `enum UIImagePickerControllerQualityType`
    * 내장 카메라로 촬영한 동영상 또는 이미지 피커에 표시하여 트랜스코딩한 동영상의 화질 설정
* `var videoMaximumDuration: TimeInterval`
    * 비디오 녹화의 최대 지속 시간(초)


### Customizing the Camera Controls
> 카메라 컨트롤 사용자 정의
* `var showsCameraControls: Bool`
    * 이미지 피커에 기본 카메라 컨트롤이 표시되는지 여부를 나타낸다.
* `var cameraOverlayView: UIView?`
    * 기본 이미지 피커 인터페이스 상단에 표시할 뷰
* `var cameraViewTransform: CGAffineTransform`
    * 카메라의 미리보기 이미지에 적용할 변환이다.


### Capturing Still Images or Movies
> 스틸 이미지 또는 동영상 캡처
* `func takePicture()`
    * 카메라를 사용하여 스틸 이미지를 캡처한다.
* `func startVideoCapture()`
    * [UIImagePickerControllerCameraDevice](https://developer.apple.com/documentation/uikit/uiimagepickercontrollercameradevice?changes=_5) 프로퍼티에서 지정한 카메라를 사용하여 비디오 캡처를 시작한다.
* `func stopVideoCapture()`
    * 비디오 캡처를 정지한다.


### Configuring the Camera to Use
> 사용할 카메라 구성
* `class func isCameraDeviceAvailable(UIImagePickerControllerCameraDevice)`
    * 지정된 카메라가 사용 가능한지 여부를 나타내는 부울 값을 반환한다.
* `var cameraDevice: UIImagePickerControllerCameraDevice`
    * 이미지 피커 컨트롤러가 사용하는 카메라
* `enum UIImagePickerControllerCameraDevice`
    * 이미지 또는 동영상 캡처에 사용할 카메라이다.


### Configuring the Camera Capture Mode
> 카메라 캡처 모드 구성
* `class func availableCaptureModes(for: UIImagePickerControllerCameraDevice)`
    * 지정된 카메라 장치가 지원하는 캡처 모드를 나타내는 NSNumber 객체의 배열을 반환한다.
* `var cameraCaptureMode: UIImagePickerControllerCameraCaptureMode`
    * 카메라가 사용하는 캡처 모드
* `enum UIImagePickerControllerCameraCaptureMode`
    * 캡처할 카메라의 미디어 카테고리


### Configuring the Flash Behavior
> Flash 동작 구성
* `class func isFlashAvailable(for: UIImagePickerControllerCameraDevice)`
    * 지정된 카메라에 플래시 기능이 있는지 여부를 나타낸다. 
* `var cameraFlashMode: UIImagePickerControllerCameraFlashMode`
    * 활성 카메라에서 사용하는 플래시 모드
* `enum UIImagePickerControllerCameraFlashMode`
    * 활성 카메라와 함께 사용할 플래시 모드 열거형


### Configuring the Export Presets
> 내보내기 사전 설정 구성
* `var imageExportPreset: UIImagePickerControllerImageURLExportPreset`
    * 앱으로 내보낼 이미지를 준비할 때 사용할 사전 설정이다.
* `enum UIImagePickerControllerImageURLExportPreset`
    * 이미지를 클라이언트 애플리케이션에 내보내는 방법을 나타내는 상수이다.
* `var videoExportPreset: String`
    * 앱으로 내보낼 비디오를 준비할 때 사용할 사전 설정이다.


&nbsp;      
## Relationships
### Inherits From
* [UINavigationController](https://developer.apple.com/documentation/uikit/uinavigationcontroller?changes=_5)


### Conforms To
* CVarArg
* Equatable
* Hashable
* NSCoding
* NSExtensionRequestHandling
* UIPasteConfigurationSupporting
* UIStateRestoring


&nbsp;      
## See Also
### Images and Video
* `class UIVideoEditorController`
    * 비디오 프레임을 트리밍하고 이전에 녹화된 동영상을 인코딩하기 위한 시스템 인터페이스를 관리하는 뷰 컨트롤러이다.


&nbsp;      
&nbsp;      
### [by. 0junChoi](https://github.com/0jun0815) email: <0jun0815@gmail.com>
### [Apple Developer Documentation UIImagePickerController](https://developer.apple.com/documentation/uikit/uiimagepickercontroller?changes=_5)
