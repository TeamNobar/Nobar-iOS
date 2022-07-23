//
//  SelectDateCVC.swift
//  Nobar
//
//  Created by 이유진 on 2022/07/19.
//

import UIKit

final class SelectDateCVC: UICollectionViewCell {
  
  var dateClosure: ((String) -> ())?
  var selectedDate = Date()
  private let grayView = UIView().then {
    $0.backgroundColor = Color.gray01.getColor()
    $0.layer.cornerRadius = 5
    
  }
  
  private let selectedDateLabel = UILabel().then {
    $0.textColor = Color.black.getColor()
    $0.font = Pretendard.size13.semibold()
  }
  
  private lazy var datePicker = UIDatePicker().then {
    $0.tintColor = Color.pink01.getColor()
    $0.datePickerMode = .date
    $0.locale = Locale(identifier: "ko_KR")
    $0.addTarget(self, action: #selector(valueChangedDatePicker(_:)), for: .valueChanged)
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
  
  private func setDayLabel() {
    let formatter = DateFormatter()
    formatter.dateFormat = "YYYY년 M월 d일"
    formatter.locale = Locale(identifier: "ko_KR")
    formatter.timeZone = NSTimeZone(name: "ko_KR") as TimeZone?
    
    let dateText = formatter.string(from: selectedDate)
    
    selectedDateLabel.text = dateText
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
      setDayLabel()
    }

  }
  
  @objc func valueChangedDatePicker(_ sender: UIDatePicker) {
    selectedDate = sender.date
    let dateFormatter = DateFormatter().then {
      $0.dateFormat = "yyyy-MM-dd"
      $0.locale = Locale(identifier: "ko_KR")
      $0.timeZone = NSTimeZone(name: "ko_KR") as TimeZone?
    }
    dateClosure?(dateFormatter.string(from: sender.date))
    print(selectedDate)
  }
  
}

