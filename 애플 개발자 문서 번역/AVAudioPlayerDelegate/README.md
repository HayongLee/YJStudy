# AVAudioPlayerDelegate
델리게이트가 오디오 중단(인터럽트) 및 오디오 디코딩 오류, 사운드 재생 완료에 응답할 수 있게 하는 프로토콜이다. 


* [Overview](#overview)
* [Topics](#topics)
    * [Responding to Sound Playback Completion](#responding-to-sound-playback-completion)
    * [Responding to an Audio Decoding Error](#responding-to-an-audio-decoding-error)
    * [Handling Audio Interruptions](#handling-audio-interruptions)


&nbsp;      
## Overview
AVAudioPlayer 객체의 델리게이트는 AVAudioPlayerDelegate 프로토콜을 채택해야 한다. 이 프로토콜의 모든 메서드는 선택 사항이다.


&nbsp;      
## Topics
### Responding to Sound Playback Completion
* `func audioPlayerDidFinishPlaying(AVAudioPlayer, successfully: Bool)`
    * 사운드 재생이 끝나면 호출된다.


&nbsp;      
### Responding to an Audio Decoding Error
* `func audioPlayerDecodeErrorDidOccur(AVAudioPlayer, error: Error?)`
    * 재생 중에 오디오 플레이어에서 디코딩 오류가 발생하면 호출된다.


&nbsp;   
### Handling Audio Interruptions
* ~~`func audioPlayerBeginInterruption(AVAudioPlayer)`~~
* ~~`func audioPlayerEndInterruption(AVAudioPlayer, withOptions: Int)`~~
* ~~`func audioPlayerEndInterruption(AVAudioPlayer)`~~
* ~~`func audioPlayerEndInterruption(AVAudioPlayer, withFlags: Int)`~~


&nbsp;
&nbsp;      
### [by. 0junChoi](https://github.com/0jun0815) email: <0jun0815@gamil.com>
### [Apple Developer Documentation AVAudioPlayerDelegate](https://developer.apple.com/documentation/avfoundation/avaudioplayerdelegate)
