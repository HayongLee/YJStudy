# UIImagePickerControllerDelegate
> 이미지 피커 인터페이스와 상호 작용하기 위해 델리게이트 객체가 구현해야하는 메서드 집합이다.


* [Overview](#overview)
* [Topics](#topics)
    * [Closing the Picker](#closing-the-picker)
    * [Getting the Editing Information](#getting-the-editing-information)
* [See Also](#see-also)    
        * [Responding to Interactions with the Picker](#responding-to-interactions-with-the-picker)    
    

&nbsp;      
## Overview
이 프로토콜의 메서드는 사용자가 이미지나 동영상을 선택하거나 피커 작업을 취소할 때 델리게이트에게 알린다. 델리게이트는 메서드는 작업이 완료 될 때 피커를 닫을 책임이 있다. 피커를 닫으려면 [UIImagePickerController](https://developer.apple.com/documentation/uikit/uiimagepickercontroller?changes=_5) 객체를 표시하는 부모 컨트롤러의 dismissModalViewControllerAnimated: 메서드를 호출한다.


스틸 이미지를 사용자의 카메라 롤 앨범에 저장하려면, [imagePickerController(_:didFinishPickingMediaWithInfo)](https://developer.apple.com/documentation/uikit/uiimagepickercontrollerdelegate/1619126-imagepickercontroller?changes=_5) 메서드 내에서 [UIImageWriteToSavedPhotosAlbum(_:_:_:_:)](https://developer.apple.com/documentation/uikit/1619125-uiimagewritetosavedphotosalbum?changes=_5) 함수를 호출한다. 동영상을 사용자의 카메라 롤 앨범에 저장하려면 [UISaveVideoAtPathToSavedPhotosAlbum(_:_:_:_:)](https://developer.apple.com/documentation/uikit/1619162-uisavevideoatpathtosavedphotosal?changes=_5) 함수를 호출한다. UIKit 기능에 설명된 이러한 함수는 이미지 또는 동영상만 저장한다. 메타 데이터를 저장하지 않는다.


카메라 롤에 이미지를 저장할 때 추가 메타 데이터를 작성하려면 Photos 프레임 워크의 [PHAssetChangeRequest](https://developer.apple.com/documentation/photos/phassetchangerequest?changes=_5) 클래스를 사용한다. [UIImagePickerControllerMediaMetadata](https://developer.apple.com/documentation/uikit/uiimagepickercontrollermediametadata?changes=_5) 키에 대한 설명을 참조한다.


&nbsp;
## Topics
### Closing the Picker
* `func imagePickerController(UIImagePickerController, didFinishPickingMediaWithInfo: [String: Any])`
    * 델리게이트에게 사용자가 스틸 이미지 또는 동영상을 선택했음을 알린다.
* `func imagePickerControllerDidCancel(UIImagePickerController)`
    * 델리게이트에게 사용자가 선택 작업을 취소했음을 알린다.


### Getting the Editing Information
> 이 키를 사용하여 편집 딕셔너리에서 델리게이트 객체로 반환된 정보를 검색한다.
* `let UIImagePickerControllerMediaType: String`
    * 사용자가 선택한 미디어 타입을 지정한다.
* `let UIImagePickerControllerOriginalImage: String`
    * 사용자가 선택한 원래의, 잘리지 않은 이미지를 지정한다.
* `let UIImagePickerControllerImageURL: String`
    * 이미지 파일의 URL을 포함하는 키
* `let UIImagePickerControllerEditedImage: String`
    * 사용자가 편집한 이미지를 지정한다.
* `let UIImagePickerControllerCropRect: String`
    * 원본 이미지에 적용된 자르기 사각형을 지정한다.
* `let UIImagePickerControllerMediaURL: String`
    * 동영상의 파일 시스템 URL을 지정한다.
* `let UIImagePickerControllerMediaMetadata: String`
    * 새로 캡처한 사진의 메타 데이터
* `let UIImagePickerControllerLivePhoto: String`
    * 선택 또는 캡처한 사진의 Live Photo 표현
* `let UIImagePickerControllerPHAsset: String`
    * 이미지의 Photos asset을 검색할 때 사용하는 키이다.
* ~~`let UIImagePickerControllerReferenceURL: String`~~


&nbsp;
## See Also
### Responding to Interactions with the Picker
* `var delegate: (UIImagePickerControllerDelegate & UINavigationControllerDelegate)?`
    * 이미지 피커의 델리게이트 객체


&nbsp;      
&nbsp;      
### [by. 0junChoi](https://github.com/0jun0815) email: <0jun0815@gamil.com>
### [Apple Developer Documentation UIImagePickerControllerDelegate](https://developer.apple.com/documentation/uikit/uiimagepickercontrollerdelegate?changes=_5)
