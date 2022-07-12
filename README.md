![Group 33780@3x](https://user-images.githubusercontent.com/51031771/178420813-8e56eb7d-70c1-4317-86db-a497cb0ceeb9.png)


## 🍹 Code Convention


<details>

<summary> 💬 💬 💬 </summary>


---

### **네이밍**

- 함수 : **lowerCamelCase** 사용하고 동사로 시작
- 변수, 상수 : **lowerCamelCase** 사용
- 클래스 : **UpperCamelCase** 사용

### 파일명(약어사용)

- ViewController → `VC`
- TableViewCell → `TVC`
- CollectionViewCell → `CVC`
- 이 외의 축약형을 사용하지 않습니다.

### **기타규칙**

- `viewDidLoad()`에서는 **함수호출만** 사용합니다.
- 함수는 `extension`에 정의하고 정리합니다.
    
    - `extension`은 목적에 따라 분류합니다.
    
    - 순서는 다음과 같습니다.
        
        ```swift
        final class A {
          private let dldld: String 
          private var sds: Bool { 
        
          }
        }
        
        // MARK: - Initialize
        extension A {
          init() {
        
          }
        
          func viewDidLoad() {
        
          }
        }
        
        // MARK: - Public functions
        extension A {
        
        }
        
        // MARK: - Private functions
        extension A {
        
        }
        
        // MARK: - 어느 함수가 모여있습니다
        extension A {
        
        }
        ```
        

## Guides

---

### ▶️ General Naming

- [API Design Guide](https://www.swift.org/documentation/api-design-guidelines/)에 설명된 Swift 명명 규칙을 사용합니다.
- 모든 네이밍은 그 내용을 충실히 설명해야 합니다. 이름을 짓기 어려운 경우 역할을 더 분리해 보세요.
- Swift Type 이니셜라이징 또는 프로토콜은 UpperCamelCase을 사용합니다.
- 그 외에는 lowerCamelCase를 사용합니다.

### ▶️  델리게이트(Delegates)

델리게이트 메서드를 만들 때 이름이 없는 첫 번째 매개변수는 델리게이트 이름이어야 합니다.

Preferred: 

```swift
func namePickerView(_ namePickerView: NamePickerView, didSelected name: String)
func namePickerView(_ namePcikerView: NamePckerview, didChanged value: String)
```

Not - Preferred:

```swift
func didSelectName(namePicker: NamePickerViewController, name: String)
func namePickerShouldReload() -> Bool
```

### ▶️ **한 줄 최대 길이**

- 한 줄은 최대 120자를 넘지 않도록 합니다.
- Xcode에서 **Preferences -> Text Editing -> Display -> Page guide at column을** 120로 설정해서 사용해주세요.

### ▶️ **final 규칙**

- 더이상 상속이 일어나지 않는 class는 `final`을 명시합니다.

```swift
 final class AnyViewController: BaseViewController {
    ...
 }
```

### ▶️ **접근자 규칙**

- class 내부에서만 쓰이는 변수는 `private`을 명시합니다.
- `fileprivate`는 필요한 경우가 아니면 피하고, `private`을 사용합니다.

```swift
  fianl class ChannelViewController {
    private var count = 0
    ...
  }
```

### ▶️ **들여쓰기 규칙**

- Indent는 2칸으로 지정합니다.
- Xcode에서 **Preferences -> Text Editing -> Display -> Line wrapping** 부분을 2 spaces로 설정해서 사용해주세요.

### ▶️ Extension 사용

한 extension당 하나의 프로토콜 또는 클래스를 채택하고 상속하도록 합니다.

```swift
class MyViewController:UIViewController {
  // class stuff here
}

// MARK: - UITableViewDataSource
extension MyViewController:UITableViewDataSource {
  // table view data source methods
}

// MARK: - UIScrollViewDelegate
extension MyViewController:UIScrollViewDelegate {
  // scroll view delegate methods
}
```

Not preferred:

```swift
class MyViewController: UIViewController, UITableViewDataSource, UIScrollViewDelegate {

```

### ▶️ **Imports를 최소화하기(Minimal Imports)**

필요 없는 import는 제거합니다. Swift Foundation도 작성하지 않아도 된다면 작성하지 않습니다.

### ▶️ 주석

주석을 사용해도 좋습니다, 다만 두가지 조건이 있습니다.

- summary, quick help 등은 사용하지 않습니다.
- 주석에 날짜와 작성자를 적습니다.
    - 작성한 코드가 히스토리가 되어야 한다면,  `// NOTE: -` 주석을 사용합니다.
    - 기한 내에 다시 작성할 코드는 `// TODO: -` 주석을 사용합니다.

로직에 주석이 필요했다면 코드만으로는 설명이 어렵다는 방증입니다. 이런 경우는 로직을 한번 되돌아 보는 것을 추천드려요.

예시는 다음과 같습니다.

![스크린샷 2022-07-07 오전 12.34.15.png](iOS%20Code%20Convention%2041d3a673186640e38c8017db6c3aa8e8/%E1%84%89%E1%85%B3%E1%84%8F%E1%85%B3%E1%84%85%E1%85%B5%E1%86%AB%E1%84%89%E1%85%A3%E1%86%BA_2022-07-07_%E1%84%8B%E1%85%A9%E1%84%8C%E1%85%A5%E1%86%AB_12.34.15.png)

### ▶️ 임포트

- 모듈 임포트는 `알파벳 순`으로 정렬합니다.
- 내장 프레임워크를 먼저 임포트하고, 빈 줄로 구분하여 서드파티 프레임워크를 임포트합니다.
    
    ```swift
    import UIKit
    
    import SwiftyColor
    import SwiftyImage
    import Then
    import URLNavigator
    ```
    

### ▶️  액션 함수 네이밍

- Action 함수의 네이밍은 '주어 + 동사 + 목적어' 형태를 사용합니다.
    - Tap(눌렀다 뗌)*은  `.touchUpInside`에 대응하고,
    - *Press(누름)*는  `.touchDown`에 대응합니다.
    - *will~*은 특정 행위가 일어나기 직전이고, *did~*는 특정 행위가 일어난 직후입니다.
    - *should~*는 일반적으로 `Bool`을 반환하는 함수에 사용됩니다.
    
    ```swift
    func didClickOnBackbutton() {
      // ...
    }
    ```
    

### ▶️ Bool 변수 네이밍

- ~인지 아닌지인 경우 `is` ex) `isFirstResponder`  `isMuted` - is + 명사, is + 형용사
- ~해야만 하는 경우 `should` ex) `shouldHideOffline` `shouldShowDivider`  - 조동사 + 동사 원형
- ~할수 있는지의 경우 `can` ex) `canBecomeFirstResponder`

### ▶️ 상수 선언

- 상수를 정의할 때에는 `enum`를 만들어 비슷한 상수끼리 모아둡니다.
    
    재사용성과 유지보수 측면에서 큰 향상을 가져옵니다. 
    
    `struct` 대신 `enum`을 사용하는 이유는, 생성자가 제공되지 않는 자료형을 사용하기 위해서입니다.
    
- [CGFloatLiteral](https://github.com/devxoul/CGFloatLiteral)을 사용해서 코드를 단순화시킵니다.
    
    ```swift
    final class ProfileViewController: UIViewController {
      private enum Metric {
        static let profileImageViewLeft = 10.f
        static let profileImageViewRight = 10.f
        static let nameLabelTopBottom = 8.f
        static let bioLabelTop = 6.f
      }
    
      private enum Font {
        static let nameLabel = UIFont.boldSystemFont(ofSize: 14)
        static let bioLabel = UIFont.boldSystemFont(ofSize: 12)
      }
    }
    ```
    

### ▶️ s**elf 사용 피하기**

Swift는 객체의 프로퍼티에 접근하거나 메서드 호출할 필요가 없는 경우에 **self를 사용하지 않아도 됩니다.**

**컴파일러에 의해 요구될 때에만 self를 사용합니다.**(@escaping 클로저나 초기화에서 인자가 프로퍼티와 애매모호할 때).

### ▶️ 계산 프로퍼티(Computed Properties)

간결함을 위해 읽기 전용인 경우 get을 생략합니다.

### ▶️ **메서드 선언(Function Declarations)**

하나의 파라미터

```swift
func reticulateSplines(with spline: [Double]) -> Bool {
  // reticulate code goes here
}
```

하나 이상의 파라미터를 가진 메서드

```swift
func reticulateSplines(
  with spline: [Double],
  adjustmentFactor: Double,
  translateConstant: Int, 
  comment: String
) -> Bool {
  // reticulate code goes here
}
```

### ▶️  **메서드 호출(Function Call)**

파라미터가 한 개일 때:

```swift
let success = reticulateSplines(with: splines)
```

```swift
let success = reticulateSplines(
  spline: splines,
  adjustmentFactor: 1.3,
  translateConstant: 2,
  comment: "normalize the display"
)
```

파라미터가 여러개인 경우

### ▶️ 빈 배열과 빈 딕셔너리

빈 배열과 빈 딕셔너리의 경우 Type Annotation을 사용합니다.

Preferred: 

```swift
var names: [String] = []
var lookup: [String: Int] = [:]
```

Not Preferred: 

```swift
var names = [String]()
var lookup = [String: Int]()
```

### ▶️ **메모리 관리(Memory Management)**

weak를 사용하여 순환 참조를 방지합니다. 

### ▶️ **삼항 연산자(Ternary Operator)**

삼항 연산자**(? : )**는 명확성 또는 코드의 깔끔성을 높일 때 사용합니다.

하나의 조건을 계산하는 것에 보통 사용되고,

복수의 조건을 계산하는 것은 일반적으로 if 문으로 이해하거나 인스턴스 변수로 리팩터링 합니다.

### ▶️ **괄호(Parentheses)**

조건문 주변의 괄호는 필요하지 않으므로 생략합니다.

Preferred:

```swift
if name == "Hello" {
  print("World")
}
```

Not preferred:

```swift
if (name == "Hello") {
  print("World")
}
```

</div>
</details>

<br>
<br>

## 🌼🌼🌼 Git Convention

🔥 [참고자료](https://github.com/TeamMyDaily/4most-Android/wiki/1.-Git-사용법)

🔥 [감자들의 깃 컨벤션이 자세하게 보고 싶다면?](https://huree-can-do-it.notion.site/code-convention-5d1c99ce79754b2eb9d82a75f14ff507)

<details>

<summary> 💬 💬 💬 </summary>
<div markdown="1">

### Git Flow

```
1. Issue를 생성한다.
2. feature Branch를 생성한다.
3. Add - Commit - Push - Pull Request 의 과정을 거친다.
4. Pull Request가 작성되면 작성자 이외의 다른 팀원이 Code Review를 한다.
5. Code Review가 완료되면 Pull Request 작성자가 develop Branch로 merge 한다.
6. 종료된 Issue와 Pull Request의 Label과 Project를 관리한다.
```

### Commit Message Convention


    - FEAT : 새로운 기능 구현
    - ADD : Feat 이외의 부수적인 코드 추가, 라이브러리 추가, 새로운 View나 Activity 생성
    - CHORE : 그 이외의 잡일/ 버전 코드 수정, 패키지 구조 변경, 파일 이동, 가독성이나 변수명, reformat 등
    - FIX : 버그, 오류 해결
    - DEL : 쓸모없는 코드 및 파일 삭제
    - MOD : xml (스토리보드) 파일만 수정한 경우
    - DOCS : README나 WIKI 등의 문서 개정
    - REFACTOR : 내부 로직은 변경 하지 않고 기존의 코드를 개선하는 리팩토링 시


<details>
<summary>`Prefix` 가 헷갈릴 때 참고해주세요!</summary>
<div markdown="2">

```swift
[ADD] 홈 테이블뷰 높이 관련 코드 추가(#1)
[FEAT] 홈 기능 구현**(#2)
[CHORE] 홈 셀 레이아웃 코드 수정(#2)
[MOVE] 홈 폴더 파일 이동(#2)
[FIX] 홈 셀 리로드 버그 해결(#3)
[DEL] 필요없는 주석 삭제(#2)
```
</div>
</details>


### Branch Naming

`<prefix 소문자로>/<이슈번호>-<관련설명>`

*→ 대소문자 꼭 지켜주세요!*

```swift
feature/2-HomeLayout
feature/10-HomeService
```

### Issue

- Template 사용
- 라벨 달기
- 프로젝트 칸반보드 체크 필수

### Pull Request

- Template 사용 (내용 꼼꼼하게 작성)
- Code Review 24시간 내로

### Merge

- Approved 걸고 코리 받으면 자기자신이 Click

</aside>




</div>
</details>


<br>
<br>

## 🌼🌼🌼🌼 Foldering

<details>

<summary> 💬 💬 💬 </summary>
<div markdown="1">

<br>

```
   🗂 Tabling-iOS
           │
           │
           |── 📂 Global
           │        │
           │        |── 📁 Base
           │        |── 📁 Constant
           │        |── 📁 Extension
           │        └── 📁 Protocol
           │
           │── 📂 Source
           │        |── 📁 Model
           │        |── 📁 Network
           │        └── 📁 Screen
           │                  │
           │                  |── TabbarController
           │                  |── 📁 Yujin
           │                  |        |── 📁 VC   
           │                  |        |── 📁 Cell
           │                  |        └── 📁 Component
           │                  |── 📁 Namjoon
           │                  |        |── 📁 VC
           │                  |        |── 📁 Cell
           │                  |        └── 📁 Component 
           │                  |── 📁 Ruhee
           │                  |        |── 📁 VC 
           │                  |        |── 📁 Cell 
           │                  |        └── 📁 Component
           │                  |
           │                  └── 📁 MyPage
           │
           └── 📂 Resource
                     |
                     |── 📁 Support
                     |        |── AppDelegate.swift     
                     |        └── SceneDelegate.swift
                     |
                     |── 📁 Storyboard
                     |        |── LaunchScreen.storyboard    
                     |        |── Main.storyboard    
                     |        |── NamjoonMain.storyboard    
                     |        └── YujinMain.storyboard
                     |
                     |── Assets.xcassets
                     └── Info.plist
        
```

</div>
</details>
