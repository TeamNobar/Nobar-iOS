//
//  SettingDetailView.swift
//  Nobar
//
//  Created by 김수연 on 2022/07/21.
//

import UIKit

import Then
import SnapKit

enum SettingDetailType {
  case inquiry
  case terms
  case library
  case resign
}

protocol TapSettingViewDelegate: AnyObject {
  func presentViewController(type: SettingDetailType)
}

final class SettingDetailView: UIView {

  private var type: SettingDetailType
  weak var tapDelegate: TapSettingViewDelegate?

  private let titleLabel = UILabel().then {
    $0.textColor = Color.black.getColor()
    $0.font = Pretendard.size15.regular()
  }

  init(frame: CGRect = .zero, type: SettingDetailType) {
    self.type = type
    super.init(frame: frame)
    render()
    configUI()
    setGesture()
  }

  required init?(coder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }
}

// MARK: - UI & Layout
extension SettingDetailView {
  private func render() {
    addSubviews([titleLabel])
    titleLabel.snp.makeConstraints {
      $0.top.equalToSuperview().inset(16)
      $0.leading.equalToSuperview().inset(26)
    }
  }

  private func configUI() {
    backgroundColor = Color.white.withAlphaColor(alpha: 0.0)
    switch type {
    case .inquiry:
      titleLabel.text = "문의하기"
    case .terms:
      titleLabel.text = "약관 및 정책"
    case .library:
      titleLabel.text = "오픈소스 라이브러리"
    case .resign:
      titleLabel.text = "회원 탈퇴"
    }
  }

  private func setGesture() {
    let tapPressRecognizer = UITapGestureRecognizer(target: self,
                                                    action: #selector(handleTapGesture(_:)))
    self.addGestureRecognizer(tapPressRecognizer)
  }

  @objc func handleTapGesture(_ sender: UITapGestureRecognizer) {
    tapDelegate?.presentViewController(type: self.type)
  }
}
