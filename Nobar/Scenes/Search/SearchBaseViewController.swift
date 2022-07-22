//
//  SearchBaseViewController.swift
//  Nobar
//
//  Created by 김수연 on 2022/07/18.
//

import UIKit

import Then
import SnapKit

final class SearchBaseViewController: BaseViewController {

  enum SectionType: Int, CaseIterable {
    case base = 0
    case result = 1
  }

  private var resultDataSource: UICollectionViewDiffableDataSource<SectionType, SearchCocktailModel>!
  private var resultSnapshot: NSDiffableDataSourceSnapshot<SectionType, SearchCocktailModel>!

  private let searchView = UIView().then {
    $0.backgroundColor = Color.white.getColor()
  }

  private lazy var searchTextField = SearchTextField().then {
    $0.resignFirstResponder()
    $0.addTarget(self, action: #selector(beginEditingText(_:)), for: .editingDidBegin)
  }

  private lazy var underline = UIView().then {
    $0.backgroundColor = Color.gray02.withAlphaColor(alpha: 0.5)
    $0.layer.applyShadow(color: .black, alpha: 0.2, x: 1, y: 1, blur: 2, spread: 0)
  }

  private let titleLabel = UILabel().then {
    $0.text = "어떤 베이스로 칵테일을 만들고 싶으세요?"
    $0.font = Pretendard.size18.extraBold()
    $0.textColor = Color.navy01.getColor()
  }

  private lazy var baseCollectionView: UICollectionView = {
    let layout = createBaseLayout()

    let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
    collectionView.showsHorizontalScrollIndicator = false
    collectionView.showsVerticalScrollIndicator = false
    collectionView.isScrollEnabled = false
    return collectionView
  }()

  private let separateLine = UIView().then {
    $0.backgroundColor = Color.gray02.withAlphaColor(alpha: 0.5)
  }

  private lazy var resultCollectionView: UICollectionView = {
    let layout = createResultLayout()

    let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
    collectionView.showsHorizontalScrollIndicator = false
    collectionView.showsVerticalScrollIndicator = false
    collectionView.delegate = self
    return collectionView
  }()

  override func viewDidLoad() {
    super.viewDidLoad()
    render()
    configUI()
    setDelegation()
    setRegistration()
    setDataSource()
  }

  override func viewWillAppear(_ animated: Bool) {
    super.viewWillAppear(animated)
    resignSearchTextField()
    configUI()
  }

  override func setupConstraints() {
    super.setupConstraints()
    setLayout()
  }
}

// MARK: - UI & Layout
extension SearchBaseViewController {
  private func render() {
    view.addSubviews([searchView, underline, titleLabel, baseCollectionView, separateLine, resultCollectionView])
    searchView.addSubviews([searchTextField])
  }

  private func configUI() {
    view.backgroundColor = Color.white.getColor()
    navigationController?.navigationBar.isHidden = true
  }

  private func setLayout() {
    searchView.snp.makeConstraints {
      $0.top.equalTo(view.safeAreaLayoutGuide.snp.top)
      $0.leading.trailing.equalToSuperview()
      $0.height.equalTo(62)
    }

    searchTextField.snp.makeConstraints {
      $0.top.equalToSuperview().inset(6)
      $0.bottom.equalToSuperview().inset(20)
      $0.leading.trailing.equalToSuperview().inset(54)
    }

    underline.snp.makeConstraints {
      $0.top.equalTo(searchView.snp.bottom)
      $0.leading.trailing.equalToSuperview()
      $0.height.equalTo(1)
    }

    titleLabel.snp.makeConstraints {
      $0.top.equalTo(underline.snp.bottom).offset(15)
      $0.leading.equalToSuperview().inset(27)
    }

    baseCollectionView.snp.makeConstraints {
      $0.height.equalTo(70)
      $0.top.equalTo(titleLabel.snp.bottom).offset(16)
      $0.leading.trailing.equalToSuperview()
    }

    separateLine.snp.makeConstraints {
      $0.top.equalTo(baseCollectionView.snp.bottom).offset(39)
      $0.height.equalTo(1)
      $0.leading.trailing.equalToSuperview()
    }

    resultCollectionView.snp.makeConstraints {
      $0.top.equalTo(separateLine.snp.bottom)
      $0.leading.trailing.bottom.equalToSuperview()
    }
  }
}

// MARK: - Action Functions
extension SearchBaseViewController {
  @objc private func beginEditingText(_ sender: UITextField) {
    let searchViewController = SearchViewController()
    self.navigationController?.pushViewController(searchViewController, animated: false)
  }
}

// MARK: - Private Functions
extension SearchBaseViewController {
  private func resignSearchTextField() {
    searchTextField.resignFirstResponder()
  }

  private func setDelegation() {
    baseCollectionView.delegate = self
    baseCollectionView.dataSource = self
  }

  private func setRegistration() {
    baseCollectionView.register(cell: BaseCocktailCollectionViewCell.self)

    resultCollectionView.register(SearchHeaderView.self, forSupplementaryViewOfKind: SearchHeaderView.className, withReuseIdentifier: SearchHeaderView.className)
    resultCollectionView.register(cell: SearchTotalResultCollectionViewCell.self)
  }
}

// MARK: - CollectionView Compositional Layout
extension SearchBaseViewController {
  func createBaseLayout() -> UICollectionViewCompositionalLayout {
    let layout = UICollectionViewCompositionalLayout { (sectionNumber, env) -> NSCollectionLayoutSection? in
      let itemSize = NSCollectionLayoutSize(widthDimension: .absolute(50),
                                            heightDimension: .absolute(70))
      let item = NSCollectionLayoutItem(layoutSize: itemSize)

      let groupSize = NSCollectionLayoutSize(widthDimension: .estimated(50),
                                             heightDimension: .absolute(70))
      let group = NSCollectionLayoutGroup.horizontal(layoutSize: groupSize,
                                                     subitems: [item])

      let section = NSCollectionLayoutSection(group: group)
      section.interGroupSpacing = 8
      section.orthogonalScrollingBehavior = .continuous
      section.contentInsets = NSDirectionalEdgeInsets(
        top: 0,
        leading: 26,
        bottom: 200,
        trailing: 26)

      return section
    }
    return layout
  }

  func createResultLayout() -> UICollectionViewCompositionalLayout {
    let layout = UICollectionViewCompositionalLayout { (sectionNumber, env) -> NSCollectionLayoutSection? in
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
      section.contentInsets = NSDirectionalEdgeInsets(
        top: 0,
        leading: 31,
        bottom: 0,
        trailing: 31)

      let headerSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1),
                                              heightDimension: .absolute(62))
      let header = NSCollectionLayoutBoundarySupplementaryItem(layoutSize: headerSize,
                                                               elementKind: SearchHeaderView.className,
                                                               alignment: .topLeading)
      section.boundarySupplementaryItems = [header]

      return section
    }
    return layout
  }
}

// MARK: - CollectionView Delegate & DataSource
extension SearchBaseViewController: UICollectionViewDelegate {
  func collectionView(_ collectionView: UICollectionView, shouldSelectItemAt indexPath: IndexPath) -> Bool {
    let item = collectionView.cellForItem(at: indexPath)

    if item?.isSelected ?? false {
      collectionView.deselectItem(at: indexPath, animated: true)
    } else {
      collectionView.selectItem(at: indexPath, animated: true, scrollPosition: [])
      return true
    }
    
    return false
  }

  func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {

    if collectionView == resultCollectionView {
      let storyboard = StoryboardRouter.detail.instance

      let detailViewController = storyboard.instantiateViewController(ofType: DetailViewController.self)

      navigationController?.pushViewController(detailViewController, animated: true)
    }
  }
}

extension SearchBaseViewController: UICollectionViewDataSource {
  func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
    return BaseCocktailModel.dummyBaseList.count
  }

  func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
    let cell = baseCollectionView.dequeueReusableCell(ofType: BaseCocktailCollectionViewCell.self, at: indexPath)

    guard let item = BaseCocktailModel.dummyBaseList.safeget(index: indexPath.row) else { return cell }
    cell.updateModel(item)
    return cell
  }
}

// MARK: - Diffable DataSource
extension SearchBaseViewController {
  private func setDataSource() {
    self.resultDataSource = UICollectionViewDiffableDataSource<SectionType, SearchCocktailModel>(collectionView: self.resultCollectionView) { (collectionview, indexPath, keyword) -> UICollectionViewCell? in

      guard let cell = self.resultCollectionView.dequeueReusableCell(withReuseIdentifier: SearchTotalResultCollectionViewCell.className, for: indexPath) as? SearchTotalResultCollectionViewCell else { preconditionFailure() }

      cell.updateModel(keyword)
      return cell
    }

    self.resultDataSource.supplementaryViewProvider = {
      collectionView, kind, indexPath in

      guard kind == SearchHeaderView.className else { return nil }
      let view = collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: SearchHeaderView.className, for: indexPath) as? SearchHeaderView

      view?.configUI(type: .baseResult)
      return view
    }

    resultSnapshot = NSDiffableDataSourceSnapshot<SectionType, SearchCocktailModel>()
    resultSnapshot.appendSections([.result])
    resultSnapshot.appendItems(SearchCocktailModel.dummyCocktailList, toSection: .result)
    resultDataSource.apply(resultSnapshot, animatingDifferences: true)
  }
}

