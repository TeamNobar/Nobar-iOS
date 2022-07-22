//
//  TastingNoteAddNewButtonView.swift
//  Nobar
//
//  Created by Ian on 2022/07/22.
//

import UIKit

final class TastingNoteAddNewButtonView: BaseView {
  private enum Metric {
    static let contentLeadingTrailing = 26.f
    static let contentTop = 16.f
    static let contentBottom = 20.f
    static let contentHeight = 45.f
  }
  
  private let contentView = UIView().then {
    $0.backgroundColor = Color.skyblue01.getColor()
    $0.layer.cornerRadius = 10.f
    $0.layer.applyShadow()
  }
  
  private let containerStackView = UIStackView().then {
    $0.axis = .horizontal
    $0.spacing = 2.f
  }
  
  private let plusIconImage = UIImageView().then {
    $0.image = ImageFactory.btn_plusnote
  }
  
  private let plusIndicateLabel = UILabel().then {
    $0.font = Pretendard.size14.medium()
    $0.textColor = Color.gray03.getColor()
    $0.text = "새로운 노트 작성하기"
  }
  
  override func initialize() {
    super.initialize()
    
    addSubview(contentView)
    
    contentView.addSubview(containerStackView)
    containerStackView.addArrangedSubviews([
      plusIconImage,
      plusIndicateLabel
    ])
  }
  
  override func setLayouts() {
    super.setLayouts()
    
    contentView.snp.makeConstraints {
      $0.leading.trailing.equalToSuperview().inset(Metric.contentLeadingTrailing)
      $0.top.equalToSuperview().inset(Metric.contentTop)
      $0.bottom.equalToSuperview().inset(Metric.contentBottom)
      $0.height.equalTo(Metric.contentHeight)
    }
    
    containerStackView.snp.makeConstraints {
      $0.center.equalToSuperview()
      $0.height.equalTo(21.f)
    }
    
    plusIconImage.snp.makeConstraints {
      $0.size.equalTo(21.f)
    }
  }
}
