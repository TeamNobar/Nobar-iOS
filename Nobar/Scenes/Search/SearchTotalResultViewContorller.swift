//
//  SearchTotalResultViewContorller.swift
//  Nobar
//
//  Created by 김수연 on 2022/07/16.
//

import UIKit

import Then
import SnapKit

final class SearchTotalResultViewController: BaseViewController {

  enum Section: Int, CaseIterable {
    case recipe
  }

  private var resultDataSource: UICollectionViewDiffableDataSource<Section, Recipe>!
  private var resultSnapshot: NSDiffableDataSourceSnapshot<Section, Recipe>!

  private var recipeList: [Recipe] = []

  private lazy var closeButton = UIButton().then {
    $0.setImage(ImageFactory.btnCancel, for: .normal)
    $0.addTarget(self, action: #selector(didClickOnCloseButton(_:)), for: .touchUpInside)
  }

  private let titleLabel = UILabel().then {
    $0.text = "검색 결과"
    $0.font = Pretendard.size16.bold()
    $0.textColor = Color.black.getColor()
  }

  private let underline = UIView().then {
    $0.backgroundColor = Color.gray02.getColor()
  }

  // 전체 collecitonView
  private lazy var searchTotalResultCollectionView: UICollectionView = {
    let layout = createTotalListLayout()

    let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
    collectionView.showsHorizontalScrollIndicator = false
    collectionView.showsVerticalScrollIndicator = true
    collectionView.register(cell: SearchTotalResultCollectionViewCell.self)
    collectionView.delegate = self
    return collectionView
  }()

  init(recipeList: [Recipe]) {
    self.recipeList = recipeList

    super.init(nibName: nil, bundle: nil)
  }

  required init?(coder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }

  override func viewDidLoad() {
    super.viewDidLoad()
    render()
    configUI()
    setDataSource()
  }

  override func setupConstraints() {
    super.setupConstraints()
    setLayout()
  }
}

// MARK: - UI & Layout
extension SearchTotalResultViewController {

  private func render() {
    view.addSubviews([underline, searchTotalResultCollectionView])
  }

  private func setLayout() {
    closeButton.snp.makeConstraints {
      $0.width.height.equalTo(42)
    }

    underline.snp.makeConstraints {
      $0.top.equalTo(view.safeAreaLayoutGuide.snp.top)
      $0.leading.trailing.equalToSuperview()
      $0.height.equalTo(1)
    }

    searchTotalResultCollectionView.snp.makeConstraints {
      $0.top.equalTo(underline.snp.bottom).offset(14)
      $0.leading.trailing.bottom.equalToSuperview()
    }
  }

  private func configUI() {
    view.backgroundColor = Color.white.getColor()
    navigationItem.leftBarButtonItem = UIBarButtonItem(customView: closeButton)
    
    let titleAttribute = [NSAttributedString.Key.font: Pretendard.size16.bold(), NSAttributedString.Key.foregroundColor: Color.black.getColor()]
    self.navigationController?.navigationBar.titleTextAttributes = titleAttribute

    navigationItem.title = "검색 결과"
  }
}

// MARK: - Action Functions
extension SearchTotalResultViewController {
  @objc private func didClickOnCloseButton(_ sender: UIButton) {
    self.dismiss(animated: true)
  }
}

// MARK: - Compositional Layout
extension SearchTotalResultViewController {
  private func createTotalListLayout() -> UICollectionViewCompositionalLayout {
    return UICollectionViewCompositionalLayout { (sectionNumber, env) -> NSCollectionLayoutSection? in
      let columns = 2
      let spacing = CGFloat(9)

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
      
      return section
    }
  }
}

// MARK: - Diffable DataSource
extension SearchTotalResultViewController {
  private func setDataSource() {
    self.resultDataSource = UICollectionViewDiffableDataSource<Section, Recipe>(collectionView: self.searchTotalResultCollectionView) { (collectionview, indexPath, recipe) -> UICollectionViewCell? in

      guard let cell = self.searchTotalResultCollectionView.dequeueReusableCell(withReuseIdentifier: SearchTotalResultCollectionViewCell.className, for: indexPath) as? SearchTotalResultCollectionViewCell else { preconditionFailure() }

      cell.updateModel(recipe)
      return cell
    }

    resultSnapshot = NSDiffableDataSourceSnapshot<Section, Recipe>()
    resultSnapshot.appendSections([.recipe])
    resultSnapshot.appendItems(recipeList, toSection: .recipe)
    resultDataSource.apply(resultSnapshot, animatingDifferences: true)
  }
}

extension SearchTotalResultViewController: UICollectionViewDelegate {
  func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
    let storyboard = StoryboardRouter.detail.instance

    let detailViewController = storyboard.instantiateViewController(ofType: DetailViewController.self)


    navigationController?.pushViewController(detailViewController, animated: true)
  }
}
