//
//  SearchTextField.swift
//  Nobar
//
//  Created by 김수연 on 2022/07/13.
//

import UIKit

import Then
import SnapKit

final class SearchTextField: UITextField {

  var didClickOnClearButtonClosure: (() -> Void)?

  private let searchIconImage = UIImageView().then {
    $0.image = ImageFactory.icnSearch
  }

  private lazy var clearTextButton = UIButton().then {
    $0.setImage(ImageFactory.icnX, for: .normal)
    $0.addTarget(self, action: #selector(didClickOnClearButton(_:)), for: .touchUpInside)
  }

  init() {
    super.init(frame: .zero)
    setTextField()
    setTextFieldElement()
    setTextFieldLayout()
  }

  required init?(coder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }

}

// MARK: - UI & Layout
extension SearchTextField {
  private func setTextField() {
    placeholder = " 칵테일 이름, 재료 이름"
    setPlaceholderAttributes(Color.gray03.getColor(), Pretendard.size13.bold())
    backgroundColor = Color.gray01.getColor()
    font = Pretendard.size13.bold()
    textColor = Color.gray03.getColor()
    tintColor = Color.navy01.getColor()

    layer.borderColor = Color.gray02.getColor().cgColor
    layer.borderWidth = 1
    layer.cornerRadius = 6

    clearButtonMode = .never
    leftViewMode = .always
    rightViewMode = .never

    becomeFirstResponder()
    addTarget(self, action: #selector(textFieldDidChange(_:)), for: .editingChanged)
  }

  private func setTextFieldElement() {
    let rightView = UIView(frame: CGRect(x: 0, y: 0, width: 28, height: 36))
    rightView.addSubview(clearTextButton)
    self.rightView = rightView

    let leftView = UIView(frame: CGRect(x: 0, y: 0, width: 43, height: 36))
    leftView.addSubview(searchIconImage)
    self.leftView = leftView
  }

  private func setTextFieldLayout() {
    clearTextButton.snp.makeConstraints {
      $0.width.height.equalTo(20)
      $0.top.equalToSuperview().inset(8)
      $0.leading.equalToSuperview()
      $0.trailing.equalToSuperview().inset(8)
    }

    searchIconImage.snp.makeConstraints {
      $0.width.height.equalTo(19)
      $0.top.equalToSuperview().inset(9)
      $0.leading.equalToSuperview().inset(16)
      $0.trailing.equalToSuperview().inset(8)
    }
  }
}

// MARK: - Action Functions
extension SearchTextField {
  @objc private func didClickOnClearButton(_ sender: UIButton) {
    self.didClickOnClearButtonClosure?()
  }

  @objc
  private func textFieldDidChange(_ sender: UITextField) {
    self.rightViewMode = self.hasText ? .always : .never
  }
}
