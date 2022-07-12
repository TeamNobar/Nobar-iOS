![Group 33781 copy](https://user-images.githubusercontent.com/51031771/178424193-9c7bf16d-3597-43cf-b71b-5460181dc795.png)



![Slide 16_9 - 7](https://user-images.githubusercontent.com/51031771/178425536-456f03e2-a84e-432f-8f34-bcb09e3fc670.png)


<details>

<summary> 🍷 🍷 🍷</summary>


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

![Slide 16_9 - 8](https://user-images.githubusercontent.com/51031771/178425596-dffd59f2-3f19-4849-975b-e573149af2f9.png)

<details>

<summary> 🍷 🍷 🍷 </summary>
<div markdown="1">

## 1.1. Rules

### **1.1.1. Git Flow**

기본적으로 Git Flow 전략을 이용한다. 작업 시작 시 선행되어야 할 작업은 다음과 같다.

```
1. Issue를 생성한다.
2. feature Branch를 생성한다.
3. Add - Commit - Push - Pull Request 의 과정을 거친다.
4. Pull Request가 작성되면 작성자 이외의 다른 팀원이 Code Review를 한다.
5. Code Review가 완료되면 Pull Request 작성자가 develop Branch로 merge 한다.
6. 종료된 Issue와 Pull Request의 Label과 Project를 관리한다.
```

### **1.1.2. Etc.**

협업 시 준수해야 할 규칙은 다음과 같다.

```
1. develop에서의 작업은 원칙적으로 금지한다. 단, README 작성은 develop Branch에서 수행한다.
2. 자신이 담당한 부분 이외에 다른 팀원이 담당한 부분을 수정할 때에는 Slack을 통해 변경 사항을 전달한다.
3. 본인의 Pull Request는 본인이 Merge한다.
4. 빠른 협업 속도를 위해 Pull Request가 올라온 이후 24시간 내에 Code Review를 수행한다.
5. Commit, Push, Merge, Pull Request 등 모든 작업은 앱이 정상적으로 실행되는 지 확인 후 수행한다.
6. README 수정을 위한 Commit 도배는 금지한다. 미리보기는 Preview를 통해 확인한다.
```

## **1.2. Branch**

협업 시 준수해야 할 규칙은 다음과 같다.

## 📍Git Branch

### **Branch Naming Rule**

Branch를 생성하기 전 Issue를 먼저 작성한다.

 Issue 작성 후 생성되는 번호와 Issue의 간략한 설명 등을 조합하여 Branch의 이름을 결정한다. `<Prefix>/<Issue_Number>-<Description>` 의 양식을 따른다.

- `main` : 개발이 완료된 산출물이 저장될 공간
- `develop` : feature 브랜치에서 구현된 기능들이 merge될 브랜치
- `feature` : 기능을 개발하는 브랜치, 이슈별/작업별로 브랜치를 생성하여 기능을 개발한다
- `release` : 릴리즈를 준비하는 브랜치, 릴리즈 직전 QA 기간에 사용한다
- `bug` : 버그를 수정하는 브랜치
- `hotfix` : 정말 급하게, 데모데이 직전에 에러가 난 경우 사용하는 브렌치

### **예시**

```
feature/#17-description소문자로만쓰기 
```

## 📍Commit Message

- [HOTFIX] : issue나, QA에서 급한 버그 수정에 사용
- [FIX] : 버그, 오류 해결
- [ADD] : Feat 이외의 부수적인 코드 추가, 라이브러리 추가, 새로운 파일 생성 시
- [FEAT] : 새로운 기능 구현
- [DEL] : 쓸모없는 코드 삭제
- [DOCS] : README나 WIKI 등의 문서 개정
- [MOD] : storyboard 파일,UI 수정한 경우
- [CHORE] : 코드 수정, 내부 파일 수정
- [CORRECT] : 주로 문법의 오류나 타입의 변경, 이름 변경 등에 사용합니다.
- [MOVE] : 프로젝트 내 파일이나 코드의 이동
- [RENAME] : 파일 이름 변경이 있을 때 사용합니다.
- [IMPROVE] : 향상이 있을 때 사용합니다.
- [REFACTOR] : 전면 수정이 있을 때 사용합니다
- [MERGE]: 다른브렌치를 merge 할 때 사용합니다.

**예시**

```
[FEAT] 레이아웃 구현(#17)
```

## 📍PR Merge는 1 approve 받은 후

## 📍 Code Review

<aside>
🐾 ***담당자가 지정되면 “나이거 언제까지 해줄게 “까지는 얘기해주기!***

</aside>

**Reviewee**

- 리뷰를 **합리적, 중립적**으로 받아들여야 함 (무조건 싫어, 좋아는 곤란)
- 반영이 어려우면 왜 어려운지, **합리적인 이유**를 대야 함
- **피드백은 반영 해도 되고 안해도됨 but.책임은 결정한 사람이 진다.**
- 반영하지 않는 것에 대한것은 합당한 이유가 반드시 존재하여야 함.

**Reviewer**

- **온화한 뉘앙스❤️🤍**
- **유효한 리뷰**가 될 수 있도록 염두에 두고 리뷰
    - 유효한 리뷰란?
        1. 날카로운(?) 질문 - 스펙에 대한 확인, 작성자의 의도 확인
        2. 오류 지적
        3. 오타, 부적절한 네이밍
        4. 스펙에 대한 잘못된 이해 (해당 스펙에 대한 Domain Knowledge 필요)
        5. 다른 모듈로의 영향성 지적
        6. 보다 나은 성능, 구조의 대안 제시
        7. 자료 구조, 처리 방식 (동기/비동기 등) 별도의 툴 제안
        8. 두루뭉술한것 보다는 코드 example을 주는 것이 좋음


</aside>




</div>
</details>


<br>
<br>


![Group 33781 2](https://user-images.githubusercontent.com/51031771/178424234-d18dbec6-4de3-481d-81d9-8ce2df7c7339.png)
