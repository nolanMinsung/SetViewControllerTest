# SetViewControllerTest
`UIPageViewController`의 `setViewController` 메서드의 콜백 함수가 불리지 않는 현상

`UIKit`을 사용하던 도중, 예상과는 다르게 동작하는 부분이 있어 기록용으로 남겨두기 위한 테스트 앱.

`UIPageViewController`의 메서드 중에

> `setViewControllers(_:direction:animated:completion:)`

라는 메서드가 있다. 특정 뷰컨트롤러(들)로 이동하게 해 주는 메서드인데,  
사용자가 스크롤하는 경우가 아닌, 개발자가 직접 (programatically) 페이징해야 하는 경우 사용할 수 있다.  
(정확히는 page view controller에 어떤 뷰컨트롤러를 띄울 지 설정할 수 있는 것이며, 이때 새 뷰컨트롤러를 띄우면서 자연스러운 애니메이션이 가능하도록 지원하는 것)

이때 애니메이션 동작 후 `completion` 콜백 함수가 호출되는데, 
### 일부 상황에서는 콜백 함수가 호출되지 않음.
다음 두 조건이 동시에 만족하면 콜백 함수가 호출되지 않는다.

1. `setViewControllers(_:direction:animated:completion:)` 의 첫 번째 인자로 들어간 뷰컨트롤러가 page view controller에 현재 떠 있는 뷰컨트롤러와 같은 객체인 경우
2. `setViewControllers(_:direction:animated:completion:)` 메서드의 `animated` 매개변수에 `true`값을 할당하는 경우

[🔗 공식 문서](https://developer.apple.com/documentation/uikit/uipageviewcontroller/setviewcontrollers(_:direction:animated:completion:)) 에서는 콜백 함수에 대해 다음과 같이 설명하고 있다.

> - completion
> A block to be called when the page-turn animation completes.
> 
> The block takes the following parameters:
> 
> - finished
> true if the animation finished; false if it was skipped.

![](https://velog.velcdn.com/images/mskim98/post/f63877f5-10dd-41b5-8f21-953669ddc038/image.png)

설명에 "page-turn animation이 끝나면 호출된다" 라고 적혀있었으니 엄밀히 말해서는 애니메이션이 적용되지 않는 위의 상황에서는 호출되지 않는 게 당연하다...고 볼 수 있지만,

그렇다기엔 `animated`가 `false`인 경우에는 또 콜백 함수가 잘 호출된다.

https://github.com/user-attachments/assets/6d33d7fe-89f6-44d1-b180-898f163d77f6




