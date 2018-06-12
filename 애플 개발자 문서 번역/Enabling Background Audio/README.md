# Enabling Background Audio
백그라운드로 들어갈 때 오디오를 계속 재생하도록 앱을 구성한다.


* [Overview](#overview)


&nbsp;      
## Overview
iOS 및 tvOS 앱을 사용하려면 일부 백그라운드 작업에 특정 기능을 사용하도록 설정해야 한다. 재생 애플리케이션에 필요한 공통 기능은 백그라운드 오디오를 재생하는 것이다. 이 기능을 사용하면 사용자가 다른 앱으로 전환하거나 iOS 기기를 잠글 때 앱의 오디오를 계속 사용할 수 있다. 이 기능은 iOS에서 AirPlay 스트리밍 및 Picture in Picutre 재생과 같은 고급 재생 기능을 활성화하는데도 필요하다.


이러한 기능을 구성하는 가장 간단한 방법은 Xcode를 사용하는 것이다. Xcode에서 앱의 `tartget`을 선택하고 `Capabilities` 탭을 선택한다. Capabilities 탭에서 `Background Modes` 스위치를 `ON`으로 설정하고 사용 가능한 모드 목록 아래에 있는 `Audio, AirPlay, and Picture in Picture` 옵션을 선택한다.


![](https://github.com/0jun0815/YJStudy/blob/master/애플%20개발자%20문서%20번역/Enabling%20Background%20Audio/Images/background-modes.png)


이 모드를 사용하도록 설정하고 오디오 세션을 구성하면 앱에서 백그라운드 오디오를 재생할 수 있다.


&nbsp;      
&nbsp;      
### [by. 0junChoi](https://github.com/0jun0815) email: <0jun0815@gmail.com>
### [Apple Developer Documentation Enabling Background Audio](https://developer.apple.com/documentation/avfoundation/media_assets_playback_and_editing/creating_a_basic_video_player_ios_and_tvos/enabling_background_audio)
