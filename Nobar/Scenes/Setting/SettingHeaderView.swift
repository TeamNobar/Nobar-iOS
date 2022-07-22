//
//  SettingHeaderView.swift
//  Nobar
//
//  Created by 김수연 on 2022/07/21.
//

import UIKit

import Then
import SnapKit

final class SettingHeaderView: UIView {

  enum SettingHeaderType {
    case center
    case service
  }

  private var type: SettingHeaderType

  private let headerTitleLabel = UILabel().then {
    $0.textColor = Color.pink01.getColor()
    $0.font = Pretendard.size17.semibold()
  }

  private let headerUnderline = UIView().then {
    $0.backgroundColor = Color.gray02.getColor()
    $0.layer.applyShadow(color: Color.black.getColor(), alpha: 0.05, x: 1, y: 1, blur: 2, spread: 0)
  }

  init(frame: CGRect = .zero,type: SettingHeaderType) {
    self.type = type
    super.init(frame: frame)
    render()
    configUI()
  }

  required init?(coder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }
}

// MARK: - UI & Layout
extension SettingHeaderView {
  private func render() {
    addSubviews([headerTitleLabel, headerUnderline])
    headerTitleLabel.snp.makeConstraints {
      $0.top.equalToSuperview().inset(15)
      $0.leading.equalToSuperview().inset(26)
    }

    headerUnderline.snp.makeConstraints {
      $0.leading.trailing.bottom.equalToSuperview()
      $0.height.equalTo(1)
    }
  }

  func configUI() {
    switch type {
    case .center:
      headerTitleLabel.text = "고객센터"
    case .service:
      headerTitleLabel.text = "서비스"
    }
  }
}
