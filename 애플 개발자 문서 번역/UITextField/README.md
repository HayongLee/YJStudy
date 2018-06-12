# UITextField
> 인터페이스에 편집 가능한 텍스트 영역을 표시하는 객체.


* [Overview](#overview)
* [Showing and Hiding the Keyboard](#showing-and-hiding-the-keyboard)
    * [Configuring the Keyboard’s Appearance](#configuring-the-keyboards-appearance)
    * [Responding to Keyboard-Related Notifications](#responding-to-keyboard-related-notifications)
* [Formatting the Text in a Text Field](#formatting-the-text-in-a-text-field)
* [Using Overlay Views to Edit Content](#using-overlay-views-to-edit-content)
* [Validating Text and Managing the Editing Process](#validating-text-and-managing-the-editing-process)
* [Interface Builder Attributes](#interface-builder-attributes)
* [Internationalization](#internationalization)
* [Accessibility](#accessibility)
* [State Preservation](#state-preservation)
* [Topics](#topics)
    * [Validating and Handling Edits](#validating-and-handling-edits)
    * [Accessing the Text Attributes](#accessing-the-text-attributes)
    * [Sizing the Text Field’s Text](#sizing-the-text-fields-text)
    * [Managing the Editing Behavior](#managing-the-editing-behavior)
    * [Setting the View’s Background Appearance](#setting-the-views-background-appearance)
    * [Managing Overlay Views](#managing-overlay-views)
    * [Drawing and Positioning Overrides](#drawing-and-positioning-overrides)
    * [Replacing the System Input Views](#replacing-the-system-input-views)
* [Relationships](#relationships)
* [See Also](#see-also)
    

&nbsp;      
## Overview
텍스트 필드는 화면 키보드를 사용하여 사용자로부터 텍스트 기반 입력을 수집한다. 키보드는 일반 텍스트, 이메일, 숫자 등과 같이 다양한 타입의 입력에 맞게 구성할 수 있다. 텍스트 필드는 타겟-액션 메커니즘과 델리게이트 객체를 사용하여 편집 과정에서 변경된 사항을 보고한다.


기본 텍스트 편집 행동(비헤이비어) 외에도 텍스트 필드에 오버레이 뷰를 추가하여 추가 정보를 표시하고 추가로 탭 할 수 있는 컨트롤을 제공할 수 있다. 북마크 버튼이나 검색 아이콘과 같은 요소에 대한 사용자 정의 오버레이 뷰를 추가할 수 있다. 텍스트 필드는 현재 텍스트를 지우는 내장 오버레이 뷰(클리어 버튼)를 제공한다. 사용자 정의 오버레이 뷰는 선택사항이다.


![](https://docs-assets.developer.apple.com/published/ef3a6fcec5/uitextfield_intro_2x_a45e1f72-b6db-4bd6-8f82-4438e14dc1da.png)


인터페이스에 텍스트 필드를 추가한 후 앱에서 사용할 수 있도록 텍스트 필드를 구성한다. 구성에는 다음 작업 중 일부 또는 전부를 수행해야 한다:
* 텍스트 필드에 대해 하나 이상의 타겟 및 액션을 구성한다.
* 텍스트 필드의 키보드 관련 속성을 구성한다.
* 델리게이트 객체를 할당하여 다음과 같은 중요한 작업을 처리한다:
    * 사용자가 텍스트 필드의 내용을 편집할 수 있어야하는지 여부를 결정한다.
    * 사용자가 입력한 텍스트의 유효성을 검사한다.
    * 키보드의 리턴 버튼 탭에 응답한다.
    * 사용자가 입력한 텍스트를 앱의 다른 부분으로 전달한다.
* 컨트롤러 객체 중 하나에 텍스트 필드에  대한 참조를 저장한다.


텍스트 필드의 델리게이트 객체의 메서드에 대한 자세한 내용은 [UITextFieldDelegate](https://developer.apple.com/documentation/uikit/uitextfielddelegate) 참조.


&nbsp;
## Showing and Hiding the Keyboard
> 키보드 표시 및 숨기기

텍스트 필드가 첫 번째 응답자(first responder)가되면, 시스템은 자동으로 키보드를 표시하고 입력을 텍스트 필드에 바인딩한다. 텍스트 필드는 사용자가 탭하면 자동으로 첫 번째 응답자가된다. [becomeFirstResponder()](https://developer.apple.com/documentation/uikit/uiresponder/1621113-becomefirstresponder) 메서드를 호출하여 텍스트 필드를 첫 번째 응답자로 만들 수도 있다. 사용자가 일부 정보를 입력해야 할 때 텍스트 필드가 강제로 첫 번째 응답자가 될 수 있다.


> Note
>
> 키보드의 모양은 사용자 인터페이스의 일부를 가릴 수 있다. 필요에 따라 인터페이스를 업데이트하여 편집중인 텍스트 필드가 표시되도록해야 한다. 키보드 알림을 사용하여 키보드의 모양과 사라짐을 감지하고 필요한 인터페이스를 변경한다. 자세한 내용은 [Responding to Keyboard-Related Notifications](https://developer.apple.com/documentation/uikit/uitextfield#1652976) 참조.


텍스트 필드의 [resignFirstResponder()](https://developer.apple.com/documentation/uikit/uiresponder/1621097-resignfirstresponder) 메서드를 호출하여 키보드를 닫도록 시스템에 요청할 수 있다. 일반적으로 특정 상호 작용에 대한 응답으로 키보드를 닫는다. 예를 들어, 사용자가 키보드의 리턴 키를 누를 때 키보드를 닫을 수 있다. 시스템은 사용자 동작에 응답하여 키보드를 닫을 수도 있다. 특히 사용자가 키보드 입력을 지원하지 않는 새 컨트롤을 누르면 시스템이 키보드를 닫는다.


키보드의 모양과 해제는 텍스트 필드의 편집 상태에 영향을 준다. 키보드가 나타나면 텍스트 필드가 편집 상태가되어 적절한 알림을 델리게이트에게 보낸다. 마찬가지로 텍스트 필드가 첫 번째 응답자 상태를 종료하면 편집 상태에서 벗어나 델리게이트에게 알린다. 편집 중에 발생하는 이벤트 시퀀스에 대한 자세한 내용은 [Validating Text and Managing the Editing Process](https://developer.apple.com/documentation/uikit/uitextfield#1653000) 참조.


### Configuring the Keyboard’s Appearance
> 키보드 모양 구성

UITextField 클래스에서 사용하는 [UITextInputTraits](https://developer.apple.com/documentation/uikit/uitextinputtraits) 프로토콜의 속성을 사용하여 텍스트 필드의 키보드를 사용자 정의할 수 있다. UIKit은 사용자의 현재 언어에 대한 표준 키보드를 지원하며 숫자, URL, 이메일 주소 및 기타 특정 타입의 정보를 입력하는 특수 키보드도 지원한다. 이 프로토콜의 프로퍼티를 사용하여 다음과 같은 키보드의 속성을 조절한다:
    * 표시할 키보드의 타입
    * 키보드의 자동 대문자 고침 행동
    * 키보드의 자동 맞춤법 보정 행동
    * 표시할 리턴 키의 타입
    
    
### Responding to Keyboard-Related Notifications
> 키보드 관련 알림에 응답 

시스템은 응답자 변경에 따라 키보드 표시 및 숨기기를 관리하기 때문에 키보드 관련 변경 사항을 추적하기 위해 다음과 같은 알림을 게시한다:
* [keyboardWillShowNotification](https://developer.apple.com/documentation/uikit/uiresponder/1621576-keyboardwillshownotification)
* [keyboardDidShowNotification](https://developer.apple.com/documentation/uikit/uiresponder/1621602-keyboarddidshownotification)
* [keyboardWillHideNotification](https://developer.apple.com/documentation/uikit/uiresponder/1621606-keyboardwillhidenotification)
* [keyboardDidHideNotification](https://developer.apple.com/documentation/uikit/uiresponder/1621579-keyboarddidhidenotification)
* [keyboardWillChangeFrameNotification](https://developer.apple.com/documentation/uikit/uiresponder/1621623-keyboardwillchangeframenotificat)
* [keyboardDidChangeFrameNotification](https://developer.apple.com/documentation/uikit/uiresponder/1621619-keyboarddidchangeframenotificati)


각 알림에는 키보드의 크기가 포함된 userInfo 딕셔너리가 있다. 키보드는 인터페이스의 일부를 숨길 수 있으므로 크기 정보를 사용하여 화면에서 내용의 위치를 변경해야 한다. 스크롤 뷰에 포함된 내용의 경우 아래 그림 같이 텍스트 필드를 뷰로 스크롤 할 수 있다. 다른 경우에는 키보드가 덮지 않도록 기본 콘텐츠 뷰의 크기를 조정할 수 있다.


![](https://docs-assets.developer.apple.com/published/ef3a6fcec5/keyboard_adjust_2x_4220aae9-104f-43e5-b753-aae36699e0d3.png)


키보드 상호 작용 관리에 대한 자세한 내용은 [Programming Guide for iOS](https://developer.apple.com/library/archive/documentation/StringsTextFonts/Conceptual/TextAndWebiPhoneOS/Introduction/Introduction.html#//apple_ref/doc/uid/TP40009542) 참조.


&nbsp;
## Formatting the Text in a Text Field
> 텍스트 필드의 텍스트 서식 지정

텍스트 필드의 텍스트에는 두 가지 타입의 서식을 지정할 수 있다:
* 이 클래스의 프로퍼티를 사용하여 텍스트의 글꼴, 색상 및 스타일을 변경할 수 있다. 또는 텍스트 필드의 내용에 대해 [NSAttributeString](https://developer.apple.com/documentation/foundation/nsattributedstring)을 지정할 수 있다.
* [Formatter](https://developer.apple.com/documentation/foundation/formatter) 객체를 사용해 텍스트 필드의 내용을 포맷할 수 있다. 


[font](https://developer.apple.com/documentation/uikit/uitextfield/1619604-font), [textColor](https://developer.apple.com/documentation/uikit/uitextfield/1619617-textcolor), [textAlignment](https://developer.apple.com/documentation/uikit/uitextfield/1619643-textalignment) 프로퍼티는 텍스트 필드의 문자열 모양에 영향을준다. 이러한 프로퍼티를 수정하면 지정된 속성이 전체 문자열에 적용된다. 보다 세분화된 서식을 지정하려면 NSAttributedString 객체를 사용하여 텍스트 필드의 텍스트를 지정한다.


UITextField 클래스는 Formatter 객체를 사용하여 문자열의 서식 지정을 지원하지는 않지만 텍스트 필드의 델리게이트를 사용하여 직접 내용의 서식을 지정할 수 있다. 이렇게하려면 텍스트 필드의 델리게이트 메서드를 사용하여 텍스트의 유효성을 검사하고 적절하게 서식을 지정한다. 예를 들어, [textField(_:shouldChangeCharactersIn:replacementString:)](https://developer.apple.com/documentation/uikit/uitextfielddelegate/1619599-textfield) 메서드를 사용하여 사용자가 입력하는 동안 텍스트의 유효성을 검사하고 서식을 지정한다. 포맷터 객체를 사용하는 방법에 대한 자세한 내용은 [Data Formatting Guide](https://developer.apple.com/library/archive/documentation/Cocoa/Conceptual/DataFormatting/DataFormatting.html#//apple_ref/doc/uid/10000029i)를 참고.


&nbsp;
## Using Overlay Views to Edit Content
> 오버레이 뷰를 사용하여 콘텐츠 편집


오버레이 뷰는 텍스트 뷰의 편집 가능 영역의 왼쪽과 오른쪽에 표시되는 작은 뷰이다. 일반적으로 오버레이 뷰는 추가 편집 컨트롤로 설정하는 이미지 기반 버튼이다. 예를 들어, 오버레이 뷰를 사용하여 북마크 버튼을 구현할 수 있다. 버튼을 오버레이 뷰로 구성하려면 버튼의 내용에 대한 이미지를 지정하고 탭에 응답할 타겟 및 버튼의 액션을 구성한다.


아래 코드는 버튼을 텍스트 필드의 왼쪽 오버레이로 추가하는 방법을 보여준다. 이 경우 코드는 버튼을 만들고 크기와 내용을 구성한다. [leftViewMode](https://developer.apple.com/documentation/uikit/uitextfield/1619588-leftviewmode) 프로퍼티는 버튼이 표시되는 시기를 지정한다. 사용자가 버튼을 탭하면 이 버튼은 구성된 액션 메서드를 호출한다. 여기서는 사용자 정의 메서드인 displayBookmarks: 이다.

```
let overlayButton = UIButton(type: .custom)
overlayButton.setImage(UIImage(named: "bookmark"), for: UIControlState.normal)
overlayButton.addTarget(self, action: #selector(displayBookmarks(_:)), for: UIControlEvents.touchUpInside)
overlayButton.frame = CGRect(x: 0, y: 0, width: 28, height: 28)

// Assign the overlay button to a stored text field
textField.leftView = overlayButton
textField.leftViewMode = UITextFieldViewMode.always
```


오버레이 뷰를 구성할 때 텍스트 필드에 내장된 클리어 버튼을 표시할지 여부를 고려한다. 클리어 버튼을 사용하면 텍스트 필드의 텍스트를 모두 삭제하는 편리한 방법을 사용자에게 제공한다. 이 버튼은 오른쪽 오버레이 위치에 표시되지만 사용자 정의 오른쪽 오버레이 뷰를 제공하는 경우 [rightViewMode](https://developer.apple.com/documentation/uikit/uitextfield/1619607-rightviewmode) 및 [clearButtonMode](https://developer.apple.com/documentation/uikit/uitextfield/1619622-clearbuttonmode) 프로퍼티를 사용하여 사용자 정의 오버레이를 표시해야하는 시기와 클리어 버튼을 표시해야 하는 시기를 정의한다. 


&nbsp; 
## Validating Text and Managing the Editing Process
> 텍스트 유효성 검사 및 편집 프로세스 관리

텍스트 필드는 델리게이트 객체의 도움을 받아 텍스트 편집을 관리한다. 사용자가 텍스트 필드와 상호 작용할 때 텍스트 필드는 해당 델리게이트에게 알리고 발생 상황을 제어 할 수 있는 기회를 제공한다. 델리게이트 메서드를 사용하여 사용자가 편집 프로세스를 시작하거나 또는 중지하지 못하도록하거나 입력할 때 텍스트의 유효성을 검사할 수 있다. 델리게이트 메서드를 사용하여 사용자가 입력한 정보를 기반으로 인터페이스의 다른 부분을 업데이트하는 등의 관련 작업을 수행할 수도 있다.


텍스트 필드의 델리게이트를 사용하여 편집 상호작용을 관리하는 방법에 대한 자세한 내용은 [UITextFieldDelegate](https://developer.apple.com/documentation/uikit/uitextfielddelegate)를 참조.


&nbsp;  
## Interface Builder Attributes
> 인터페이스 빌더 속성

아래 표는 인터페이스 빌더에서 텍스트 필드에 대해 구성하는 속성이다:


Attribute | Description
------------ | -------------
Text | 텍스트 필드에 표시되는 초기 텍스트.  텍스트를 일반 문자열 또는 속성이 지정된 문자열로 지정할 수 있다. 속성이 지정된 문자열을 지정하면, 인터페이스 빌더는 문자열의 글꼴, 색상 및 형식을 편집하기 위한 다양한 옵션을 제공한다.
Color | 텍스트 필드의 텍스트 색상. 이 속성을 프로그래밍 방식으로 설정하려면 [textColor](https://developer.apple.com/documentation/uikit/uitextfield/1619617-textcolor) 프로퍼티를 사용한다.
Font | 텍스트 필드의 텍스트 글꼴. 이 속성을 프로그래밍 방식으로 설정하려면 [font](https://developer.apple.com/documentation/uikit/uitextfield/1619604-font) 프로퍼티를 사용한다. 
Alignment | 편집 영역 내에서 텍스트 필드의 텍스트 정렬. 이 옵션을 일반 문자열의 서식을 지정할 때만 사용할 수 있다. 이 속성을 프로그래밍 방식으로 설정하려면 [textAlignment](https://developer.apple.com/documentation/uikit/uitextfield/1619643-textalignment) 프로퍼티를 사용한다.
Placeholder | 텍스트 필드에 표시되는 플레이스 홀더 텍스트. 텍스트 필드의 문자열이 비어 있으면 텍스트 필드에 대신 이 문자열(플레이스 홀더 텍스트)이 표시되어 실제 텍스트가 없음을 나타낸다. 텍스트 필드에 텍스트를 입력하면 플레이스 홀더 문자열이 표시되지 않는다. 이 속성을 프로그래밍 방식으로 설정하려면 [placeholder](https://developer.apple.com/documentation/uikit/uitextfield/1619621-placeholder) 프로퍼티를 사용한다.
Background | 텍스트 필드가 사용 가능한 경우 표시할 배경 이미지. 이 이미지는 나머지 텍스트 필드의 내용 뒤에 표시된다. 이 속성을 프로그래밍 방식으로 설정하려면 [background](https://developer.apple.com/documentation/uikit/uitextfield/1619623-background) 프로퍼티를 사용한다.
Disabled | 텍스트 필드가 비활성화 될 때 표시할 배경 이미지. 이 이미지는 나머지 텍스트 필드의 내용 뒤에 표시된다. 이 속성을 프로그래밍 방식으로 설정하려면 [disabledBackground](https://developer.apple.com/documentation/uikit/uitextfield/1619611-disabledbackground) 프로퍼티를 사용한다.
Border Style | 텍스트 필드 테두리의 비주얼 스타일. 이 속성은 편집 가능한 텍스트 영역 주위에 그려지는 시각적 경계를 정의한다(있는 경우). 이 속성을 프로그래밍 방식으로 설정하려면 [borderStyle](https://developer.apple.com/documentation/uikit/uitextfield/1619624-borderstyle) 프로퍼티를 사용한다.
Clear Button | 클리어 버튼의 행동. 클리어 버튼은 텍스트 필드의 텍스트를 모두 지우는데 사용되는 기본 제공 오버레이 뷰이다. 이 속성을 사용하여 클리어 버튼이 나타나는 시기를 정의한다. 이 속성을 프로그래밍 방식으로 설정하려면 [clearButtonMode](https://developer.apple.com/documentation/uikit/uitextfield/1619622-clearbuttonmode) 프로퍼티를 사용한다.
Min Font Size | 텍스트 필드 텍스트의 최소 글꼴 크기이다. Adjust to Fit 옵션을 활성화하면 텍스트 필드에서 텍스트의 가독성을 최대한 보장할 수 있도록 글꼴 크기가 자동으로 변경된다. 이 속성을 사용하여 텍스트에 적합하다고 생각되는 가장 작은 글꼴 크기를 지정할 수 있다. 이 속성을 프로그래밍 방식으로 설정하려면 [minimumFontSize](https://developer.apple.com/documentation/uikit/uitextfield/1619605-minimumfontsize) 프로퍼티를 사용한다.


아래 표는 텍스트 필드에 대해 구성한 키보드 관련 속성으로 이 속성은 UITextField 클래스에서 채택하는 [UITextInputTraits](https://developer.apple.com/documentation/uikit/uitextinputtraits) 프로토콜의 속성에 해당한다:


Attribute | Description
------------ | -------------
Capitalization | 입력한 텍스트에 적용할 자동 대문자 스타일. 이 속성은 Shift 키가 자동으로 눌려지는 시간을 결정한다. 텍스트 필드의 [autocapitalizationType](https://developer.apple.com/documentation/uikit/uitextinputtraits/1624447-autocapitalizationtype) 프로퍼티를 사용하여 이 속성의 값에 프로그래밍 방식으로 접근할 수 있다.
Correction | 텍스트 필드의 자동 수정 행동. 이 속성은 입력하는 동안 자동 수정을 사용할지 여부를 결정한다. 텍스트 필드의 [autocorrectionType](https://developer.apple.com/documentation/uikit/uitextinputtraits/1624453-autocorrectiontype) 프로퍼티를 사용하여 이 속성의 값에 프로그래밍 방식으로 접근할 수 있다.
Spell Checking | 텍스트 필드의 맞춤법 검사 행동. 이 속성은 입력하는 동안 맞춤법 검사를 사용할지 여부를 결정한다. 텍스트 필드의 [speelCheckingType](https://developer.apple.com/documentation/uikit/uitextinputtraits/1624461-spellcheckingtype) 프로퍼티를 사용하여 이 속성의 값에 프로그래밍 방식으로 접근할 수 있다. 
Keyboard Type | 텍스트 필드의 키보드 스타일. 이 속성은 텍스트 필드가 활성화되었을 때 표시되는 키보드 타입을 지정한다. 텍스트 필드의 [keyboardType](https://developer.apple.com/documentation/uikit/uitextinputtraits/1624457-keyboardtype) 프로퍼티를 사용하여 이 속성의 값에 프로그래밍 방식으로 접근할 수 있다.
Appearance | 텍스트의 키보드에 적용된 비주얼 스타일. 어둡거나 밝은 키보드를 지정하려면 이 프로퍼티를 사용한다. 텍스트 필드의 [keyboardAppearance](https://developer.apple.com/documentation/uikit/uitextinputtraits/1624434-keyboardappearance) 프로퍼티를 사용하여 이 속성의 값에 프로그래밍 방식으로 접근할 수 있다.
Return Key | 키보드에 표시할 리턴 키 타입. 이 속성을 사용하여 키보드의 리턴 키에 적용되는 텍스트 및 비주얼 스타일을 구성한다. 텍스트 필드의 [returnKeyType](https://developer.apple.com/documentation/uikit/uitextinputtraits/1624446-returnkeytype) 프로퍼티를 사용하여 이 속성의 값에 프로그래밍 방식으로 접근할 수 있다. 리턴 키는 기본적으로 비활성화되어 있으며 사용자가 텍스트 필드에 텍스트를 입력한 경우에만 활성화된다. 리턴 키 탭에 응답하려면 텍스트 필드에 지정한 델리게이트에서 [textFieldShouldReturn(_:)](https://developer.apple.com/documentation/uikit/uitextfielddelegate/1619603-textfieldshouldreturn) 메서드를 구현한다.


텍스트 뷰에 대해 구성할 수 있는 추가 속성에 관한 자세한 내용은 [UIControl](https://developer.apple.com/documentation/uikit/uicontrol)을 참조.


&nbsp;
## Internationalization
> 국제화

장치의 기본 언어는 텍스트 필드(리턴키 포함)로 팝업되는 키보드에 영향을 준다. 이 기능을 사용하려면 아무 것도 할 필요가 없다. 기본적으로 활성화되어 있다. 그러나 텍스트 필드는 모든 언어의 입력을 처리할 수 있어야한다.


스토리보드를 사용하여 인터페이스를 만들때 Xcode의 기본 국제화 기능을 사용하여 프로젝트가 지원하는 지역화를 구성한다. 지역화를 추가하면 Xcode는 해당 지역화를 위한 문자열 파일을 생성한다. 프로그래밍 방식으로 인터페이스를 구성할 때 시스템의 기본 제공을 사용하여 지역화된 문자열 및 리소스를 로드한다. 인터페이스 국제화에 대한 자세한 내용은 [Internationalization and Localization Guide](https://developer.apple.com/library/archive/documentation/MacOSX/Conceptual/BPInternational/Introduction/Introduction.html#//apple_ref/doc/uid/10000171i) 참조.


&nbsp;  
## Accessibility
> 접근성

텍스트 필드는 기본적으로 접근할 수 있다. 텍스트 필드의 기본 접근성 속성은 사용자 상호 작용 활성화(User Interaction Enabled)이다.


iOS 컨트롤을 접근 가능하게 만드는 방법에 대한 자세한 내용은 [UIControl](https://developer.apple.com/documentation/uikit/uicontrol) 참조. 인터페이스에 접근할 수 있게 하는 방법에 대한 일반 정보는 [Programming Guide for iOS](https://developer.apple.com/library/archive/documentation/UserExperience/Conceptual/iPhoneAccessibility/Introduction/Introduction.html#//apple_ref/doc/uid/TP40008785)를 참조.


&nbsp;  
## State Preservation
> 상태 보존

텍스트 필드의 [restorationIdentifier]() 프로퍼티에 값을 할당하면 선택한 텍스트 범위가 있을 경우 그대로 유지된다. 다음 실행주기 동안 텍스트 필드는 해당 선택 사항을 복원하려고 시도한다. 선택 범위를 현재 텍스트에 적용할 수 없는 경우 선택이 이루어지지 않는다. 상태 보존 및 복원의 작동 방식에 대한 자세한 내용은 [App Programming Guide for iOS](https://developer.apple.com/library/archive/documentation/iPhone/Conceptual/iPhoneOSProgrammingGuide/Introduction/Introduction.html#//apple_ref/doc/uid/TP40007072) 참조.


&nbsp;
## Topics
### Validating and Handling Edits
> 편집 유효성 검사 및 처리

* `var delegate: UITextFieldDelegate?`
    * 리시버의 델리게이트
* `protocol UITextFieldDelegate`
    * 텍스트 필드 객체에서 텍스트의 편집 및 유효성 검사를 관리하는데 사용하는 선택적 메서드 집합이다.


### Accessing the Text Attributes
> 텍스트 속성에 접근하기

* `var text: String?`
    * 텍스트 필드에 표시되는 텍스트
* `var attributedText: NSAttributedString?`
    * 텍스트 필드로 표시되는 스타일 지정된 텍스트
* `var placeholder: String?`
    * 텍스트 필드에 다른 텍스트가 없을 때 표시되는 문자열
* `var attributedPlaceholder: NSAttributedString?`
    * 텍스트 필드에 다른 텍스트가 없을 때 표시되는 스타일 지정된 문자열
* `var defaultTextAttributes: [NSAttributedString.Key: Any]`
    * 텍스트에 적용할 기본 속성
* `var font: UIFont?`
    * 테스트의 글꼴
* `var textColor: UIColor?`
    * 텍스트의 색상
* `var textAlignment: NSTextAlignment`
    * 텍스트를 정렬하는데 사용하는 기술
* `var typingAttributes: [NSAttributedString.Key: Any]`
    * 사용자가 입력한 새 텍스트에 적용할 속성
* `enum UITextField.BorderStyle`
    * 텍스트 필드 주위에 그려지는 테두리 타입


### Sizing the Text Field’s Text
> 텍스트 필드의 텍스트 크기 조정

* `var adjustsFontSizeToFitWidth: Bool`
    * 텍스트 문자열의 경계 사각형에 텍스트 문자열을 맞추기 위해 글꼴 크기를 줄여야하는지 여부를 나타내는 부울 값
* `var minimumFontSize: CGFloat`
    * 텍스트 필드의 텍스트를 그리는데 허용되는 가장 작은 글꼴의 크기


### Managing the Editing Behavior
> 편집 행동 관리하기

* `var isEditing: Bool`
    * 텍스트 필드가 현재 편집 모드에 있는지 여부를 나타내는 부울 값
* `var clearsOnBeginEditing: Bool`
    * 편집이 시작될 때 텍스트 필드에서 이전 텍스트를 제거할지 여부를 나타내는 부울 값
* `var clearsOnInsertion: Bool`
    * 텍스트 삽입이 이전 내용을 바꿀지 여부를 나타내는 부울 값
* `var allowsEditingTextAttributes: Bool`
    * 사용자가 텍스트 필드의 텍스트 속성을 편집할 수 있는지 여부를 나타내는 부울 값
* `enum UITextField.DidEndEditingReason`
    * 텍스트 필드에서 편집이 끝난 이유를 나타내는 상수
* `class let didEndEditingReasonUserInfoKey: String`
* `class let textDidBeginEditingNotification: NSNotification.Name`
    * 텍스트 필드에서 편집 세션이 시작되었다는 것을 관찰자(옵저버)에게 알린다. 영향을 받는 텍스트 필드는 notification의 객체 매개변수에 저장된다. userInfo 딕셔너리는 사용되지 않는다.
* `class let textDidChangeNotification: NSNotification.Name`
    * 텍스트 필드의 텍스트가 변경되었다는 것을 관찰자(옵저버)에게 알린다. 영향을 받는 텍스트 필드는 notification의 객체 매개변수에 저장된다.
* `class let textDidEndEditingNotification: NSNotification.Name`
    * 편집 세션이 텍스트 필드에 대해 종료되었음을 관찰자(옵저버)에게 알린다. 영향을 받는 텍스트 필드는 notification의 객체 매개변수에 저장된다. userInfo 딕셔너리는 사용되지 않는다.
    

### Setting the View’s Background Appearance
> 뷰의 백그라운드 모양 설정하기

* `var borderStyle: UITextField.BorderStyle`
    * 텍스트 필드에서 사용하는 테두리 스타일
* `var background: UIImage?`
    * 텍스트 필드가 활성화되었을 때 텍스트 필드의 백그라운드 모양을 나타내는 이미지
* `var disabledBackground: UIImage?`
    * 텍스트 필드가 비활성화되었을 때 텍스트 필드의 백그라운드 모양을 나타내는 이미지


### Managing Overlay Views
> 오버레이 뷰 관리하기

* `var clearButtonMode: UITextField.ViewMode`
    * 텍스트 필드에 표준 클리어 버튼이 나타날 때 제어한다.
* `var leftView: UIView?`
    * 오버레이 뷰는 텍스트 필드의 왼쪽(또는 리딩)에 표시된다.
* `var leftViewMode: UITextField.ViewMode`
    * 텍스트 필드의 왼쪽 오버레이 뷰가 표시되는 시기를 제어한다.
* `var rightView: UIView?`
    * 오버레이 뷰는 텍스트 필드의 오른쪽(또는 트래일링)에 표시된다.
* `var rightViewMode: UITextField.ViewMode`
    * 텍스트 필드에 오른쪽 오버레이 뷰가 표시되는 시기를 제어한다.
* `enum UITextField.ViewMode`
    * 텍스트 필드에 오버레이 뷰가 나타나는 시간을 정의한다.


### Drawing and Positioning Overrides
> 그리기 및 위치 재정의

* `func textRect(forBounds: CGRect) -> CGRect`
    * 텍스트 필드의 텍스트의 드로잉 사각형을 반환한다.
* `func drawText(in: CGRect)`
    * 지정된 사각형에 리시버의 텍스트를 그린다.
* `func placeholderRect(forBounds: CGRect) -> CGRect`
    * 텍스트 필드의 플레이스 홀더 텍스트에 대한 드로잉 사각형을 반환한다.
* `func drawPlaceholder(in: CGRect)`
    * 지정된 사각형에 리시버의 플레이스 홀더 텍스트를 그린다.
* `func borderRect(forBounds: CGRect) -> CGRect`
    * 리시버의 테두리 사각형을 반환한다.
* `func editingRect(forBounds: CGRect) -> CGRect`
    * 편집 가능한 텍스트를 표시할 수 있는 사각형을 반환한다.
* `func clearButtonRect(forBounds: CGRect) -> CGRect`
    * 내장 클리어 버튼의 드로잉 사각형을 반환한다.
* `func leftViewRect(forBounds: CGRect) -> CGRect`
    * 리시버의 왼쪽 오버레이 뷰의 드로잉 사각형을 반환한다.
* `func rightViewRect(forBounds: CGRect) -> CGRect`
    * 리시버의 오른쪽 오버레이 뷰의 드로잉 사각형을 반환한다.


### Replacing the System Input Views
> 시스템 입력 뷰 바꾸기

* `var inputView: UIView?`
    * 텍스트 필드가 첫 번재 응답자(first responder)가 될 때 표시할 사용자 정의 입력 뷰 이다.
* `var inputAccessoryView: UIView?`
    * 텍스트 필드가 첫 번째 응답자가 될 때 표시할 사용자 정의 액세서리 뷰이다.


&nbsp;      
## Relationships
### Inherits From
* UIControl


### Adopted By
* CVarArg
* Equatable
* Hashable
* NSCoding
* UIAccessibilityIdentification
* UIContentSizeCategoryAdjusting
* UIPasteConfigurationSupporting
* UITextDraggable
* UITextDroppable
* UITextInput
* UITextPasteConfigurationSupporting
* UIUserActivityRestoring


&nbsp;
## See Also
### Text View
* class UILabel
* class UITextView
* Drag and Drop Customization


&nbsp;      
&nbsp;      
### [by. 0junChoi](https://github.com/0jun0815) email: <0jun0815@gmail.com>
### [Apple Developer Documentation UITextField](https://developer.apple.com/documentation/uikit/uitextfield)
