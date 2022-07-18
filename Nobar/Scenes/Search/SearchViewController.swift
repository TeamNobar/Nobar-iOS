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

  enum KeywordSectionType: Int, CaseIterable {
    case recent = 0
    case recommend = 1
  }

  enum AutoResultSectionType: Int, CaseIterable {
    case cocktail = 0
    case ingredient = 1
  }

  private var keywordSectionType: KeywordSectionType?

  private var resultDataSource: UICollectionViewDiffableDataSource<AutoResultSectionType, String>!
  private var resultSnapshot: NSDiffableDataSourceSnapshot<AutoResultSectionType, String>!

  // TODO: 나중에 서버에서 한꺼번에 리스트로 받아옴
  private var dummyKeywords: [String] = ["브랜디", "선라이즈피치", "피치크러쉬", "카시스 오렌지", "은비쨩", "칵테일어쩌구", "밀푀유나베", "피치어쩌구", "리큐르", "채원쨩??"]
  private var dummyCocktail: [String] = ["브랜디", "선라이즈피치", "피치크러쉬", "카시스 오렌지", "은비쨩", "칵테일어쩌구", "피치만 나와라", "피치어쩌구", "리큐르", "채원쨩", "피치1", "피치2", "피치3", "피치4"]
  private var dummyIngredient: [String] = ["피피피피", "피치주스도있고요", "재료들이", "오렌지주스", "은비쨩", "재료어쩌구", "리큐르", "채원쨩"]

  private let searchView = UIView().then {
    $0.backgroundColor = Color.white.getColor()
  }

  private lazy var backButton = UIButton().then {
    $0.setImage(ImageFactory.btnBackSearch, for: .normal)
    $0.addTarget(self, action: #selector(didClickOnBackButton(_:)), for: .touchUpInside)
  }

  private lazy var searchTextField = SearchTextField().then {
    $0.delegate = self
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
    let layout = createKeywordLayout()
    layout.configuration.interSectionSpacing = 0

    let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
    collectionView.showsHorizontalScrollIndicator = false
    collectionView.showsVerticalScrollIndicator = false
    collectionView.keyboardDismissMode = .onDrag
    return collectionView
  }()

  private lazy var searchAutoResultCollectionView: UICollectionView = {
    let layout = createAutoResultLayout()

    let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
    collectionView.showsHorizontalScrollIndicator = false
    collectionView.showsVerticalScrollIndicator = false
    collectionView.isHidden = true
    collectionView.keyboardDismissMode = .onDrag
    return collectionView
  }()

  override func viewDidLoad() {
    super.viewDidLoad()
    render()
    configUI()
    setDelegation()
    setRegistration()
    setTextFieldButton()
    setDataSource()
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
    view.addSubviews([searchView, searchKeywordCollectionView, searchAutoResultCollectionView])
    searchView.addSubviews([backButton, searchTextField, underline])
    searchKeywordCollectionView.addSubview(emptyLabel)
  }

  private func configUI() {
    view.backgroundColor = Color.white.getColor()
    navigationController?.navigationBar.isHidden = true
    emptyLabel.isHidden = true
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
      $0.height.equalTo(1)
    }

    searchKeywordCollectionView.snp.makeConstraints {
      $0.top.equalTo(underline.snp.bottom)
      $0.leading.trailing.bottom.equalToSuperview()
    }

    searchAutoResultCollectionView.snp.makeConstraints {
      $0.top.equalTo(underline.snp.bottom)
      $0.leading.trailing.bottom.equalToSuperview()
    }

    emptyLabel.snp.makeConstraints {
      $0.top.equalToSuperview().inset(58)
      $0.centerX.equalToSuperview()
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

    searchAutoResultCollectionView.register(SearchHeaderView.self, forSupplementaryViewOfKind: SearchHeaderView.className, withReuseIdentifier: SearchHeaderView.className)
    searchAutoResultCollectionView.register(cell: SearchAutoResultCollectionViewCell.self)
  }

  private func initTextField() {
    searchTextField.rightViewMode = .never
    searchTextField.becomeFirstResponder()
  }

  private func setTextFieldButton() {
    searchTextField.didClickOnClearButtonClosure = {
      self.searchTextField.text?.removeAll()
      self.searchAutoResultCollectionView.isHidden = true
    }
  }

  private func setAutoResultCollectionView() {
    searchAutoResultCollectionView.isHidden = false
  }
}

// MARK: - Action Functions
extension SearchViewController {
  @objc private func judgeHasText(_ sender: UITextField) {
    if searchTextField.hasText {
      setAutoResultCollectionView()
      guard let searchText = searchTextField.text else { return }

      self.performQuery(with: searchText)

    } else {
      searchAutoResultCollectionView.isHidden = true
    }
  }

  @objc private func didClickOnBackButton(_ sender: UIButton) {
    self.searchTextField.text?.removeAll()

    if searchAutoResultCollectionView.isHidden {
      self.navigationController?.popViewController(animated: true)
    } else {
      searchAutoResultCollectionView.isHidden = true
    }
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
    let header = NSCollectionLayoutBoundarySupplementaryItem(layoutSize: headerSize, elementKind: SearchHeaderView.className, alignment: .topLeading)
    section.boundarySupplementaryItems = [header]

    return section
  }

  func getLayoutRecommendSection() -> NSCollectionLayoutSection {
    let itemSize = NSCollectionLayoutSize(widthDimension:
        .fractionalWidth(1), heightDimension: .absolute(50))
    let item = NSCollectionLayoutItem(layoutSize: itemSize)
    item.contentInsets = NSDirectionalEdgeInsets(top: 0, leading: 26, bottom: 0, trailing: 0)

    let groupSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1), heightDimension: .absolute(250))
    let group = NSCollectionLayoutGroup.vertical(layoutSize: groupSize, subitem: item, count: 5)

    let section = NSCollectionLayoutSection(group: group)
    section.orthogonalScrollingBehavior = .continuous

    let headerSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1), heightDimension: .absolute(50))
    let header = NSCollectionLayoutBoundarySupplementaryItem(layoutSize: headerSize, elementKind: SearchHeaderView.className, alignment: .topLeading)
    section.boundarySupplementaryItems = [header]

    return section
  }

  private func createKeywordLayout() -> UICollectionViewCompositionalLayout {
    return UICollectionViewCompositionalLayout { (sectionNumber, env) -> NSCollectionLayoutSection? in
      switch sectionNumber {
      case 0: return self.getLayoutRecentSection()
      case 1: return self.getLayoutRecommendSection()
      default: return self.getLayoutRecentSection()
      }
    }
  }

  func createAutoResultLayout() -> UICollectionViewCompositionalLayout {
    let layout = UICollectionViewCompositionalLayout { (sectionNumber, env) -> NSCollectionLayoutSection? in
      let itemSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1),
                                            heightDimension: .fractionalHeight(1))
      let item = NSCollectionLayoutItem(layoutSize: itemSize)

      let groupSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1),
                                             heightDimension: .absolute(50))
      let group = NSCollectionLayoutGroup.horizontal(layoutSize: groupSize, subitem: item, count: 1)

      let section = NSCollectionLayoutSection(group: group)

      guard let sections = AutoResultSectionType(rawValue: sectionNumber) else { return nil }
      switch sections {
      case .cocktail:
        section.contentInsets = NSDirectionalEdgeInsets(top: 0, leading: 0, bottom: 12, trailing: 0)
      case .ingredient:
        section.contentInsets = NSDirectionalEdgeInsets(top: 0, leading: 0, bottom: 250, trailing: 0)
      }

      let headerSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1),
                                              heightDimension: .absolute(50))
      let header = NSCollectionLayoutBoundarySupplementaryItem(layoutSize: headerSize,
                                                               elementKind: SearchHeaderView.className,
                                                               alignment: .topLeading)
      section.boundarySupplementaryItems = [header]
      return section
    }
    return layout
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
    guard let sectionType = KeywordSectionType(rawValue: section) else { return 1 }

    switch sectionType {
    case .recent:
      return dummyKeywords.count
    case .recommend:
      return 5
    }

  }

  func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
    guard let sectionType = KeywordSectionType(rawValue: indexPath.section) else {
      return UICollectionViewCell()
    }

    switch sectionType {
    case .recent:
      let cell = searchKeywordCollectionView.dequeueReusableCell(ofType: RecentCollectionViewCell.self, at: indexPath)

      cell.updateKeyword(dummyKeywords[indexPath.row])
      return cell
    case .recommend:
      let cell = searchKeywordCollectionView.dequeueReusableCell(ofType: RecommendCollectionViewCell.self, at: indexPath)

      cell.updateModel(SearchModel.dummyRecommendList[indexPath.row])
      return cell
    }
  }

  func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {

    if kind == SearchHeaderView.className {
      let headerView = collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: SearchHeaderView.className, for: indexPath)

      guard let headerView = headerView as? SearchHeaderView else { return UICollectionReusableView() }

      guard let sectionType = KeywordSectionType(rawValue: indexPath.section) else {
        return UICollectionViewCell()
      }

      switch sectionType {
      case .recent:
        headerView.configUI(type: .recent)
        headerView.didClickOnDeleteButtonClosure = {
          self.dummyKeywords.removeAll()
          self.searchKeywordCollectionView.reloadSections([0])
          self.emptyLabel.isHidden = false
        }
      case .recommend:
        headerView.configUI(type: .recommend)
      }
      return headerView
    } else {
      return UICollectionReusableView()
    }
  }
}

// MARK: - Diffable DataSource
extension SearchViewController {
  private func setDataSource() {
    self.resultDataSource = UICollectionViewDiffableDataSource<AutoResultSectionType, String>(collectionView: self.searchAutoResultCollectionView) { (collectionview, indexPath, keyword) -> UICollectionViewCell? in

      guard let cell = self.searchAutoResultCollectionView.dequeueReusableCell(withReuseIdentifier: SearchAutoResultCollectionViewCell.className, for: indexPath) as? SearchAutoResultCollectionViewCell else { preconditionFailure() }

      cell.updateResult(keyword)
      cell.updateAttributedText(self.searchTextField.text ?? "")
      return cell
    }

    self.resultDataSource.supplementaryViewProvider = {
      collectionView, kind, indexPath in

      guard kind == SearchHeaderView.className else { return nil }
      let view = collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: SearchHeaderView.className, for: indexPath) as? SearchHeaderView

      guard let sections = AutoResultSectionType(rawValue: indexPath.section) else { return nil }
      switch sections {
      case .cocktail:
        view?.configUI(type: .cocktail)
      case .ingredient:
        view?.configUI(type: .ingredient)
      }
      return view
    }
  }

  private func performQuery(with searchText: String?) {
    guard let searchText = searchText else { return }

    let filteredCocktail = self.dummyCocktail.filter { $0.hasPrefix(searchText) }
    let filteredIngredient = self.dummyIngredient.filter { $0.hasPrefix(searchText) }

    var fiveCocktail = Array(filteredCocktail.prefix(5))
    let fiveIngredient = Array(filteredIngredient.prefix(5))

    if fiveCocktail.isEmpty {
      fiveCocktail.append(" ")
    }

    resultSnapshot = NSDiffableDataSourceSnapshot<AutoResultSectionType, String>()
    resultSnapshot.appendSections([.cocktail, .ingredient])
    resultSnapshot.appendItems(fiveCocktail, toSection: .cocktail)
    resultSnapshot.appendItems(fiveIngredient, toSection: .ingredient)
    resultDataSource.apply(resultSnapshot, animatingDifferences: true)
  }
}

extension SearchViewController: UITextFieldDelegate {
  func textFieldShouldReturn(_ textField: UITextField) -> Bool {
    searchTextField.resignFirstResponder()

    let resultViewController = SearchResultViewController(searchResultText: self.searchTextField.text ?? "")
    self.navigationController?.pushViewController(resultViewController, animated: false)
    return true
  }
}
