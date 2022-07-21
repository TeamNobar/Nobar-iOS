//
//  SelectDateCVC.swift
//  Nobar
//
//  Created by 이유진 on 2022/07/19.
//

import UIKit

final class SelectDateCVC: UICollectionViewCell {
  
  private let selectedDate = "2022년 3월 2일"
  
  private let grayView = UIView().then {
    $0.backgroundColor = Color.gray01.getColor()
    $0.layer.cornerRadius = 5
    
  }
  
  private let selectedDateLabel = UILabel().then {
    $0.textColor = Color.black.getColor()
    $0.font = Pretendard.size13.semibold()
  }
  
  private let datePicker = UIDatePicker().then {
    $0.tintColor = Color.pink01.getColor()
    $0.datePickerMode = .date
    $0.locale = Locale(identifier: "ko_KR")

    
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
  
    addSubviews([grayView,datePicker])
    grayView.addSubview(selectedDateLabel)
    
    grayView.snp.makeConstraints {
      $0.leading.trailing.equalToSuperview().inset(26)
      $0.height.equalTo(42)
    }
    selectedDateLabel.snp.makeConstraints{
      $0.leading.equalToSuperview().offset(13)
      $0.centerY.equalToSuperview()
    }
    datePicker.snp.makeConstraints{
//      $0.leading.equalToSuperview().offset(10)
      $0.centerX.equalToSuperview()
      $0.centerY.equalToSuperview()
      $0.height.equalTo(40)
    }
    
  }
  
 func setLayout(for status: WritingStatus){
    switch status{
    case .newWriting,.revising:
      datePicker.isHidden = false
      grayView.isHidden = true
      selectedDateLabel.isHidden = true
    case .viewing:
      datePicker.isHidden = true
      grayView.isHidden = false
      selectedDateLabel.isHidden = false
      selectedDateLabel.text = selectedDate
    }

  }
}

