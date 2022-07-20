//
//  NicknameViewController.swift
//  Nobar
//
//  Created by 김수연 on 2022/07/20.
//

import UIKit

import Then
import SnapKit

class NicknameViewController: BaseViewController {

  private let titleLabel = UILabel().then {
    $0.text = "닉네임을 정해볼까요?"
    $0.textColor = Color.navy01.getColor()
    $0.font = Pretendard.size20.extraBold()
  }

  private lazy var nicknameTextField = UITextField().then {
    $0.backgroundColor = Color.gray01.getColor()
    $0.font = Pretendard.size16.medium()
    $0.textColor = Color.black.getColor()
    $0.tintColor = Color.navy01.getColor()
    $0.attributedPlaceholder = NSAttributedString(string: "최대 7자까지 입력 가능합니다", attributes: [NSAttributedString.Key.foregroundColor: Color.gray03.getColor(), NSAttributedString.Key.font: Pretendard.size16.medium()])
    $0.layer.cornerRadius = 10
    $0.addLeftPadding(width: 18)
    $0.addRightPadding(width: 18)
    $0.becomeFirstResponder()
    $0.addTarget(self, action: #selector(textFieldDidChange(_:)), for: .editingChanged)
  }

  private let warningImage = UIImageView().then {
    $0.image = ImageFactory.icnWarning
  }

  private let warningLabel = UILabel().then {
    $0.text = "7자 이내로 입력해주세요"
    $0.font = Pretendard.size10.regular()
    $0.sizeToFit()
    $0.textColor = Color.pink01.getColor()
  }

  private lazy var startButton = UIButton().then {
    $0.setTitle("시작하기", for: .normal)
    $0.setTitleColor(Color.white.getColor(), for: .normal)
    $0.setTitleColor(Color.gray03.getColor(), for: .disabled)
    $0.titleLabel?.font = Pretendard.size14.bold()
    $0.layer.cornerRadius = 20
    $0.addTarget(self, action: #selector(didClickOnStartButton(_:)), for: .touchUpInside)
  }


  override func viewDidLoad() {
    super.viewDidLoad()
    render()
    configUI()
    setTextField()
    setStartButton()
  }

  override func setupConstraints() {
    super.setupConstraints()
    setLayout()
  }
}

// MARK: - UI & Layout
extension NicknameViewController {
  private func render() {
    view.addSubviews([titleLabel, nicknameTextField, warningImage, warningLabel, startButton])

    [warningImage, warningLabel].forEach {
      $0.isHidden = true
    }
  }

  private func configUI() {
    view.backgroundColor = Color.white.getColor()
  }

  private func setLayout() {
    titleLabel.snp.makeConstraints {
      $0.top.equalToSuperview().inset(130)
      $0.leading.equalToSuperview().inset(26)
    }

    nicknameTextField.snp.makeConstraints {
      $0.top.equalTo(titleLabel.snp.bottom).offset(20)
      $0.leading.trailing.equalToSuperview().inset(26)
      $0.height.equalTo(42)
    }

    warningImage.snp.makeConstraints {
      $0.height.width.equalTo(15)
      $0.top.equalTo(nicknameTextField.snp.bottom).offset(9)
      $0.leading.equalToSuperview().inset(32)
    }

    warningLabel.snp.makeConstraints {
      $0.centerY.equalTo(warningImage.snp.centerY)
      $0.leading.equalTo(warningImage.snp.trailing).offset(2)
    }

    startButton.snp.makeConstraints {
      $0.top.equalTo(nicknameTextField.snp.bottom).offset(95)
      $0.width.equalTo(171)
      $0.height.equalTo(40)
      $0.centerX.equalToSuperview()
    }
  }
}

// MARK: - Action Function
extension NicknameViewController {
  @objc private func didClickOnStartButton(_ sender: UIButton) {
    let mainViewController = MainViewController()
    let mainNavigationController = UINavigationController(rootViewController: mainViewController)

    mainNavigationController.modalPresentationStyle = .overFullScreen
    mainNavigationController.modalTransitionStyle = .crossDissolve
    self.present(mainNavigationController, animated: true)
  }
}

// MARK: - Private Function
extension NicknameViewController {
  @objc private func textFieldDidChange(_ sender: UITextField) {
    setTextField()
    setStartButton()
    showWarningLabel()
  }

  private func setTextField() {
    nicknameTextField.delegate = self
    nicknameTextField.clearButtonMode = nicknameTextField.isEditing ? .always : .never
    startButton.isEnabled = nicknameTextField.hasText ? true : false
  }

  private func setStartButton() {
    startButton.backgroundColor = startButton.isEnabled ? Color.pink01.getColor() : Color.gray02.getColor()
  }

  private func showWarningLabel() {
    guard let nicknameTextCount = nicknameTextField.text?.count else { return }

    if nicknameTextCount > 6 {
      [warningImage, warningLabel].forEach {
        $0.isHidden = false
      }
    } else {
      [warningImage, warningLabel].forEach {
        $0.isHidden = true
      }
    }
  }
}

// MARK: - TextField Delegate
extension NicknameViewController: UITextFieldDelegate {
  func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
    let maxCategoryTitleLength = 7

    guard let currentText = nicknameTextField.text,
          let stringRange = Range(range, in: currentText) else { return false }

    let updatedText = currentText.replacingCharacters(in: stringRange, with: string)

    return updatedText.count <= maxCategoryTitleLength
  }
}
