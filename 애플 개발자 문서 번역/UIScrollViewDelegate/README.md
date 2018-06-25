# UIScrollViewDelegate
>  UIScrollViewDelegate 프로토콜에 의해 선언된 메서드는 채택 델리게이트가 UIScrollView 클래스의 메시지에 응답하여 스크롤, 확대, 축소, 스크롤 된 콘텐츠의 감속 및 애니메이션 스크롤과 같은 작업에 응답한다.


* [Topics](#topics)
    * [Responding to Scrolling and Dragging](#responding-to-scrolling-and-dragging)
    * [Managing Zooming](#managing-zooming)
    * [Responding to Scrolling Animations](#responding-to-scrolling-animations)
    * [Responding to Inset Changes](#responding-to-inset-changes)
* [Relationships](#relationships)
* [See Also](#see-also)


&nbsp;      
## Topics
### Responding to Scrolling and Dragging
> 스크롤 및 드래그에 응답

* `func scrollViewDidScroll(UIScrollView)`
    * 사용자가 리시버 내에 콘텐츠 뷰를 스크롤 할 때 델리게이트에게 알린다.
* `func scrollViewWillBeginDragging(UIScrollView)`
    * 스크롤 뷰에서 콘텐츠 스크롤을 시작할 시점을 델리게이트에게 알린다.
* `func scrollViewWillEndDragging(UIScrollView, withVelocity: CGPoint, targetContentOffset: UnsafeMutablePointer<CGPoint>)`
    * 사용자가 콘텐츠 스크롤을 마쳤을 때 델리게이트에게 알린다.
* `func scrollViewDidEndDragging(UIScrollView, willDecelerate: Bool)`
    * 드래그가 스크롤 뷰에서 끝났을 때 델리게이트에게 알린다.
* `func scrollViewShouldScrollToTop(UIScrollView) -> Bool`
    * 스크롤 뷰가 콘텐츠의 맨 위로 스크롤해야 하는 경우 델리게이트에게 요청한다.
* `func scrollViewDidScrollToTop(UIScrollView)`
    * 델리게이트에게 스크롤 뷰가 콘텐츠의 맨 위로 스크롤되었음을 알린다.
* `func scrollViewWillBeginDecelerating(UIScrollView)`
    * 스크롤 뷰가 스크롤 동작을 감속시키기 시작했다고 델리게이트에게 알린다.
* `func scrollViewDidEndDecelerating(UIScrollView)`
    * 스크롤 뷰가 스크롤 동작의 감속을 종료했다는 것을 델리게이트에게 알린다.
    

### Managing Zooming
> 줌잉(확대, 축소) 관리

* `func viewForZooming(in: UIScrollView) -> UIView?`
    * 스크롤 뷰에서 확대, 축소가 발생하려고 할 때 뷰의 크기를 조정하도록 델리게이트에게 요청한다.
* `func scrollViewWillBeginZooming(UIScrollView, with: UIView?)`
    * 델리게이트에게 스크롤 뷰의 콘텐츠 확대가 시작될 예정임을 알린다.
* `func scrollViewDidEndZooming(UIScrollView, with: UIView?, atScale: CGFloat)`
    * 스크롤 뷰의 콘텐츠 확대가 완료되면 델리게이트에게 알린다.
* `func scrollViewDidZoom(UIScrollView)`
    * 델리게이트에게 스크롤 뷰의 확대, 축소 배율이 변경되었음을 알린다.
    

### Responding to Scrolling Animations
> 스크롤 애니메이션에 응답

* `func scrollViewDidEndScrollingAnimation(UIScrollView)`
    * 스크롤 뷰의 스크롤 애니메이션이 끝날 때 델리게이트에게 알린다.
    

### Responding to Inset Changes
> 인셋 변경에 응답

* `func scrollViewDidChangeAdjustedContentInset(UIScrollView)`
    * 스크롤 뷰의 인셋 값이 변경되었을 때 호출된다.


&nbsp;      
## Relationships
### Inherits From
* NSObjectProtocol


### Inherited By
* UICollectionViewDelegate
* UIScrollViewAccessibilityDelegate
* UITableViewDelegate
* UITextViewDelegate


### Adopted By
* UIWebView


&nbsp;      
## See Also
### Responding to Scroll View Interactions
* var delegate: UIScrollViewDelegate?


&nbsp;      
&nbsp;      
### [by. 0junChoi](https://github.com/0jun0815) email: <0jun0815@gmail.com>
### [Apple Developer Documentation UIScrollViewDelegate](https://developer.apple.com/documentation/uikit/uiscrollviewdelegate)
