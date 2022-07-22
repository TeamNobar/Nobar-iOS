//
//  OnboardingViewController.swift
//  Nobar
//
//  Created by 김수연 on 2022/07/22.
//

import UIKit

import Then
import SnapKit

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
    OnboardingContentModel(image: ImageFactory.AppIcon ?? UIImage(), title: "수많은 홈텐딩 레시피를\n한 곳에서 확인할 수 있어요"),
    OnboardingContentModel(image: ImageFactory.AppIcon ?? UIImage(), title: "재료와 베이스로\n쉽게 검색할 수 있어요"),
    OnboardingContentModel(image: ImageFactory.AppIcon ?? UIImage(), title: "테이스팅 노트로\n맛의 잔상을 남겨보세요")
    ]
}
