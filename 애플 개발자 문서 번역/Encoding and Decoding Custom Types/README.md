# Encoding and Decoding Custom Types
> JSON과 같은 외부 표현과의 호환성을 위해 데이터 타입을 인코딩 및 디코딩 가능하게 만든다.


* [Overview](#overview)
* [Encode and Decode Automatically](#encode-and-decode-automatically)
* [Encode or Decode Exclusively](#encode-or-decode-exclusively)
* [Choose Properties to Encode and Decode Using Coding Keys](#choose-properties-to-encode-and-decode-using-coding-keys)
* [Encode and Decode Manually](#encode-and-decode-manually)
* [See Also](#see-also)


&nbsp;      
## Overview
많은 프로그래밍 작업에는 네트워크 연결을 통해 데이터를 보내거나 디스크에 데이터를 저장하거나 API 및 서비스에 데이터를 제출하는 작업이 포함된다. 이러한 작업에서는 종종 데이터가 전송되는 동안 중간 형멧으로 데이터를 인코딩하고 디코딩해야 한다. 


Swift 표준 라이브러리는 데이터 인코딩 및 디코딩에 대한 표준화된 접근 방식을 정의한다. 커스텀 타입에 대해 [Ecodable](https://developer.apple.com/documentation/swift/encodable) 및 [Decodable](https://developer.apple.com/documentation/swift/decodable) 프로토콜을 구현하여 이 접근 방식을 채택한다. 이러한 프로토콜을 채택하면 [Encoder](https://developer.apple.com/documentation/swift/encoder) 및 [Decoder](https://developer.apple.com/documentation/swift/decoder) 프로토콜의 구현에서 데이터를 가져와서 JSON 또는 프로퍼티 리스트와 같은 외부 표현에서 데이터를 인코딩하거나 디코딩할 수 있다. 인코딩 및 디코딩을 모두 지원하려면 Encodable 및 Decodable 프로토콜을 결합한 [Codable](https://developer.apple.com/documentation/swift/codable)에 대한 적합성을 선언한다. 이 과정은 커스텀 타입을 codable하게 만드는 것으로 알려져 있다.


&nbsp;
## Encode and Decode Automatically
타입 codable을 만드는 가장 간단한 방법은 이미 Codable 타입을 사용하는 프로퍼티를 선언하는 것이다. 이러한 타입에는 String, Int 및 Double과 같은 표준 라이브러리 타입과 Date, Data, URL과 같은 Foundation 타입이 있다. codable 프로퍼티가 있는 모든 타입은 해당 적합성 선언함으로써 Codable에 자동으로 적합해진다.


랜드 마크의 이름과 창립 연도를 저장하는 Landmark 구조체를 예로 들면:
```
struct Landmark {
    var name: String
    var foundingYear: Int
}
```


Landmark의 상속 목록에 Codable을 추가하면 Encodable 및 Decodable의 모든 프로토콜 요구 사항을 충족하는 자동 적합성이 트리거 된다:
```
struct Landmark: Codable {
    var name: String
    var foundingYear: Int

    // Landmark now supports the Codable methods init(from:) and encode(to:), 
    // even though they aren't written as part of its declaration.
}
```


커스텀 타입에 Codable을 채택하면 기본 제공 데이터 형식과 커스텀 인코더 및 디코더가 제공하는 어떤 형식으로 이를 직렬화 할 수 있다. 예를 들어 Landmark 구조체는 [PropertyListEncoder](https://developer.apple.com/documentation/foundation/propertylistencoder) 및 [JSONEncoder](https://developer.apple.com/documentation/foundation/jsonencoder) 클래스를 사용하여 인코딩 할 수 있다. 단, Landmark 자체에는 프로퍼티 리스트 또는 JSON을 구체적으로 처리하는 코드가 포함되어 있지 않다.  


codable한 다른 커스텀 타입으로 구성된 커스텀 타입에도 동일한 원칙이 적용된다. 모든 프로퍼티가 Codable한 경우, 모든 커스텀 타입도 Codable이 될 수 있다.


아래 예제는 Landmark 구조체에 location 프로퍼티가 추가 될 때 자동 Codable 적합성이 적용되는 방법을 보여준다:
```
struct Coordinate: Codable {
    var latitude: Double
    var longitude: Double
}

struct Landmark: Codable {
    // Double, String, and Int all conform to Codable.
    var name: String
    var foundingYear: Int

    // Adding a property of a custom Codable type maintains overall Codable conformance.
    var location: Coordinate
}
```


Array, Dictionary 및 Optional과 같은 기본 제공 타입은 codable 타입을 포함할 때마다 Codable에 적합하다. Landmark에 Coordinate 인스턴스의 배열을 추가할 수 있으며 전체 구조가 여전히 Codable을 만족시킨다.


아래 예제는 Landmark 내에 기본 제공 codable 타입을 사용하는 여러 프로퍼티를 추가할 때 자동 적합성이 적용되는 방법을 보여준다:
```
struct Landmark: Codable {
    var name: String
    var foundingYear: Int
    var location: Coordinate

    // Landmark is still codable after adding these properties.
    var vantagePoints: [Coordinate]
    var metadata: [String: String]
    var website: URL?
}
```


&nbsp;
## Encode or Decode Exclusively
어떤 경우에는 양방향 인코딩 및 디코딩에 대한 Codable의 지원이 필요하지 않을 수 있다. 예를 들어, 일부 앱은 원격 네트워크 API를 호출하기만 하면 되며 동일한 타입을 포함하는 응답을 디코딩할 필요가 없다. 데이터 인코딩만 지원해야 하는 경우 Encodable 적합성을 선언한다. 반대로 주어진 타입의 데이터만 읽어야하는 경우 Decodable에 적합성을 선언한다.


아래 예제는 데이터를 인코딩하거나 디코딩하는 Landmark 구조체에 대체 선언을 보여준다:
```
struct Landmark: Encodable {
    var name: String
    var foundingYear: Int
}
```
```
struct Landmark: Decodable {
    var name: String
    var foundingYear: Int
}
```


&nbsp;   
## Choose Properties to Encode and Decode Using Coding Keys
Codable 타입은 [CodingKey](https://developer.apple.com/documentation/swift/codingkey) 프로토콜을 준수하는 CodingKeys라는 특수 중첩 열거형을 선언할 수 있다. 이 열거형이 있는 경우, 해당 사례는 codable 타입의 인스턴스가 인코딩 또는 디코딩될 때 포함되어야 하는 프로퍼티의 권한 있는 목록 역할을 한다. 열거형 케이스의 이름은 타입의 해당 프로퍼티에 지정한 이름과 일치해야 한다.


인스턴스를 디코딩 할 때 또는 인코딩된 표현에 특정 프로퍼티가 포함되지 않아야 하는 경우 CodingKeys 열거형에서 해당 프로퍼티를 생략한다. CodingKeys에서 생략된 프로퍼티에는 포함 타입이 Decodable 또는 Codable에 자동으로 일치하도록 기본값이 필요하다. 


직렬화된 데이터 형식에 사용된 키가 데이터 타입의 프로퍼티 이름과 일치하지 않으면, CodingKeys 열거형의 raw-value 타입으로 String을 지정하여 대체 키를 제공한다. 각 열거형 케이스의 raw-value로 사용하는 문자열은 인코딩 및 디코딩 중에 사용되는 키 이름이다. 케이스 이름과 raw-value 간의 연결을 통해 모델링중인 직렬화 형식의 이름, 문장, 부호 및 대소 문자를 일치시키지 않고 [Swift API Design Guidlines](https://swift.org/documentation/api-design-guidelines/)에 따라 데이터 구조의 이름을 지정할 수 있다.


아래 예제는 인코딩 및 디코딩 할 때 Landmark 구조체의 name과 foundingYear 프로퍼티에 대한 대체 키를 사용한다:
```
struct Landmark: Codable {
    var name: String
    var foundingYear: Int
    var location: Coordinate
    var vantagePoints: [Coordinate]

    enum CodingKeys: String, CodingKey {
        case name = "title"
        case foundingYear = "founding_date"

        case location
        case vantagePoints
    }
}
```


&nbsp;    
## Encode and Decode Manually
Swift 타입의 구조가 인코딩된 형식의 구조와 다른 경우 Encodable 및 Decodable 커스텀 구현을 제공하여 자신의 인코딩 및 디코딩 로직을 정의할 수 있다.


아래 예제는 Coordinate 구조체가 확장되어 additionalInfo 컨테이너 내부에 중첩된 elevation 프로퍼티를 지원한다:
```
struct Coordinate {
    var latitude: Double
    var longitude: Double
    var elevation: Double

    enum CodingKeys: String, CodingKey {
        case latitude
        case longitude
        case additionalInfo
    }

    enum AdditionalInfoKeys: String, CodingKey {
        case elevation
    }
}
```


Coordinate 타입의 인코딩된 형식에는 중첩된 정보의 두 번째 레벨이 포함되어 있으므로 타입의 Encodable 및 Decodable 프로토콜을 사용하면 특정 레벨에서 사용되는 전체 코딩 키 집합을 나열하는 두 개의 열거형을 사용한다.


아래 예제는 필수 이니셜라이저인 [init(from:)](https://developer.apple.com/documentation/swift/decodable/2894081-init)을 구현하는 Decodable 프로토콜을 준수하도록 Coodinate 구조체를 확장하였다:
```
extension Coordinate: Decodable {
    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        latitude = try values.decode(Double.self, forKey: .latitude)
        longitude = try values.decode(Double.self, forKey: .longitude)

        let additionalInfo = try values.nestedContainer(keyedBy: AdditionalInfoKeys.self, forKey: .additionalInfo)
        elevation = try additionalInfo.decode(Double.self, forKey: .elevation)
    }
}
```


이니셜라이저는 매개 변수로 받는 Decoder 인스턴스의 메서드를 사용하여 Coordinate 인스턴스를 채운다. Coordinate 인스턴스의 두 프로퍼티는 Swift 표준 라이브러리에서 제공하는 키 컨테이너 API를 사용하여 초기화된다.


아래 예제는 필수 메서드인 [encode(to:)](https://developer.apple.com/documentation/swift/encodable/2893603-encode)를 구현하는 Encodable 프로토콜을 준수하도록 Coodinate 구조체를 확장하였다:
```
extension Coordinate: Encodable {
    func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        try container.encode(latitude, forKey: .latitude)
        try container.encode(longitude, forKey: .longitude)

        var additionalInfo = container.nestedContainer(keyedBy: AdditionalInfoKeys.self, forKey: .additionalInfo)
        try additionalInfo.encode(elevation, forKey: .elevation)
    }
}
```


encode(to:) 메서드의 구현은 앞의 예제에서 디코딩 연산의 반대이다.


인코딩 및 디코딩 프로세스를 커스텀할 때 사용되는 컨테이너 타입에 대한 자세한 내용은 [KeyedEncodingContainerProtocol](https://developer.apple.com/documentation/swift/keyedencodingcontainerprotocol) 및 [UnkeyedEncodingContainer](https://developer.apple.com/documentation/swift/unkeyedencodingcontainer)를 참조.


&nbsp;      
## See Also
### First Steps
* typealias Codable
* protocol NSCoding
* protocol NSSecureCoding


### Related Documentation
* [Using JSON with Custom Types](https://developer.apple.com/documentation/foundation/archives_and_serialization/using_json_with_custom_types)


&nbsp;      
&nbsp;      
### [by. 0junChoi](https://github.com/0jun0815) email: <0jun0815@gmail.com>
### [Apple Developer Documentation Encoding and Decoding Custom Types](https://developer.apple.com/documentation/foundation/archives_and_serialization/encoding_and_decoding_custom_types)
