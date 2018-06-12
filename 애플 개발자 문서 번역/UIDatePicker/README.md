# UIDatePicker
> 날짜 및 시간 값을 입력하는데 사용되는 컨트롤이다.


* [Overview](#overview)
* [Configuring a Date Picekr](#configuring-a-date-picekr)
* [Responding to User Interaction](#responding-to-user-interaction)
* [Debugging Date Pickers](#debugging-date-pickers)
* [Interface Builder Attributes](#interface-builder-attributes)
* [Appearance](#ppearance)
* [Internationalization](#internationalization)
* [Topics](#topics)
    * [Managing the Date and Calendar](#managing-the-date-and-calendar)
    * [Configuring the Date Picker Mode](#configuring-the-date-picker-mode)
    * [Configuring Temporal Attributes](#configuring-temporal-attributes)
    * [Constants](#constants)
* [Relationships](#relationships)
* [See Also](#see-also)
    

&nbsp;      
## Overview
date picker를 사용하여 특정 시점(캘린더 날짜, 시간 값 또는 둘 다) 또는 시간 간격(예: 타이머)을 입력할 수 있다. date picker는 연관된 대상 객체와의 상호 작용을 보고한다.


![](https://docs-assets.developer.apple.com/published/9b72935ec7/d932bb88-19b5-4ce2-bdbe-67298719699d.png)


인터페이스에 date picker를 추가하려면 다음을 수행한다.
1. 생성시 date picker 모드를 설정
2. 필요한 경우 최소 및 최대 날짜와 같은 추가 구성 옵션을 제공
3. date picker에 액션 메서드를 연결
4. 인터페이스에서 date picker의 위치를 제어하는 오토 레이아웃 규칙을 설정


date picker는 시간 및 날짜 선택을 처리하는 데만 사용된다. 리스트에서 임의 항목을 선택하여 처리하려면 [UIPickerView](https://developer.apple.com/documentation/uikit/uipickerview)객체를 사용한다.


&nbsp;
## Configuring a Date Picekr
> Date Picker 구성

date picker의 구성은 프로그래밍 방식 또는 인터페이스 빌더에서 값을 설정할 수 있는 [datePickerMode](https://developer.apple.com/documentation/uikit/uidatepicker/1615997-datepickermode) 프로퍼티에 의해 결정된다. 날짜 또는 시간 값이 포함된 모드의 경우 로케일, 캘린더 및 표준 시간대 정보를 적절하게 구성 할 수도 있다. date picker는 현재 사용자의 날짜 및 시간 값을 형식화할 때 해당 정보를 사용하며, 기본값은 장치의 로케일, 캘린더 및 시간대이다. [date](https://developer.apple.com/documentation/uikit/uidatepicker/1615975-date) 프로퍼티는 현재 선택한 날짜를 [NSDate](https://developer.apple.com/documentation/foundation/nsdate) 객체 형태로 나타내며 캘린더 및 시간대에 무관하다. 


사용자가 선택할 수 있는 날짜 범위를 제한하려면 [minimumDate](https://developer.apple.com/documentation/uikit/uidatepicker/1615980-minimumdate) 및 [maximumDate](https://developer.apple.com/documentation/uikit/uidatepicker/1615999-maximumdate) 프로퍼티에 값을 할당한다. [minuteInterval](https://developer.apple.com/documentation/uikit/uidatepicker/1615998-minuteinterval) 프로퍼티를 사용하여 특정 시간 단위만 허용할 수도 있다.


[datePickerMode](https://developer.apple.com/documentation/uikit/uidatepicker/1615997-datepickermode) 프로퍼티를 [UIDatePicker.Mode.countDownTimer](https://developer.apple.com/documentation/uikit/uidatepicker/mode/countdowntimer)로 설정하면 사용자가 시간과 분으로 기간을 선택할 수 있다. 이 모드에서 [countDownDuration](https://developer.apple.com/documentation/uikit/uidatepicker/1615986-countdownduration) 프로퍼티는 표시된 지속 시간을 [TimeInterval](https://developer.apple.com/documentation/foundation/timeinterval) 초 단위로 나타낸다. 단 몇 초 만에 이 프로퍼티를 설정하더라도 date picker는 값을 분 단위로 표시할 수 있다.


아래 그림은 [datePickerMode](https://developer.apple.com/documentation/uikit/uidatepicker/1615997-datepickermode) 프로퍼티가 [UIDatePicker.Mode.countDownTimer](https://developer.apple.com/documentation/uikit/uidatepicker/mode/countdowntimer)로 설정되고 [minuteInterval](https://developer.apple.com/documentation/uikit/uidatepicker/1615998-minuteinterval) 프로퍼티가 5로 설정된 date picker를 보여준다. [countDownDuration](https://developer.apple.com/documentation/uikit/uidatepicker/1615986-countdownduration)의 값은 현재 4500이다.


![](https://docs-assets.developer.apple.com/published/9b72935ec7/293b359e-e6be-4152-b7e0-c6022f899490.png)


> Note
>
> UIDatePicker 객체를 사용하여 시간 간격을 선택할 수 있지만 실제 타이머 동작을 구현하려면 [Timer](https://developer.apple.com/documentation/foundation/timer) 객체를 사용해야 한다.


&nbsp;
## Responding to User Interaction
> 사용자 상호작용에 대한 응답

Date picker는 사용자가 선택한 날짜를 변경할 때 앱에 알리기 위해 [Target-Action](https://developer.apple.com/library/archive/documentation/General/Conceptual/Devpedia-CocoaApp/TargetAction.html#//apple_ref/doc/uid/TP40009071-CH3) 디자인 패턴을 사용한다. date picker 값이 변경될 때 알림을 받으려면 액션 메서드를 [valueChanged](https://developer.apple.com/documentation/uikit/uicontrol/event/1618238-valuechanged) 이벤트로 등록한다. 런타임에 date picker는 사용자가 날짜 또는 시간을 선택하는 것에 대한 응답으로 메서드를 호출한다.


[addTarget(_:action:for:)](https://developer.apple.com/documentation/uikit/uicontrol/1618259-addtarget) 메서드를 사용하거나 인터페이스 빌더에서 연결을 생성하여 date picker를 액션 메서드에 연결한다. 액션 메서드의 서명은 아래에 나열된 세 가지 형식 중 하나를 취한다. date picker에서 값 변경에 응답해야 하는 정보를 제공하는 양식을 선택한다.
```
@IBAction func doSomething()
@IBAction func doSomething(sender: UIDatePicker)
@IBAction func doSomething(sender: UIDatePicker, forEvent event: UIEvent)
```


&nbsp; 
## Debugging Date Pickers
> Date Picker 디버깅

date picker로 문제를 디버깅 할 때 다음과 같은 일반적인 함정을 살펴본다:
* **최소 날짜는 최대 날짜보다 이전이어야 한다.** [minimumDate](https://developer.apple.com/documentation/uikit/uidatepicker/1615980-minimumdate) 및 [maximumDate](https://developer.apple.com/documentation/uikit/uidatepicker/1615999-maximumdate) 프로퍼티의 범위를 확인한다. 최대 날짜가 최소 날짜보다 작은 경우 두 프로퍼티가 모두 무시되고 date picker를 통해 날짜 값을 선택할 수 있다. 최소 및 최대 날짜는 카운트다운-타이머 모드([UIDatePicker.Mode.countDownTimer](https://developer.apple.com/documentation/uikit/uidatepicker/mode/countdowntimer))에서 무시된다.
* **분 간격은 60의 약수여야 한다.** [minuteInterval](https://developer.apple.com/documentation/uikit/uidatepicker/1615998-minuteinterval) 값을 균등하게 60으로 나눌 수 있는지 확인한다. 그렇지 않으면 기본값이 사용된다(1).


&nbsp;  
## Interface Builder Attributes
> 인터페이스 빌더 속성

아래 표는 인터페이스 빌더의 Attributes Inspector에서 date picker를 구성하는 핵심 속성을 나열한다.


Attribute | Description
------------ | -------------
Mode | date picker 모드이다. date picker가 시간, 날짜, 시간 및 날짜 또는 카운트다운 간격을 표시할지 여부를 결정한다. [datePickerMode](https://developer.apple.com/documentation/uikit/uidatepicker/1615997-datepickermode) 프로퍼티를 사용하여 런타임에 이 값에 접근한다. 
Locale | date picker와 연관된 로케일이다. 이 프로퍼티는 시스템 디폴트를 특정 로케일로 재정의할 수 있게 한다. [locale](https://developer.apple.com/documentation/uikit/uidatepicker/1615995-locale) 프로퍼티를 사용하여 프로그래밍 방식으로 이 속성에 접근할 수 있다.
Interval | 현재 모드로 표시된 경우 분 스피너의 세분성이다. 기본값은 1이고 최대 값은 30이다. 선택한 값은 60의 제수(1, 2, 3, 4, 5, 6, 10, 12, 15, 20, 30)이어야 한다. [minuteInterval](https://developer.apple.com/documentation/uikit/uidatepicker/1615998-minuteinterval) 프로퍼티를 사용하여 런타임에 이 값에 접근한다.


아래 표는 date picker에서 날짜 및 시간 표시를 제어하는 속성이 나열되어 있다.

Attribute | Description
------------ | -------------
Date | date picker가 표시할 초기 날짜이다. 기본값은 현재 날짜이지만 사용자 정의 값을 설정할 수 있다. 이 속성은 [date](https://developer.apple.com/documentation/uikit/uidatepicker/1615975-date) 프로퍼티를 프로그래밍 방식으로 설정하는 것과 같다.  
Constraints | date picker에 표시되는 선택 가능한 날짜 범위. 동적 범위를 사용하려면 [minimumDate](https://developer.apple.com/documentation/uikit/uidatepicker/1615980-minimumdate) 및 [maximumDate](https://developer.apple.com/documentation/uikit/uidatepicker/1615999-maximumdate) 프로퍼티를 프로그래밍 방식으로 구성한다. Mode 속성이 Count Down Timer로 설정된 경우 date picker는 이러한 옵션을 무시한다. 
Timer | 카운트다운 타이머 모드에서 사용될 때 date picker의 초기 값. 값은 초 단위로 측정되지만 디스플레이는 분 단위이다.


> Note
>
> 인터페이스 빌더를 사용하여 Mode 속성을 Count Down Timer로 설정하고 timer 속성 값을 지정하면 프로젝트를 빌드하고 실행할 때 date picker가 Timer 속성 값을 준수하지 않을 수 있다. 이 경우 date picker에  Attributes Inspector로 돌아가서 Date 팝업 메뉴에서 Custom을 선택하고(관련 값을 무시할 수 있음) 프로젝트를 다시 빌드한다.


&nbsp;
## Appearance

UIDatePicker의 appearance는 사용자 정의할 수 없다.


오토 레이아웃을 사용하여 레이아웃에서 date picker를 통합해야 한다. date picker는 크기를 조정할 수 있지만 본질적인 콘텐츠 크기로 사용해야 한다.


&nbsp;  
## Internationalization
> 국제화

date picker는 적절한 로케일을 지정하면 자체적으로 국제화를 처리한다. Attributes Inspector에서 Locale([locale](https://developer.apple.com/documentation/uikit/uidatepicker/1615995-locale)) 필드를 설정하여 date picker가 나타날 특정 로케일을 선택할 수 있다. 이렇게하면 date picker 표시에 사용하는 언어가 변경되지만 날짜와 시간의 형식(예: 특정 로케일에서 월 이전에 일이 표시되거나 12시간 시계보다 24시간 시계를 선호하는 경우)이 변경된다. date picker의 너비는 자국어 길이에 맞게 자동으로 조정된다. 시스템 언어를 사용하려면 이 등록 정보를 기본값으로 둔다.


&nbsp;
## Topics
### Managing the Date and Calendar
> 날짜 및 캘린더 관리

* `var calendar: Calendar!`
    * date picker에 사용할 캘린더
* `var date: Date`
    * date picker에 표시될 날짜
* `var locale: Locale?`
    * date picker에서 사용하는 로케일
* `func setDate(Date, animated: Bool)`
    * date picker에 표시할 날짜를 설정하고 애니메이션을 설정하는 옵션을 제공한다.
* `var timeZone: TimeZone?`
    * date picker에 표시된 날짜에 반영된 시간대
    

### Configuring the Date Picker Mode
> Date Picker Mode 구성

* `var datePickerMode: UIDatePicker.Mode`
    * date picker 모드
    
    
### Configuring Temporal Attributes
> 임시 속성 구성

* `var maximumDate: Date?`
    * date picker가 표시할 수 있는 최대 날짜
* `var minimumDate: Date?`
    * date picker가 표시할 수 있는 최소 날짜
* `var minuteInterval: Int`
    * date picker가 분을 표시해야 하는 간격
* `var countDownDuration: TimerInterval`
    * mode 프로퍼티가 [UIDatePicker.Mode.countDownTimer](https://developer.apple.com/documentation/uikit/uidatepicker/mode/countdowntimer)로 설정된 경우 date picker에 표시되는 값
    
    
### Constants
* `enum UIDatePicker.Mode`
    * date picker에 표시되는 모드 열거형


&nbsp;      
## Relationships
### Inherits From
* UIControl


### Conforms To
* CVarArg
* Equatable
* Hashable
* NSCoding
* UIAccessibilityIdentification
* UIPasteConfigurationSupporting
* UIUserActivityRestoring


&nbsp;
## See Also
* class UIControl
* class UIButton
* class UIPageControl
* class UISegmentedControl
* class UISlider
* class UIStepper
* class UISwitch


&nbsp;      
&nbsp;      
### [by. 0junChoi](https://github.com/0jun0815) email: <0jun0815@gmail.com>
### [Apple Developer Documentation UIDatePicker](https://developer.apple.com/documentation/uikit/uidatepicker)
