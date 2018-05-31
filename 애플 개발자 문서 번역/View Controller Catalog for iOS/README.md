# View Controller Catalog for iOS
> 문서의 목적 및 용도 설명 (UIKit framework가 제공하는 view controller의 개요) View Controller의 역할, View Controller 사용 시 이점에 관한 내용 뒤에서 소개할 Controller들에 대한 개요


* [Navigation Controllers](#navigation-controllers)
* [Tab Bar Controllers](#tab-bar-controllers)
* [Page View Controllers](#page-view-controllers)
* [Split View Controllers](#split-view-controllers)
* [Popovers](#popovers)
* [Combined View Controller Interfaces](#combined-view-controller-interfaces)


&nbsp;      
## Navigation Controllers
> Navigation Controller의 구조 및 역할에 관한 내용 Navigation Interface와 Navigation Controller의 관계 Navigation Controller의 구성과 사용법에 관한 내용
* Anatomy of a Navigation Interface
    * Navigation Controller의 주된 역할과 Navigation interface의 구조에 관한 내용
* The Objects of a Navigation Interface
    * Navigation Controller가 Navigation Interface를 구현하기 위해 사용하는 객체에 관한 내용
* Creating a Navigation Interface
    * Navigation Interface를 생성할 때 유의할 점과 생성하기 위한 방법에 관한 내용
* Adopting a Full-Screen Layout for Navigation Views
    * View가 전체화면을 사용해야하는지 결정해야 할 때, Navigation Controller가 고려해야 할 사항과 설정방법에 관한 내용
* Modifying the Navigation Stack
    * Navigation Controller 클래스가 제공하는 Navigation Stack을 관리하기 위한 옵션에 관한 내용
* Monitoring Changes to the Navigation Stack
    * Navigation Stack에 있는 View Controller가 push 또는 pop이 되어 Navigation Stack이 변할 때 이루어지는 일련의 과정과 Navigation Controller가 보내는 메시지에 관한 내용
* Customizing the Navigation Bar Appearance
    * Navigation Bar를 커스터마이징하는 방법에 관한 내용
* Displaying a Navigation Toolbar
    * Toolbar를 표시하거나 숨기기 위한 설정방법과 Toolbar Item에 관한 내용


&nbsp;
## Tab Bar Controllers
> Tab Bar Controller에 대한 소개 Tap Bar Controller의 뷰 계층구조(view hierarchy)에 관한 내용 Tab Bar Controller의 구성과 사용법에 관한 내용
* Anatomy of a Tab Bar Interface
    * Tab Bar Interface의 역할과 구성과 Tab Bar Controller의 역할에 관한 내용
* The Objects of a Tab Bar Interface
    * Tab Bar Interface를 구성하고 있는 객체들에 관한 내용
* Creating a Tab Bar Interface
    * Tab Bar Interface를 생성하기 전에 고려해야 할 사항과 Tab Bar Interface를 생성하기 위한 방법에 관한 내용
* Managing Tabs at Runtime
    * Tab Bar Interface 생성 후 Tab 관리에 관한 내용
* Tab Bar Controllers and View Rotation
    * Tab Bar Controller가 지원하는 화면 방향과 회전에 관한 내용
* Tab Bar and Full-Screen Layout
    * Tab Bar Controller가 지원하는 전체화면에 관한 내용과 관련 프로퍼티를 통한 설정방법
    

&nbsp;      
## Page View Controllers
> Page View Controller의 사용 목적 Page View Controller의 뷰 계층구조에 관한 내용
* Anatomy of a Page View Controller Interface
    * Page View Controller Interface 구성에 관한 내용
* The Objects of a Page View Controller Interface
    * Page View Interface를 구성하고 있는 객체에 관한 내용
* Creating a Page View Controller Interface
    * Page View Controller Interface를 생성할 수 있는 방법과 Initial View Controller를 세팅하는 방법에 관한 내용
* Customizing Behavior at initialization
    * 초기화 시 Page View Controller를 커스터마이징 할 수 있는 방법에 관한 내용
* Customizing Behavior at Run Time with a Delegate
    * 디바이스 방향이 바뀌고 유저가 새로운 페이지를 탐색할 때 Page View Controller의 델리게이트의 역할에 관한 내용
* Supplying Content by Providing a Data Source
    * Data Source를 제공하고 Gesture recognizer를 활용하는 방법에 관한 내용
* Supplying Content by Setting the Current View Controller
    * 보여지고 있는 컨텐츠를 직접 제어하기 위한 방법에 관한 내용
* Special Consideration for Right-to-Left and Bottom-to-Top Content
    * left-to-right와 top-to-bottom식의 컨텐츠를 보여주기 위해 Page Controller View를 사용하는 방법에 관한 내용
    

&nbsp;  
## Split View Controllers
> Split View Controller의 역할에 관한 내용 Split View Interface의 Pane에 관한 내용
* Creating a Split View Controller Using a Storyboard
    * 스토리보드에서 Split View Controller를 생성하는 방법에 관한 내용
* Creating a Split View Controller Programmatically
    * 프로그래밍으로 Split View Controller를 생성하는 방법에 관한 내용
* Supporting Orientation Changes in a Split View
    * Split View Controller가 화면의 가로방향과 세로방향 지원에 관한 내용
    
    
&nbsp;
## Popovers    
> Popover의 역할과 사용되는 상황에 관한 내용 Modal View와의 비교에 대한 간략한 내용
* Creating and PResenting a Popover
    * Popover를 생성하고 표시하기 위한 방법에 관한 내용
* Implementing a Popover Delegate
    * Popover 델리게이트의 사용과 동작에 관한 내용
* Tips for Managing Popovers in Your App
    * Popover 관련있는 코드를 작성할 때 고려해야할 사항들에 관한 내용


&nbsp;
## Combined View Controller Interfaces
> 여러 View Controller 결합하여 인터페이스를 생성할 때, View Controller의 결합순서 iOS에서 Table View, Navigation, Tab Bar controller를 결합하는 방법에 대한 설명
* Adding a Navigation Controller to a Tab Bar Interface
    * Tab Bar Controller에 Navigation Controller를 결합시키는 방법(스토리보드와 프로그래밍)
* Displaying a Navigation Controller Modally
    * Navigation Controller를 Modal로 표시하기 위한 방법에 관한 내용
* Displaying a Tab Bar Controller Modally
    * Tab Bar Controller를 Modal로 표시하기 위한 방법에 관한 내용
* Using Table View Controllers in a Navigation Interface
    * Table View Controller를 Navigation Interface로 활용하는 방법에 관한 내용


&nbsp;      
&nbsp;      
### [by. 0junChoi](https://github.com/0jun0815) email: <0jun0815@gamil.com>
### [Apple Developer Documentation View Controller Catalog for iOS](https://developer.apple.com/library/content/documentation/WindowsViews/Conceptual/ViewControllerCatalog/Introduction.html)
### 출처: [부스트코스 iOS 강의](http://www.edwith.org/boostcourse-ios/lecture/17991/)
