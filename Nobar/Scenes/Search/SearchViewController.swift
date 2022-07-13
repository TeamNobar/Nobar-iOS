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

  private let searchIconImage = UIImageView().then {
    $0.image = ImageFactory.icnSearch
  }

  private lazy var clearTextButton = UIButton().then {
    $0.setImage(ImageFactory.icnX, for: .normal)
    $0.addTarget(self, action: #selector(didClickOnClearButton(_:)), for: .touchUpInside)
  }

  private lazy var searchTextField = UITextField().then {
    $0.placeholder = " 칵테일 이름, 재료 이름"
    $0.setPlaceholderAttributes(Color.gray03.getColor(), Pretendard.size13.bold())
    $0.backgroundColor = Color.gray01.getColor()
    $0.font = Pretendard.size13.bold()
    $0.textColor = Color.gray03.getColor()
    $0.tintColor = Color.navy01.getColor()

    $0.layer.borderColor = Color.gray04.cgColor
    $0.layer.borderWidth = 0.4
    $0.layer.cornerRadius = 6

    $0.clearButtonMode = .never
    $0.leftViewMode = .always
    $0.rightViewMode = .never
    $0.addTarget(self, action: #selector(textFieldDidChange(_:)), for: .editingChanged)

    $0.becomeFirstResponder()
  }

  private lazy var underline = UIView().then {
    $0.backgroundColor = Color.gray02.getColor()
    $0.makeShadow(color: UIColor(red: 0, green: 0, blue: 0, alpha: 0.2), opacity: 1, offset: CGSize(width: 1, height: 1), radius: 2)
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
    collectionView.register(cell: RecentCollectionViewCell.self)
    collectionView.register(cell: RecommendCollectionViewCell.self)
    return collectionView
  }()

  override func viewDidLoad() {
    super.viewDidLoad()
    render()
    configUI()
    setDelegation()
  }

  override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
      view.endEditing(true)
  }

  private func render() {
    view.addSubview(searchView)
    searchView.snp.makeConstraints {
      $0.top.equalTo(view.safeAreaLayoutGuide.snp.top)
      $0.leading.trailing.equalToSuperview()
      $0.height.equalTo(62)
    }

    searchView.addSubview(backButton)
    backButton.snp.makeConstraints {
      $0.top.equalToSuperview().inset(2)
      $0.leading.equalToSuperview().inset(10)
      $0.width.height.equalTo(44)
    }

    searchView.addSubview(searchTextField)
    searchTextField.snp.makeConstraints {
      $0.top.equalToSuperview().inset(6)
      $0.bottom.equalToSuperview().inset(20)
      $0.leading.equalTo(backButton.snp.trailing)
      $0.trailing.equalToSuperview().inset(54)
    }

    searchView.addSubview(underline)
    underline.snp.makeConstraints {
      $0.top.equalTo(searchTextField.snp.bottom).offset(20)
      $0.leading.trailing.equalToSuperview()
      $0.height.equalTo(0.4)
    }

    view.addSubview(searchKeywordCollectionView)
    searchKeywordCollectionView.snp.makeConstraints {
      $0.top.equalTo(underline.snp.bottom)
      $0.leading.trailing.bottom.equalToSuperview()
    }
  }

  private func configUI() {
    view.backgroundColor = .white
    navigationController?.navigationBar.isHidden = true
    setCustomTextField()
    searchKeywordCollectionView.register(SearchHeaderView.self, forSupplementaryViewOfKind: SearchHeaderView.className, withReuseIdentifier: SearchHeaderView.className)
  }

  private func setCustomTextField() {
    let rightView = UIView(frame: CGRect(x: 0, y: 0, width: 28, height: 36))
    rightView.addSubview(clearTextButton)
    clearTextButton.snp.makeConstraints {
      $0.width.height.equalTo(20)
      $0.top.equalToSuperview().inset(8)
      $0.leading.equalToSuperview()
      $0.trailing.equalToSuperview().inset(8)
    }
    searchTextField.rightView = rightView

    let leftView = UIView(frame: CGRect(x: 0, y: 0, width: 43, height: 36))
    leftView.addSubview(searchIconImage)
    searchIconImage.snp.makeConstraints {
      $0.width.height.equalTo(19)
      $0.top.equalToSuperview().inset(9)
      $0.leading.equalToSuperview().inset(16)
      $0.trailing.equalToSuperview().inset(8)
    }
    searchTextField.leftView = leftView
  }

  private func setDelegation() {
    searchKeywordCollectionView.delegate = self
    searchKeywordCollectionView.dataSource = self
  }
}

// MARK: - Action Functions

extension SearchViewController {

  @objc
  private func textFieldDidChange(_ sender: UITextField) {
    searchTextField.rightViewMode = searchTextField.hasText ? .always : .never
  }

  @objc
  private func didClickOnClearButton(_ sender: UIButton) {
    searchTextField.text = ""
  }

  @objc
  private func didClickOnBackButton(_ sender: UIButton) {
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

// TODO: 유진언니 PR Merge 후에 Extension 파일에 추가할 예정
extension UITextField {

  /// placeholder 컬러, 폰트 변경 메서드
  func setPlaceholderAttributes(_ placeholderColor: UIColor, _ placeholderFont: UIFont) {
    attributedPlaceholder = NSAttributedString(string: placeholder ?? "", attributes: [
      .foregroundColor: placeholderColor,
      .font: placeholderFont].compactMapValues { $0 }
    )
  }

  /// UITextField 왼쪽에 여백 주는 메서드
  func addLeftPadding(_ amount: CGFloat) {
      let paddingView = UIView(frame: CGRect(x: 0, y: 0, width: amount, height: self.frame.size.height))
      self.leftView = paddingView
      self.leftViewMode = .always
  }

  /// UITextField 오른쪽에 여백 주는 메서드
  func addRightPadding(_ amount: CGFloat) {
      let paddingView = UIView(frame: CGRect(x: 0, y: 0, width: amount, height: self.frame.size.height))
      self.rightView = paddingView
      self.rightViewMode = .always
  }
}

extension UIView {
  @discardableResult
  func makeShadow(color: UIColor,
                  opacity: Float,
                  offset: CGSize,
                  radius: CGFloat) -> Self {
    layer.shadowColor = color.cgColor
    layer.shadowOpacity = opacity
    layer.shadowOffset = offset
    layer.shadowRadius = radius
    return self
  }
}
