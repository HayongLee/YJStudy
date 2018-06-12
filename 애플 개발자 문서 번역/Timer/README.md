# Timer
특정 시간 간격이 지난 후 시작되어 지정된 메시지를 대상 객체로 보내는 타이머이다.


* [Overview](#overview)
* [Comparing Repeating and Nonrepeating Timers](#comparing-repeating-and-nonrepeating-timers)
* [Timer Tolerance](#timer-tolerance)
* [Scheduling Timers in Run Loops](#scheduling-timers-in-run-loops)
* [Subclassing Notes](#subclassing-notes)
* [Topics](#topics)
    * [Creating a Timer](#creating-a-timer)
    * [Firing a Timer](#firing-a-timer)
    * [Stopping a Timer](다)
    * [Retrieving Timer Information](#retrieving-timer-information)
    * [Configuring Firing Tolerance](#configuring-firing-tolerance)


&nbsp;      
## Overview
타이머는 런 루프와 함께 작동한다. 런 루프는 타이머에 대한 강한 참조를 유지하므로 런 루프에 추가한 후 타이머에 대한 자신만의 강한 참조를 유지할 필요가 없다.


타이머를 효과적으로 사용하려면 런 루프가 작동하는 방법을 알아야 한다. 자세한 내용은 [Threading Programming Guide](https://developer.apple.com/library/content/documentation/Cocoa/Conceptual/Multithreading/Introduction/Introduction.html#//apple_ref/doc/uid/10000057i)를 참조한다.


타이머는 실시간 메커니즘이 아니다. 장시간 런 루프 콜아웃 중에 타이머의 실행 시간이 발생하거나 런 루프가 타이머를 모니터링하지 않는 모드에 있는 경우 런 루프가 타행머를 확인할 때까지 타이머가 실행되지 않는다. 따라서 타이머가 실제로 실행되는 시간은 훨씬 늦을 수 있다. [Timer Tolerance](#timer-tolerance) 참조.


타이머는 Core Foundation, CFRunLoopTimer의 toll-free bridged이다. [Toll-Free-Bridging](https://developer.apple.com/library/content/documentation/General/Conceptual/CocoaEncyclopedia/Toll-FreeBridgin/Toll-FreeBridgin.html#//apple_ref/doc/uid/TP40010810-CH2) 참조


&nbsp;      
## Comparing Repeating and Nonrepeating Timers
타이머가 생성될 때 반복 또는 비반복 여부를 지정한다. 비반복 타이머는 한 번 실행된 다음 자동으로 무효화되므로 타이머가 다시 실행되지 않는다. 대조적으로 반복 타이머는 실행되고 동일한 런 루프에서 자체적으로 일정을 조정한다. 반복 타이머는 실제 실행 시간이 아닌 예약 실행 시간에 따라 항상 일정을 잡는다. 예를 들어 타이머가 특정 시간 및 그 이후 5초마다 실행되도록 예약된 경우 실제 실행 시간이 지연 되더라도 예약된 실행 시간은 항상 원래의 5초 간격으로 떨어진다. 실행 시간이 예약된 실행 시간 중 하나 이상을 지날 때까지 지연되면 실행 시간은 해당 시간동안 한 번만 실행된다. 이후 타이머는 실행 후 다음의 예약된 발사 시간 동안 재조정된다.


&nbsp;      
## Timer Tolerance
iOS7, macOS 10.9 이상에서는 타이머 허용 오차([tolerance](#configuring-firing-tolerance))를 지정할 수 있다. 타이머가 작동할 때의 이러한 유연성 덕분에 시스템의 전력 절감 및 응답성을 최적화할 수 있다. 타이머는 예약된 실행 날짜와 예약된 실행 날짜에 허용 오차를 더한 시간 사이에 언제든지 실행될 수 있다. 타이머는 예약된 실행 날짜 전에 실행하지 않는다. 반복 타이머의 경우, 다음 실행 날짜는 이동을 피하기 위해 개별 실행 시간에 적용되는 허용 오차와 관계없이 원래 실행 날짜로부터 계산된다. 기본값은 0이며 추가 허용 오차가 적용되지 않음을 의미한다. 시스템은 [tolerance](#configuring-firing-tolerance) 프로퍼티 값에 관계없이 특정 타이머에 대해 적은 양의 허용 오차를 적용할 수 있는 권리를 보유한다.


타이머 사용자는 타이머의 적절한 허용 오차를 결정할 수 있다. 일반적인 규칙은 반복 타이머의 경우 허용 오차를 시간 간격의 최소 10%로 설정한다. 소량의 허용 오차라도 애플리케이션의 전력 사용에 상당한 긍정적 영향을 미친다. 시스템은 허용 오차에 최대값을 적용할 수 있다.


&nbsp;      
## Scheduling Timers in Run Loops
한 번에 하나의 런 루프에서만 타이머를 등록할 수 있지만 런 루프 내에서 여러 개의 런 루프 모드에 추가할 수 있다. 타이머를 만드는 세 가지 방법이 있다:


* [scheduledTimer(timeInterval:invocation:repeats:)](#creating-a-timer) 또는 [scheduledTimer(timeInterval:target:selector:userInfo:repeats:)](#creating-a-timer) 클래스 메서드를 사용하여 타이머를 만들고 기본 모드의 현재 런 루프에서 타이머를 예약한다.
* [init(timeInterval:invocation:repeats:)](#creating-a-timer) 또는 [init(timeInterval:target:selector:userInfo:repeats:)](#creating-a-timer) 클래스 메서드를 사용하여 런 루프에서 예약하지 않고 타이머 객체를 만든다. (생성한 후에는 해당 RunLoop 객체의 [add(_:forMode:)](https://developer.apple.com/documentation/foundation/runloop/1418468-add) 메서드를 호출하여 수동으로 런 루프에 타이머를 추가해야 한다.) 
* 타이머를 할당하고 [init(fireAt:interval:target:selector:userInfo:repeats:)](#creating-a-timer) 메서드를 사용하여 타이머를 초기화한다. (생성한 후에는 해당 RunLoop 객체의 [add(_:forMode:)](https://developer.apple.com/documentation/foundation/runloop/1418468-add) 메서드를 호출하여 수동으로 런 루프에 타이머를 추가해야 한다.) 


런 루프에서 예약되면 타이머는 무효화 될 때까지 지정된 간격으로 실행된다. 비반복 타이머는 실행된 후 즉시 무효화된다. 그러나 반복 타이머의 경우 [invalidate()](#stopping-a-timer) 메서드를 호출하여 타이머 객체를 직접 무효화해야 한다. 이 메서드를 호출하면 현재 런 루프에서 타이머를 제거하도록 요청한다. 결과적으로 타이머가 설치된 동일한 스레드에서 항상 [invalidate()](#stopping-a-timer) 메서드를 호출해야 한다. 타이머를 무효화하면 런 루프에서 더 이상 영향을 미치지 않도록 타이머가 즉시 비활성화된다. 그런 다음 런 루프는 [invalidate()](#stopping-a-timer) 메서드가 반환되기 직전이나 나중에 해당 시점에서 타이머(그리고 타이머에 대한 강한 참조)를 제거한다. 일단 무효화되면, 타이머 객체는 재사용될 수 없다.


반복되는 타이머가 실행된 후에는 마지막 예약된 실행 날짜 이후의 타이머 간격의 정수배인 가장 가까운 미래 날짜에 대해 지정된 [tolerance](#configuring-firing-tolerance) 내에서 다음 실행을 예약한다. 셀럭터를 수행하는데 걸리는 시간 또는 호출이 지정된 간격보다 긴 경우, 타이머는 다음 실행만 예약한다. 즉 타이머는 지정된 셀럭터 또는 호출을 수행하는 동안 발생한 누락된 실행을 보완하지 않는다.


&nbsp;      
## Subclassing Notes
Timer를 서브클래스화하지 않는다.


&nbsp;      
## Topics
### Creating a Timer
* `class func scheduledTimer(withTimeInterval: TimeInterval, repeats: Bool, block: (Timer) -> Void)`
    * 타이머를 만들고 기본 모드의 현재 런 루프에서 타이머를 예약한다.
* `class func scheduledTimer(timeInterval: TimeInterval, target: Any, selector: Selector, userInfo: Any?, repeats: Bool)`
    * 타이머를 만들고 기본 모드의 현재 런 루프에서 타이머를 예약한다. 
* `class func scheduledTimer(timeInterval: TimeInterval, invocation: NSInvocation, repeats: Bool)`
    * 새 타이머를 만들고 기본 모드의 현재 런 루프에서 타이머를 예약한다. 
* `init(timeInterval: TimeInterval, repeats: Bool, block: (Timer) -> Void)`
    * 지정된 시간 간격 및 블록을 사용하여 타이머 객체를 초기화한다.
* `init(timeInterval: TimeInterval, target: Any, selector: Selector, userInfo: Any?, repeats: Bool)`
    * 지정된 객체 및 셀렉터를 사용하여 타이머 객체를 초기화한다.
* `init(timeInterval: TimeInterval, invocation: NSInvocation, repeats: Bool)`
    * 지정된 호출 객체로 타이머 객체를 초기화한다.
* `init(fire: Date, interval: TimeInterval, repeats: Bool, block: (Timer) -> Void)`
    * 지정된 날짜와 시간 간격, 지정된 블록을 사용하여 타이머를 초기화한다.
* `init(fireAt: Date, interval: TimeInterval, target: Any, selector: Selector, userInfo: Any?, repeats: Bool)`
    * 지정된 객체 및 셀렉터를 사용하여 타이머를 초기화한다.


&nbsp;
## Firing a Timer
* `func fire()`
    * 타이머의 메세지를 타겟에 송신한다.


&nbsp;
## Stopping a Timer
* `func invalidate()`
    * 타이머가 다시 실행되는 것을 중지하고 런 루프에서 타이머를 제거하도록 요청한다.


&nbsp;    
## Retrieving Timer Information
* `var isValid: Bool`
    * 타이머가 현재 유효한지 여부를 나타내는 부울 값
* `var fireDate: Date`
    * 타이머가 시작되는 날짜
* `var timeInterval: TimeInterval`
    * 타이머의 시간 간격(초)
* `var userInfo: Any?`
    * 리시버의 userInfo 객체


&nbsp;    
## Configuring Firing Tolerance
* `var tolerance: TimeInterval`


&nbsp; 
&nbsp;      
### [by. 0junChoi](https://github.com/0jun0815) email: <0jun0815@gmail.com>
### [Apple Developer Documentation Timer](https://developer.apple.com/documentation/foundation/timer)
