# UserDefaults
> 사용자의 기본 데이터베이스에 대한 인터페이스로, 앱 시작과 동시에 키-값 쌍을 저장한다.


* [Overview](#overview)
* [Storing Default Objects](#storing-default-objects)
* [Persisting File References](#persisting-file-references)
* [Responding to Defaults Changes](#responding-to-defaults-changes)
* [Using Defaults in Managed Environments](#using-defaults-in-managed-environments)
* [Sandbox Considerations](#sandbox-considerations)
* [Thread Safety](#thread-safety)
* [Topics](#topics)
    * [Getting the Standard User Defaults Object](#getting-the-standard-user-defaults-object)
    * [Creating User Defaults Objects](#creating-user-defaults-objects)
    * [Getting Default Values](#getting-default-values)
    * [Setting Default Values](#setting-default-values)
    * [Removing Defaults](#removing-defaults)
    * [Maintaining Suites](#maintaining-suites)
    * [Registering Defaults](#registering-defaults)
    * [Maintaining Persistent Domains](#maintaining-persistent-domains)
    * [Maintaining Volatile Domains](#maintaining-volatile-domains)
    * [Accessing Managed Environment Keys](#accessing-managed-environment-keys)
    * [Domains](#domains)
    * [Notifications](#notifications)
    * [Legacy](#legacy)
* [Relationships](#relationships)
    * [Inherits From](#inherits-from)
    * [Conforms To](#conforms-to)
    

&nbsp;      
## Overview
UserDefault 클래스는 기본 시스템과 상호 작용할 수 있는 프로그래밍 방식의 인터페이스를 제공한다. 기본 시스템을 사용하면 앱이 사용자의 취향에 맞게 행동을 사용자화할 수 있다. 예를 들어 사용자가 선호하는 측정 단위 또는 미디어 재생 속도를 지정할 수 있도록 허용할 수 있다. 앱은 사용자의 기본 데이터베이스에 있는 매개 변수 집합에 값을 할당하여 이러한 환경 설정을 저장한다. 매개 변수는 시작시 앱의 기본 상태 또는 기본적으로 작동하는 방식을 결정하는데 일반적으로 사용되므로 *defaults* 라고 한다.


런타임에 UserDefaults 객체를 사용하여 앱이 사용자의 기본 데이터베이스에서 사용하는 기본값을 읽는다. UserDefaults는 기본값을 필요로 할 때마다 사용자의 기본 데이터베이스를 열지 않아도되도록 정보를 캐시한다. 기본값을 설정하면 프로세스 내에서 동기적으로 변경되고 영구 저장소 및 기타 프로세스와는 비동기적으로 변경된다.


> Important
>
> 환경 설정 하위 시스템에 접근하면 안된다. 환경 설정 프로퍼티 리스트 파일을 수정하면 변경 사항 손실, 변경 반영 지연 및 애플리케이션 충돌이 발생할 수 있다. 환경 설정을 구성하려면 대신 macOS에서 기본 커맨드-라인 유틸리티를 사용한다.


교육 기관의 관리 장치를 제외하고 사용자의 기본값은 로컬로 단일 장치에 저장되고 백업 및 복원을 위해 유지된다. 사용자의 연결된 장치에서 환경 설정 및 기타 데이터를 동기화하려면 대신 [NSUbiquitousKeyValueStore](https://developer.apple.com/documentation/foundation/nsubiquitouskeyvaluestore)를 사용한다.


&nbsp;
## Storing Default Objects
> 기본 객체 저장

UserDefaults 클래스는 Float, Double, Integer, Boolean 값 및 URL와 같은 일반적인 타입에 접근하기 위한 편의 메서드를 제공한다. 이 메서드는 [Setting Default Values](https://developer.apple.com/documentation/foundation/userdefaults#1664798)에 설명되어 있다.


기본 객체는 NSData, NSString, NSNumber, NSDate, NSArray 또는 NSDictionary의 인스턴스(또는 컬렉션, 인스턴스의 조합)의 프로퍼티 리스트여야 한다. 다른 타입의 객체를 저장하려면 일반적으로 객체 타입을 저장하여 NSData의 인스턴스를 만들어야 한다.


변경 가능한 객체를 값으로 설정하더라도 UserDefaults에서 반환되는 값은 변경할 수 없다. 예를 들어, "MyStringDefault"의 값으로 변경 가능한 문자열을 설정하면 나중에 [string(forKey:)](https://developer.apple.com/documentation/foundation/userdefaults/1416700-string) 메서드를 사용하여 검색한 문자열은 변경되지 않는다. 변경할 수 있는 문자열을 기본값으로 설정하고 나중에 문자열을 변경하면 [set(_:forKey:)](https://developer.apple.com/documentation/foundation/userdefaults/1414067-set)를 다시 호출하지 않으면 기본값에 변경된 문자열 값이 반영되지 않는다.


&nbsp;
## Persisting File References
> 파일 참조 유지

파일 URL은 파일 시스템의 위치를 지정한다. [set(_:forKey:)](https://developer.apple.com/documentation/foundation/userdefaults/1414194-set) 메서드를 사용하여 특정 파일의 위치를 저장하고 사용자가 해당 파일을 이동하면 앱이 다음에 실행될 때 해당 파일을 찾을 수 없다. 파일 시스템 identity로 파일에 대한 참조를 저장하려면 [bookmarkData(options:includingResourceValuesForKeys:relativeTo:)](https://developer.apple.com/documentation/foundation/nsurl/1417795-bookmarkdata) 메서드를 사용하여 NSURL 북마크 데이터를 만들고 [set(_:forKey)](https://developer.apple.com/documentation/foundation/userdefaults/1414067-set) 메서드를 사용하여 NSURL 북마크 데이터를 지속시킬 수 있다. 그런 다음 [URLByResolvingBookmarkData:options:relativeToURL:bookmarkDataIsStale:error:](https://developer.apple.com/documentation/foundation/nsurl/1572035-urlbyresolvingbookmarkdata) 메서드를 사용하여 사용자 기본값에 저장된 북마크 데이터를 파일 URL로 확인할 수 있다.


&nbsp;
## Responding to Defaults Changes
> 기본값 변경에 대한 응답

키-값 관찰자를 사용하여 기본값에 대한 업데이트 사항을 알릴 수 있다. [default](https://developer.apple.com/documentation/foundation/notificationcenter/1414169-default) 알림 센터에서 [didChangeNotification](https://developer.apple.com/documentation/foundation/userdefaults/1408206-didchangenotification)의 관찰자로 등록하여 로컬 기본값 데이터베이스에 대한 모든 업데이트를 알릴 수도 있다.


자세한 사항은 [Key-Value Observing Programming Guide](https://developer.apple.com/library/content/documentation/Cocoa/Conceptual/KeyValueObserving/KeyValueObserving.html#//apple_ref/doc/uid/10000177i), [Notification Programming Topics](https://developer.apple.com/library/content/documentation/Cocoa/Conceptual/Notifications/Introduction/introNotifications.html#//apple_ref/doc/uid/10000043i) 참조.


&nbsp;
## Using Defaults in Managed Environments
> 관리 환경에서 기본값 사용

앱이 관리 환경을 지원하는 경우 UserDefaults를 사용하여 관리자가 사용자를 위해 관리하는 기본 설정을 결정할 수 있다. 컴퓨터실 또는 교실과 같은 관리 환경에서 관리자 또는 교사는 사용자에 대한 기본 설정 집합을 설정하여 시스템을 구성할 수 있다. 환경 설정이 이러한 방식([Accessing Managed Environment Keys](https://developer.apple.com/documentation/foundation/userdefaults#1664949)에 설명된 방법에 따라)으로 관리되는 경우 앱은 사용자가 컨트롤을 비활성화하거나 숨김으로써 해당 환경 설정을 편집하지 못하도록 해야 한다.


자세한 내용은 [Mobile Device Management Protocol Reference](https://developer.apple.com/library/content/documentation/Miscellaneous/Reference/MobileDeviceManagementProtocolRef/1-Introduction/Introduction.html#//apple_ref/doc/uid/TP40017387) 참조.


교육 기관에서 관리하는 기기에서 실행되는 앱은 iCloud 키-값 저장소를 사용하여 소량의 데이터를 사용자의 다른 기기에 있는 다른 인스턴스와 공유할 수 있다. 예를 들어, 교과서 애플리케이션은 사용자가 읽는 현재 페이지 번호를 저장하여 시작할 때 애플리케이션의 다른 인스턴스가 동일한 페이지로 열리도록 할 수 있다. 


자세한 내용은 [Preferences and Settings Programming Guide](https://developer.apple.com/library/content/documentation/Cocoa/Conceptual/UserDefaults/Introduction/Introduction.html#//apple_ref/doc/uid/10000059i)에 [Storing Preferences in iCloud](https://developer.apple.com/library/content/documentation/Cocoa/Conceptual/UserDefaults/StoringPreferenceDatainiCloud/StoringPreferenceDatainiCloud.html#//apple_ref/doc/uid/10000059i-CH7) 참조.


&nbsp;
## Sandbox Considerations
> 샌드박스 고려사항

샌드박스 처리된 앱은 다음 예외를 제외하고 다른 앱의 환경 설정에 접근하거나 수정할 수 없다:
* macOS 및 iOS의 앱 확장
* macOS의 애플리케이션 그룹에 있는 다른 앱


[addSuite(named:)](https://developer.apple.com/documentation/foundation/userdefaults/1410294-addsuite) 메서드를 사용하여 타사 앱의 도메인을 추가한다고 해서 앱이 해당 앱 환경 설정에 접근하는 것을 허용하지 않는다. 다른 앱의 환경 설정에 접근하거나 수정하려고 해도 오류가 발생하지 않는다. 대신 macOS는 다른 애플리케이션의 실제 환경 설정 파일보다는 앱 컨테이너에있는 파일을 읽고 쓴다.


&nbsp;
## Thread Safety
> 스레드 안전성

UserDefaults 클래스는 스레드로부터 안전하다.


&nbsp;
## Topics
### Getting the Standard User Defaults Object
> 표준 사용자 기본 객체 얻기

* `class var standard: UserDefaults`
    * 공유 기본 객체를 반환한다.


### Creating User Defaults Objects
> 사용자 기본 객체 생성

* `init()`
    * 앱 및 현재 사용자의 기본값으로 초기화된 사용자 기본 객체를 만든다.
* `init?(suiteName: String?)`
    * 지정된 데이터베이스 이름의 기본값으로 초기화된 사용자 기본 객체를 만든다.


### Getting Default Values
> 기본 값 가져오기

* `func object(forKey: String)`
    * 지정된 키와 연관된 객체를 반환한다.
* `func url(forKey: String)`
    * 지정된 키와 연관된 URL을 반환한다.
* `func array(forKey: String)`
    * 지정된 키와 연관된 배열을 반환한다.
* `func dictionary(forKey: String)`
    * 지정된 키와 연관된 딕셔너리 객체를 반환한다.
* `func string(forKey: String)`
    * 지정된 키와 연관된 문자열을 반환한다.
* `func stringArray(forKey: String)`
    * 지정된 키와 연관된 문자열 배열을 반환한다.
* `func data(forKey: String)`
    * 지정된 키와 연관된 데이터 객체를 반환한다.
* `func bool(forKey: String)`
    * 지정된 키와 연관된 부울 값을 반환한다.
* `func integer(forKey: String)`
    * 지정된 키와 연관된 정수 값 반환한다.
* `func float(forKey: String)`
    * 지정된 키와 연관된 float 값 반환한다.
* `func double(forKey: String)`
    * 지정된 키와 연관된 double 값 반환한다.
* `func dictionaryRepresentation()`
    * 검색 목록의 도메인에 있는 모든 키-값 쌍의 합집합을 포함하는 딕셔너리를 반환한다.


### Setting Default Values
> 기본값 설정

* `func set(Any?, forKey: String)`
    * 지정된 기본 키의 값을 설정한다.
* `func set(Float, forKey: String)`
    * 지정된 기본 키의 값을 지정된 float 값으로 설정한다.
* `func set(Double, forKey: String)`
    * 지정된 기본 키의 값을 지정된 double 값으로 설정한다.
* `func set(Int, forKey: String)`
    * 지정된 기본 키의 값을 지정된 정수 값으로 설정한다.
* `func set(Bool, forKey: String)`
    * 지정된 기본 키의 값을 지정된 부울 값으로 설정한다.
* `func set(URL?, forKey: String)`
    * 지정된 기본 키의 값을 지정된 URL로 설정한다.


### Removing Defaults
> 기본값 제거

* `func removeObject(forKey: String)`
    * 지정된 기본 키의 값을 제거한다.


### Maintaining Suites
> 개발 도구 묶음 유지 보수

* `func addSuite(named: String)`
    * 수신자의 검색 목록에 지정된 도메인 이름을 삽입한다.
* `func removeSuite(named: String)`
    * 수신자의 검색 목록에서 지정된 도메인 이름을 제거한다.


### Registering Defaults
> 기본값 등록

* `func register(defaults: [String: Any])`
    * 지정된 딕셔너리의 내용을 등록 도메인에 추가한다.


### Maintaining Persistent Domains
> 영구 도메인 유지 보수

* `func persistentDomain(forName: String)`
    * 지정된 도메인에 대한 기본값의 사전 표현을 반환한다. 
* `func setPersistentDomain([String: Any], forName: String)`
    * 지정된 영구 도메인에 대한 사전을 설정한다.
* `func removePersistentDomain(forName: String)`
    * 지정된 영구 도메인의 내용을 사용자의 기본값에서 제거한다.
* ~~`func persistentDomainNames()`~~


### Maintaining Volatile Domains
> 휘발성 도메인 유지 보수

* `var volatileDomainNames: [String]`
    * 현재 휘발성 도메인 이름
* `func volatileDomain(forName: String)`
    * 지정된 휘발성 도메인에 대한 딕셔너리를 반환한다.
* `func setVolatileDomain([String: Any], forName: String)`
    * 지정된 휘발성 도메인에 대한 딕셔너리를 설정한다.
* `func removeVolatileDomain(forName: String)`
    * 사용자의 기본값에서 지정된 휘발성 도메인을 제거한다.


### Accessing Managed Environment Keys
> 관리 환경 키 접근

* `func objectIsForced(forKey: String)`
    * 지정된 키가 관리자가 관리하는지 여부를 나타내는 부울 값을 반환한다.
* `func objectIsForced(forKey: String, inDomain: String)`
* 지정된 도메인의 키가 관리자가 관리하는지 여부를 나타내는 부울 값을 반환한다.


### Domains
> 도메인

* `class let argumentDomain: String`
    * 애플리케이션의 인수에서 파싱된 기본값으로 구성된 도메인이다. 애플리케이션의 커맨드-라인 호출이 포함된 하나 이상의 쌍이 기본 값이다.
* `class let globalDomain: String`
    * 모든 애플리케이션에서 볼 수 있는 기본값으로 구성된 도메인이다.
* `class let registrationDomain: String`
    * 검색에서 항상 성공할 수 있도록 애플리케이션에서 값을 설정할 수 있는 일련의 임시 기본값으로 구성된 도메인이다.


### Notifications
> 알림

* `class let didChangeNotification: NSNotification.Name`
    * 사용자 기본값이 현재 프로세스 내에서 변경될 때 게시 됨.
* `class let sizeLimitExceededNotification: NSNotification.Name`
    * 허용된 것보다 많은 데이터가 사용자 기본값에 저장될 때 게시 됨.
* `class let completedInitialCloudSyncNotification: NSNotification.Name`
    * 기기가 iCloud 계정에 처음 연결되거나 사용자가 기본 iCloud 계정을 전환할 때 유비쿼터스 기본값이 데이터 다운로드를 완료하면 게시된다.
* `class let didChangeCloudAccountsNotification: NSNotification.Name`
    * 사용자가 기본 iCloud 계정을 변경하면 게시된다.
* `class let noCloudAccountNotification: NSNotification.Name`
    * 클라우드 기본값이 설정되었지만 iCloud 사용자가 로그인하지 않은 경우 게시 됨.


### Legacy
> 낡은 기술(더이상 사용하지 않는 기술)

* ~~`init?(user: String)`~~
* `func synchronize()`
    * 보류중인 기본 데이터베이스로의 비동기 업데이트를 기다리고 반환한다. 이 메서드는 불필요하므로 사용하지 않아야 한다.
* `class func resetStandardUserDefaults()`
    * 이 메서드는 효과가 없으므로 사용하지 않아야 한다.


&nbsp;      
## Relationships
### Inherits From
* NSObject


### Conforms To
* CVarArg, Equatable, Hashable


&nbsp;      
&nbsp;      
### [by. 0junChoi](https://github.com/0jun0815) email: <0jun0815@gamil.com>
### [Apple Developer Documentation UserDefaults](https://developer.apple.com/documentation/foundation/userdefaults)
