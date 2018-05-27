# AVAudioSession
앱에서 오디오를 어떻게 사용할 것인지 시스템과 통신하는 매개 객체이다.


* [Overview](#overview)
* [Topics](#topics)
    * [First Steps](#first-steps)
    * [Configuring the Audio Session](#configuring-the-audio-session)
    * [Activating the Audio Session](#activating-the-audio-session)
    * [Requesting Permission to Record](#requesting-permission-to-record)
    * [Responding to Other Audio](#responding-to-other-audio)
    * [Responding to Audio Session Notifications](#responding-to-audio-session-notifications)
    * [Working with Audio Routes](#working-with-audio-routes)
    * [Working with Audio Channels](#working-with-audio-channels)
    * [Working with Audio Device Settings](#working-with-audio-device-settings)
    * [Setting the Aggregated I/O Preference](#setting-the-aggregated-i/o-preference)
    * [Constants](#constants)
    * [Supporting Types](#supporting-types)


&nbsp;      
## Overview
오디오 세션은 앱과 운영 체제, 그리고 기본 오디오 하드웨어 사이의 중재자 역할을 한다. 오디오 세션을 사용하여 특정 동작 또는 오디오 하드웨어와의 상호 작용에 대해 자세히 설명하지 않고 운영 체제에 애플리케이션의 오디오 특성을 알린다. 이 동작은 이러한 세부 사항의 관리를 오디오 세션에 위임한다. 그러면 운영 체제가 사용자의 오디오 환경을 가장 잘 관리할 수 있다.


모든 iOS 및 tvOS 앱에는 다음과 같이 사전 구성된 기본 오디오 세션이 있다:
* 오디오 재생은 지원되지만 오디오 녹음은 허용되지 않는다(오디오 녹음은 tvOS에서 지원되지 않는다).
* iOS에서 벨소리/무음 스위치를 무음 모드로 설정하면 앱에서 재생되는 모든 오디오가 음소거된다.
* iOS에서는 기기가 잠겨있을 때 앱의 오디오가 음소거된다.
* 앱이 오디오를 재생하면 다른 모든 배경 오디오는 음소거된다.


기본 오디오 세션은 유용한 동작을 제공하지만 미디어 재생 애플리케이션을 제작할 때 필요한 일반적인 오디오 동작을 제공하지는 않는다. 기본 동작을 변경하려면 앱의 오디오 세션 카테고리를 구성한다.


사용할 수 있는 카테고리는 7가지([Audio Session Categories and Modes](https://developer.apple.com/library/content/documentation/Audio/Conceptual/AudioSessionProgrammingGuide/AudioSessionCategoriesandModes/AudioSessionCategoriesandModes.html#//apple_ref/doc/uid/TP40007875-CH10) 참조)이지만 재생 앱에서 가장 필요한 카테고리는 [AVAudioSessionCategoryPlayback](https://github.com/0jun0815/YJStudy/tree/master/애플%20개발자%20문서%20번역/AVAudioSessionCategoryPlayback)이다. 이 카테고리는 오디오 재생이 앱의 핵심 기능임을 나타낸다. 이 카테고리를 지정하면 벨소리/무음 스위치가 무음 모드(iOS 전용)로 설정된 상태에서도 앱의 오디오가 계속된다. 오디오 AirPlay 및 Picture in Picture 백그라운드 모드를 사용하는 경우 앱에서 백그라운드 오디오를 재생할 수도 있다([Enabling Background Audio](https://github.com/0jun0815/YJStudy/tree/master/애플%20개발자%20문서%20번역/Enabling%20Background%20Audio) 참조).


AVAudioSession 객체를 사용하여 앱의 오디오 세션을 구성한다. AVAudioSession은 오디오 세션 카테고리를 설정하고 다른 구성을 수행하는데 사용되는 싱글톤 객체이다. 앱 생명주기 전체에서 오디오 세션과 상호 작용할 수 있지만, 다음 예와 같이 앱 실행시 이 구성을 수행하는 것이 유용한 경우가 많다.
```
func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplicationLaunchOptionsKey: Any]?) -> Bool {
    let audioSession = AVAudioSession.sharedInstance()
    do {
        try audioSession.setCategory(AVAudioSessionCategoryPlayback)
    } catch {
        print("Setting category to AVAudioSessionCategoryPlayback failed.")
    }
    // Other project setup
    return true
}
```
이 카테고리는 `setActive(_:)` 또는 `setActive(_:with:)` 메서드를 사용하여 오디오 세션을 활성화 할 때 사용된다.


> 카테고리를 설정한 후 언제든지 오디오 세션을 활성화 할 수 있지만 일반적으로 앱에서 오디오 재생을 시작할 때 까지 이 호출을 연기하는 것이 좋다. 호출을 연기하면 진행중인 다른 백그라운드 오디오가 중간에 중단되지 않는다.


&nbsp;      
## Topics
### First Steps
카테고리, 모드 및 선호하는 장치 설정을 구성하려면 앱의 싱글톤 오디오 세션 인스턴스에 접근한다.


* `class func sharedInstance()`
    * 공유 오디오 세션 인스턴스를 반환한다.
    
    
&nbsp;      
### Configuring the Audio Session
카테고리, 옵션, 모드를 설정하여 앱의 오디오 세션을 구성한다.


* `var category: String`
    * 현재 오디오 세션 카테고리
* `func setCategory(String)`
    * 현재 오디오 세션 카테고리를 설정한다.
* `func setCategory(String, with: AVAudioSessionCategoryOptions = [])`
    * 지정된 옵션을 사용하여 오디오 세션 카테고리를 설정한다.
* `func setCategory(String, mode: String, options: AVAudioSessionCategoryOptions = [])`
    * 오디오 세션 카테고리, 모드, 원하는 옵션을 설정한다.
* `var availableCategories: [String]`
    * 현재 장치에서 사용할 수 있는 오디오 세션 카테고리
* `var categoryOptions: AVAudioSessionCategoryOptions`
    * 현재 오디오 세션 카테고리와 관련된 옵션 마스크
* `var mode: String`
    * 현재 오디오 세션 모드
* `func setMode(String)`
    * 오디오 세션 모드를 설정한다.
* `var availableModes: [String]`
    * 장치에서 사용할 수 있는 오디오 세션 모드


&nbsp;      
### Activating the Audio Session
카테고리 및 모드 구성으로 오디오 세션을 활성화한다.


* `func setActive(Bool)`
    * 앱의 오디오 세션을 활성화 또는 비활성화한다.
* `func setActive(Bool, with: AVAudioSessionSetActiveOptions = [])`
    * 지정된 옵션을 사용하여 앱의 오디오 세션을 활성화 또는 비활성화한다.


&nbsp;      
### Requesting Permission to Record
오디오를 녹음하기 위해 사용자에게 명시적으로 허용을 요청한다.


오디오 녹음에는 사용자의 명시적인 허용이 필요하다. 처음으로 앱의 오디오 세션에서 녹음을 허용하는 카테고리를 사용 중에 오디오 입력 경로를 사용하려고 시도하면 시스템에서 자동으로 사용자에게 허용을 묻는다. `requestRecordPermission(_:)` 메서드를 호출하여 명시적으로 요청을 할 수 있다. 사용자가 앱에 녹음 을 허용할 때까지는 무음만 녹음할 수 있다.


* `func recordPermission()`
    * 현재 녹음 허용 상태를 반환한다.
* `func requestRecordPermission(PermissionBlock)`
    * 오디오 녹음에 대한 사용자의 허용을 요청한다.


&nbsp;      
### Responding to Other Audio
다른 앱이 백그라운드 오디오를 재생하는지 확인하여 앱에서 오디오를 재생하는 방법을 결정할 수 있다.


* `var isOtherAudioPlaying: Bool`
    * 다른 앱에서 현재 오디오를 재생 중인지 여부를 나타내는 부울 값
* `var secondaryAudioShouldBeSilencedHint: Bool`
    * 다른 앱에서 오디오를 재생하는지 여부를 나타내는 부울 값


&nbsp;      
### Responding to Audio Session Notifications
오디오 세션을 활성화하기 전에 상태 변경 알림을 수신하려면 등록한다.


AVAudioSession은 중단, 경로 변경 및 미디어 서비스 재설정과 같은 중요한 상태 변경을 나타내는 알림을 게시한다. 오디오 세션을 활성화하기 전에 이러한 알림을 수신하려면 등록한다.


* [Responding to Audio Session Interruptions](https://developer.apple.com/documentation/avfoundation/avaudiosession/responding_to_audio_session_interruptions)
* [Responding to Audio Session Route Changes](https://developer.apple.com/documentation/avfoundation/avaudiosession/responding_to_audio_session_route_changes)
    * 오디오 세션 알림을 직접 관찰하여 앱이 중단(인터럽트)에 응답하는지 확인한다.
* `static let AVAudioSessionInterruption: NSNotification.Name`
    * 오디오 중단이 발생할 때 게시된다.
* `static let AVAudioSessionRouteChange: NSNotification.Name`
    * 시스템의 오디오 경로가 변경되면 게시된다.
* `static let AVAudioSessionSilenceSecondaryAudioHint: NsNotification.Name`
    * 다른 애플리케이션의 기본 오디오가 시작되고 중지될 때 게시된다.
* `static let AVAudioSessionMediaServicesWereLost: NSNotification.Name`
    * 미디어 서버가 종료되면 게시된다.
* `static let AVAudioSessionMediaServicesWereReset: NSNotification.Name`
    * 미디어 서버가 다시 시작될 때 게시된다.


&nbsp;      
### Working with Audio Routes
장치 오디오 경로의 상태를 검사하고 원하는 입출력 경로 설정을 구성한다.


오디오 경로는 오디오 신호의 전자 경로이다. 장치 오디오 경로의 상태를 검사하고 원하는 입출력 경로 설정을 구성한다.


* `var currentRoute: AVAudioSessionRouteDescription`
    * 현재의 오디오 입출력 경로를 설명하는 객체
* `var isInputAvailable: Bool`
    * 오디오 입력 경로를 사용할 수 있는지 여부를 나타내는 부울 값
* `var availableInputs: [AVAudioSessionPortDescription]?`
    * 라우팅에 사용할 수 있는 입력 포트의 배열
* `var preferredInput: AVAudioSessionPortDescription?`
    * 오디오 라우팅을 위한 기본 입력 포트
* `func setPreferredInput(AVAudioSessionPortDescription?)`
    * 오디오 라우팅의 기본 입력 포트를 설정한다.
* `var inputDataSources: [AVAudioSessionDataSourceDescription]?`
    * 오디오 세션의 현재 입력 포트에 사용할 수 있는 데이터 소스의 배열
* `var inputDataSource: AVAudioSessionDataSourceDescription?`
    * 현재 선택된 입력 데이터 소스
* `func setInputDataSource(AVAudioSessionDataSourceDescription?)`
    * 오디오 세션의 현재 입력 포트에 대한 데이터 소스를 선택한다.
* `var outputDataSources: [AVAudioSessionDataSourceDescription]?`
    * 현재 오디오 경로에 사용할 수 있는 출력 데이터 소스의 배열
* `var outputDataSource: AVAudioSessionDataSourceDescription?`
    * 현재 선택된 출력 데이터 소스
* `func setOutputDataSource(AVAudioSessionDataSourceDescription?)`
    * 오디오 세션의 출력 데이터 소스를 설정한다.
* `func overrideOutputAudioPort(AVAudioSessionPortOverride)`
    * 일시적으로 현재 오디오 경로를 변경한다.
* `var routeSharingPolicy: AVAudioSessionRouteSharingPolicy`
    * 현재 라우팅 정책
* `func setCategory(String, mode: String, routeSharingPolicy: AVAudioSessionRouteSharingPolicy, options: AVAudioSessionCategoryOptions = [])`
    * 세션 카테고리, 모드, 경로 공유 정책 및 옵션을 설정한다.


&nbsp;      
### Working with Audio Channels
현재 오디오 장치에서 사용 가능한 오디오 입출력 채널 수를 검사하고 구성한다.


* `var inputNumberOfChannels: Int`
    * 현재 경로의 오디오 입력 채널 수
* `var maximumInputNumberOfChannels: Int`
    * 현재 오디오 경로에 사용할 수 있는 최대 입력 채널 수
* `var preferredInputNumberOfChannels: Int`
    * 현재 경로의 기본 입력 채널 수
* `func setPreferredInputNumberOfChannels(Int)`
    * 현재 경로의 기본 입력 채널 수를 설정한다.
* `var outputNumberOfChannels: Int`
    * 오디오 출력 채널 수
* `var maximumOutputNumberOfChannels: Int`
    * 현재 오디오 경로에 사용할 수 있는 최대 출력 채널 수
* `var preferredOutputNumberOfChannels: Int`
    * 현재 경로의 기본 출력 채널 수
* `func setPreferredOutputNumberOfChannels(Int)`
    * 현재 경로의 기본 출력 채널 수를 설정한다.


&nbsp;      
### Working with Audio Device Settings
입력 게인, 샘플 속도, I/O 버퍼 지속 시간과 같은 오디오 장치 설정을 검사하고 구성한다.


* `var inputGain: Float`
    * 세션과 관련된 입력에 적용되는 게인
* `var isInputGainSettable: Bool`
    * 입력 게인을 설정할 수 있는지 여부를 나타내는 부울 값
* `func setInputGain(Float)`
    * 입력 게인을 지정된 값으로 변경한다.
* `var outputVolume: Float`
    * 사용자가 설정한 시스템 전체 출력 볼륨
* `var inputLatency: TimeInterval`
    * 오디오 입력 대기시간(초)
* `var outputLatency: TimeInterval`
    * 오디오 출력 대기시간(초)
* `var sampleRate: Double`
    * 현재 오디오 샘플 속도(헤르츠)
* `var preferredSampleRate: Double`
    * 기본 샘플 속도(헤르츠)
* `func setPreferredSampleRate(Double)`
    * 입출력의 기본 샘플 속도를 설정한다. 
* `var ioBufferDuration: TimeInterval`
    * 현재 I/O 버퍼 지속 시간(초)
* `var preferredIOBufferDuration: TimeInterval`
    * 기본 I/O 버퍼 지속 시간(초)
* `func setPReferredIOBufferDuration(TimeInterval)`
    * 기본 오디오 I/O 버퍼 지속시간(초)을 설정한다.


&nbsp;      
### Setting the Aggregated I/O Preference
집계된 I/O 기본을 설정하여 기본 오디오 입력 동작을 구성한다.


iOS 10부터 AVCaptureSession은 라이브 사진 기능을 지원하는 iPhone 및 iPad에서 기본 오디오 입력 구성을 변경했다. 이 변경은 백그라운드 오디오 재생을 중단하지 않고 라이브 사진을 찍을 수 있게한다. 집계된 I/O 환경을 설정하여 기본 오디오 입력 동작을 구성한다.


* `func setAggregatedIOPreference(AVAudioSessionIOType)`
    * 오디오 세션의 집계된 I/O 구성 환경을 설정한다.


&nbsp;      
### Constants
* `[Audio Session Categories](https://developer.apple.com/documentation/avfoundation/avaudiosession/audio_session_categories)`
    * 세션의 카테고리 프로퍼티를 설정하는데 사용되는 오디오 세션의 카테고리 식별자
* `[Audio Session Modes](https://developer.apple.com/documentation/avfoundation/avaudiosession/audio_session_modes)`
    * 세션의 모드 프로퍼티를 설정하는데 사용되는 오디오 세션의 모드 식별자
* `[Audio Session Error Codes](https://developer.apple.com/documentation/avfoundation/avaudiosession/audio_session_error_codes)`
    * AVAudioSession 메서드에서 반환한 NSError 객체에 사용되는 오류 코드
* `[Interruption Flags](https://developer.apple.com/documentation/avfoundation/avaudiosession/1616458-interruption_flags)`
    * 중단(인터럽트) 후의 오디오 세션 상태를 나타내는 정수
* `[Activation Flags](https://developer.apple.com/documentation/avfoundation/avaudiosession/1616620-activation_flags)`
    * 세션 활성화 또는 비활성화시 앱의 오디오 의도에 대한 추가 정보를 제공하는 플래그
* `enum AVAudioSessionRouteSharingPolicy`
    * 오디오 세션에 가능한 경로 공유 정책을 나타내는 열거형


&nbsp;      
### Supporting Types
* `protocol AVAudioSessionDelegate`
    * 오디오 세션의 상태 변화에 대한 응답을 정의하는 프로토콜
* `class AVAudioSessionChannelDescription`
    * 체널 설명은 현재 장치의 하드웨어 체널에 대한 설명 정보를 제공한다.
* `class AVAudioSessionDataSourceDescription`
    * 소스의 이름, 위치 및 방향과 같은 정보를 제공하는 오디오 입출력에 대한 데이터 소스를 정의 설명
* `class AVAudioSessionPortDescription`
    * 포트 및 지원되는 하드웨어 체널의 기능에 대한 정보 
* `class AVAudioSessionRouteDescription`
    * 경로 설명은 세션에 대한 현재 오디오 경로와 관련된 입출력 포트를 관리한다.


&nbsp;      
&nbsp;      
### [by. 0junChoi](https://github.com/0jun0815) email: <0jun0815@gamil.com>
### [Apple Developer Documentation AVAudioPlayerSession](https://developer.apple.com/documentation/avfoundation/avaudiosession)
