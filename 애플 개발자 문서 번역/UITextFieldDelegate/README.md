# UITextFieldDelegate
> 텍스트 필드 객체에서 텍스트의 편집 및 유효성 검사를 관리하는데 사용하는 선택적 메서드 집합이다.


* [Overview](#overview)
* [Topics](#topics)
    * [Managing Editing](#managing-editing)
    * [Editing the Text Field’s Text](#editing-the-text-fields-text)
* [Relationships](#relationships)
* [See Also](#see-also)
    

&nbsp;      
## Overview
텍스트 필드는 중요한 변경에 대한 응답으로 델리게이트의 메서드를 호출한다. 이 메서드를 사용하여 사용자가 입력한 텍스트의 유효성을 확인하고 키보드와의 특정 상호 작용에 응답하고 전체 편집 프로세스를 제어할 수 있다. 텍스트 필드가 첫 번째 응답자(first responder)가 되기 직전에 편집이 시작되고 키보드(또는 지정된 입력 뷰)가 표시된다. 편집 프로세스의 흐름은 다음과 같다:
1. 첫 번째 응답자가 되기 전에 텍스트 필드는 델리게이트의 [textFieldShouldBeginEditing(_:)](https://developer.apple.com/documentation/uikit/uitextfielddelegate/1619601-textfieldshouldbeginediting) 메서드를 호출한다. 이 메서드를 사용하여 텍스트 필드의 내용 편집을 허용하거나 금지한다.
2. 텍스트 필드가 첫 번째 응답자가 된다. 이에 따라 시스템은 키보드(또는 텍스트 필드의 입력 뷰)를 표시하고 필요에 따라 [keyboardWillShowNotification](https://developer.apple.com/documentation/uikit/uiresponder/1621576-keyboardwillshownotification) 및 [keyboardDidShowNotification](https://developer.apple.com/documentation/uikit/uiresponder/1621602-keyboarddidshownotification) 알림을 게시한다. 키보드 또는 다른 입력 뷰가 이미 표시된 경우 시스템은 대신 [keyboardWillChangeFrameNotification](https://developer.apple.com/documentation/uikit/uiresponder/1621623-keyboardwillchangeframenotificat) 및 [keyboardDidChangeFrameNotification](https://developer.apple.com/documentation/uikit/uiresponder/1621619-keyboarddidchangeframenotificati) 알림을 게시한다.
3. 텍스트 필드는 델리게이트의 [textFieldDidBeginEditing(_:)](https://developer.apple.com/documentation/uikit/uitextfielddelegate/1619590-textfielddidbeginediting) 메서드를 호출하고 [textDidBeginEditingNotification](https://developer.apple.com/documentation/uikit/uitextfield/1619616-textdidbegineditingnotification) 알림을 게시한다.
4. 텍스트 필드는 편집하는 동안 다양한 델리게이트 메서드를 호출한다:
    * 현재 텍스트가 변경될 때마다 [textField(_:shouldChangeCharactersIn:repacementString:)](https://developer.apple.com/documentation/uikit/uitextfielddelegate/1619599-textfield) 메서드를 호출하고 [textDidChangeNotification](https://developer.apple.com/documentation/uikit/uitextfield/1619640-textdidchangenotification) 알림을 게시한다.
    * 사용자가 내장된 클리어 버튼을 탭하여 텍스트를 지울때 [textFieldShouldClear(_:)](https://developer.apple.com/documentation/uikit/uitextfielddelegate/1619594-textfieldshouldclear) 메서드를 호출한다.
    * 사용자가 키보드의 리턴 버튼을 탭할 때 [textFieldShouldReture(_:)](https://developer.apple.com/documentation/uikit/uitextfielddelegate/1619603-textfieldshouldreturn) 메서드를 호출한다.
5. 첫 번째 응답자에서 물러나기 전에 텍스트 필드는 해당 대리자의 [textFieldShouldEndEditing(_:)](https://developer.apple.com/documentation/uikit/uitextfielddelegate/1619592-textfieldshouldendediting) 메서드를 호출한다. 이 메서드를 사용하여 현재 텍스트의 유효성을 검사한다.
6. 텍스트 필드는 첫 번째 응답자에서 물러난다. 이에 따라 시스템은 필요한 경우 키보드를 숨기거나 조정한다. 키보드를 숨기면 시스템은 [keyboardWillHideNotification](https://developer.apple.com/documentation/uikit/uiresponder/1621606-keyboardwillhidenotification) 및 [keyboardDidHideNotification](https://developer.apple.com/documentation/uikit/uiresponder/1621579-keyboarddidhidenotification) 알림을 게시한다.
7. 텍스트 필드의 델리게이트의 [textFieldDidEndEditing(_:)](https://developer.apple.com/documentation/uikit/uitextfielddelegate/1619591-textfielddidendediting) 메서드를 호출하고 [textDidEndEditingNotification](https://developer.apple.com/documentation/uikit/uitextfield/1619633-textdidendeditingnotification) 알림을 게시한다.


텍스트 필드의 기능에 대한 자세한 내용은 [UITextField](https://developer.apple.com/documentation/uikit/uitextfield)를 참조.


&nbsp;
## Topics
### Managing Editing
> 편집 관리

* `func textFieldShouldBeginEditing(UITextField) -> Bool`
    * 지정된 텍스트 필드에서 편집을 시작해야 하는 경우 델리게이트에게 요청한다.
* `func textFieldDidBeginEditing(UITextField)`
    * 지정된 텍스트 필드에서 편집이 시작되었음을 델리게이트에 알린다.
* `func textFieldShouldEndEditing(UITextField) -> Bool`
    * 지정된 텍스트 필드에서 편집을 중지해야 하는 경우 델리게이트에 요청한다.
* `func textFieldDidEndEditing(UITextField, reason: UITextField.DidEndEditingReason)`
    * 지정된 텍스트 필드에 대해 편집이 중지되었음을 델리게이트에게 알린다.
* `func textFieldDidEndEditing(UITextField)`
    * 지정된 텍스트 필드에 대해 편집이 중지되었음을 델리게이트에게 알린다.
* `enum UITextField.DidEndEditingReason`
    * 텍스트 필드에서 편집이 끝난 이유를 나타내는 상수.


### Editing the Text Field's Text
> 텍스트 필드의 텍스트 편집하기

* `func textField(UITextField, shouldChangeCharactersIn: NSRange, replacementString: String) -> Bool`
    * 지정된 텍스트를 변경해야 하는 경우 델리게이트에 요청한다.
* `func textFieldShouldClear(UITextField) -> Bool`
    * 텍스트 필드의 현재 내용을 제거해야 하는 경우 델리게이트에 요청한다.
* `func textFieldShouldReturn(UiTextField) -> Bool`
    * 텍스트 필드가 리턴 버튼 누르기를 처리해야 하는 경우 델리게이트에 요청한다.


&nbsp;      
## Relationships
### Inherits From
* NSObjectProtocol


&nbsp;
## See Also
### Validating and Handling Edits
* var delegate: UiTextFieldDelegate?


&nbsp;      
&nbsp;      
### [by. 0junChoi](https://github.com/0jun0815) email: <0jun0815@gamil.com>
### [Apple Developer Documentation UITextFieldDelegate](https://developer.apple.com/documentation/uikit/uitextfielddelegate)
