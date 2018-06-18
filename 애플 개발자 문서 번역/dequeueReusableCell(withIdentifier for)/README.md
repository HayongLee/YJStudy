# dequeueReusableCell(withIdentifier:for:)
> 지정된 재사용 식별자에 대한 재사용 가능한 테이블 뷰 셀 객체를 반환하고 이를 테이블에 추가한다.


* [Declaration](#declaration)
* [Parameters](#parameters)
* [Return Value](#return-value)
* [Discussion](#discussion)
* [See Also](#see-also)


&nbsp;      
## Declaration
```
func dequeueReusableCell(withIdentifier identifier: String, 
                    for indexPath: IndexPath) -> UITableViewCell
```


&nbsp;      
## Parameters
* identifier
    * 재사용 할 셀 객체를 나타내는 문자열. 이 매개 변수는 nil이 아니어야 한다.
* indexPath
    * 셀의 위치를 지정하는 인덱스 경로. 데이터 소스는 셀에 대한 요청이 있을 때 이 정보를 수신하며 이를 전달해야 한다. 이 메서드는 인덱스 경로를 사용하여 테이블 뷰에서 셀의 위치를 기반으로 추가 구성을 수행한다.
    
    
&nbsp;      
## Return Value 
연관된 재사용 식별자가있는 UITableViewCell 객체이다. 이 메서드는 항상 유효한 셀을 리턴한다.


&nbsp;      
## Discussion
성능상의 이유로 테이블 뷰의 데이터 소스는 일반적으로 tableView(_:cellForRowAt:) 메서드에서 셀을 행에 할당 할 때 UITableViewCell 객체를 재사용해야 한다. 테이블 뷰는 데이터 소스가 재사용하도록 표시한 큐 또는 UITableViewCell 객체의 목록을 유지 관리한다. 테이블 뷰에 새 셀을 제공하라는 메시지가 표시되면 데이터 소스 객체에서 이 메서드를 호출한다. 이 메서드는 기존 셀을 사용할 수 있는 경우 이를 제거하거나 이전에 등록한 클래스 또는 nib 파일을 기반으로 새 셀을 만들고 테이블에 추가한다.


> **Important**
> 이 메서드를 호출하기 전에 register(_:forCellResueIdentifier:) 또는 register(_:forCellResueIdentifier:) 메서드를 사용하여 클래스 또는 nib 파일을 등록해야 한다.


지정된 식별자에 대한 클래스를 등록하고 새 셀을 만들어야하는 경우 이 메서드는 init(style:reuseIdentifier:) 메서드를 호출하여 셀을 초기화한다. nib 파일에서 셀 객체를 로드한다. 기존 셀을 다시 사용할 수 있는 경우 이 메서드는 대신 셀의 prepareForReuse() 메서드를 호출한다.


&nbsp;      
## See Also
### Creating Table View Cells
* `func register(UINib?, forCellReuseIdentifier: String)`
* `func register(AnyClass?, forCellReuseIdentifier: String)`
* `func dequeueReusableCell(withIdentifier: String) -> UITableViewCell?`


&nbsp;      
&nbsp;      
### [by. 0junChoi](https://github.com/0jun0815) email: <0jun0815@gmail.com>
### [Apple Developer Documentation dequeueReusableCell(withIdentifier:for:)](https://developer.apple.com/documentation/uikit/uitableview/1614878-dequeuereusablecell)
