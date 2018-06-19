# JSONEncoder
> 데이터 타입의 인스턴스를 JSON 객체로 인코딩하는 객체이다.


* [Overview](#overview)
* [Topic](#topic)
    * [First Steps](#first-steps)
    * [Customizing Encoding](#customizing-encoding)
    * [Encoding Dates](#encoding-dates)
    * [Encoding Raw Data](#encoding-raw-data)
    * [Encoding Exceptional Numbers](#encoding-exceptional-numbers)
* [See Also](#see-also)


&nbsp;      
## Overview
아래 예제는 간단한 GroceryProduct 타입의 인스턴스를 JSON 객체에서 인코딩하는 방법을 보여준다. 이 타입은 JSONEncoder 인스턴스를 사용하여 JSON으로 인코딩 할 수 있도록 [Codable](https://developer.apple.com/documentation/swift/codable) 프로토콜을 채택한다.
```
struct GroceryProduct: Codable {
    var name: String
    var points: Int
    var description: String?
}

let pear = GroceryProduct(name: "Pear", points: 250, description: "A ripe pear.")

let encoder = JSONEncoder()
encoder.outputFormatting = .prettyPrinted

let data = try encoder.encode(pear)
print(String(data: data, encoding: .utf8)!)

/* Prints:
{
    "name" : "Pear",
    "points" : 250,
    "description" : "A ripe pear."
}
*/
```


&nbsp;      
## Topic
### First Steps
> 첫 단계

* `init()`
    * 기본 형식 설정 및 인코딩 전략을 사용하여 재사용 가능한 새 JSON 인코더를 만든다.
* `func encode<T>(T) -> Data`
    * 사용자가 제공한 값의 JSON 인코딩 표현을 반환한다.


### Customizing Encoding
> 인코딩 커스터마이징

* `var outputFormatting: JSONEncoder.OutputFormatting`
    * 인코딩 된 JSON 객체의 가독성, 크기 및 요소 순서를 결정하는 값.
* `struct JSONEncoder.OutputFormatting`
    * 인코딩 된 JSON 객체의 가독성, 크기 및 요소 순서를 결정하는 출력 형식 옵션.
* `var keyEncodingStrategy: JSONEncoder.KeyEncodingStrategy`
    * 형식의 코딩 키가 JSON 키로 인코딩되는 방식을 결정하는 값.
* `enum JSONEncoder.KeyEncodingStrategy`
    * 타입의 코딩 키가 JSON 키로 인코딩되는 방식을 결정하는 값.
* `var userInfo: [CodingUserInfoKey : Any]`
    * 컨텍스트 정보를 제공하여 인코딩 프로세스를 커스텀화하는데 사용하는 딕셔너리.


### Encoding Dates
> 날짜 인코딩

* `var dateEncodingStrategy: JSONEncoder.DateEncodingStrategy`
    * 날짜를 JSON 객체의 일부로 인코딩 할 때 사용되는 전략.
* `enum JSONEncoder.DateEncodingStrategy`
    * JSON으로 날짜를 인코딩 할 때 날짜 형식을 지정하는 데 사용할 수 있는 형식 지정 전략.


### Encoding Raw Data
> Raw Data 인코딩

* `var dataEncodingStrategy: JSONEncoder.DataEncodingStrategy`
    * 인코더가 raw data를 인코딩하는 데 사용하는 전략. 
* `enum JSONEncoder.DataEncodingStrategy`
    * raw data를 인코딩하기 위한 전략.


### Encoding Exceptional Numbers
> 예외적인 숫자 인코딩

* `var nonConformingFloatEncodingStrategy: JSONEncoder.NonConformingFloatEncodingStrategy`
    * 예외적인 부동 소수점 값을 만나면 인코더가 사용하는 전략.
* `enum JSONEncoder.NonConformingFloatEncodingStrategy`
    * 부적합한 부동 소수점 숫자를 인코딩하기 위한 전략으로 IEEE 754 예외 값이라고도 한다.


&nbsp; 
## See Also
### JSON
* [Using JSON with Custom Types](https://developer.apple.com/documentation/foundation/archives_and_serialization/using_json_with_custom_types)
* class JSONDecoder
* class JSONSerialization


&nbsp;      
&nbsp;      
### [by. 0junChoi](https://github.com/0jun0815) email: <0jun0815@gmail.com>
### [Apple Developer Documentation JSONEncoder](https://developer.apple.com/documentation/foundation/jsonencoder)
