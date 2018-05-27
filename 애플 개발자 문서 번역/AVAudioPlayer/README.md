# AVAudioPlayer
파일 또는 메모리에서 오디오 데이터의 재생을 제공하는 오디오 플레이어


* [Overview](#overview)
* [Topics](#topics)
    * [Initializing an AVAudioPlayer Object](#initializing-an-avaudioplayer-object)
    * [Configuring and Controlling Playback](#configuring-and-controlling-playback)
    * [Managing Information About a Sound](#managing-information-about-a-sound)
    * [Using Audio Level Metering](#using-audio-level-metering)
    * [Formats](#formats)


&nbsp;      
## Overview
네트워크 스크림에서 캡처한 오디오를 재생하거나 매우 낮은 I/O 대기 시간을 필요로 하지 않는다면 이 클래스를 사용하여 오디오를 재생한다.


오디오 플레이어를 사용하면 다음을 수행할 수 있다:
* 어떤 지속 시간의 사운드라도 재생한다.
* 파일 또는 메모리 버퍼에서 사운드를 재생한다.
* 사운드 반복
* 정확한 동기화로 오디오 플레이어당 하나의 사운드, 동시에 여러 사운드를 재생한다.
* 재생중인 각 사운드의 상대 재생 레벨, 스테레오 위치 지정 및 재생 속도를 제어한다.
* 빨리감기 및 되감기와 같은 애플리케이션 기능을 지원하는 사운드 파일의 특정 지점을 찾는다.
* 재생 레벨 미러링에 사용할 수 있는 데이터 얻기


AVAudioPlayer 클래스를 사용하면 iOS 및 macOS에서 사용할 수 있는 오디오 형식으로 사운드를 재생할 수 있다. (iOS의 수신 전화와 같은) 인터럽트를 처리하고 사운드 재생이 끝나면 사용자 인터페이스를 업데이트하는 델리게이트를 구현한다. 델리게이트 메서드는 [AVAudioPlayerDelegate](https://github.com/0jun0815/YJStudy/tree/master/애플%20개발자%20문서%20번역/AVAudioPlayerDelegate)에 설명되어 있다.


오디오 플레이어를 재생, 일시 중지 또는 중지하려면 [Configuring and Controlling Playback](#configuring-and-controlling-playback)에서 설명한 재생 제어 방법 중 하나를 호출한다. 


이 클래스는 Objective-C로 선언된 프로퍼티 기능을 사용하여 사운드 타임 라인 내의 재생 지점과 같은 사운드에 대한 정보를 관리하고 볼륨 및 반복과 같은 재생 옵션에 접근한다.


iOS에서 재생할 적절한 오디오 세션을 구성하려면 [AVAudioSession](https://github.com/0jun0815/YJStudy/tree/master/애플%20개발자%20문서%20번역/AVAudioSession) 및 [AVAudioSessionDelegate](https://developer.apple.com/documentation/avfoundation/avaudiosessiondelegate)를 참조한다.


&nbsp;      
## Topics
### Initializing an AVAudioPlayer Object
* `init(contentsOf: URL)`
    * 지정된 사운드 파일을 재생하기위한 오디오 플레이어를 초기화하고 반환한다.
* `init(data: Data)`
    * 지정된 메모리 버퍼를 재생하기위한 오디오 플레이어를 초기화하고 반환한다.
* `init(contentsOf: URL, fileTypeHint: String?)`
    * 지정된 URL 및 파일 타입 힌트를 사용하여 오디오 플레이어를 초기화하고 반환한다.
* `init(data: Data, fileTypeHint: String?)`
    * 지정된 데이터 및 파일 타입 힌트를 사용하여 오디오 플레이어를 초기화하고 반환한다.
    

&nbsp;      
### Configuring and Controlling Playback
* `func play()`
    * 비동기적으로 사운드를 재생한다.
* `func play(atTime: TimeInterval)`
    * 오디오 출력 장치의 타임 라인의 지정된 지점에서 시작하여 비동기적으로 사운드를 재생한다.
* `func pause()`
    * 재생을 일시 중지한다. 사운드는 일시 중지된 부분부터 다시 재생할 준비가 된다.
* `func stop()`
    * 재생을 중지하고 재생에 필요한 설정을 취소한다.
* `func prepareToPlay()`
    * 버퍼를 미리 로드하여 재생할 오디오 플레이어를 준비한다.
* `func setVolume(Float, fadeDuration: TimeInterval)`
    * 특정 기간 동안 새 볼륨으로 사라진다.
* `var isPlaying: Bool`
    * 오디오 플레이어가 재생 중인지(true) 또는 재생되지 않는지(false) 나타내는 부울 값
* `var volume: Float`
    * 오디오 플레이어의 재생 볼륨으로 선형 눈금의 경우 0.0에서 1.0 사이
* `var pen: Float`
    * 오디오 플레이어의 스테레오 팬 위치
* `var rate: Float`
    * 오디오 플레이어의 재생 속도
* `var enableRate: Bool`
    * 오디오 플레이어에서 재생 속도 조정을 사용할 수 있는지 여부를 지정하는 부울 값
* `var numberOfLoops: Int`
    * 재생이 끝날 때까지 사운드가 처음으로 되돌아 오는 횟수
* `var delegate: AVAudioPlayerDelegate?`
    * 오디오 플레이어의 델리게이트 객체
* `protocol AVAudioPlayerDelegate`
    * 델리게이트가 오디오 중지 및 오디오 디코딩 오류 및 사운드 재생 완료에 응답할 수 있게하는 프로토콜
* `var settings: [String: Any]`
    * 플레이어와 연관된 사운드에 대한 정보가 들어 있는 오디오 플레이어의 설정 딕셔너리


&nbsp;   
### Managing Information About a Sound
* `var numberOfChannels: Int`
    * 오디오 플레이어와 연결된 사운드의 오디오 채널 수
* `var channelAssignments: [AVAudioSessionChannelDescription]?`
    * 오디오 플레이어와 관련된 [AVAudioSessionChannelDescription]() 객체의 배열
* `var duration: TimeInterval`
    * 오디오 플레이어와 관련된 사운드의 총 지속 시간(초)
* `var currentTime: TimeInterval`
    * 오디오 플레어와 관련된 사운드 타임 라인 내의 재생 지점(초)
* `deviceCurrentTime: TimeInterval`
    * 오디오 출력 장치의 시간 값(초)
* `var url: URL?`
    * 오디오 플레이어와 관련된 사운드의 URL
* `var data: Data?`
    * 오디오 플레이어와 관련된 사운드가 포함된 데이터 객체
* `var currentDevice: String?`
    * 현재 오디오 플레이어의 UID
* `var format: AVAudioFormat`
    * 버퍼의 오디오 형식
    

&nbsp;      
### Using Audio Level Metering
* `var isMeteringEnabled: Bool`
    * 오디오 플레이어의 오디오 레벨 미터링 켜기/끄기 상태를 지정하는 부울 값
* `func averagePower(forChannel: Int)`
    * 재생되고 있는 사운드의 지정된 채널의 평균 전력을 데시벨 단위로 반환한다.
* `func peekPower(forChannel: Int)`
    * 재생되고 있는 사운드의 지정된 채널의 피크 파워를 데시벨 단위로 반환한다.
* `func updateMeters()`
    * 오디오 플레이어의 모든 채널에 대한 평균 및 최대 전력 값을 새로고침
    

&nbsp;   
### Formats
* [General Audio Format Settings]()
    * [AVAudioPlayer](), [AVAudioRecorder]() 클래스에서 처리되는 모든 오디오 형식에 적용되는 오디오 설정


&nbsp;
&nbsp;      
### [by. 0junChoi](https://github.com/0jun0815) email: <0jun0815@gamil.com>
### [Apple Developer Documentation AVAudioPlayer](https://developer.apple.com/documentation/avfoundation/avaudioplayer)
