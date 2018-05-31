# Human Interface Guidelines
H.I.G 문서는 애플리케이션을 개발할 때 필요한 디자인과 동작을 포함한 여러 규칙을 통하여 사용자 인터페이스를 어떻게 구성하는 방법에 대한 지침을 제시한다.


### H.I.G 문서를 읽어야하는 이유
* 애플리케이션을 설계할 때 사용자와 상호작용에 관해 생각하고 설계할 수 있다.
* 개발자가 아닌 사용자의 입장에서 애플리케이션을 바라보고 설계할 수 있다.
* 애플리케이션의 일관성을 유지할 수 있다.
* 기획자, 디자이너 등 협업에 있어 기준점을 제시하여 협업의 효율을 높일 수 있다.
* 이미 사용자에게 익숙한 환경을 제공하여 새로운 애플리케이션 사용의 진입장벽을 낮출 수 있다.
* 이미 검증된 사용자 경험을 이해하고 그것을 토대로 조금 더 유연한 사용자 경험을 설계할 수 있다.


* [Overview](#overview)
* [App Architecture](#app-architecture)
* [User Interaction](#user-interaction)
* [System Capabilities](#system-capabilities)
* [Visual Design](#visual-design)
* [Icons and Images](#icons-and-images)
* [Bar](#bar)
* [Views](#views)
* [Controls](#controls)
* [Extensions](#extensions)
* [Technologies](#technologies)
* [Resources](#resources)


&nbsp;      
## Overview
> iOS 플랫폼 테마의 특징과 인터페이스 요소에 관한 개요 iPhone X와 iOS11의 도입으로 인한 새로운 특징과 변화에 관해 설명한다.
* Themes
    * iOS 플랫폼 테마의 특징과 디자인원칙에 관한 설명
* iPhone X
    * iPhone X의 특징과 디자인 설계시 고려해야 할 사항들에 관한 내용
* What's New in iOS 11
    * iOS11의 변화와 새로운 특징에 관한 설명
* Interface Essentials
    * UIKit에서 제공하는 3가지 인터페이스 요소에 설명


&nbsp;      
## App Architecture
> 애플리케이션 아키텍처 설계 시 고려해야 할 사항들에 관해 설명한다.
* Accessibility
    * 장애가 있는 사용자들에게 접근성을 제공하는 방법과 설계지침
* Loading
    * 로딩화면 설계 시 고려해야 할 사항
* Modality
    * 모달에 관한 설명과 설계 시 고려해야 할 사항
* Navigation
    * 내비게이션의 종류와 설계 시 고려해야 할 사항
* Onboarding
    * 애플리케이션 시작화면 설계 시 고려해야 할 사항
* Requesting Permission
    * 사용자에게 권한요청 시 고려해야 할 사항
* Settings
    * 애플리케이션 내에 환경설정 설계 시 고려해야 할 사항
    
    
&nbsp;  
## User Interaction
> 애플리케이션이 사용자와 상호작용하는 동작 설계 시 고려해야 할 사항들에 관해 설명한다.
* 3D Touch
    * 3D 터치 기능과 동작에 관한 설명과 설계 시 고려해야 할 사항
* Audio
    * 무음, 볼륨, 헤드폰 사용에 관한 사용자의 일반적인 요구 동작에 관한 설명과 좋은 오디오 환경 설계 시 고려해야 할 사항
* Authentication
    * 사용자에게 인증 요청을 하는 애플리케이션 설계 시 고려해야 할 사항과 생체인증 요청적용 시 고려해야 할 사항
* Data Entry
    * 데이터 입력 요구 설계 시 고려해야 할 사항
* Drag and Drop
    * 드래그 앤 드롭의 역할과 설계 시 고려해야 할 사항
* Feedback
    * 피드백 제공 시 주의할 점과 햅틱 피드백 설계 시 고려해야 할 사항
* File Handling
    * 파일처리에 관한 동작이 있는 애플리케이션 설계 시 고려해야 할 사항
* Gestures
    * 제스처 설계 시 고려해야 할 사항과 표준 제스처 동작에 관한 설명
* Near Field Communication
    * NFC 설계 시 사용자에게 제공되는 용어에 관한 지침
* Undo and Redo
    * 실행취소와 재실행 역할 설계 시 고려해야 할 사항
    

&nbsp;      
## System Capabilities
> 시스템이 지원하는 여러 시스템 기능과 각 기능에 대해 설계 시 고려해야 할 사항에 관해 설명한다.
* Multitasking
    * 멀티태스킹 기능에 관한 설명과 멀티태스킹을 지원하는 애플리케이션 설계 시 고려해야 할 사항
* Printing
    * 시스템이 지원하는 프린트 기능에 관한 설명과 사용 시 고려해야 할 사항
* Quick Look
    * 미리보기 제공 시 고려해야 할 사항
* Ratings and Reviews
    * 평점 및 리뷰 제공시간과 사용 시 고려해야 할 사항
* Screenshots
    * 스크린샷 기능에 관한 설명과 시스템의 스크린샷 기능 동작 시 인터페이스 변겨엥 관한 주의사항
* Siri
    * iOS에서 시리가 지원하는 서비스에 관한 설명과 시리와 상호작용하는 애플리케이션 설계 시 고려해야 할 사항
* TV Providers
    * TV 애플리케이션 상태에 따른 애플리케이션 설계 지침 내용, 싱글사인온(SSO)에 관한 설명고 사용에 관한 주의 사항
    
    
&nbsp;
## Visual Design
> 애플리케이션의 시각적인 요소 설계 시 고려해야 할 사항들에 관해 설명한다.
* Adaptivity and Layout
    * iOS 기기별 화면크기와 사이즈 클래스에 관한 설명, 오토레이아웃에 설명 및 레이아웃 설계 시 고려해야 할 사항
* Animation 
    * 애니메이션 효과를 사용했을 시 이점과 설계 시 고려해야 할 사항
* Branding
    * 브랜드 디자인 설계 및 사용에 관한 지침
* Color
    * 사용될 색상 선택에 관한 지침과 색 관리에 관한 지침
* Terminology
    * 애플리케이션에서 사용하는 용어에 관한 지침
* Typography
    * 글꼴 및 스타일에 관한 지침


&nbsp;
## Icons and Images
> iOS에서의 이미지, 아이콘, 시작화면에 관한 내용과 지침에 관한 내용을 설명한다.
* Image Size and Resolution
    * iOS에서 사용하는 이미지 크기와 해상도에 관한 설명과 고해상도 이미지 작업 설계에 관한 지침
* App Icon
    * 애플리케이션 아이콘 디자인에 관한 내용과 사용자가 선택 가능한 애플리케이션 아이콘 제공에 관한 설명
* Custom Icons
    * 사용자 정의 아이콘 디자인에 관한 지침
* Launch Screen
    * 시작화면 디자인에 관한 지침과 기기별 크기에 관한 설명
* System Icons
    * 시스템이 제공하는 세 가지 아이콘 모음에 관한 설명과 시스템 아이콘 사용에 관한 지침


&nbsp;
## Bars
> iOS에서 사용하는 바의 각 역할과 용도에 관한 설명과 각 바를 구현할 때 고려해야 할 사항에 관한 내용이다.
* Navigation Bars
    * 내비게이션바에 관한 설명과 내비게이션바, 내비게이션바 컨트롤 요소 설계 시 고려해야 할 사항
* Search Bars
    * 검색바에 관한 설명과 검색바 제공방법에 관한 지침, 스코프바에 관한 설명
* Tab Bars
    * 탭바에 관한 설명과 탭바 설계 시 고려해야 할 사항
* Toolbars
    * 툴바에 관한 설명과 툴바 설계 시 고려해야 할 사항
    

&nbsp;
## Views
> 뷰의 종류와 역할에 관해 설명하고 뷰 설계 시 고려해야 할 사항에 관한 내용이다.
* Action Sheets
    * 액션시트에 관한 설명과 설계 시 고려해야 할 사항
* Activity Views
    * 액티비티뷰에 관한 설명과 설계 시 고려해야 할 사항
* Alerts
    * 얼럿 구성과 역할에 관한 설명, 얼럿 설계 시 고려해야 할 사항
* Collections
    * 컬렉션뷰에 관한 설명과 설계 시 고려해야 할 사항
* Image Views
    * 이미지뷰에 관한 설명과 animated sequence에서 이미지 사이즈 일관성 유지에 관한 권고 사항
* Maps
    * 맵뷰에 관한 설명과 설계 시 고려해야 할 사항
* Pages
    * 페이지뷰 컨트롤러에 관한 설명과 설계 시 고려해야 할 사항
* Propovers
    * 팝오버에 관한 설명과 설계 시 고려해야 할 사항
* Scroll Views
    * 스크롤뷰에 관한 설명과 설계 시 고려해야 할 사항
* Split Views
    * 스플릿뷰에 관한 설명과 설계 시 고려해야 할 사항
* Tables
    * 테이블뷰에 관한 설명과 iOS에서 구현하는 테이블의 두 가지 스타일, 테이블뷰 설계 시 고려해야 할 사항
* Text Views
    * 텍스트뷰에 관한 설명과 설계 시 고려해야 할 사항
* Web Views
    * 웹뷰에 관한 설명과 설계 시 고려해야 할 사항


&nbsp;  
## Controls
> 여러 가지 컨트롤 요소들에 관한 소개와 설계 시 고려해야 할 사항들에 관한 내용이다.
* Buttons
    * 버튼에 관한 설명과 종류, 설계 시 고려해야 할 사항
* Edit Menus
    * 편집메뉴에 관한 설명과 설계 시 고려해야 할 사항
* Labels
    * 레이블에 관한 설명과 설계 시 고려해야 할 사항
* Page Controls
    * 페이지컨트롤에 관한 설명과 설계 시 고려해야 할 사항
* Pickers
    * 피커에 관한 설명(+ 날짜 피커에 관한 설명), 피커 설계 시 고려해야 할 사항
* Progress Indicators
    * 진행률 표시기에 관한 설명과 종류, 각 진행률 표시기 설계 시 고려해야 할 사항
* Refresh Content Controls
    * 새로고침 컨트롤에 관한 설명과 새로고침 컨트롤을 사용하기 전 고려해야 할 사항에 관한 내용 
* Segmented Controls
    * 세그먼트 컨트롤에 관한 설명과 설계 시 고려해야 할 사항
* Sliders
    * 슬라이더에 관한 설명과 설계 시 고려해야 할 사항
* Steppers
    * 스텝퍼에 관한 설명과 설계 시 고려해야 할 사항
* Switches
    * 스위치에 관한 설명과 설계 시 고려해야 할 사항
* Text Fields
    * 텍스트 필드에 관한 설명과 상황에 맞는 키보드 타입 선택에 관한 내용, 텍스트 필드 설계 시 고려해야 할 사항 


nbsp;  
## Extensions
> 여러 가지 확장기능을 소개하고 확장 기능을 사용하는 애플리케이션 설계 시 고려해야 할 사항들에 관해 설명한다.
* Custom Keyboards
    * 키보드 확장 기능과 사용자 정의 키보드에 관한 설명 및 설계 시 고려해야 할 사항
* Documnet Providers
    * 문서 공급자 확장기능에 관한 설명과 사용 시 고려해야 할 사항
* Home Screen Actions
    * 홈 스크린 퀵 액션 기능에 관한 설명과 설계지침 해당 기능을 사용하는 애플리케이션 설계 시 고려해야 할 사항
* Messaging
    * iMessage 애플리케이션과 스티커팩 확장 기능에 관한 설명과 설계 시 고려해야 할 사항
* Photo Editing
    * 사전 편집 확장기능에 관한 설명과 해당 확장기능 사용 시 고려해야 할 사항
* Sharing and Actions
    * 공유 확장기능과 동작 확장기능에 관한 설명과 설계 시 고려해야 할 사항
* Widgets
    * 위젯에 관한 소개와 설계 시 고려해야 할 사항


& nbsp;
## Technologies
> 여러 기술을 구현할 수 있는 Kit에 관해 설명하고 해당 Kit 사용 시 설계지침에 관한 내용이다.
* Apple Pay
    * 결제방법으로 사용할 수 있는 애플페이에 관한 설명과 설계지침
* Augmented Reality
    * 증강현실 기술을 구현할 수 있는 ARKit에 관한 설명과 설계지침
* GameKit
    * 게임을 만드는데 사용할 수 있는 GameKit에 관한 소개와 설계지침
* HealthKit
    * 건강 및 피트니스 관련된 HealthKit에 관한 설명과 설계지침
* HomeKit
    * HomeKit의 용어 정의와 설계지침
* iCloud
    * iCloud에 관한 소개와 iCloud를 활용한 애플리케이션 작성에 관한 설계지침
* In-App Purchase
    * 인앱 구매에 관한 소개와 애플리케이션이 인앱 구매를 사용 시 설계지침, 인앱과 애플페이의 차이점에 관한 설명
* Live Photos
    * 라이브사진 기능에 관한 설명과 사용 시 설계지침
* ResearchKit
    * Research 애플리케이션과 활용법에 관한 설명 및 설계지침
* Social Media
    * 애플리케이션을 소셜 미디어 서비스와의 통합 시 주의사항 및 설계지침
* Wallet
    * Wallet 애플리케이션에 관한 설명과 PassKit을 활용한 애플리케이션 설계지침


&nbsp;  
## Resources
> iOS를 포함한 애플의 플랫폼들에 대한 자원 제공에 관한 내용


&nbsp;      
&nbsp;      
### [by. 0junChoi](https://github.com/0jun0815) email: <0jun0815@gamil.com>
### [Apple Developer Documentation Human Interface Guidelines](https://developer.apple.com/ios/human-interface-guidelines/overview/themes/)
### 출처: [부스트코스 iOS 강의](http://www.edwith.org/boostcourse-ios/lecture/17991/)
