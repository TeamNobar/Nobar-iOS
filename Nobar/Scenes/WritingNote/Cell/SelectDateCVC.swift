//
//  SelectDateCVC.swift
//  Nobar
//
//  Created by 이유진 on 2022/07/19.
//

import UIKit

final class SelectDateCVC: UICollectionViewCell {
  
  private let grayView = UIView().then {
    $0.backgroundColor = Color.gray01.getColor()
  }
  
  private let selectDateLabel = UILabel().then {
    $0.textColor = Color.gray03.getColor()
    $0.font = Pretendard.size13.semibold()
  }
  
  private let datePicker = UIDatePicker().then {
    $0.tintColor = Color.pink01.getColor()
  }
  
  override init(frame: CGRect) {
    super.init(frame: frame)
    render()
  }
  
  @available(*, unavailable)
  required init?(coder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }
    
}

// MARK: - UI & Layout

extension SelectDateCVC {
  
  private func render() {
    addSubview(grayView)
    grayView.addSubviews([selectDateLabel,datePicker])
    
    grayView.snp.makeConstraints {
      $0.leading.trailing.equalToSuperview().inset(26)
      $0.height.equalTo(42)
    }
    selectDateLabel.snp.makeConstraints{
      $0.leading.equalToSuperview().offset(13)
      $0.centerY.equalToSuperview()
    }
    datePicker.snp.makeConstraints{
      $0.leading.trailing.equalToSuperview().offset(40)
      $0.centerY.equalToSuperview()
      $0.height.equalTo(40)
    }
    
  }
  
}

