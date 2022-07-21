//
//  ScoreCVC.swift
//  Nobar
//
//  Created by 이유진 on 2022/07/18.
//

import UIKit

final class ScoreCVC: UICollectionViewCell {
  private let score = 4.5
  
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
    initSlider()
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

  private func initSlider() {
    heartSlider.addTarget(self, action: #selector(slideHeartSlider), for: UIControl.Event.valueChanged)
  }

  @objc func slideHeartSlider(){
    var value = heartSlider.value
    
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
    case .viewing: heartSlider.isHidden = true
      setHeartScore(score: score)
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
  
}


