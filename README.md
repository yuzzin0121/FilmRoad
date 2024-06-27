# FilmRoad

> FilmRoad는 요즘 인기있는 TV 프로그램 탐색, 검색, 저장할 수 있는 **TV 프로그램 탐색 앱**입니다.
<img src=https://github.com/yuzzin0121/FilmRoad/assets/77273340/62aef7e4-be3a-4afb-a571-d54e4bcd1307 width=650 height=350>
<br>


## 프로젝트 개발 및 환경
- iOS 1인 개발
- 개발 기간: 1주 (2024.06.17 ~ 2024.06.25)
- 환경: 최소 버전 16.0 / 세로 모드 / 아이폰용
<br>


## 핵심 기능 
- **TV 프로그램 탐색 |** 이번주 유행하는 TV 프로그램 / 가장 인기 있는 TV 프로그램 / 요즘 대세 TV 프로그램 탐색
- **TV 북마크 |** 등록 / 취소 / 조회
- **TV 상세 화면 |** 설명, 시즌, 에피소드, 캐스트 정보, 비슷한 콘텐츠, 티저 재생
- **TV 프로그램 티저 재생 화면**
- **TV 검색**
- **프로필 |** 조회 / 수정
<br><br>

## 스크린샷

### 😃 프로필
|프로필 조회|프로필 수정|
|------|---|
|<img src=https://github.com/yuzzin0121/FilmRoad/assets/77273340/89bc3970-32e9-4961-a236-313b6597f0e4 width=150 height=330>|<img src=https://github.com/yuzzin0121/FilmRoad/assets/77273340/785849ad-8c54-4d63-9b4a-d261e661db61 width=150 height=330>|


### 🔍 TV 프로그램 탐색 • 검색 • 상세 화면
|TV 프로그램 탐색|TV 프로그램 검색|상세 화면|에피소드 리스트|티저 재생|북마크 등록 • 취소|북마크 조회|
|-----|---|---|---|---|---|---|
|<img src=https://github.com/yuzzin0121/FilmRoad/assets/77273340/3fce8338-6f90-4e96-ad9b-10a8a340db89 width=150 height=330>|<img src=https://github.com/yuzzin0121/FilmRoad/assets/77273340/35740b9e-34c7-40db-8c93-9e367e437a1f width=150 height=330>|<img src=https://github.com/yuzzin0121/FilmRoad/assets/77273340/167070cf-3ef9-4210-8c5b-7d1a509a1a2f width=150 height=330>|<img src=https://github.com/yuzzin0121/FilmRoad/assets/77273340/623329d4-d120-4181-9f7c-dc1f3c124b39 width=150 height=330>|<img src=https://github.com/yuzzin0121/FilmRoad/assets/77273340/805c7aa4-edcd-4676-977b-693edf311abe width=150 height=330>|<img src=https://github.com/yuzzin0121/FilmRoad/assets/77273340/f440eab6-64e9-4483-933f-542dd9094b52 width=150 height=330>|<img src=https://github.com/yuzzin0121/FilmRoad/assets/77273340/a6776512-453f-4acc-ab58-48415808d0e9 width=150 height=330>|

<br>

## 주요 기술
**Platform** - SwiftUI / UIKit <br>
**Pattern** - Router / MVVM / Input-Output / DI / Repository <br>
**Network** - URLSession / Alamofire <br>
**Database** - Realm <br>
**Reactive** **Programming** - Combine <br> 
**Etc** - Concurrency / WKWebView <br>
<br><br>

## 핵심 구현
**MVVM / Input-Output**
- MVVM 디자인 패턴을 적용함으로써 뷰와 비즈니스 로직을 명확하게 분리
- Input-Output 패턴을 통해 로직에 사용될 입력값과 뷰에 사용될 출력값을 분리

**Alamofire**
- Router 패턴과 TargetType 프로토콜을 통해 네트워크 통신 API를 구조화 및 확장

**URLSession**
- URLSession을 통해 네트워크 통신을 함으로써 최적의 성능과 안정성 제공

**Concurrency**
- async와 await 키워드를 통해 코드 가독성 향상 및 스레드 생성량과 컨텍스트 스위칭 감소

**Etc**
- ViewModifier를 활용해 View들에 대한 CustomWrapper 구현
- @ViewBuilder를 사용하여 NavigationBarWrapper 구현
- @ViewBuilder를 통해 NavigationLazyView를 구현함으로써 하위뷰가 그려질 때 init되는 이슈 해결
- final 키워드와 접근제어자를 통해 컴파일 속도 최적화

<br><br>

## 트러블 슈팅
### 1. **하위 뷰가 화면에 보이기 전에 init되는 이슈**
- 클로저를 통해 뷰가 init되도록 NavigationLazyView를 구현
```
struct NavigationLazyView<T: View>: View {
    let build: () -> T
    
    init(_  build: @autoclosure @escaping () -> T) {
        self.build = build이 
    }
    var body: some View {
        build()
    }
}
```
<br>

|NavigationLazyView 적용 전|NavigationLazyView 적용 후|
|------|---|
|<Image src="https://github.com/yuzzin0121/FilmRoad/assets/77273340/e9ae4cee-447a-47eb-a54a-b37ecca9a0b2" width=380 height=350></Image>|<img src=https://github.com/yuzzin0121/FilmRoad/assets/77273340/9c0f2b48-5523-4a81-a0ce-c03945e7999d width=650 height=45>|



<br><br>

### 2. **View에서 액션에 따라 처리하는 비즈니스 로직이 노출되는 문제(ex: onAppear, button Tap)**
- ViewModel에서 Action이라는 enum을 통해 액션 전용 타입을 구현 후 action 메서드에서 케이스에 따라 비즈니스 로직을 실행하도록 한다.
- View에서는 viewModel의 사용자 액션과 일치하는 케이스에 대해 action 메서드만 호출 -> viewModel의 비즈니스 로직을 숨길 수 있다.
  <br><br>
### ViewModel
<Image src="https://github.com/yuzzin0121/FilmRoad/assets/77273340/e0326e0c-d40e-4fb2-99b7-8cbc6697535f" width=430 height=400></Image>

### View
<Image src="https://github.com/yuzzin0121/FilmRoad/assets/77273340/f8ec88c9-eef3-4cbd-bc23-5f669e0a7f62" width=260 height=50></Image><br>
<Image src="https://github.com/yuzzin0121/FilmRoad/assets/77273340/c07f4bf2-954d-4372-8827-f90350ba9182" width=430 height=100></Image>
