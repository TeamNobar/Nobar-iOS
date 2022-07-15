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

  enum Section: Int, CaseIterable {
    case cocktail = 0
    case ingredient = 1
  }

  var firstKeyword: String?
  private var sections: Section?
  private var dataSource: UICollectionViewDiffableDataSource<Section, String>!
  private var snapshot: NSDiffableDataSourceSnapshot<Section, String>!

  // TODO: 나중에 서버에서 한꺼번에 리스트로 받아옴
  private var dummyCocktail: [String] = ["브랜디", "선라이즈피치", "피치크러쉬", "카시스 오렌지", "은비쨩", "칵테일어쩌구", "피치만 나와라", "피치어쩌구", "리큐르", "채원쨩", "피치1", "피치2", "피치3", "피치4"]

  private var dummyIngredient: [String] = ["여긴재료", "주스도있고요", "재료들이", "오렌지주스", "은비쨩", "재료어쩌구", "리큐르", "채원쨩"]

  private let searchView = UIView().then {
    $0.backgroundColor = .white
  }

  private lazy var searchTextField = SearchTextField().then {
    $0.addTarget(self, action: #selector(judgeHasText(_:)), for: .editingChanged)
  }

  private lazy var backButton = UIButton().then {
    $0.setImage(ImageFactory.btnBackSearch, for: .normal)
    $0.addTarget(self, action: #selector(didClickOnBackButton(_:)), for: .touchUpInside)
  }

  private lazy var underline = UIView().then {
    $0.backgroundColor = Color.gray02.getColor()
    $0.layer.applyShadow(color: .black, alpha: 0.2, x: 1, y: 1, blur: 2, spread: 0)
  }

  private lazy var searchAutoResultCollectionView: UICollectionView = {
    let layout = createCompositionLayout()

    let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
    collectionView.showsHorizontalScrollIndicator = false
    collectionView.showsVerticalScrollIndicator = false
    return collectionView
  }()

  override func viewDidLoad() {
    super.viewDidLoad()
    render()
    configUI()
    setTextField()
    setRegistration()
    setDataSource()
    performQuery(with: firstKeyword)
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
    view.addSubviews([searchView, searchAutoResultCollectionView])
    searchView.addSubviews([backButton, searchTextField, underline])
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

    searchAutoResultCollectionView.snp.makeConstraints {
      $0.top.equalTo(underline.snp.bottom)
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
    searchTextField.text = firstKeyword
    searchTextField.rightViewMode = .always
    searchTextField.didClickOnClearButtonClosure = {
      self.searchTextField.text?.removeAll()
      self.navigationController?.popViewController(animated: false)
    }
  }
  
  private func setRegistration() {
    searchAutoResultCollectionView.register(SearchHeaderView.self, forSupplementaryViewOfKind: SearchHeaderView.className, withReuseIdentifier: SearchHeaderView.className)
    searchAutoResultCollectionView.register(cell: SearchAutoResultCollectionViewCell.self)
  }
}

// MARK: - Action Functions
extension SearchResultViewController {
  @objc private func judgeHasText(_ sender: UITextField) {
    if searchTextField.hasText == false {
      navigationController?.popViewController(animated: false)
    } else {
      guard let searchText = searchTextField.text
      else { return }
      
      self.performQuery(with: searchText)
    }
  }

  @objc private func didClickOnBackButton(_ sender: UIButton) {
    self.navigationController?.popViewController(animated: false)
  }
}

// MARK: - Compositional Layout
extension SearchResultViewController {
  private func createCompositionLayout() -> UICollectionViewCompositionalLayout {
    let layout = UICollectionViewCompositionalLayout { (sectionNumber, env) -> NSCollectionLayoutSection? in
      let itemSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1),
                                            heightDimension: .fractionalHeight(1))
      let item = NSCollectionLayoutItem(layoutSize: itemSize)

      let groupSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1),
                                             heightDimension: .absolute(50))
      let group = NSCollectionLayoutGroup.horizontal(layoutSize: groupSize, subitem: item, count: 1)

      let section = NSCollectionLayoutSection(group: group)

      guard let sections = Section(rawValue: sectionNumber) else { return nil }
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

// MARK: - Diffable DataSource
extension SearchResultViewController {
  private func setDataSource() {
    self.dataSource = UICollectionViewDiffableDataSource<Section, String>(collectionView: self.searchAutoResultCollectionView) { (collectionview, indexPath, keyword) -> UICollectionViewCell? in

      guard let cell = self.searchAutoResultCollectionView.dequeueReusableCell(withReuseIdentifier: SearchAutoResultCollectionViewCell.className, for: indexPath) as? SearchAutoResultCollectionViewCell else { preconditionFailure() }

      cell.updateResult(keyword)
      cell.updateAttributedText(self.searchTextField.text ?? "")
      return cell
    }

    self.dataSource.supplementaryViewProvider = {
      collectionView, kind, indexPath in

      guard kind == SearchHeaderView.className else { return nil }
      let view = collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: SearchHeaderView.className, for: indexPath) as? SearchHeaderView

      guard let sections = Section(rawValue: indexPath.section) else { return nil }
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

    snapshot = NSDiffableDataSourceSnapshot<Section, String>()
    snapshot.appendSections([.cocktail, .ingredient])
    snapshot.appendItems(fiveCocktail, toSection: .cocktail)
    snapshot.appendItems(fiveIngredient, toSection: .ingredient)
    dataSource.apply(snapshot, animatingDifferences: true)
  }
}
