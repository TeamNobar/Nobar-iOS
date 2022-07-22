//
//  TastingNoteDividerView.swift
//  Nobar
//
//  Created by Ian on 2022/07/21.
//

import UIKit

final class TastingNoteDividerView: BaseView {
  private enum Metric {
    static let dateDividerContentSpacing = 20.f
    static let dividerHeight = 0.4.f
  }
  
  private lazy var dateDividerStackView = UIStackView().then {
    $0.axis = .horizontal
    $0.alignment = .center
    $0.spacing = Metric.dateDividerContentSpacing
  }
  
  private let dateLeftDivider = UIView().then {
    $0.backgroundColor = Color.gray03.getColor()
  }
  
  private let dateRightDivider = UIView().then {
    $0.backgroundColor = Color.gray03.getColor()
  }
  
  private let dateDividerLabel = UILabel().then {
    $0.textColor = Color.gray03.getColor()
    $0.font = Pretendard.size14.regular()
  }

  override func initialize() {
    super.initialize()
    
    addSubview(dateDividerStackView)
    
    dateDividerStackView.addArrangedSubviews([
      dateLeftDivider,
      dateDividerLabel,
      dateRightDivider
    ])
  }
  
  override func setLayouts() {
    super.setLayouts()
    
    dateLeftDivider.snp.makeConstraints {
      $0.height.equalTo(Metric.dividerHeight)
    }
    
    dateRightDivider.snp.makeConstraints {
      $0.height.equalTo(Metric.dividerHeight)
    }
    
    dateDividerStackView.snp.makeConstraints {
      $0.width.equalTo(UIScreen.main.bounds.width)
      $0.edges.equalToSuperview()
    }
    
    dateDividerLabel.snp.makeConstraints {
      $0.center.equalToSuperview()
    }
  }
}

extension TastingNoteDividerView {
  func updateDateString(to dateString: String) {
    dateDividerLabel.text = dateString
  }
}
