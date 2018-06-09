# 현재 앱에서 다른앱 실행하기


애플리케이션에서 다른 애플리케이션 실행은 다음 순서로 진행된다: 
1. 디바이스에 실행하려는 앱이 존재하는지 확인한다.
2. 존재할 경우 앱을 실행한다.
3. 존재하지 않을 경우 다운로드를 할 수 있게끔 앱스토어를 실행한다.


디바이스에 실행하려는 앱이 존재하는지 확인하기 위해선 UIApplication의 인스턴스 메서드인 canOpenURL(_:)을 호출하는데 여기서 매개변수 url로 전달할 URL Scheme가 필요하다.


URL Scheme는 실행할 다른 앱에 등록된 값을 사용하여야 하며 현재 앱에서는 이 값에 접근 권한을 부여해야 한다.


### URL Scheme 등록
실행할 다른 앱의 info.plist에 URL types/Item 0/URL Schemes/item 0 항목에 등록할 URL Scheme 이름을 작성한다. (예: instagram)


![url-schemes](https://github.com/0jun0815/YJStudy/blob/master/iOS/현재%20앱에서%20다른%20앱%20실행하기/Images/url-schemes.png)


또는 info.plist를 소스 코드 파일로 열어 아래 구문을 작성한다.
```
<key>CFBundleURLTypes</key>
    <array>
        <dict>
            <key>CFBundleURLName</key>
            <string></string>
            <key>CFBundleURLSchemes</key>
            <array>
                <string>등록할 URLSchemeName</string>
            </array>
        </dict>
</array>
```


### URL Scheme 접근
현재 앱의 info.plist에 


![lsapplicationqueriesschemes](https://github.com/0jun0815/YJStudy/blob/master/iOS/현재%20앱에서%20다른%20앱%20실행하기/Images/lsapplicationqueriesschemes.png)


또는 info.plist를 소스 코드 파일로 열어 아래 구문을 작성한다.
```
<key>LSApplicationQueriesSchemes</key>
<array>
    <string>실행할 다른 앱의 URLSchemeName</string>
</array>
```


### 구현
UIApplication의 canOpenURL(_:) 메서드를 호출하여 디바이스에 애플리케이션이 존재하는지 확인, open(_:options:completionHandler:) 메서드를 호출하여 실행 URL(URLScheme) 또는 다운로드 URL을 연다.


```
@IBAction func launchAnotherApp(_ sender: UIButton) {
    // 실행할 애플리케이션의 URLScheme
    let launchURL = URL(string: "instagram:")!
    // 다운로드할 애플리케이션의 URL
    let downloadURL = URL(string: "https://itunes.apple.com/kr/app/instagram/id389801252?mt=8")!

    let application = UIApplication.shared

    // 실행하려는 애플리케이션이 현재 기기에 존재할 경우
    if application.canOpenURL(launchURL) {
        let alert = UIAlertController(title: nil, message: "다른 앱을 실행하시겠습니까?", preferredStyle: .alert)
        let okAction = UIAlertAction(title: "확인", style: .cancel) { (_) in
            application.open(launchURL, options: [:], completionHandler: nil)
        }
        alert.addAction(okAction)
        present(alert, animated: false)
    // 현재 기기에 존재하지 않을 경우
    } else {
        let alert = UIAlertController(title: nil, message: "앱스토어로 이동하시겠습니까?", preferredStyle: .alert)
        let okAction = UIAlertAction(title: "확인", style: .cancel) { (_) in
            application.open(downloadURL, options: [:], completionHandler: nil)
        }
        alert.addAction(okAction)
        present(alert, animated: false)
    }
}
```


&nbsp;
&nbsp;      
### [by. 0junChoi](https://github.com/0jun0815) email: <0jun0815@gamil.com>
