//
//  SearchResultViewController.swift
//  Nobar
//
//  Created by 김수연 on 2022/07/11.
//

import UIKit

import Then
import SnapKit

final class SearchResultViewController: BaseViewController {

  enum ResultSecionType: Int, CaseIterable {
    case cocktail = 0
    case ingredient = 1
  }

  var searchText: String?
  private var resultSectionType: ResultSecionType?

  // TODO: 이전 뷰에서 필터링 된 재료 리스트 전달 filterIngredient 어쩌구
  private var dummyIngredient: [String] = ["피피피피", "피치주스도있고요", "재료들이", "오렌지주스", "은비쨩", "재료어쩌구", "리큐르", "채원쨩"]

  private let searchView = UIView().then {
    $0.backgroundColor = .white
  }

  private lazy var searchTextField = SearchTextField().then {
    $0.addTarget(self, action: #selector(beginEditingText(_:)), for: .editingDidBegin)
  }

  private lazy var backButton = UIButton().then {
    $0.setImage(ImageFactory.btnBackSearch, for: .normal)
    $0.addTarget(self, action: #selector(didClickOnBackButton(_:)), for: .touchUpInside)
  }

  private lazy var underline = UIView().then {
    $0.backgroundColor = Color.gray02.withAlphaColor(alpha: 0.5)
    $0.layer.applyShadow(color: .black, alpha: 0.2, x: 1, y: 1, blur: 2, spread: 0)
  }

  private lazy var searchTotalResultCollectionView: UICollectionView = {
    let layout = createKeywordLayout()

    let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
    collectionView.showsHorizontalScrollIndicator = false
    collectionView.showsVerticalScrollIndicator = false
    collectionView.keyboardDismissMode = .onDrag
    return collectionView
  }()

  init(searchResultText: String) {
    self.searchText = searchResultText

    super.init(nibName: nil, bundle: nil)
  }

  required init?(coder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }

  override func viewDidLoad() {
    super.viewDidLoad()
    render()
    configUI()
    setTextField()
    setDelegation()
    setRegistration()
  }

  override func viewWillAppear(_ animated: Bool) {
    super.viewWillAppear(animated)
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
extension SearchResultViewController {

  private func render() {
    view.addSubviews([searchView, searchTotalResultCollectionView, underline])
    searchView.addSubviews([backButton, searchTextField])
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

    searchTotalResultCollectionView.snp.makeConstraints {
      $0.top.equalTo(underline.snp.bottom).offset(2)
      $0.leading.trailing.bottom.equalToSuperview()
    }
  }

  private func configUI() {
    view.backgroundColor = .white
    navigationController?.navigationBar.isHidden = true
  }
}

// MARK: - Private Functions
extension SearchResultViewController {
  private func setTextField() {
    searchTextField.resignFirstResponder()
    searchTextField.text = searchText
  }

  private func setDelegation() {
    searchTotalResultCollectionView.delegate = self
    searchTotalResultCollectionView.dataSource = self
  }
  
  private func setRegistration() {
    searchTotalResultCollectionView.register(SearchHeaderView.self, forSupplementaryViewOfKind: SearchHeaderView.className, withReuseIdentifier: SearchHeaderView.className)
    searchTotalResultCollectionView.register(cell: SearchTotalResultCollectionViewCell.self)

    searchTotalResultCollectionView.register(cell: SearchAutoResultCollectionViewCell.self)
  }
}

// MARK: - Action Functions
extension SearchResultViewController {
  @objc private func beginEditingText(_ sender: UITextField) {
    self.navigationController?.popViewController(animated: false)
  }

  @objc private func didClickOnBackButton(_ sender: UIButton) {
    self.navigationController?.popViewController(animated: false)
  }
}

// MARK: - Compositional Layout
extension SearchResultViewController {
  // section 1
  private func getLayoutTotalResultSection() -> NSCollectionLayoutSection {
    let columns = 2
    let spacing = 9.f

    let itemSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1.0),
                                          heightDimension: .estimated(75))
    let item = NSCollectionLayoutItem(layoutSize: itemSize)

    let groupSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1.0),
                                           heightDimension: .absolute(75))
    let group = NSCollectionLayoutGroup.horizontal(layoutSize: groupSize, subitem: item, count: columns)
    group.interItemSpacing = .fixed(spacing)

    let section = NSCollectionLayoutSection(group: group)
    section.interGroupSpacing = spacing
    section.contentInsets = NSDirectionalEdgeInsets(top: 0, leading: 26, bottom: 30, trailing: 26)

    let headerSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1),
                                            heightDimension: .absolute(50))
    let header = NSCollectionLayoutBoundarySupplementaryItem(layoutSize: headerSize,
                                                             elementKind: SearchHeaderView.className,
                                                             alignment: .topLeading)
    section.boundarySupplementaryItems = [header]

    return section
  }

  // section 2
  private func getLayoutIngredientResultSection() -> NSCollectionLayoutSection {
    let itemSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1),
                                          heightDimension: .fractionalHeight(1))
    let item = NSCollectionLayoutItem(layoutSize: itemSize)

    let groupSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1),
                                           heightDimension: .absolute(50))
    let group = NSCollectionLayoutGroup.horizontal(layoutSize: groupSize, subitem: item, count: 1)

    let section = NSCollectionLayoutSection(group: group)

    let headerSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1),
                                            heightDimension: .absolute(50))
    let header = NSCollectionLayoutBoundarySupplementaryItem(layoutSize: headerSize,
                                                             elementKind: SearchHeaderView.className,
                                                             alignment: .topLeading)
    section.boundarySupplementaryItems = [header]
    return section
  }

  // layout
  private func createKeywordLayout() -> UICollectionViewCompositionalLayout {
    return UICollectionViewCompositionalLayout { (sectionNumber, env) -> NSCollectionLayoutSection? in
      switch sectionNumber {
      case 0: return self.getLayoutTotalResultSection()
      case 1: return self.getLayoutIngredientResultSection()
      default: return self.getLayoutIngredientResultSection()
      }
    }
  }
}

// MARK: - CollectionView Delegate functions
extension SearchResultViewController: UICollectionViewDelegate {

  func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
    guard let sectionType = ResultSecionType(rawValue: indexPath.section) else { return }

    // 이전 뷰와 동일하게 앱잼 내에서는 칵테일만 선택되도록
    if sectionType == .cocktail {
      print("칵테일 상세뷰로 이동 - 결과뷰")
      let storyboard = StoryboardRouter.detail.instance

      let detailViewController = storyboard.instantiateViewController(ofType: DetailViewController.self)


      navigationController?.pushViewController(detailViewController, animated: true)
      // 칵테일 상세뷰로 이동 - 수아뷰
      // let item = indexPath.item
      // if let recipeId = 서버에서 받아온 레시피 모델.safeget(index: item).id {
      //  let 레시피 상세 뷰 = 레시피상세뷰컨()
      //  navigationViewController?.pushViewController(레시피 상세뷰컨)
    }
  }
}

extension SearchResultViewController: UICollectionViewDataSource {

  func numberOfSections(in collectionView: UICollectionView) -> Int {
    return ResultSecionType.allCases.count
  }

  func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
    guard let sectionType = ResultSecionType(rawValue: section) else { return 1 }

    switch sectionType {
    case .cocktail:
      return SearchCocktailModel.dummyCocktailList.count
    case .ingredient:
      return dummyIngredient.count
    }
  }

  func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
    guard let sectionType = ResultSecionType(rawValue: indexPath.section) else {
      return UICollectionViewCell()
    }

    switch sectionType {
    case .cocktail:
      let cell = searchTotalResultCollectionView.dequeueReusableCell(ofType: SearchTotalResultCollectionViewCell.self, at: indexPath)

      guard let item = SearchCocktailModel.dummyCocktailList.safeget(index: indexPath.row) else { return cell }
      cell.updateModel(item)
      return cell
    case .ingredient:
      let cell = searchTotalResultCollectionView.dequeueReusableCell(ofType: SearchAutoResultCollectionViewCell.self, at: indexPath)


      guard let item = dummyIngredient.safeget(index: indexPath.row) else { return cell }
      cell.updateResult(item)
      cell.updateAttributedText(self.searchText ?? "")
      return cell
    }
  }

  func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {

    if kind == SearchHeaderView.className {
      let headerView = collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: SearchHeaderView.className, for: indexPath)

      guard let headerView = headerView as? SearchHeaderView else { return UICollectionReusableView() }

      guard let sectionType = ResultSecionType(rawValue: indexPath.section) else {
        return UICollectionViewCell()
      }

      switch sectionType {
      case .cocktail:
        headerView.configUI(type: .total)
        headerView.didClickOnTotalButtonClosure = {
          let searchTotalViewController = SearchTotalResultViewController()
          let searchNavigationController = UINavigationController(rootViewController: searchTotalViewController)
          searchNavigationController.modalPresentationStyle = .fullScreen
          self.present(searchNavigationController, animated: true)
        }
      case .ingredient:
        headerView.configUI(type: .ingredient)
      }

      return headerView
    } else {
      return UICollectionReusableView()
    }
  }
}


