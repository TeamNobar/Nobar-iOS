//
//  SearchViewController.swift
//  Nobar
//
//  Created by 김수연 on 2022/07/12.
//

import UIKit

import Then
import SnapKit

final class SearchViewController: BaseViewController {

  enum SectionType: Int {
    case recent = 0
    case recommend = 1
  }

  private var sectionType: SectionType?

  private var dummyKeywords: [String] = ["브랜디", "선라이즈피치", "피치크러쉬", "카시스 오렌지", "은비쨩", "칵테일어쩌구", "밀푀유나베", "피치어쩌구", "리큐르", "채원쨩??"]

  private let searchView = UIView().then {
    $0.backgroundColor = .white
  }

  private lazy var backButton = UIButton().then {
    $0.setImage(ImageFactory.btnBackSearch, for: .normal)
    $0.addTarget(self, action: #selector(didClickOnBackButton(_:)), for: .touchUpInside)
  }

  private lazy var searchTextField = SearchTextField().then {
    $0.addTarget(self, action: #selector(judgeHasText(_:)), for: .editingChanged)
  }

  private lazy var underline = UIView().then {
    $0.backgroundColor = Color.gray02.getColor()
    $0.layer.applyShadow(color: .black, alpha: 0.2, x: 1, y: 1, blur: 2, spread: 0)
  }

  private let emptyLabel = UILabel().then {
    $0.text = "최근 검색어가 아직 없어요"
    $0.textColor = Color.gray03.getColor()
    $0.font = Pretendard.size13.regular()
  }

  private lazy var searchKeywordCollectionView: UICollectionView = {
    let layout = createCompositionLayout()
    layout.configuration.interSectionSpacing = 0

    let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
    collectionView.showsHorizontalScrollIndicator = false
    collectionView.showsVerticalScrollIndicator = false
    return collectionView
  }()

  override func viewDidLoad() {
    super.viewDidLoad()
    render()
    configUI()
    setDelegation()
    setRegistration()
  }

  override func viewWillAppear(_ animated: Bool) {
      super.viewWillAppear(animated)
      initTextField()
  }

  override func setupConstraints() {
    super.setupConstraints()
    setLayout()
  }

  override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
      view.endEditing(true)
  }
}

// MARK: - UI & Layout
extension SearchViewController {
  private func render() {
    view.addSubviews([searchView, searchKeywordCollectionView])
    searchView.addSubviews([backButton, searchTextField, underline])
  }

  private func configUI() {
    view.backgroundColor = .white
    navigationController?.navigationBar.isHidden = true
  }

  private func setLayout() {
    searchView.snp.makeConstraints {
      $0.top.equalTo(view.safeAreaLayoutGuide.snp.top)
      $0.leading.trailing.equalToSuperview()
      $0.height.equalTo(62)
    }

    backButton.snp.makeConstraints {
      $0.top.equalToSuperview().inset(2)
      $0.leading.equalToSuperview().inset(10)
      $0.width.height.equalTo(44)
    }

    searchTextField.snp.makeConstraints {
      $0.top.equalToSuperview().inset(6)
      $0.bottom.equalToSuperview().inset(20)
      $0.leading.equalTo(backButton.snp.trailing)
      $0.trailing.equalToSuperview().inset(54)
    }

    underline.snp.makeConstraints {
      $0.top.equalTo(searchTextField.snp.bottom).offset(20)
      $0.leading.trailing.equalToSuperview()
      $0.height.equalTo(0.4)
    }

    searchKeywordCollectionView.snp.makeConstraints {
      $0.top.equalTo(underline.snp.bottom)
      $0.leading.trailing.bottom.equalToSuperview()
    }
  }
}

// MARK: - Private Funtions
extension SearchViewController {
  private func setDelegation() {
    searchKeywordCollectionView.delegate = self
    searchKeywordCollectionView.dataSource = self
  }

  private func setRegistration() {
    searchKeywordCollectionView.register(SearchHeaderView.self, forSupplementaryViewOfKind: SearchHeaderView.className, withReuseIdentifier: SearchHeaderView.className)
    searchKeywordCollectionView.register(cell: RecentCollectionViewCell.self)
    searchKeywordCollectionView.register(cell: RecommendCollectionViewCell.self)
  }

  private func initTextField() {
    searchTextField.text = ""
    searchTextField.rightViewMode = .never
  }
}

// MARK: - Action Functions
extension SearchViewController {
  @objc private func judgeHasText(_ sender: UITextField) {
    if searchTextField.hasText {
      let searchResultViewController = SearchResultViewController()
      searchResultViewController.firstKeyword = self.searchTextField.text
      navigationController?.pushViewController(searchResultViewController, animated: false)
    }
  }

  @objc private func didClickOnBackButton(_ sender: UIButton) {
    self.navigationController?.popViewController(animated: true)
  }
}

// MARK: - CollectionView Compositional Layout functions
extension SearchViewController {
  private func getLayoutRecentSection() -> NSCollectionLayoutSection {
    let estimatedWidth: CGFloat = 50
    let absoluteHeight: CGFloat = 36

    let size = NSCollectionLayoutSize(widthDimension: .estimated(estimatedWidth), heightDimension: .absolute(absoluteHeight))

    let item = NSCollectionLayoutItem(layoutSize: size)
    let group = NSCollectionLayoutGroup.horizontal(layoutSize: size, subitems: [item])

    let section = NSCollectionLayoutSection(group: group)
    section.interGroupSpacing = 8
    section.orthogonalScrollingBehavior = .continuous
    section.contentInsets = NSDirectionalEdgeInsets(top: 0, leading: 26, bottom: 24, trailing: 26)

    let headerSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1), heightDimension: .absolute(50))
    let header = NSCollectionLayoutBoundarySupplementaryItem(layoutSize: headerSize, elementKind: "SearchHeaderView", alignment: .topLeading)
    section.boundarySupplementaryItems = [header]

    return section
  }

  private func getLayoutRecommendSection() -> NSCollectionLayoutSection {
    let itemSize = NSCollectionLayoutSize(widthDimension:
        .fractionalWidth(1), heightDimension: .absolute(50))
    let item = NSCollectionLayoutItem(layoutSize: itemSize)
    item.contentInsets = NSDirectionalEdgeInsets(top: 0, leading: 26, bottom: 0, trailing: 0)

    let groupSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1), heightDimension: .absolute(250))
    let group = NSCollectionLayoutGroup.vertical(layoutSize: groupSize, subitem: item, count: 5)

    let section = NSCollectionLayoutSection(group: group)
    section.orthogonalScrollingBehavior = .continuous

    let headerSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1), heightDimension: .absolute(50))
    let header = NSCollectionLayoutBoundarySupplementaryItem(layoutSize: headerSize, elementKind: "SearchHeaderView", alignment: .topLeading)
    section.boundarySupplementaryItems = [header]

    return section
  }

  private func createCompositionLayout() -> UICollectionViewCompositionalLayout {
    return UICollectionViewCompositionalLayout { (sectionNumber, env) -> NSCollectionLayoutSection? in
      switch sectionNumber {
      case 0: return self.getLayoutRecentSection()
      case 1: return self.getLayoutRecommendSection()
      default: return self.getLayoutRecentSection()
      }
    }
  }
}

// MARK: - CollectionView Delegate functions
extension SearchViewController: UICollectionViewDelegate {

}

extension SearchViewController: UICollectionViewDataSource {
  
  func numberOfSections(in collectionView: UICollectionView) -> Int {
    return 2
  }

  func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
    guard let sectionType = SectionType(rawValue: section) else { return 1 }

    switch sectionType {
    case .recent:
      return dummyKeywords.count
    case .recommend:
      return 5
    }

  }

  func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
    guard let sectionType = SectionType(rawValue: indexPath.section) else {
      return UICollectionViewCell()
    }

    switch sectionType {
    case .recent:
      let cell = searchKeywordCollectionView.dequeueReusableCell(ofType: RecentCollectionViewCell.self, at: indexPath)

      cell.update(data: dummyKeywords[indexPath.row])
      return cell
    case .recommend:
      let cell = searchKeywordCollectionView.dequeueReusableCell(ofType: RecommendCollectionViewCell.self, at: indexPath)

      cell.update(data: SearchModel.dummyRecommendList[indexPath.row])
      return cell
    }
  }

  func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {

    if kind == SearchHeaderView.className {
      let headerView = collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: SearchHeaderView.className, for: indexPath)

      guard let headerView = headerView as? SearchHeaderView else { return UICollectionReusableView() }

      guard let sectionType = SectionType(rawValue: indexPath.section) else {
        return UICollectionViewCell()
      }

      switch sectionType {
      case .recent:
        headerView.configUI(type: .recent)
      case .recommend:
        headerView.configUI(type: .recommend)
      }

      return headerView
    } else {
      return UICollectionReusableView()
    }
  }
}
