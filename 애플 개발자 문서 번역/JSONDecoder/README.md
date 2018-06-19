# JSONDecoder
> JSON 객체에서 데이터 타입의 인스턴스를 디코딩하는 객체이다.


* [Overview](#overview)
* [Topic](#topic)
    * [First Steps](#first-steps)
    * [Customizing Decoding](#customizing-decoding)
    * [Decoding Dates](#decoding-dates)
    * [Decoding Raw Data](#decoding-raw-data)
    * [Decoding Exceptional Numbers](#decoding-exceptional-numbers)
* [See Also](#see-also)


&nbsp;      
## Overview
아래 예제는 간단한 GroceryProduct 타입의 인스턴스를 JSON 객체에서 디코딩하는 방법을 보여준다. 이 타입은 JSONDecoder 인스턴스를 사용하여 디코딩할 수 있도록 [Codable](https://developer.apple.com/documentation/swift/codable)을 채택한다.
```
struct GroceryProduct: Codable {
    var name: String
    var points: Int
    var description: String?
}

let json = """
{
    "name": "Durian",
    "points": 600,
    "description": "A fruit with a distinctive scent."
}
""".data(using: .utf8)!

let decoder = JSONDecoder()
let product = try decoder.decode(GroceryProduct.self, from: json)

print(product.name) // Prints "Durian"
```


&nbsp;      
## Topic
### First Steps
> 첫 단계

* `init()`
    * 기본 형식 설정 및 디코딩 전략을 사용하여 재사용 가능한 새로운 JSON 디코더를 만든다.
* `func decode<T>(T.Type, from: Data) -> T`
    * 지정한 타입의 값을 JSON 객체에서 디코딩하여 반환한다.


### Customizing Decoding
> 디코딩 커스터마이징

* `var keyDecodingStrategy: JSONDecoder.KeyDecodingStrategy`
    * 타입의 코딩 키가 JSON 키에서 디코딩되는 방식을 결정한다.
* `enum JSONDecoder.KeyDecodingStrategy`
    * 타입의 코딩 키가 JSON 키에서 디코딩되는 방식을 결정하는 값.
* `var userInfo: [CodingUserInfoKey : Any]`
    * 컨텍스트를 제공하여 디코딩 프로세스를 커스텀화하는데 사용하는 딕셔너리.


### Decoding Dates
> 날짜 디코딩

* `var dateDecodingStrategy: JSONDecoder.DateDecodingStrategy`
    * JSON 객체의 일부에서 날짜를 디코딩 할 때 사용되는 전략.
* `enum JSONDecoder.DateDecodingStrategy`
    * JSON에서 날짜를 형식화 할 때 사용할 수 있는 전략.


### Decoding Raw Data
> Raw Data 디코딩

* `var dataDecodingStrategy: JSONDecoder.DataDecodingStrategy`
    * 디코더가 raw data를 디코딩하는 데 사용하는 전략.
* `enum JSONDecoder.DataDecodingStrategy`  
    * raw data를 디코딩하는 전략.


### Decoding Exceptional Numbers
> 예외적인 숫자 디코딩

* `var nonConformingFloatDecodingStrategy: JSONDecoder.NonConformingFloatDecodingStrategy`
    * 예외적인 부동 소수점 값을 만나면 디코더가 사용하는 전략.
* `enum JSONDecoder.NonConformingFloatDecodingStrategy`
    * 부적합한 부동 소수점 수를 인코딩하기 위한 전략으로 IEE 754 예외 값이라고도 한다.


&nbsp; 
## See Also
### JSON
* [Using JSON with Custom Types](https://developer.apple.com/documentation/foundation/archives_and_serialization/using_json_with_custom_types)
* class JSONEncoder
* class JSONSerialization


&nbsp;      
&nbsp;      
### [by. 0junChoi](https://github.com/0jun0815) email: <0jun0815@gmail.com>
### [Apple Developer Documentation JSONDecoder](https://developer.apple.com/documentation/foundation/jsondecoder)
