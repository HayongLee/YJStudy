# AVAudioSessionCategoryPlayback
앱을 성공적으로 사용하기 위해 녹음된 음악 또는 다른 사운드를 재생하는 카테고리이다.


* [Declaration](#declaration)
* [Discussion](#discussion)


&nbsp;      
## Delaration
```
let AVAudioSessionCategoryPlayback: String
```


&nbsp;      
## Discussion
이 카테고리를 사용할 때, 벨/무음 스위치가 무음으로 설정되거나 화면이 잠겨 있을 때도 앱 오디오가 계속된다. 앱이 백그라운드로 전활 될 때(예: 화면이 잠길 때) 오디오를 계속 재생하려면 정보 프로퍼티 리스트 파일(info.plist)의 [UIBackgroundModes](https://developer.apple.com/library/content/documentation/General/Reference/InfoPlistKeyReference/Articles/iPhoneOSKeys.html#//apple_ref/doc/plist/info/UIBackgroundModes) 키에 오디오 값을 추가한다.  


기본적으로 이 카테고리를 사용하려면 애플리케이션의 오디오가 혼합(믹싱)될 수 없음을 의미한다. 세션을 활성화하면 혼합될 수 없는 다른 오디오 세션도 중단된다. 이 카테고리의 혼합을 허용하려면 [mixWithOthers](https://developer.apple.com/documentation/avfoundation/avaudiosessioncategoryoptions/1616611-mixwithothers) 옵션을 사용한다.



&nbsp;      
&nbsp;      
### [by. 0junChoi](https://github.com/0jun0815) email: <0jun0815@gamil.com>
### [Apple Developer Documentation AVAudioSessionCategoryPlayback](https://developer.apple.com/documentation/avfoundation/avaudiosessioncategoryplayback)
