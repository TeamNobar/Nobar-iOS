//
//  MyPageNavigationView.swift
//  Nobar
//
//  Created by Ian on 2022/07/18.
//

import UIKit

final class MyPageNavigationView: BaseView {
  private lazy var titleLabel = UILabel().then {
    $0.text = self.nickName
    $0.font = Pretendard.size18.extraBold()
    $0.textColor = Color.navy01.getColor()
  }

  private let containerView = UIView()
  private let nickName: String
  
  init(nickName: String) {
    self.nickName = nickName
    super.init(frame: .zero)
  }
  
  required init?(coder aDecoder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }
  
  override func initialize() {
    super.initialize()

    addSubview(containerView)
    containerView.addSubview(titleLabel)
  }

  override func setLayouts() {
    super.setLayouts()

    containerView.snp.makeConstraints {
      $0.width.equalTo(UIScreen.main.bounds.width)
      $0.leading.trailing.equalToSuperview()
      $0.top.bottom.lessThanOrEqualToSuperview()
      $0.height.greaterThanOrEqualTo(44.f)
    }

    titleLabel.snp.makeConstraints {
      $0.centerY.equalToSuperview()
      $0.leading.equalToSuperview().inset(16.f)
    }
  }
}
