//
//  CustomAlert.swift
//  Nobar
//
//  Created by 김수연 on 2022/07/20.
//

import UIKit

import SnapKit
import Then

final class CustomAlert : BaseViewController {

  private let containerView = UIView().then {
    $0.backgroundColor = Color.white.getColor()
    $0.layer.cornerRadius = 10
  }

  var alertTitleLabel = UILabel().then {
    $0.textColor = Color.black.getColor()
    $0.font = Pretendard.size15.bold()
    $0.sizeToFit()
  }

  lazy var cancleButton = UIButton().then {
    $0.setTitle("취소하기", for: .normal)
    $0.setTitleColor(Color.gray03.getColor(), for: .normal)
    $0.titleLabel?.font = Pretendard.size14.semibold()
    $0.backgroundColor = Color.white.getColor()
    $0.layer.borderColor = Color.gray02.getColor().cgColor

    $0.layer.borderWidth = 1
    $0.layer.cornerRadius = 20
    $0.addTarget(self, action: #selector(didClickOnCancleButton(_:)), for: .touchUpInside)
  }

  lazy var confirmButton = UIButton().then {
    $0.setTitle("삭제하기", for: .normal)
    $0.setTitleColor(Color.white.getColor(), for: .normal)
    $0.titleLabel?.font = Pretendard.size14.semibold()
    $0.backgroundColor = Color.pink01.getColor()
    $0.layer.cornerRadius = 20
  }

  override func viewDidLoad() {
    super.viewDidLoad()
    render()
    configUI()
  }

  override func setupConstraints() {
    super.setupConstraints()
    setLayout()
  }
}

// MARK: - UI & Layout
extension CustomAlert {
  private func render() {
    view.addSubview(containerView)
    containerView.addSubviews([alertTitleLabel, cancleButton, confirmButton])
  }

  private func configUI() {
    view.backgroundColor = Color.black.withAlphaColor(alpha: 0.2)
  }

  private func setLayout() {
    containerView.snp.makeConstraints {
      $0.width.equalTo(250.adjustedW)
      $0.height.equalTo(188)
      $0.center.equalToSuperview()
    }

    alertTitleLabel.snp.makeConstraints {
      $0.top.equalToSuperview().inset(24)
      $0.centerX.equalToSuperview()
    }

    cancleButton.snp.makeConstraints {
      $0.top.equalTo(alertTitleLabel.snp.bottom).offset(24)
      $0.leading.trailing.equalToSuperview().inset(34)
      $0.height.equalTo(40)
    }

    confirmButton.snp.makeConstraints {
      $0.top.equalTo(cancleButton.snp.bottom).offset(18)
      $0.leading.trailing.equalToSuperview().inset(34)
      $0.bottom.equalToSuperview().inset(24)
      $0.height.equalTo(40)
    }
  }
}

extension CustomAlert {

  @objc func didClickOnCancleButton(_ sender: UIButton) {
    self.dismiss(animated: true)
  }

  func showCustomAlert(viewController: UIViewController,
                       title: String,
                       cancleBtnTitle: String,
                       confirmBtnTitle: String,
                       confirmAction: UIAction) {
    alertTitleLabel.text = title
    cancleButton.setTitle(cancleBtnTitle, for: .normal)
    confirmButton.setTitle(confirmBtnTitle, for: .normal)
    confirmButton.addAction(confirmAction, for: .touchUpInside)

    self.modalPresentationStyle = .overFullScreen
    self.modalTransitionStyle = .crossDissolve
    viewController.present(self, animated: true, completion: nil)
  }
}
