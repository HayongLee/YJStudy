# UIApplication
> iOS에서 실행되는 앱의 중앙 집중식 제어 및 조정 지점이다.


* [Overview](#overview)
* [Subclassing Notes](#subclassing-notes)
* [Topics](#topics)
    * [Getting the App Instance](#getting-the-app-instance)
    * [Managing the App's Behavior](#managing-the-app's-behavior)
    * [Registering for Remote Notifications](#registering-for-remote-notifications)
    * [Managing Background Execution](#managing-background-execution)
    * [Opening a URL Resource](#opening-a-url-resource)
    * [Managing the App Idle Timer](#managing-the-app-idle-timer)
    * [Managing Home Screen Quick Actions for 3D Touch](#managing-home-screen-quick-actions-for-3d-touch)
    * [Determining the Availability of Protected Content](#determining-the-availability-of-protected-content)
    * [Registering for Remote Control Events](#registering-for-remote-control-events)
    * [Controlling App Appearance](#controlling-app-appearance)
    * [Controlling and Handling Events](#controlling-and-handling-events)
    * [Managing the App's Icon](#managing-the-app's-icon)
    * [Getting App Windows](#getting-app-windows)
    * [Getting the Font Sizing Preference](#getting-the-font-sizing-preference)
    * [Managing the Default Interface Orientations](#managing-the-default-interface-orientations)
    * [Managing Status Bar Orientation](#managing-status-bar-orientation)
    * [Constants](#constants)
    * [Notifications](#notifications)
    * [Deprecated Symbols](#deprecated-symbols)
* [Relationships](#relationships)
    * [Inherits From](#inherits-from)
    * [Conforms To](#conforms-to)
* [See Also](#see-also)
    * [Application](#Application)
    

&nbsp;      
## Overview
모든 iOS 앱에는 UIApplication 인스턴스(또는 매우 드물게 UIApplication의 하위 클래스)가 하나만 있다. 앱이 시작되면 시스템은 [UIApplicationMain(_:_:_:_:)](https://developer.apple.com/documentation/uikit/1622933-uiapplicationmain) 함수를 호출한다. 다른 작업들 사이에서 이 함수는 Singleton UIApplication 객체를 만든다. 그런 다음 [shared](https://developer.apple.com/documentation/uikit/uiapplication/1622975-shared) 클래스 메서드를 호출하여 객체에 접근한다.


앱의 application 객체의 주요 역할은 들어오는 사용자 이벤트의 초기 라우팅을 처리하는 것이다. 컨트롤 객체([UIControl](https://developer.apple.com/documentation/uikit/uicontrol) 클래스의 인스턴스)가 적절한 대상 객체에게 전달된 액션 메시지를 전달한다. application 객체는 오픈 윈도우([UIWindow](https://developer.apple.com/documentation/uikit/uiwindow) objects)의 목록을 유지 관리하며 이를 통해 앱의 [UIView](https://developer.apple.com/documentation/uikit/uiview) 객체를 검색 할 수 있다.


UIApplication 클래스는 [UIApplicationDelegate](https://developer.apple.com/documentation/uikit/uiapplicationdelegate) 프로토콜을 준수하고 일부 프로토콜 메서드를 구현해야 하는 델리게이트를 정의한다. application 객체는 델리게이트에게 중요한 런타임 이벤트(예: 앱 시작, 메모리 부족 경고, 앱 종료)를 알리고 적절히 응답할 기회를 제공한다.


앱은 [openURL(_:)](https://developer.apple.com/documentation/uikit/uiapplication/1622961-openurl) 메서드를 통해 전자 메일이나 이미지 파일과 같은 리소스를 공동으로 처리할 수 있다. 예를 들어 전자 메일 URL로 이 메서드를 호출하는 앱은 메일 앱을 시작하고 메시지를 표시한다.


이 클래스의 API를 사용하여 장치별 동작을 관리할 수 있다. UIApplication 객체를 사용하여 다음 작업을 수행한다:
* 들어오는 터치 이벤트 일시 중지([beginIgnoringInteractionEvents()](https://developer.apple.com/documentation/uikit/uiapplication/1623047-beginignoringinteractionevents))
* 원격 알림 등록([registerForRemoteNotifications()](https://developer.apple.com/documentation/uikit/uiapplication/1623078-registerforremotenotifications))
* undo-redo UI 트리거([applicationSupportsShakeToEdit](https://developer.apple.com/documentation/uikit/uiapplication/1623127-applicationsupportsshaketoedit))
* URL 스키마를 처리하도록 등록된 앱이 설치되어 있는지 확인([canOpenURL(_:)](https://developer.apple.com/documentation/uikit/uiapplication/1622952-canopenurl))
* 백그라운드에서 작업을 완료할 수 있도록 앱 실행 확장([beginBackgroundTask(expirationHandler:)](https://developer.apple.com/documentation/uikit/uiapplication/1623031-beginbackgroundtask), [beginBackgroundTask(withName:expirationHandler:)](https://developer.apple.com/documentation/uikit/uiapplication/1623051-beginbackgroundtask))
* 로컬 알림 예약 및 취소([scheduleLocalNotification(_:)](https://developer.apple.com/documentation/uikit/uiapplication/1623005-schedulelocalnotification), [cancelLocalNotification(_:)](https://developer.apple.com/documentation/uikit/uiapplication/1623082-cancellocalnotification))
* 원격 제어 이벤트 수신 조정([beginReceivingRemoteControlEvents()](https://developer.apple.com/documentation/uikit/uiapplication/1623126-beginreceivingremotecontrolevent), [endReceivingRemoteControlEvents()](https://developer.apple.com/documentation/uikit/uiapplication/1623057-endreceivingremotecontrolevents))
* 앱-레벨 상태 복원 작업 수행([Managing the State Restoration Behavior](https://developer.apple.com/documentation/uikit/uiapplication#1657552) 작업 그룹의 메서드)


&nbsp;
## Subclassing Notes
대부분의 앱은 UIApplication 서브 클래스가 필요 없다. 대신 앱 델리게이트를 사용하여 시스템과 앱 간의 상호 작용을 관리한다.


앱이 들어오는 이벤트를 시스템이 처리하기 전에 처리해야 하는 경우(매우 드문 상황) 사용자 정의 이벤트 또는 액션 디스패치 메커니즘을 구현할 수 있다. 이렇게하려면 UIApplication을 서브클래스화하고 [sendEvent(_:)](https://developer.apple.com/documentation/uikit/uiapplication/1623043-sendevent) 또는 [sendAction(_:to:from:for:)](https://developer.apple.com/documentation/uikit/uiapplication/1622946-sendaction) 메서드를 재정의한다. 가로챈 모든 이벤트에 대해 이벤트를 처리한 후 [super sendEvent: event]를 호출하여 시스템에 이벤트를 다시 전달한다. 이벤트를 가로채는 것은 거의 필요하지 않으며 가능하면 피해야 한다.


&nbsp;
## Topics
### Getting the App Instance
> 앱 인스턴스 가져오기

* `class var shared: UIApplication`
    * 싱글턴 앱 인스턴스를 반환한다.
    

### Managing the App's Behavior
> 앱의 행동 관리하기

* `var delegate: UIApplicationDelegate?`
    * 앱 객체의 델리게이트
* `protocol UIApplicationDelegate`
    * 앱의 수명기간 중 중요한 이벤트에 대한 응답으로 싱글턴 UIApplication 객체에 의해 호출되는 메서드 세트이다.


### Registering for Remote Notifications
> 원격 알림 등록

* `func registerForRemoteNotifications()`
    * Apple Push Notification 서비스를 통해 원격 알림 수신 등록
* `func unregisterForRemoteNotifications()`
    * Apple Push Notification 서비스를 통해 수신된 모든 원격 알림 등록을 취소한다.
* `var isRegisteredForRemoteNotifications: Bool`
    * 앱이 현재 원격 알림에 등록되어 있는지 여부를 나타내는 부울 값


### Managing Background Execution
> 백그라운드 실행 관리

* `var applicationState: UIApplicationState`
    * 앱의 런타임 상태이다.
* `var backgroundTimeRemaining: TimeInterval`
    * 앱이 백그라운드에서 실행되어야 하는 시간이다.
* `var backgroundRefreshStatus: UIBackgroundRefreshStatus`
    * 백그라운드 동작을 수행할 수 있도록 백그라운드에서 실행되는 앱의 기능
* `func setMinimumBackgroundFetchInterval(TimeInterval)`
    * 백그라운드 페치 동작 사이에 경과해야 하는 최소 시간을 지정한다.
* `func beginBackgroundTask(withName: String?, expirationHandler:(() -> Void)? = nil)`
    * 지정된 이름의 새로운 장기 실행 백그라운드 태스크의 시작을 표시한다.
* `func beginBackgroundTask(expirationHandler: (() -> Void)? = nil)`
    * 새로운 장기 실행 백그라운드 작업의 시작을 표시한다.
* `func endBackgroundTask(UIBackgroundTaskIdentifier)`
    * 특정 장기 실행 백그라운드 작업의 끝을 표시한다.


### Opening a URL Resource
> URL 리소스 열기

* `func open(URL, options: [String: Any] = [:], completionHandler: ((Bool) -> Void)? = nil)`
    * 지정된 URL에서 비동기적으로 리소르를 열려고 시도한다.
* `func canOpenURL(URL)`
    * URL 스키마가 장치에 설치된 일부 애플리케이션에서 처리 될 수 있는지 여부를 나타내는 부울 값을 반환한다.


### Managing the App Idle Timer
> 앱 유휴 타이머 관리

* `var isIdleTimerDisabled: Bool`
    * 앱에서 유휴 타이머를 사용하지 않도록 설정할지 여부를 제어하는 부울 값


### Managing the State Restoration Behavior
> 상태 회복 행동 관리

* `func extendStateRestoration()`
    * 코드가 비동기로 상태를 복원하고 있다는 것을 앱에 알린다.
* `func completeStateRestoration()`
    * 비동기 상태 복원이 완료되었음을 앱에 알린다.
* `func ignoreSnapshotOnNextApplicationLaunch()`
    * 다음 실행 주기 중에 앱이 최근 스냅 샷 이미지를 사용하지 못하게 한다.
* `class func registerObject(forStateRestoration: UIstateRestoring, restorationIdentifier: String)`
    * 상태 복원 시스템에서 사용할 사용자 정의 객체를 등록한다.


### Managing Home Screen Quick Actions for 3D Touch
> 3D 터치를 위한 홈 스크린 빠른 동작 관리

* `var shortcutItems: [UIApplicationShortcutItem]?`
    * 홈 스크린은 앱의 동적 빠른 동작을 보여준다. 3D 터치를 지원하는 장치에서 사용 가능하다.


### Determining the Availability of Protected Content
> 보호된 콘텐츠의 가용성 결정

* `var isProtectedDataAvailable: Bool`
    * 콘텐츠 보호가 활성 상태인지 여부를 나타내는 부울 값


### Registering for Remote Control Events
> 원격 제어 이벤트 등록

* `func beginReceivingRemoteControlEvents()`
    * 앱에 원격 제어 이벤트 수신을 시작하도록 알린다.
* `func endReceivingRemoteControlEvents()`
    * 앱에 원격 제어 이벤트 수신을 중단하도록 알린다.


### Controlling App Appearance
> 앱 Appearance(외관, 모양) 제어

* `var statusBarFrame: CGRect`
    * 상태 바의 영역을 정의하는 프레임 사각형이다.
* `var isNetworkActivityIndicatorVisible: Bool`
    * 네트워크 작업 인디케이터를 켜거나 끄는 부울 값이다.
* `var userInterfaceLayoutDirection: UIUserInterfaceLayout`
    * 사용자 인터페이스의 레이아웃 방향을 반환한다.


### Controlling and Handling Events
> 이벤트 제어 및 처리

* `func sendEvnet(UIEvent)`
    * 이벤트를 애플리케이션의 적절한 응답자 객체에게 전달한다.
* `func sendAction(Selector, to: Any?, from: Any?, for: UIEvent?)`
    * selector로 식별된 액션 메시지를 지정된 대상으로 보낸다.
* `func beginIgnoringInteractionEvents()`
    * 수신자에게 터치 관련 이벤트 처리를 일시 중지하도록 알린다.
* `func endIgnoringInteractionEvents()`
    * 수신자에게 터치 관련 이벤트 처리를 재개하도록 알린다.
* `var isIgnoringInteractionEvents: Bool`
    * 수신자가 화면의 터치에 의해 시작된 이벤트를 무시하는지 여부를 나타내는 부울 값
* `var applicationSupportsShakeToEdit: Bool`
    * 장치를 흔들면 undo-redo 사용자 인터페이스가 표시되는지 여부를 결정하는 부울 값


### Managing the App's Icon
> 앱 아이콘 관리

* `var applicationIconBadgeNumber: Int`
    * 현재 스프링보드에 있는 앱 아이콘의 배지로 설정된 숫자
* `var supportsAlternateIcons: Bool`
    * 앱이 아이콘을 변경할 수 있는지 여부를 나타내는 부울 값
* `var alternateIconName: String?`
    * 앱에 표시되는 아이콘의 이름
* `func setAlternateIconName(String?, completionHandler: ((Error?) -> Void)? = nil)`
    * 앱의 아이콘을 변경한다.


### Getting App Windows
> 앱 Windows 가져오기

* `var keyWindow: UIWindow?`   
    * 앱의 주요 윈도우
* `var windows: [UIWindow]`
    * 앱의 표시된 숨겨진 윈도우


### Getting the Font Sizing Preference
> 글꼴 크기 지정 환결 설정 가져오기

* `var preferredContentSizeCategory: UIContentSizeCategory`
    * 사용자가 선호하는 글꼴 크기 조정 옵션


### Managing the Default Interface Orientations
> 기본 인터페이스 방향 관리

* `func supportedInterfaceOrientations(for: UIWindow?)`
    * 지정된 윈도우에 있는 뷰 컨트롤러에 사용할 기본 인터페이스 방향 집합을 반환한다.
* `func UIInterfaceOrientationIsLandscape(UIInterfaceOrientation)`
* `func UIInterfaceOrientationIsPortrait(UIInterfaceOrientation)`


### Managing Status Bar Orientation
> 상태 바 방향 관리

* `var statusBarOrientationAnimationDuration: TimeInterval`
    * 90도 방향 변경 중에 상태 막대의 애니메이션 지속 시간(초).


### Constants
> 상수

* `enum UIApplicationState`
    * 앱의 실행 상태
* `typealias UIBackgroundTaskIdentifier`
    * 백그라운드에서 실행될 요청을 식별하는 고유한 토큰이다.
* `Background Task Constants`
    * 백그라운드에서 실행될 때 사용되는 상수
* `enum UIBackgroundFetchResult`
    * 백그라운드 페치 동작의 결과를 나타내는 상수
* `Fetch Intervals`
    * 백그라운드 다운로드의 패치 간격을 나타내는 상수
* `enum UIBackgroundRefreshStatus`
    * 앱의 백그라운드 실행을 사용할지 여부를 나타내는 상수
* `enum UIInterfaceOrientation`
    * 앱 사용자 인터페이스의 방향
* `struct UIInterfaceOrientationMask`
    * 이 상수는 뷰 컨트롤러가 지원하는 인터페이스 방향을 지정하기위한 마스크 비트이다.
* `enum UIUserInterfaceLayoutDirection`
    * 사용자 인터페이스의 방향 흐름을 지정한다.
* `enum UIStatusBarStyle`
    * 장치의 상태 바 스타일
* `enum UIStatusBarAnimation`
    * 상태 바에 숨겨지거나 보여질때 적용되는 애니메이션
* `Settings Launch URL`
    * 앱의 설정을 여는데 사용되는 상수
* `URL Options`
* `UserInfo Dictionary Keys`
    * 일부 UIApplication-posted 알림의 userInfo 딕셔너리 값에 접근하는데 사용되는 키
* `Content Size Category Constants`
    * 사용자가 선호하는 글꼴 크기를 나타내는 상수
* `Accessibility Content Size Category Constants`
    * 접근 가능성을 사용할 때 기본 글꼴 크기를 나타내는 상수
* `Key for Content Size Change Notifications`
    * 새 콘텐츠 크기 카테고리를 식별하는 키
* `Extension Point Identifier Constants`
    * 앱에서 허용하지 않을 확장 점을 식별하는 상수
* `Run Loop Mode for Tracking`
    * 컨트롤을 추적하는 동안 모드가 발생한다.
* `Exceptions`
    * 다음 상수는 앱에서 throw 할 수 있는 예외를 정의한다.
* `struct UIContentSizeCategory`
    * 콘텐츠의 적절한 사이즈를 나타내는 상수이다.


### Notifications
> 알림

모든 UIApplication 알림은 [shared](https://developer.apple.com/documentation/uikit/uiapplication/1622975-shared)에 의해 반환돈 앱 인스턴스에 의해 게시된다.

* `static let UIApplicationBackgroundRefreshStatusDidChange: NSNotification.Name`
    * 백그라운드에서 콘텐츠를 다운로드 하기위한 앱의 상태가 변경되면 게시 됨
* `static let UIApplicationDidBecomeActive: NSNotification.Name`
    * 앱이 활성화되면 게시 됨
* `static let UIApplicationDidChangeStatusBarFrame: NSNotification.Name`
    * 상태 바의 프레임이 변경되면 게시 됨
* `static let UIApplicationDidChangeStatusBarOrientation: NSNotification.Name`
    * 앱 사용자 인터페이스의 방향이 바뀔 때 게시된다.
* `static let UIApplicationDidEnterBackground: NSNotification.Name`
    * 앱이 백그라운드에 입장하면 게시된다.
* `static let UIApplicationDidFinishLaunching: NSNotification.Name`
    * 앱 실행 시작 직후에 게시된다.
* `static let UIApplicationDidReceiveMemoryWarning: NSNotification.Name`
    * 앱이 메모리 부족에 대해 운영체제로부터 경고를 받으면 게시된다.
* `static let UIApplicationProtectedDataDidBecomeAvailable: NSNotification.Name`
    * 코드가 접근 할 수 있도록 보호된 파일을 사용할 수 있게되면 게시된다.
* `static let UIApplicationProtectedDataWillBecomeUnavailable: NSNotification.Name`
    * 보호된 파일이 잠겨져 접근할 수 없게되기 직전에 게시된다.
* `static let UIApplicationSignificantTimeChange: NSNotification.Name`
    * 예를 들어, 새로운 날(자정), 이동 통신사 시간 업데이트, 일광 절약 시간 변경 등 중요한 시간대 변경이 있는 경우 게시된다.
* `static let UIApplicationUserDidTakeScreenshot: NSNotification.Name`
    * 사용자가 홈 및 잠금 버튼을 눌러 스크린 샷을 찍을 때 게시 됨
* `static let UIApplicationWillChangeStatusBarOrientation: NSNotification.Name`
    * 앱이 인터페이스의 방향을 바꿀 때 게시 됨
* `static let UIApplicationWillChangeStatusBarFrame: NSNotification.Name`
    * 앱이 상태 바의 프레임을 변경하려고 할 때 게시됨
* `static let UIApplicationWillEnterForeground: NSNotification.Name`
    * 앱이 백그라운드 상태에서 활성 앱이되기 직전에 게시된다.
* `static let UIApplicationWillResignActive: NSNotification.Name`
    * 앱이 더이상 활성화되어 있지 않고 포커스를 잃었을 때 게시된다.
* `static let UIApplicationWillTerminate: NSNotification.Name`
    * 앱이 곧 종료 될 때 게시된다.
* `static let UIContentSizeCategoryDidChange: NSNotification.Name`
    * 사용자가 기본 콘텐츠 크기 설정을 변경하면 게시된다.


### Deprecated Symbols
> 사용되지 않는 기호

* ~~`func registerUserNotificationSettings(UIUserNotificationSettings)`~~
* ~~`var currentUserNotificationSettings: UIUserNotificationSettings?`~~
* ~~`struct UIRemoteNotificationType`~~
* ~~`func openURL(URL)`~~
* ~~`func scheduleLocalNotification(UILocalNotification)`~~
* ~~`func presentLocalNotificationNow(UILocalNotification)`~~
* ~~`func cancelLocalNotification(UILocalNotification)`~~
* ~~`func cancelAllLocalNotifications()`~~
* ~~`var scheduledLocalNotifications: [UILocalNotification]?`~~
* ~~`func setNewsstandIconImage(UIImage?)`~~
* ~~`func setKeepAliveTimeout(TimeInterval, handler: (() -> Void)? = nil)`~~
* ~~`func clearKeepAliveTimeout()`~~
* ~~`func setStatusBarHidden(Bool, with: UIStatusBarAnimation)`~~
* ~~`var isStatusBarHidden: Bool`~~
* ~~`func setStatusBarStyle(UIStatusBarStyle, animated: Bool)`~~
* ~~`var statusBarStyle: UIStatusBarStyle`~~
* ~~`func setStatusBarOrientation(UIInterfaceOrientation, animated: Bool)`~~
* ~~`var statusBarOrientation: UIInterfaceOrientation`~~
* ~~`func registerForRemoteNotifications(matching: UIRemoteNotificationType)`~~
* ~~`func enabledRemoteNotificationTypes()`~~


&nbsp;      
## Relationships
### Inherits From
* UIResponder


### Conforms To
* CVarArg
* Equatable
* Hashable
* UIPasteConfigurationSupporting


&nbsp;      
## See Also
### Application
* [Managing Your App's Life Cycle](https://developer.apple.com/documentation/uikit/core_app/managing_your_app_s_life_cycle)
    * 앱 델리게이트가 앱의 상위 수준 동작을 관리하는 방식을 이해한다.
* `protocol UIApplicationDelegate`
    * 싱글턴에 의해 호출되는 메서드 세트, UIApplication 앱 생명주기의 중요한 사건에 대한 응답을 한다.
* `func UIApplicationMain(Int32, UnsafeMutablePointer<UnsafeMutablePointer<Int8>>!, String?, String?)`
    * 애플리케이션 객체와 애플리케이션 델리게이트를 만들고 이벤트 주기를 설정한다.


&nbsp;      
&nbsp;      
### [by. 0junChoi](https://github.com/0jun0815) email: <0jun0815@gamil.com>
### [Apple Developer Documentation UIApplication](https://developer.apple.com/documentation/uikit/uiapplication)
