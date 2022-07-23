//
//  SearchViewController.swift
//  Nobar
//
//  Created by 김수연 on 2022/07/12.
//

import UIKit

import Then
import SnapKit
import RealmSwift

final class SearchViewController: BaseViewController {

  enum KeywordSectionType: Int, CaseIterable {
    case recent = 0
    case recommend = 1
  }

  enum AutoResultSectionType: Int, CaseIterable {
    case cocktail = 0
    case ingredient = 1
  }

  var searchRecentList: [String] = [] {
    didSet {
      searchKeywordCollectionView.reloadSections([0])
    }
  }

  private var recommendList: [Recommend] = []

  private var keywordSectionType: KeywordSectionType?

  let realm = try? Realm()

  private var resultDataSource: UICollectionViewDiffableDataSource<AutoResultSectionType, String>!
  private var resultSnapshot: NSDiffableDataSourceSnapshot<AutoResultSectionType, String>!

  private var networkingService = NetworkingService()

  private var recipeList: [Recipe] = []
  private var ingredientList: [Ingredient] = []

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
    $0.backgroundColor = Color.gray02.withAlphaColor(alpha: 0.5)
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
    setRealmData()
    getSearchMain()
  }

  override func viewWillAppear(_ animated: Bool) {
    super.viewWillAppear(animated)
    initTextField()
    configUI()
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
    view.addSubviews([searchView, searchKeywordCollectionView, searchAutoResultCollectionView, underline])
    searchView.addSubviews([backButton, searchTextField])
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
      $0.top.equalTo(searchView.snp.bottom)
      $0.leading.trailing.equalToSuperview()
      $0.height.equalTo(1)
    }

    searchKeywordCollectionView.snp.makeConstraints {
      $0.top.equalTo(underline.snp.bottom).offset(2)
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
    searchAutoResultCollectionView.delegate = self
  }

  private func setRegistration() {
    searchKeywordCollectionView.register(SearchHeaderView.self, forSupplementaryViewOfKind: SearchHeaderView.className, withReuseIdentifier: SearchHeaderView.className)
    searchKeywordCollectionView.register(cell: RecentCollectionViewCell.self)
    searchKeywordCollectionView.register(cell: RecommendCollectionViewCell.self)

    searchAutoResultCollectionView.register(SearchHeaderView.self, forSupplementaryViewOfKind: SearchHeaderView.className, withReuseIdentifier: SearchHeaderView.className)
    searchAutoResultCollectionView.register(cell: SearchAutoResultCollectionViewCell.self)
  }

  private func initTextField() {
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
  func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
    guard let sectionType = KeywordSectionType(rawValue: indexPath.section) else { return }

    guard let autoSectionType = AutoResultSectionType(rawValue: indexPath.section) else { return }

    if searchAutoResultCollectionView.isHidden {
      switch sectionType {
      case .recent:
        let resultViewController = SearchResultViewController(searchResultText: searchRecentList.safeget(index: indexPath.item) ?? "", ingredientList: self.ingredientList)
        navigationController?.pushViewController(resultViewController, animated: false)
      case .recommend:
        let item = indexPath.item
        if let recipeId = recipeList.safeget(index: item)?.id {
          let storyboard = StoryboardRouter.detail.instance

          let detailViewController = storyboard.instantiateViewController(ofType: DetailViewController.self)
          detailViewController.recipeId = recipeId
          navigationController?.pushViewController(detailViewController, animated: true)
        }
      }
    } else {
      if autoSectionType == .cocktail {
        // TODO: - 앱잼 내에서는 칵테일 부분만 선택되는 것으로 변경
        let item = indexPath.item
        if let recipeId = recipeList.safeget(index: item)?.id {
          let storyboard = StoryboardRouter.detail.instance

          let detailViewController = storyboard.instantiateViewController(ofType: DetailViewController.self)
          detailViewController.recipeId = recipeId
          navigationController?.pushViewController(detailViewController, animated: true)
        }
      }
    }
  }
}

extension SearchViewController: UICollectionViewDataSource {
  
  func numberOfSections(in collectionView: UICollectionView) -> Int {
    return 2
  }

  func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
    guard let sectionType = KeywordSectionType(rawValue: section) else { return 1 }

    switch sectionType {
    case .recent:
      return searchRecentList.count
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

      guard let item = searchRecentList.safeget(index: indexPath.row) else { return cell }
      cell.updateKeyword(item)
      return cell
    case .recommend:
      let cell = searchKeywordCollectionView.dequeueReusableCell(ofType: RecommendCollectionViewCell.self, at: indexPath)

      guard let item = recommendList.safeget(index: indexPath.row) else { return cell }
      cell.updateModel(with: "\(indexPath.row + 1)" ,item)
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
        headerView.deleteButton.isHidden = searchRecentList.isEmpty ? true : false
        emptyLabel.isHidden = searchRecentList.isEmpty ? false : true

        headerView.didClickOnDeleteButtonClosure = {
          self.deleteRecentSearch()
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

    var recipeNameList: [String] = []
    var ingredientNameList: [String] = []

    for i in 0..<recipeList.count {
      recipeNameList.append(recipeList.safeget(index: i)?.name ?? "")
    }

    for i in 0..<ingredientList.count {
      ingredientNameList.append(ingredientList.safeget(index: i)?.name ?? "")
    }


    let filteredCocktail = recipeNameList.filter { $0.hasPrefix(searchText) }
    let filteredIngredient = ingredientNameList.filter { $0.hasPrefix(searchText) }

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
    let searchText = self.searchTextField.text ?? ""
    let ingredientList: [Ingredient] = []

    searchTextField.resignFirstResponder()
    saveRecentSearch(keyword: searchText)

    let resultViewController = SearchResultViewController(searchResultText: searchText, ingredientList: ingredientList)
    self.navigationController?.pushViewController(resultViewController, animated: false)
    return true
  }
}

// MARK: - Realm Manager
extension SearchViewController {
  private func setRealmData() {
    let savedSearchRecent = realm?.objects(RecentSearchModel.self)
    savedSearchRecent?.forEach { object in
      searchRecentList.insert(object.keyword, at: 0)
    }
  }

  private func saveRecentSearch(keyword: String) {
    let recentSearchModel = RecentSearchModel()
    recentSearchModel.keyword = keyword
    try? realm?.write {
      realm?.add(recentSearchModel)
    }
    searchRecentList.insert(keyword, at: 0)
    emptyLabel.isHidden = true
  }

  private func deleteRecentSearch() {
    try? realm?.write {
      realm?.deleteAll()
    }
    searchRecentList.removeAll()
  }
}

// MARK: - Networking
extension SearchViewController {
  private func getSearchMain() {
    let endPoint = Endpoint<Search>(apiRouter: .searchMain)

    networkingService.request(endPoint) { [weak self] result in
      switch result {
      case .success(let search):
        guard let recommends = search.recommends,
              let recipes = search.recipes,
              let ingredients = search.ingredients
        else { return }

        self?.recommendList = recommends
        self?.recipeList = recipes
        self?.ingredientList = ingredients

        DispatchQueue.main.async {
          self?.searchKeywordCollectionView.reloadSections([1])
        }

      case .failure(let error):
        print(String(describing: error), #line)
      }
    }
  }
}
