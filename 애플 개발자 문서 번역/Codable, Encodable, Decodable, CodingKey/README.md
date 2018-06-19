# Codable, Encodable, Decodable, CodingKey


* [Codable](#codable)
    * [Declaration](#declaration)
    * [Discussion](#discussion)
    * [See Also](#see-also)
* [Encodable](#encodable)
    * [Topics](#topics)
* [Decodable](#decodable)
    * [Topics](#topics1)
* [CodingKey](#codingKey)
    * [Topics](#topics2)
* [Relationships](#relationships)
* [See Also](#see-also1)


&nbsp;
## Codable
> 외부 표현으로 또는 외부 표현에서 변환할 수 있는 타입이다.


&nbsp;
### Declaration
```
typealias Codable = Decodable & Encodable
```


&nbsp;
### Discussion
Codable은 Encodable 및 Decodable 프로토콜에 대한 타입 알리아스이다. Codable을 타입 또는 제네릭 제약 조건으로 사용하면 두 프로토콜을 모두 준수하는 모든 타입과 일치한다.


&nbsp;
### See Also
#### First Steps
* [Encoding and Decoding Custom Types](https://developer.apple.com/documentation/foundation/archives_and_serialization/encoding_and_decoding_custom_types)
* protocol NSCoding
* protocol NSSecureCoding


&nbsp;      
## Encodable
> 자신을 외부 표현으로 인코딩할 수 있는 타입이다.


&nbsp;      
### Topics
#### Instance Methods
* `func encode(to: Encoder)`
    * 이 값을 지정된 인코더에 인코드한다. **필수 사항**


&nbsp;      
## Decodable
> 외부 표현에서 자신을 디코딩 할 수 있는 타입이다.


&nbsp;      
### Topics
#### Initializers
* `init(from: Decoder)`
    * 지정된 디코더에서 디코딩하여 새 인스턴스를 만든다. **필수 사항**


&nbsp;      
## CodingKey
> 인코딩 및 디코딩을 위한 키로 사용할 수 있는 타입이다.


&nbsp;      
### Topics
#### Initializers
* `init?(intValue: Int)`
    * 지정된 정수로부터 새로운 인스턴스를 생성한다. **필수 사항**
* `init?(stringValue: String)`
    * 주어진 문자열로부터 새로운 인스턴스를 생성한다. **필수 사항**


#### Instance Properties
* `var intValue: Int?`
    * 정수 인덱스가 지정된 컬렉션(예: Int 키 딕셔너리)에 사용할 값이다. **필수 사항**
* `var stringValue: String`
    * 명명된 컬렉션(예: 문자열 키 딕셔너리)에 사용할 문자열이다. **필수 사항**


&nbsp;      
## Relationships
### Inherits From
* CustomDebugStringConvertible, CustomStringConvertible


### Adopted By
* Array
* CGAffineTransform
* CGPoint
* CGRect
* CGSize
* CGVector
* DateInterval
* Decimal
* Dictionary
* MPMusicPlayerPlayParameters
* Optional
* Set


&nbsp;      
## See Also
### Custom Encoding and Decoding
* [Encoding and Decoding Custom Types](https://developer.apple.com/documentation/foundation/archives_and_serialization/encoding_and_decoding_custom_types)
* typealias Codable
* protocol Decodable
* protocol CodingKey
* struct CodingUserInfoKey


&nbsp;      
&nbsp;      
### [by. 0junChoi](https://github.com/0jun0815) email: <0jun0815@gmail.com>
### [Apple Developer Documentation Codable](https://developer.apple.com/documentation/swift/codable)
### [Apple Developer Documentation Encodable](https://developer.apple.com/documentation/swift/encodable)
### [Apple Developer Documentation Decodable](https://developer.apple.com/documentation/swift/decodable)
### [Apple Developer Documentation CodingKey](https://developer.apple.com/documentation/swift/codingkey)
