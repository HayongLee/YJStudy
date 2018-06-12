# DateFormatter
> 날짜와 텍스트 표현 사이를 변환하는 포맷터.


* [Overview](#overview)
* [Working With User-Visible Representations of Dates and Times](#working-with-user-visible-representations-of-dates-and-times)
* [Working With Fixed Format Date Representations](#working-with-fixed-format-date-representations)
* [Thread Safety](#thread-safety)
* [Topics](#topics)
    * [Converting Objects](#converting-objects)
    * [Managing Formats and Styles](#managing-formats-and-styles)
    * [Managing Attributes](#managing-attributes)
    * [Managing Behavior Version](#managing-behavior-version)
    * [Managing Natural Language Support](#managing-natural-language-support)
    * [Managing AM and PM Symbols](#managing-am-and-pm-symbols)
    * [Managing Weekday Symbols](#managing-weekday-symbols)
    * [Managing Month Symbols](#managing-month-symbols)
    * [Managing Quarter Symbols](#managing-quarter-symbols)
    * [Managing Era Symbols](#managing-era-symbols)
    * [Constants](#constants)
    * [Instance Properties](#instance-properties)
* [Relationships](#relationships)
* [See Also](#see-also)
    

&nbsp;      
## Overview
DateFormatter의 인스턴스는 [NSDate](https://developer.apple.com/documentation/foundation/nsdate) 객체의 문자열 표현을 만들고 날짜 및 시간의 텍스트 표현을 [NSDate](https://developer.apple.com/documentation/foundation/nsdate) 객체로 변환한다. 날짜와 시간을 사용자가 시각적으로 표현할 수 있도록 DateFormatter는 다양한 현지화된 사전 설정 및 구성 옵션을 제공한다. 고정된 형식의 날짜 및 시간의 표현의 경우 사용자 정의 형식 문자열을 지정할 수 있다.


ISO 8601 형식으로 날짜 표현을 사용하는 경우 [ISO8601DateFormatter](https://developer.apple.com/documentation/foundation/iso8601dateformatter)를 사용한다.


두 개의 [NSDate](https://developer.apple.com/documentation/foundation/nsdate) 객체 사이의 간격을 나타내려면 [DateIntervalFormatter](https://developer.apple.com/documentation/foundation/dateintervalformatter)를 사용한다.


[NSDateComponents](https://developer.apple.com/documentation/foundation/nsdatecomponents) 객체로 지정된 시간을 나타내려면 [DateComponentsFormatter](https://developer.apple.com/documentation/foundation/datecomponentsformatter)를 사용한다.


&nbsp;  
## Working With User-Visible Representations of Dates and Times
> 사용자가 볼 수 있는 날짜와 시간 표현으로 작업하기

사용자에게 날짜를 표시할 때 특정 요구사항에 따라 날짜 포맷터의 [dateStyle](https://developer.apple.com/documentation/foundation/dateformatter/1415411-datestyle) 및 [timeStyle](https://developer.apple.com/documentation/foundation/dateformatter/1413467-timestyle) 프로퍼티를 설정한다. 예를 들어 시간을 표시하지 않고 월, 일 및 연도를 표시하려면 dateStyle 프로퍼티를 [DateFormatter.Style.long](https://developer.apple.com/documentation/foundation/dateformatter/style/long)으로 설정하고 timeStyle 프로퍼티를 [DateFormatter.Style.none](https://developer.apple.com/documentation/foundation/dateformatter/style/none)으로 설정한다. 반대로 시간만 표시하려면 dateStyle 프로퍼티를 DateFormatter.Style.none으로 설정하고 timeStyle 프로퍼티를 [DateFormatter.Style.short](https://developer.apple.com/documentation/foundation/dateformatter/style/short)로 설정한다. DateFormatter는 dateStyle 및 timeStyle 프로퍼티 값을 기반으로 지정된 로케일에 적합한 지정된 날짜의 표현을 제공한다.

```
let dateFormatter = DateFormatter()
dateFormatter.dateStyle = .medium
dateFormatter.timeStyle = .none

let date = Date(timeIntervalSinceReferenceDate: 118800)

// US English Locale (en_US)
dateFormatter.locale = Locale(identifier: "en_US")
print(dateFormatter.string(from: date)) // Jan 2, 2001

// French Locale (fr_FR)
dateFormatter.locale = Locale(identifier: "fr_FR")
print(dateFormatter.string(from: date)) // 2 janv. 2001
```


미리 정의된 스타일을 사용하여 얻을 수 없는 형식을 정의해야 하는 경우 [setLocalizedDateFormatFromTemplate(_:)](https://developer.apple.com/documentation/foundation/dateformatter/1417087-setlocalizeddateformatfromtempla)를 사용하여 템플릿에서 지역화된 날짜 형식을 지정할 수 있다.

```
let dateFormatter = DateFormatter()
let date = Date(timeIntervalSinceReferenceDate: 410220000)

// US English Locale (en_US)
dateFormatter.locale = Locale(identifier: "en_US")
dateFormatter.setLocalizedDateFormatFromTemplate("MMMMd")   // set template after
print(dateFormatter.string(from: date)) // December 31
```


&nbsp; 
## Working With Fixed Format Date Representations
> 고정 형식 날짜 표현 사용하기

> Important
>
> macOS 10.12 이상 또는 iOS 10 이상에서는 ISO 8601 날짜 표현을 사용할 때 iSO8601DateFormatter 클래스를 사용한다.

RFC 3339와 같은 고정 형식 날짜로 작업할 때 [dateFormat](https://developer.apple.com/documentation/foundation/dateformatter/1413514-dateformat) 프로퍼티를 설정하여 형식 문자열을 지정한다. 대부분의 고정된 형식의 경우 [locale](https://developer.apple.com/documentation/foundation/dateformatter/1411973-locale) 프로퍼티를 POSIX locale("en_US_POSIX")로 설정하고 [timeZone](https://developer.apple.com/documentation/foundation/dateformatter/1411406-timezone) 프로퍼티를 UTC로 설정해야 한다.

```
let RFC3339DateFormatter = DateFormatter()
RFC3339DateFormatter.locale = Locale(identifier: "en_US_POSIX")
RFC3339DateFormatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ssZZZZZ"
RFC3339DateFormatter.timeZone = TimeZone(secondsFromGMT: 0)

/* 39 minutes and 57 seconds after the 16th hour of December 19th, 1996 with an offset of -08:00 from UTC (Pacific Standard Time) */
let string = "1996-12-19T16:39:57-08:00"
let date = RFC3339DateFormatter.date(from: string)
```


&nbsp; 
## Thread Safety
> 스레드 안전성

iOS 7 이상에서는 NSDateFormatter가 스레드로부터 안전하다.


macOS 10.9 및 이후 버전에서 NSDateFormatter는 64 비트 애플리케이션에서 최신 행동을 사용하는 한 스레드로부터 안전하다.


이전 버전의 운영체제나 레거시 포맷터 행동을 사용하거나 macOS에서 32비트로 실행하는 경우 NSDateFormatter는 스레드로부터 안전하지 않으므로 여러 스레드에서 동시에 날짜 포맷터를 변경하면 안된다.


&nbsp;
## Topics
### Converting Objects
> 객체 변환

* `func date(from: String) -> Date?`
    * 리시버의 현재 설정을 사용해 해석된 문자열의 날짜 표현을 반환한다.
* `func string(from: Date) -> String`
    * 리시버의 현재 설정을 사용해 포맷된 날짜의 문자열 표현을 반환한다.
* `class func localizedString(from: Date, dateStyle: DateFormatterStyle, timeStyle: DateFormatter.Style) -> String`
    * 지정된 날짜 및 시간 스타일을 사용하여 현재 로케일에 대해 포맷된 지정된 날짜의 문자열 표현을 반환한다.
* `func getObjectValue(AutoreleasingUnsafeMutablePointer<AnyObject?>?, for: String, range: UnsafeMutablePointer<NSRange>?)`
    * 지정된 문자열의 날짜 표현과 사용된 문자열의 범위를 참조로 반환하고, 문자열을 구문 분석 할 수 있는지 여부를 나타내는 부울 값을 반환한다. 


### Managing Formats and Styles
> 형식 및 스타일 관리

* `var dateStyle: DateFormatter.Style`
    * 리시버의 날짜 스타일
* `var timeStyle: DateFormatter.Style`
    * 리시버의 시간 스타일
* `var dateFormat: String!`
    * 리시버가 사용하는 날짜 형식 문자열
* `func setLocalizedDateFormatFromTemplate(String)`
    * 리시버에 지정된 로케일을 사용하여 템플릿의 날짜 형식을 설정한다.
* `class func dateFormat(fromTemplate: String, options: Int, locale: Locale?) -> String`
    * 지정된 로케일에 적절하게 배치된, 지정된 날짜 형식 컴포넌트를 나타내는 지역화된 날짜 형식 문자열을 리턴한다.
* `var formattingContext: Formatter.Context`
    * 날짜 형식을 지정할 때 사용되는 대문자 형식 지정 컨텍스트이다.


### Managing Attributes
> 속성 관리

* `var calendar: Calendar!`
    * 리시버의 캘린더
* `var defaultDate: Date?`
    * 리시버의 기본 날짜
* `var locale: Locale!`
    * 리시버의 로케일
* `var timeZone: TimeZone!`
    * 리시버의 시간대
* `var twoDigitStartDate: Date?`
    * 두 자리 연도 지정자로 표시될 수 있는 가장 빠른 날짜
* `var gregorianStartDate: Date?`
    * 리시버의 그레고리 캘린더의 시작 날짜


### Managing Behavior Version
> 행동(비헤이비어) 버전 관리

* `var formatterBehavior: DateFormatter.Behavior`
    * 리시버의 포맷터 행동
* `class var defaultFormatterBehavior: DateFormatter.Behavior`
    * 클래스의 인스턴스에 대한 기본 형식 지정 행동을 반환한다.


### Managing Natural Language Support
> 자연 언어 지원 관리

* `var isLenient: Bool`
    * 리시버가 문자열을 파싱할 때 발견적 방법(heuristics)을 사용하는지 여부를 나타내는 부울 값
* `var doesRelativeDateFormatting: Bool`
    * 리시버가 날짜 구성 요소에 대해 "오늘" 및 "내일"과 같은 구를 사용하는지 여부를 나타내는 부울 값


### Managing AM and PM Symbols
> AM 및 PM 기호 관리

* `var amSymbol: String!`
    * 리시버의 AM 기호
* `var pmSymbol: String!`
    * 리시버의 PM 기호


### Managing Weekday Symbols
> 평일 기호 관리

* `var weekdaySymbols: [String]!`
    * 리시버의 평일 기호의 배열
* `var shortWeekdaySymbols: [String]!`
    * 리시버의 짧은 평일 기호의 배열
* `var veryShortWeekdaySymbols: [String]!`
    * 리시버의 매우 짧은 평일 기호의 배열
* `var standaloneWeekdaySymbols: [String]!`
    * 리시버의 독립형 평일 기호 배열
* `var shortStandaloneWeekdaySymbols: [String]!`
    * 리시버의 짧은 독립형 평일 기호 배열
* `var veryShortStandaloneWeekdaySymbols: [String]!`
    * 리시버의 매우 짧은 독립형 평일 기호 배열


### Managing Month Symbols
> 월 기호 관리

* `var monthSymbols: [String]!`
    * 리시버의 월 기호의 배열
* `var shortMonthSymbols: [String]!`
    * 리시버의 짧은 월 기호의 배열
* `var veryShortMonthSymbols: [String]!`
    * 리시버의 매우 짧은 월 기호의 배열
* `var standaloneMonthSymbols: [String]!`
    * 리시버의 독립형 월 기호 배열
* `var shortStandaloneMonthSymbols: [String]!`
    * 리시버의 짧은 독립형 월 기호 배열
* `var veryShortStandaloneMonthSymbols: [String]!`
    * 리시버의 매우 짧은 독립형 월 기호 배열


### Managing Quarter Symbols
> 분기 기호 관리

* `var quarterSymbols: [String]!`
    * 리시버의 분기 기호의 배열
* `var shortQuarterSymbols: [String]!`
    * 리시버의 짧은 분기 기호의 배열
* `var standaloneQuarterSymbols: [String]!`
    * 리시버의 독립형 분기 기호의 배열
* `var shortStandaloneQuarterSymbols: [String]!`
    * 리시버의 짧은 독립형 분기 기호의 배열


### Managing Era Symbols
> 연대 기호 간리 

* `var eraSymbols: [String]!`
    * 리시버의 연대 기호의 배열
* `var longEraSymbols: [String]!`
    * 리시버의 긴 연대 기호의 배열


### Constants
* `enum DateFormatter.Style`  
    * 날짜 및 시간에 대해 미리 정의된 형식 스타일을 지정하는 상수.
* `enum DateFormatter.Behavior`
    * NSDateFormatter가 보여야하는 행동을 지정하는 상수.


### Instance Properties
* `var generatesCalendarDates: Bool`
    * 이 프로퍼티를 사용해서는 안된다.


&nbsp;      
## Relationships
### Inherits From
* Formatter


### Conforms To
* CVarArg, Equatable, Hashable

&nbsp;
## See Also
### Date Formatting
* class DateComponentsFormatter
* class DateIntervalFormatter
* class ISO8601DateFormatter


&nbsp;      
&nbsp;      
### [by. 0junChoi](https://github.com/0jun0815) email: <0jun0815@gmail.com>
### [Apple Developer Documentation DateFormatter](https://developer.apple.com/documentation/foundation/dateformatter)
