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
    $0.setPlaceholderAttributes(Color.gray03, Pretendard.size13.bold())
    $0.backgroundColor = Color.gray01
    $0.font = Pretendard.size13.bold()
    $0.textColor = Color.gray03
    $0.tintColor = Color.navy01

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
    $0.backgroundColor = Color.gray02
    $0.makeShadow(color: UIColor(red: 0, green: 0, blue: 0, alpha: 0.2), opacity: 1, offset: CGSize(width: 1, height: 1), radius: 2)
  }

  override func viewDidLoad() {
    super.viewDidLoad()
    render()
    configUI()
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

  }

  private func configUI() {
    view.backgroundColor = .white
    navigationController?.navigationBar.isHidden = true
    setCustomTextField()
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
}

// MARK: Action Functions
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
  private func createLayout() -> UICollectionViewCompositionalLayout {
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

    let layout = UICollectionViewCompositionalLayout(section: section)
    return layout
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

extension NSObject {
    static var className: String {
        return String(describing: self)
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
