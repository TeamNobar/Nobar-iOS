//
//  OnboardingViewController.swift
//  Nobar
//
//  Created by 김수연 on 2022/07/22.
//

import UIKit

import Then
import SnapKit
import AuthenticationServices


final class OnboardingViewController : BaseViewController {
  
  private lazy var onboardingCollectionView: UICollectionView = {
    let layout = createLayout()
    
    let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
    collectionView.showsHorizontalScrollIndicator = false
    collectionView.alwaysBounceVertical = false
    collectionView.register(cell: OnboardingCollectionViewCell.self)
    collectionView.dataSource = self
    
    return collectionView
  }()
  
  private var pageControl = OnboardingPageControl().then {
    $0.pages = 3
    $0.selectedPage = 0
  }
  
  private lazy var appleLoginButton = UIButton().then {
    $0.setImage(ImageFactory.btnSignup, for: .normal)
    $0.addTarget(nil, action: #selector(handleAuthorizationAppleIDButtonAction), for: .touchUpInside)
  }
  
  override func viewDidLoad() {
    super.viewDidLoad()
    render()
    configUI()
  }
  
  override func setupConstraints() {
    super.setupConstraints()
    setLayout()
  }
}

// MARK: - UI & Layout
extension OnboardingViewController {
  private func render() {
    view.addSubviews([onboardingCollectionView, pageControl, appleLoginButton])
  }
  
  private func setLayout() {
    onboardingCollectionView.snp.makeConstraints {
      $0.top.equalToSuperview().inset(143)
      $0.leading.trailing.equalToSuperview()
      $0.height.equalTo(386)
    }
    
    pageControl.snp.makeConstraints {
      $0.top.equalTo(onboardingCollectionView.snp.bottom).offset(36)
      $0.centerX.equalToSuperview()
      $0.width.equalTo(74)
      $0.height.equalTo(10)
    }
    
    appleLoginButton.snp.makeConstraints {
      $0.top.equalTo(pageControl.snp.bottom).offset(77)
      $0.centerX.equalToSuperview()
      $0.width.equalTo(235.adjustedW)
      $0.height.equalTo(45.adjustedH)
    }
  }
  
  private func configUI() {
    view.backgroundColor = Color.white.getColor()
  }
}


extension OnboardingViewController: ASAuthorizationControllerPresentationContextProviding { }
extension OnboardingViewController: ASAuthorizationControllerDelegate {
  func setupAppleLoginButtons() { }
  
  @objc func handleAuthorizationAppleIDButtonAction() {
    let appleIDProvider = ASAuthorizationAppleIDProvider()
    let request = appleIDProvider.createRequest()
    request.requestedScopes = [.fullName, .email]
    let authorizationController = ASAuthorizationController(authorizationRequests: [request])
    authorizationController.delegate = self
    authorizationController.presentationContextProvider = self
    authorizationController.performRequests()
  }
  
  func presentationAnchor(for controller: ASAuthorizationController) -> ASPresentationAnchor {
    return self.view.window!
  }
  
  func authorizationController(
    controller: ASAuthorizationController,
    didCompleteWithAuthorization authorization: ASAuthorization
  ) {
    switch authorization.credential {
    case let appleIDCredential as ASAuthorizationAppleIDCredential:
      let userIdentifier = appleIDCredential.user
      let fullName = appleIDCredential.fullName
      let email = appleIDCredential.email
      let uniqueEmailId = appleIDCredential.authorizedScopes
      let state = appleIDCredential.state
      
      guard
        let authorizationCode = appleIDCredential.authorizationCode,
        let identityToken = appleIDCredential.identityToken,
        let authString = String(data: authorizationCode, encoding: .utf8),
        let tokenString = String(data: identityToken, encoding: .utf8) else {
        return
      }
      print("authorizationCode: \(authorizationCode)")
      print("identityToken: \(identityToken)")
      print("code: \(authString)")
      print("id_token: \(tokenString)")
      print("useridentifier: \(userIdentifier)")
      print("fullName: \(String(describing: fullName))")
      print("email: \(String(describing: email))")
      print("scope: \(uniqueEmailId)")
      
      let viewController = NicknameViewController()
      viewController.modalTransitionStyle = .crossDissolve
      viewController.modalPresentationStyle = .fullScreen
      self.present(viewController, animated: true)
      
    case let passwordCredential as ASPasswordCredential:
      let username = passwordCredential.user
      let password = passwordCredential.password
      
      print("username: \(username)")
      print("password: \(password)")
      
    default:
      break
    }
  }
  
  @available(iOS 13.0, *)
  func authorizationController(controller: ASAuthorizationController, didCompleteWithError error: Error) {
    print("err")
  }
}

extension OnboardingViewController {
  func createLayout() -> UICollectionViewCompositionalLayout {
    let layout = UICollectionViewCompositionalLayout { (sectionNumber, env) -> NSCollectionLayoutSection? in
      
      let itemSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1.0),
                                            heightDimension: .absolute(386))
      let item = NSCollectionLayoutItem(layoutSize: itemSize)
      
      let groupSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1.0),
                                             heightDimension: .absolute(386))
      let group = NSCollectionLayoutGroup.horizontal(layoutSize: groupSize, subitem: item, count: 1)
      
      let section = NSCollectionLayoutSection(group: group)
      section.orthogonalScrollingBehavior = .groupPagingCentered
      
      section.visibleItemsInvalidationHandler = { items, contentOffset, environment in
        let currentPage = Int(max(0, round(contentOffset.x / environment.container.contentSize.width)))
        self.pageControl.selectedPage = currentPage
      }
      
      return section
    }
    return layout
  }
}

extension OnboardingViewController: UICollectionViewDataSource {
  func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
    return 3
  }
  
  func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
    let cell = onboardingCollectionView.dequeueReusableCell(ofType: OnboardingCollectionViewCell.self, at: indexPath)
    
    guard let item = OnboardingContentModel.OnboardingContentList.safeget(index: indexPath.row) else { return cell }
    cell.updateContentModel(item)
    return cell
  }
}

struct OnboardingContentModel {
  let image: UIImage
  let title: String
}

extension OnboardingContentModel {
  static let OnboardingContentList: [OnboardingContentModel] = [
    OnboardingContentModel(image: ImageFactory.imgOnboarding1
                           ?? UIImage(), title: "수많은 홈텐딩 레시피를\n한 곳에서 확인할 수 있어요"),
    OnboardingContentModel(image: ImageFactory.imgOnboarding2 ?? UIImage(), title: "재료와 베이스로\n쉽게 검색할 수 있어요"),
    OnboardingContentModel(image: ImageFactory.imgOnboarding3 ?? UIImage(), title: "테이스팅 노트로\n맛의 잔상을 남겨보세요")
  ]
}
