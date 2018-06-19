# Using JSON with Custom Types
> Swift에서 여러 종류의 JSON을 인코딩하고 디코딩하는 방법을 보여준다.


* [Overview](#overview)
* [Read Data from Arrays](#read-data-from-arrays)
* [Change Key Names](#change-key-names)
* [Access Nested Data](#access-nested-data)
* [Merge Data at Different Depths](#merge-data-at-different-depths)
* [See Also](#see-also)


&nbsp;      
## Overview
다른 앱, 서비스 및 파일에서 보내거나 받는 JSON 데이터는 다양한 모양과 구조로 제공될 수 있다. 외부 JSON 데이터와 앱의 모델 유형 간의 차이점을 처리하려면 이 샘플에 설명된 기술을 사용한다.


![](https://docs-assets.developer.apple.com/published/81e3676209/ddb949cb-0e77-426f-8000-43e2e2ab262d.png)


이 샘플은 간단한 데이터 타입인 GroceryProduct를 정의하고 여러 JSON 형식에서 해당 타입의 인스턴스를 생성하는 방법을 보여준다.
```
struct GroceryProduct: Codable {
    var name: String
    var points: Int
    var description: String?
}
```


&nbsp;      
## Read Data from Arrays
Swift의 표현형 시스템을 사용하여 동일하게 구조화된 객체의 컬렉션을 수동으로 반복하지 않도록 한다. 이 예제에서는 배열 타입을 값으로 사용하여 다음과 같이 구성된 JSON을 사용하는 방법을 확인한다:
```
[
    {
        "name": "Banana",
        "points": 200,
        "description": "A banana grown in Ecuador."
    }
]
```


사용하는 JSON에 균등한 요소 배열이 포함되어 있으면, 개별 요소의 타입에 대한 Codable 프로토콜에 대한 적합성을 추가한다. 전체 배열을 디코딩하거나 인코딩하려면 [Element].self 구문을 사용한다.


아래 예제에서 GroceryProduct 구조체는 자동으로 디코딩 가능하다. 왜냐하면 Codable 프로토콜에 대한 적합성이 그 선언에 포함되어 있기 때문이다. 이 예제의 전체 배열은 decode 메서드를 호출할 때 사용 된 구문을 기반으로 디코딩 할 수 있다.


```
let json = """
[
    {
        "name": "Banana",
        "points": 200,
        "description": "A banana grown in Ecuador."
    },
    {
        "name": "Orange",
        "points": 100
    }
]
""".data(using: .utf8)!

struct GroceryProduct: Codable {
    var name: String
    var points: Int
    var description: String?
}

let decoder = JSONDecoder()
let products = try decoder.decode([GroceryProduct].self, from: json)

print("The following products are available:")
for product in products {
    print("\t\(product.name) (\(product.points) points)")
    if let description = product.description {
        print("\t\t\(description)")
    }
}


// ----- 출력 -----
The following products are available:
    Banana (200 points)
        A banana grown in Ecuador.
    Orange (100 points)
```


JSON 배열에 GroceryProduct 인스턴스가 아닌 요소가 하나라도 포함되어있는 경우, 디코딩은 실패한다. 이렇게하면 JSON 배열 공급자에 의해 오타 또는 보증 오해가 발생해도 데이터가 자동으로 손실되지 않는다.


&nbsp;      
## Change Key Names
JSON 키의 데이터를 이름에 관계없이 커스텀 타입의 프로퍼티에 매핑하는 방법에 대해 알아보자. 예를 들어, 이 예제에서는 JSON의 "product_name"키를 GroceryProduct의 name 프로퍼티에 매핑하는 방법을 보여준다:
```
{
    "product_name": "Banana",
    "product_cost": 200,
    "description": "A banana grown in Ecuador."
}
```


Swift 코드에서 사용하는 이름이 동일한 값을 참조하는 JSON의 이름과 항상 일치하지는 않는다. Swift에서 JSONEncoder와 JSONDecoder 클래스로 작업 할 때, 다른 이름을 사용해야하는 JSON을 사용하는 경우에도 데이터 타입에 기존 Swift 이름을 쉽게 적용할 수 있다.


Swift 이름과 JSON 이름 사이의 매핑을 생성하려면, Codable, Encodable 또는 Decodable에 적합성을 추가하는 동일한 타입 내에서 CodingKeys라는 이름의 중첩된 열거형을 사용한다.


아래 예제에서, Swift 프로퍼티 name, points가  인코딩되고 디코딩 될 때 product_name과 어떻게 맵핑되는지 보자.
```
let json = """
[
    {
        "product_name": "Bananas",
        "product_cost": 200,
        "description": "A banana grown in Ecuador."
    },
    {
        "product_name": "Oranges",
        "product_cost": 100,
        "description": "A juicy orange."
    }
]
""".data(using: .utf8)!

struct GroceryProduct: Codable {
    var name: String
    var points: Int
    var description: String?

    private enum CodingKeys: String, CodingKey {
        case name = "product_name"
        case points = "product_cost"
        case description
    }
}

let decoder = JSONDecoder()
let products = try decoder.decode([GroceryProduct].self, from: json)

print("The following products are available:")
for product in products {
    print("\t\(product.name) (\(product.points) points)")
    if let description = product.description {
        print("\t\t\(description)")
    }
}


// ----- 출력 -----
The following products are available:
    Bananas (200 points)
        A banana grown in Ecuador.
    Oranges (100 points)
        A juicy orange.
```


description이라는 이름이 두 표현 사이에서 일관 되더라도 GroceryProduct 구조체에 필요한 값이기 때문에 CodingKeys 열거형에 여전히 포함시킨다. 해당 열거형 케이스는 이름이 해당 프로퍼티 이름과 동일하므로 명시적인 raw-value가 필요하지 않다.


커스텀 매핑을 사용하면 JSON 키의 이름이 다른 경우에도 Swift API의 프로퍼티 이름에 [Swift API Design Guidlines](https://swift.org/documentation/api-design-guidelines/)를 적용할 수 있다.


&nbsp;      
## Access Nested Data
코드에서 필요없는 JSON의 구조 및 데이터를 무시하는 방법에 대해 알아보자. 이 예제에서는 중간 타입을 사용하여 원하지 않는 데이터 및 구조를 건너 뛰어 JSON에서 식료품 제품을 추출하는 방법을 확인한다:
```
[
    {
        "name": "Home Town Market",
        "aisles": [
            {
                "name": "Produce",
                "shelves": [
                    {
                        "name": "Discount Produce",
                        "product": {
                            "name": "Banana",
                            "points": 200,
                            "description": "A banana that's perfectly ripe."
                        }
                    }
                ]
            }
        ]
    }
]
```


외부 소스 또는 기존 로컬 형식의 JSON을 사용하는 애플리케이션을 작성할 수 있다. 두 경우 모두 앱에서 모델링하는 개념의 구조와 JSON 제작자가 모델링한 개념이 일치하지 않을 수 있다. 때로는 Swift 프로그램을 위한 논리적 데이터 묶음이 사용하는 JSON의 여러 중첩된 객체 또는 배열에 분산되어 있는 경우가 있다. 읽고 있는 JSON의 구조와 일치하는 decodable 타입은 디코딩하기에 안전한 중간 타입이다. 나머지 앱에서 사용할 타입의 이니셜라이저에서 데이터 소스로 사용된다.


중간 타입을 사용하면 다양한 형태의 외부 JSON과의 호환성을 유지하면서 자신의 코드에서 가장 자연스러운 타입을 사용할 수 있다.


아래 예제는 식료품 점을 나타내는 타입과 그것이 판매하는 제품의 목록을 소개한다:
```
struct GroceryStore {
    var name: String
    var products: [Product]

    struct Product: Codable {
        var name: String
        var points: Int
        var description: String?
    }
}
```


API는 다음과 같이 구성된 JSON을 사용하여 식료품 점에 대한 정보를 제공할 수 있다:
```
let json = """
[
    {
        "name": "Home Town Market",
        "aisles": [
            {
                "name": "Produce",
                "shelves": [
                    {
                        "name": "Discount Produce",
                        "product": {
                            "name": "Banana",
                            "points": 200,
                            "description": "A banana that's perfectly ripe."
                        }
                    }
                ]
            }
        ]
    },
    {
        "name": "Big City Market",
        "aisles": [
            {
                "name": "Sale Aisle",
                "shelves": [
                    {
                        "name": "Seasonal Sale",
                        "product": {
                            "name": "Chestnuts",
                            "points": 700,
                            "description": "Chestnuts that were roasted over an open fire."
                        }
                    },
                    {
                        "name": "Last Season's Clearance",
                        "product": {
                            "name": "Pumpkin Seeds",
                            "points": 400,
                            "description": "Seeds harvested from a pumpkin."
                        }
                    }
                ]
            }
        ]
    }
]
""".data(using: .utf8)!
```


API에서 반환한 JSON에는 해당 Swift 타입을 채우기 위해 필요한 것보다 많은 정보가 들어 있다. 특히 이전에 정의 된 품 구조체와 구조적으로 호환되지 않는다. 해장 제품은 aisles 및 shelves가 안에 중첩되어 있다. JSON의 공급자가 추가 정보를 필요로하지만, 이 정보를 사용하는 모든 앱 내부에서는 유용하지 않을 수 있다.


외부 컨테이너에서 필요한 데이터를 추출하려면 소스 JSON의 모양을 반영하는 타입을 작성하고 Decodable로 표시한다. 그런 다음 소스 JSON을 미러링하는 타입의 인스턴스를 사용하는 나머지 앱에서 사용할 타입에 이니셜라이저를 작성한다.


아래 예제에서 GroceryStoreService 구조체는 식료품 JSON과 애플리품이션에서 의도된 용도에 이상적인 GroceryStore 구조체 사이의 중간 역할을 한다:
```
struct GroceryStoreService: Decodable {
    let name: String
    let aisles: [Aisle]

    struct Aisle: Decodable {
        let name: String
        let shelves: [Shelf]

        struct Shelf: Decodable {
            let name: String
            let product: GroceryStore.Product
        }
    }
}
```


GroceryStoreService 구조체는 소스 JSON의 구조(aisles와 shelves 포함)와 일치하므로 Decodable 프로토콜이 구조체의 상속된 타입 목록에 포함되어 있으면 Decodable 프로토콜 적합이 자동으로 수행된다. GroceryStore 구조체의 중첩 된 Product 구조체는 데이터가 동일한 이름과 타입을 사용하기 때문에 Shelf 구조체에서 재사용된다.


GroceryStoreService 구조체의 역할을 중간 타입으로 완성하려면, GroceryStore 구조체의 확장을 사용한다. 확장은 GroceryStoreService 인스턴스를 취하는 이니셜라이저를 추가하고 aisles와 shelves를 루핑하여 불필요한 중첩을 제거하고 버린다:
```
extension GroceryStore {
    init(from service: GroceryStoreService) {
        name = service.name
        products = []

        for aisle in service.aisles {
            for shelf in aisle.shelves {
                products.append(shelf.product)
            }
        }
    }
}
```


위의 예제에서 타입 간의 관계를 사용하면 JSON을 쉽고 간결하게 읽고 GroceryStoreService 중간 타입을 전달하고 앱에서 결과로 나오는 GroceryStore 인스턴스를 사용할 수 있다:
```
let decoder = JSONDecoder()
let serviceStores = try decoder.decode([GroceryStoreService].self, from: json)

let stores = serviceStores.map { GroceryStore(from: $0) }

for store in stores {
    print("\(store.name) is selling:")
    for product in store.products {
        print("\t\(product.name) (\(product.points) points)")
        if let description = product.description {
            print("\t\t\(description)")
        }
    }
}


// ----- 출력 -----
Home Town Market is selling:
    Banana (200 points)
        A banana that's perfectly ripe.
Big City Market is selling:
    Chestnuts (700 points)
        Chestnuts that were roasted over an open fire.
    Pumpkin Seeds (400 points)
        Seeds harvested from a pumpkin.
```


&nbsp;      
## Merge Data at Different Depths
Encodable 및 Decodable의 프로토콜 요구사항에 대한 커스텀 정의 구현을 작성하여 JSON 구조의 서로 다른 깊이에서 데이터를 결합하거나 분리 할 수 있다. 이 예제는 JSON에서 다음과 같이 보이는 GroceryProduct 인스턴스를 생성하는 방법을 보여준다:
```
{
    "Banana": {
        "points": 200,
        "description": "A banana grown in Ecuador."
    }
}
```


때로는 JSON 파일 또는 API에서 사용하는 데이터 모델이 앱에서 사용중인 모델과 일치하지 않는 경우가 있다. 이러한 상황이 발생하면 인코딩 및 디코딩 할 때 JSON에서 객체를 병합하거나 분리해야 할 수 있다. 결과적으로 단일 인스턴스의 인코딩 또는 디코딩에는 JSON 객체의 계층 구조에서 위 또는 아래로 도달해야 한다.


아래 예제는 이러한 형태의 데이터 병합이 자주 발생함을 보여준다. 판매하는 각 제품의 이름, 가격 및 기타 세부사항을 추적하는 식료품 점을 모델링한다.


```
let json = """
{
    "Banana": {
        "points": 200,
        "description": "A banana grown in Ecuador."
    },
    "Orange": {
        "points": 100
    }
}
""".data(using: .utf8)!
```


제품 이름은 제품의 나머지 세부 사항을 정의하는 키의 이름이기도하다. 이 경우 Banana 제품에 대한 정보는 제품 이름 자체에 중첩된 객체에 저장된다. 그러나 제품의 이름이 물체의 식별 키로부터 오는 것이 분명하다는 것은 관습에 의한 것이다.


반대로 JSON 구조의 또 다른 공식에는 각 제품에 대한 product 키와 각 제품 이름을 저장하는 name 키가 있을 수 있다. 이 대안 공식은 아래 예에서와 같이 Swift에서 데이터를 모델링하는 방법과 일치하다:
```
struct GroceryStore {
    struct Product {
        let name: String
        let points: Int
        let description: String?
    }

    var products: [Product]

    init(products: [Product] = []) {
        self.products = products
    }
}
```


GroceryStore 구조체에 대한 다음의 확장은 그것이 Codable 프로토콜에 대한 최종 적합성으로 구조체를 중간에 가져 오는 Encodable 프로토콜을 따르게한다. 특히, CodingKey 프로토콜과 같은 종류의 적합성을 가진 보다 전형적인 열거형이 아닌, 중첩 된 구조체 ProductKey를 사용한다. Product 구조체의 인스턴스 이름으로 사용될 수 있는 코딩 키의 수를 무제한으로 고려하기 위한 구조체가 필요하다.
```
extension GroceryStore: Encodable {
    struct ProductKey: CodingKey {
        var stringValue: String
        init?(stringValue: String) {
            self.stringValue = stringValue
        }

        var intValue: Int? { return nil }
        init?(intValue: Int) { return nil }

        static let points = ProductKey(stringValue: "points")!
        static let description = ProductKey(stringValue: "description")!
    }

    func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: ProductKey.self)

        for product in products {
            // Any product's `name` can be used as a key name.
            let nameKey = ProductKey(stringValue: product.name)!
            var productContainer = container.nestedContainer(keyedBy: ProductKey.self, forKey: nameKey)

            // The rest of the keys use static names defined in `ProductKey`.
            try productContainer.encode(product.points, forKey: .points)
            try productContainer.encode(product.description, forKey: .description)
        }
    }
}
```


위의 예제에서 Encodable 프로토콜을 준수하면 GroceryStore 인스턴스는 JSONEncoder 인스턴스를 사용하여 JSON으로 인코딩 될 수 있다:
```
var encoder = JSONEncoder()
encoder.outputFormatting = .prettyPrinted

let store = GroceryStore(products: [
    .init(name: "Grapes", points: 230, description: "A mixture of red and green grapes."),
    .init(name: "Lemons", points: 2300, description: "An extra sour lemon.")
])

print("The result of encoding a GroceryStore:")
let encodedStore = try encoder.encode(store)
print(String(data: encodedStore, encoding: .utf8)!)
print()


// ----- 출력 -----
The result of encoding a GroceryStore:
{
    "Grapes" : {
        "points" : 230,
        "description" : "A mixture of red and green grapes."
    },
    "Lemons" : {
        "points" : 2300,
        "description" : "An extra sour lemon."
    }
}
```


Codable 프로토콜에 대한 적합성 구현의 두 번째 절반은 디코딩이다. 다음의 확장을 GroceryStore 구조체에 대한 적합성을 완성한다. 들어오는 JSON 객체를 디코딩하는 과정에서 이니셜라이저는 객체의 첫 번째 중첩 레벨의 모든 키를 반복한다.
```
extension GroceryStore: Decodable {
    public init(from decoder: Decoder) throws {
        var products = [Product]()
        let container = try decoder.container(keyedBy: ProductKey.self)
        for key in container.allKeys {
            // Note how the `key` in the loop above is used immediately to access a nested container.
            let productContainer = try container.nestedContainer(keyedBy: ProductKey.self, forKey: key)
            let points = try productContainer.decode(Int.self, forKey: .points)
            let description = try productContainer.decodeIfPresent(String.self, forKey: .description)

            // The key is used again here and completes the collapse of the nesting that existed in the JSON representation.
            let product = Product(name: key.stringValue, points: points, description: description)
            products.append(product)
        }

        self.init(products: products)
    }
}

let decoder = JSONDecoder()
let decodedStore = try decoder.decode(GroceryStore.self, from: json)

print("The store is selling the following products:")
for product in decodedStore.products {
    print("\t\(product.name) (\(product.points) points)")
    if let description = product.description {
        print("\t\t\(description)")
    }
}


// ----- 출력 -----
The store is selling the following products:
    Orange (100 points)
    Banana (200 points)
        A banana grown in Ecuador.
```


&nbsp;      
## See Also
### JSON
* class JSONEncoder
* class JSONDecoder
* class JSONSerialization


&nbsp;      
&nbsp;      
### [by. 0junChoi](https://github.com/0jun0815) email: <0jun0815@gmail.com>
### [Apple Developer Documentation Using JSON with Custom Types](https://developer.apple.com/documentation/foundation/archives_and_serialization/using_json_with_custom_types)
