//
//  ScoreCVC.swift
//  Nobar
//
//  Created by 이유진 on 2022/07/18.
//

import UIKit

final class ScoreCVC: UICollectionViewCell {
  var score = 5.0
  
  var scoreClosure: ((Double) -> Void)?
  private let heartSlider = HeartRatingUISlider().then {
    $0.minimumValue = 0
    $0.maximumValue = 5
    $0.value = 0.5
    $0.minimumTrackTintColor = .clear
    $0.maximumTrackTintColor = .clear
    $0.thumbTintColor = .clear
  }
  
  private var heartImageViews: [UIImageView] = []
  
  private var heartStackView = UIStackView().then{
    $0.axis = .horizontal
    $0.distribution = .fillEqually
    $0.spacing = 21
  }
  
  override init(frame: CGRect) {
    super.init(frame: frame)
    render()
    initStackView()

  }
  
  @available(*, unavailable)
  required init?(coder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }
  
}

// MARK: - UI & Layout

extension ScoreCVC {
  
  private func render() {
    addSubviews([heartStackView,heartSlider])
    heartStackView.snp.makeConstraints{
      $0.centerX.centerY.equalToSuperview()
      $0.height.equalTo(42)
    }
    heartSlider.snp.makeConstraints{
      $0.leading.trailing.equalTo(heartStackView)
      $0.centerY.equalToSuperview()
    }
    
  }
  
  private func initStackView() {
    
    for i in 0..<5 {
      let imageView = UIImageView(image:ImageFactory.btnScoreEmpty)
      heartStackView.addArrangedSubview(imageView)
      
    }
  }
  

  private func addSliderGesture() {
    heartSlider.addTarget(self, action: #selector(slideHeartSlider), for: UIControl.Event.valueChanged)
  }
  
  private func deleteSliderGesture() {
    heartSlider.removeTarget(self, action: #selector(slideHeartSlider), for: UIControl.Event.valueChanged)
  }

  @objc func slideHeartSlider(){
    var value = heartSlider.value
    score = Double(value)

    switch value{
    case 0..<0.5: score = 0.5
    case 0.5..<1: score = 1.0
    case 1..<1.5: score = 1.5
    case 1.5..<2: score = 2.0
    case 2..<2.5: score = 2.5
    case 2.5..<3: score = 3.0
    case 3..<3.5: score = 3.5
    case 3.5..<4: score = 4.0
    case 4..<4.5: score = 4.5
    case 4.5...5: score = 5.0
    default: score = 0.0
    }
    print(score)
    scoreClosure?(score)
    
    for idx in 0..<5 {
      if value > 0.5 {
        value -= 1
        let imageView = heartStackView.subviews[idx] as? UIImageView ?? UIImageView()
        imageView.image = ImageFactory.btnScoreFill
      } else if 0 < value && value < 0.5 {
        value -= 0.5
        let imageView = heartStackView.subviews[idx] as? UIImageView ?? UIImageView()
        imageView.image = ImageFactory.btnScoreHalf
      }else {
        let imageView = heartStackView.subviews[idx] as? UIImageView ?? UIImageView()
        imageView.image = ImageFactory.btnScoreEmpty
      }

    }

  }
  
  func setLayout(for status: WritingStatus){
    switch status{
    case .newWriting,.revising: heartSlider.isHidden = false
      addSliderGesture()
    case .viewing: heartSlider.isHidden = true
      setHeartScore(score: score)
      deleteSliderGesture()
    }

  }
  
  //TODO:
  func setHeartScore(score: Double){
    var value = score
    for idx in 0..<5 {
      if value > 0.5 {
        value -= 1
        let imageView = heartStackView.subviews[idx] as? UIImageView ?? UIImageView()
        imageView.image = ImageFactory.btnScoreFill
      } else if 0 < value && value <= 0.5 {
        value -= 0.5
        let imageView = heartStackView.subviews[idx] as? UIImageView ?? UIImageView()
        imageView.image = ImageFactory.btnScoreHalf
      }else {
        let imageView = heartStackView.subviews[idx] as? UIImageView ?? UIImageView()
        imageView.image = ImageFactory.btnScoreEmpty
      }

    }
  }
}


