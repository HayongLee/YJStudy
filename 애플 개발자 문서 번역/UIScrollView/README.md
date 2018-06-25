# UIScrollView
>  포함 된 뷰를 스크롤 및 확대, 축소 할 수 있는 뷰이다.


* [Overview](#overview)
* [State Preservation](#state-preservation)
* [Topics](#topics)
    * [Responding to Scroll View Interactions](#responding-to-scroll-view-interactions)
    * [Managing the Content Size and Offset](#managing-the-content-size-and-offset)
    * [Managing the Content Inset Behavior](#managing-the-content-inset-behavior)
    * [Getting the Layout Guides](#getting-the-layout-guides)
    * [Configuring the Scroll View](#configuring-the-scroll-view)
    * [Getting the Scrolling State](#getting-the-scrolling-state)
    * [Managing the Scroll Indicator and Refresh Control](#managing-the-scroll-indicator-and-refresh-control)
    * [Scrolling to a Specific Location](#scrolling-to-a-specific-location)
    * [Managing Touches](#managing-touches)
    * [Zooming and Panning](#zooming-and-panning)
    * [Managing the Keyboard](#managing-the-keyboard)
    * [Managing the Index](#managing-the-index)
* [Relationships](#relationships)
* [See Also](#see-also)


&nbsp;    
## Overview
UIScrollView는 UITableView 및 UITextView를 비롯한 여러 UIKit 클래스의 수퍼 클래스이다.


UIScrollView 객체 (또는 간단히 스크롤 뷰)의 중심 개념은 콘텐츠 뷰 보다 원점이 조정 가능한 뷰라는 점이다. 콘텐츠를 프레임에 클립한다. 프레임의 콘텐츠는 일반적으로 애플리케이션의 메인 윈도우와 일치한다(반드시 그렇지는 않음). 스크롤 뷰는 손가락의 움직임을 추적하고 그에 따라 원점을 조정한다. 스크롤 뷰를 통해 콘텐츠를 보여주고 있는 뷰는 콘텐츠 뷰의 오프셋에 고정되어있는 새로운 원점을 기반으로 그 부분을 드로잉한다. 스크롤 뷰 자체는 수직 및 수평 스크롤 인디케이터를 표시하는 것을 제외하고는 드로잉을 수행하지 않는다. 스크롤 뷰는 스크롤을 멈출 때를 알 수 있도록 콘텐츠 뷰의 크기를 알아야 한다. 기본적으로 스크롤이 콘텐츠 범위를 초과하면 "튀어 오른다(bounce 효과)".


스크롤 뷰에서 표시된 콘텐츠의 드로잉을 관리하는 객체는 뷰가 화면의 크기를 초과하지 않도록 콘텐츠의 서브 뷰를 타일식으로 배열해야 한다. 스크롤 뷰에서 스크롤 할 때 이 객체는 필요에 따라 서브 뷰를 추가하고 제거해야 한다.


스크롤 뷰에는 스크롤 바가 없기 때문에 터치에서 스크롤 할 의도와 콘텐츠의 서브 뷰를 추적할 의도가 있는지 여부를 알 수 있어야 한다. 이 결정을 내리기 위해 타이머를 시작하여 터치 다운 이벤트를 일시적으로 가로채고 타이머가 작동하기 전에 접촉하는 손가락이 움직이는지 확인한다. 위치가 크게 변경되지 않고 타이머가 발생하면 스크롤 뷰는 추적 이벤트를 콘텐츠 뷰의 수정된 서브 뷰로 보낸다. 그런 다음 사용자가 타이머가 경과하기 전에 손가락을 충분히 드래그하면 스크롤 뷰는 서브 뷰에서 추적을 취소하고 스크롤을 수행한다. 서브 클래스는 스크롤 뷰에서 스크롤 제스처를 처리하는 방법에 영향을 주도록 [touchesShouldBegin(_:with:in:)](https://developer.apple.com/documentation/uikit/uiscrollview/1619418-touchesshouldbegin), [isPagingEnabled](https://developer.apple.com/documentation/uikit/uiscrollview/1619432-ispagingenabled) 및 [touchesShouldCancel(in:)](https://developer.apple.com/documentation/uikit/uiscrollview/1619387-touchesshouldcancel) 메서드(스크롤 뷰에서 호출함)을 재정의할 수 있다. 


또한 스크롤 뷰는 콘텐츠의 확대, 축소 및 패닝을 처리한다. 사용자가 핀치 인 또는 핀치 아웃 제스처를 하면 스크롤 뷰는 콘텐츠의 오프셋 및 크기를 조정한다. 제스처가 끝나면 콘텐츠 뷰를 관리하는 객체는 필요에 따라 콘텐츠의 서브 뷰를 업데이트해야 한다. 제스처가 끝나고 손가락이 여전히 아래쪽에 있을 수 있다. 제스처가 진행되는 동안 스크롤 뷰는 서브 뷰에 추적 호출을 보내지 않는다.


UIScrollView 클래스에는 [UIScrollViewDelegate](https://developer.apple.com/documentation/uikit/uiscrollviewdelegate) 프로토콜을 채택해야하는 델리게이트가 있을 수 있다. 확대, 축소 및 이동이 작동하려면 델리게이트가 [viewForZooming(in:)](https://developer.apple.com/documentation/uikit/uiscrollviewdelegate/1619426-viewforzooming) 및 [scrollViewDidEndZooming(_:with:atScale:)](https://developer.apple.com/documentation/uikit/uiscrollviewdelegate/1619407-scrollviewdidendzooming)을 구현해야 한다. 또한 최대([maximumZoomScale](https://developer.apple.com/documentation/uikit/uiscrollview/1619408-maximumzoomscale)) 및 최소([minimumZoomScale](https://developer.apple.com/documentation/uikit/uiscrollview/1619428-minimumzoomscale)) 줌 배율이 달라야 한다.


&nbsp;
## State Preservation
이 뷰의 [restorationIdentifier](https://developer.apple.com/documentation/uikit/uiviewcontroller/1621499-restorationidentifier) 프로퍼티에 값을 할당하면 앱 시작 사이에 스크롤 관련 정보가 보존된다. 특히 [zoomScale](https://developer.apple.com/documentation/uikit/uiscrollview/1619419-zoomscale), [contentInset](https://developer.apple.com/documentation/uikit/uiscrollview/1619406-contentinset) 및 [contentOffset](https://developer.apple.com/documentation/uikit/uiscrollview/1619404-contentoffset) 프로퍼티 값은 유지된다. 복원 중 스크롤 뷰는 콘텐츠가 이전과 같은 위치로 스크롤되도록 이 값을 복원한다. 상태 보존 및 복원의 작동 방식에 대한 자세한 내용은 [App Programming Guide for iOS](https://developer.apple.com/library/archive/documentation/iPhone/Conceptual/iPhoneOSProgrammingGuide/Introduction/Introduction.html#//apple_ref/doc/uid/TP40007072) 참조.


&nbsp;      
## Topics
### Responding to Scroll View Interactions
> 스크롤 뷰 상호 작용에 응답

* `var delegate: UIScrollViewDelegate?`
    * 스크롤 뷰 객체의 델리게이트이다.
* `protocol UIScrollViewDelegate`
    * UIScrollViewDelegate 프로토콜에 의해 선언된 메서드는 채택 델리게이트가 UIScrollView 클래스의 메시지에 응답하여 스크롤, 확대, 축소, 스크롤 된 콘텐츠의 감속 및 애니메이션 스크롤과 같은 작업에 응답한다.


### Managing the Content Size and Offset
> 콘텐츠 크기 및 오프셋 관리

* `var contentSize: CGSize`
    * 콘텐츠 뷰의 사이즈.
* `var contentOffset: CGPoint`
    * 콘텐츠 뷰의 원점이 스크롤 뷰의 원점에서 오프셋 된 지점이다.
* `func setContentOffset(CGPoint, animated: Bool)` 
    * 콘텐츠 뷰의 원점으로부터 리시버의 원점에 대응하는 오프셋을 설정한다.
    

### Managing the Content Inset Behavior
> 콘텐츠 인셋 동작 관리

* `var adjustedContentInset: UIEdgeInsets`
    * 콘텐츠 인셋 및 스크롤 뷰의 안전 영역에서 파생된 인셋이다.
* `var contentInset: UIEdgeInsets`
    * 콘텐츠 뷰가 안전 영역 또는 스크롤 뷰 가장자리에서 인셋되는 커스텀 거리이다.
* `var contentInsetAdjustmentBehavior: UIScrollView.ContentInsetAdjustmentBehavior`
    * 조정된 콘텐츠 오프셋을 결정하기 위한 동작이다.
* `enum UIScrollView.ContentInsetAdjustmentBehavior`
    * 조정된 콘텐츠 인셋에 안전한 영역 인셋이 추가되는 방법을 나타내는 상수.
* `func adjustedContentInsetDidChange()`
    * 스크롤 뷰의 조정된 콘텐츠 인셋이 변경되면 호출된다.


### Getting the Layout Guides
> 레이아웃 가이드 가져 오기

* `var frameLayoutGuide: UILayoutGuide`
    * 스크롤 뷰의 변환되어 있지 않은 프레임 구형을 기본으로 한 레이아웃 가이드이다.
* `var contentLayoutGuide: UILayoutGuide`
    * 스크롤 뷰의 변환되어 있지 않은 콘텐츠 구형을 기본으로 한 레이아웃 가이드이다.


### Configuring the Scroll View
> 스크롤 뷰 구성

* `var isScrollEnabled: Bool`
    * 스크롤이 사용 가능한지 여부를 결정하는 부울 값.
* `var isDirectionalLockEnabled: Bool`
    * 스크롤이 특정 방향으로 비활성화되는지 여부를 결정하는 부울 값. 
* `var isPagingEnabled: Bool`
    * 스크롤 뷰에서 페이징을 사용할 수 있는지 여부를 결정하는 부울 값.
* `var scrollsToTop: Bool`
    * 스크롤 할 수 있는 제스처를 사용할지 여부를 제어하는 부울 값.
* `var bounces: Bool`
    * 스크롤 뷰가 콘텐츠의 가장자리를 통과하여 다시 튀어 나올지 여부를 제어하는 부울 값.
* `var alwaysBounceVertical: Bool`
    * 수직 스크롤이 콘텐츠의 끝에 도달할 때 튀어 오르기가 항상 발생하는지 여부를 결정하는 부울 값.
* `var alwaysBounceHorizontal: Bool`
    * 수평 스크롤이 콘텐츠 뷰의 끝에 도달할 때 튀어 오르기가 항상 발생하는지 여부를 결정하는 부울 값.


### Getting the Scrolling State
> 스크롤링 상태 가져 오기

* `var isTracking: Bool`
    * 사용자가 스크롤을 시작하기 위해 콘텐츠를 터치한 여부를 반환한다.
* `var isDragging: Bool`
    * 사용자가 콘텐츠를 스크롤하기 시작했는지 여부를 나타내는 부울 값.
* `var isDecelerating: Bool`
    * 사용자가 손가락을 떼었을 때 콘텐츠가 스크롤 뷰에서 움직이고 있는지 여부를 반환한다.
* `var decelerationRate: UIScrollView.DecelerationRate`
    * 사용자가 손가락을 뗀 후의 감속도를 결정하는 부동 소수점 값.
* `struct UIScrollView.DecelerationRate`
    * 스크롤 뷰의 감속도. **베타**


### Managing the Scroll Indicator and Refresh Control
> 스크롤 인디케이터 및 새로고침 제어 관리

* `var indicatorStyle: UIScrollView.IndicatorStyle`
    * 스크롤 인디케이터 스타일
* `enum UIScrollView.IndicatorStyle`
    * 스크롤 인디케이터의 스타일이다. 이러한 상수를 사용하여 indicatorStyle 스타일의 값을 설정한다.
* `var scrollIndicatorInsets: UIEdgeInsets`
    * 스크롤 인디케이터가 스크롤 뷰 가장자리에서 인셋되는 거리이다.
* `var showsHorizontalScrollIndicator: Bool`
    * 수평 스크롤 인디케이터가 표시되는지 여부를 제어하는 부울 값이다.
* `var showsVerticalScrollIndicator: Bool`
    * 수직 스크롤 인디케이터가 표시되는지 여부를 제어하는 부울 값이다.
* `func flashScrollIndicators()`
    * 스크롤 인디케이터를 잠시 표시한다.
* `var refreshControl: UIRefreshControl?`
    * 스크롤 뷰와 연관된 새로 고침 컨트롤이다.
    

### Scrolling to a Specific Location
> 특정 위치 스크롤링

* `func scrollRectToVisible(CGRect, animated: Bool)`
    * 콘텐츠의 특정 영역을 스크롤하여 리시버에 표시되도록 한다.
    

### Managing Touches
> 터치 관리

* `func touchesShouldBegin(Set<UITouch>, with: UIEvent?, in: UIView) -> Bool`
    * 표시된 콘텐츠에서 손가락이 닿으면 기본 동작을 커스텀하기 위해 서브 클래스로 재정의된다.
* `func touchesShouldCancel(in: UIView) -> Bool`
    * 콘텐츠 서브 뷰와 관련된 터치를 취소하고 드래그를 시작할지 여부를 반환한다.
* `var canCancelContentTouches: Bool`
    * 콘텐츠 뷰의 터치가 항상 추적되는지 여부를 제어하는 부울 값.
* `var delaysContentTouches: Bool`
    * 스크롤 뷰가 터치 다운 제스처 처리를 지연하는지 여부를 결정하는 부울 값.
* `var directionalPressGestureRecognizer: UIGestureRecognizer`
    * 방향 버튼 누름에 대한 기본 제스처 인식기이다.
    

### Zooming and Panning
> 줌잉(확대, 축소) 및 패닝

* `var panGestureRecognizer: UIPanGestureRecognizer`
    * 팬 제스처를 위한 기본 제스처 인식기.
* `var pinchGestureRecognizer: UIPinchGestureRecognizer?`
    * 핀치 제스처를 위한 기본 제스처 인식기.
* `func zoom(to: CGRect, animated: Bool)`
    * 리시버에서 볼 수 있도록 콘텐츠의 특정 영역을 확대한다.
* `var zoomScale: CGFloat`
    * 스크롤 뷰의 콘텐츠에 적용되는 현재 배율 인수를 지정하는 부동 소수점 값.
* `func setZoomScale(CGFloat, animated: Bool)`
    * 현재 줌 배율을 지정하는 부동 소수점 값.
* `var maximumZoomScale: CGFloat`
    * 스크롤 뷰의 콘텐츠에 적용할 수 있는 최대 배율 인수를 지정하는 부동 소수점 값.
* `var minimumZoomScale: CGFloat`
    * 스크롤 뷰의 콘텐츠에 적용할 수 있는 최소 배율 인수를 지정하는 부동 소수점 값.
* `var isZoomBouncing: Bool`
    * 확대, 축소가 리시버에 지정된 배율 제한을 초과했음을 나타내는 부울 값.
* `var isZooming: Bool`
    * 콘텐츠 뷰가 현재 확대 또는 축소되어 있는지 여부를 나타내는 부울 값.
* `var bouncesZoom: Bool`
    * 크기 조정이 최대 또는 최소 제한을 초과할 때 스크롤 뷰에서 콘텐츠 크기 조정을 애니메이션으로 표시할지 여부를 결정하는 부울 값.
    

### Managing the Keyboard
> 키보드 관리

* `var keyboardDismissMode: UIScrollView.KeyboardDismissMode`
    * 스크롤 뷰에서 드래그가 시작될 때 키보드가 해제되는 방식.
* `enum UIScrollView.KeyboardDismissMode`
    * 스크롤 뷰에서 드래그가 시작될 때 키보드가 해제되는 방식. 
    

### Managing the Index
> 인덱스 관리

* `var indexDisplayMode: UIScrollView.IndexDisplayMode`
    * 사용자가 스크롤하는 동안 인덱스가 표시되는 방식.
* `enum UIScrollView.IndexDisplayMode`
    * 사용자가 스크롤하는 동안 인덱스가 표시되는 방식.


&nbsp;      
## Relationships
### Inherits From
* UIView


### Conforms To
* CVarArg
* Equatable
* Hashable
* NSCoding
* UIAccessibilityIdentification
* UIFocusItemScrollableContainer
* UIPasteConfigurationSupporting
* UIUserActivityRestoring


&nbsp;      
## See Also
### Container Views
* [Collection Views](https://developer.apple.com/documentation/uikit/views_and_controls/collection_views)
* [Table Views](https://developer.apple.com/documentation/uikit/views_and_controls/table_views)
* class UIStackView


&nbsp;      
&nbsp;      
### [by. 0junChoi](https://github.com/0jun0815) email: <0jun0815@gmail.com>
### [Apple Developer Documentation UIScrollView](https://developer.apple.com/documentation/uikit/uiscrollview)
