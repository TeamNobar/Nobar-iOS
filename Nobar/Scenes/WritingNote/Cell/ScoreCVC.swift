//
//  ScoreCVC.swift
//  Nobar
//
//  Created by 이유진 on 2022/07/18.
//

import UIKit

final class ScoreCVC: UICollectionViewCell {
  
  private let slider = UISlider()
  
  private var heartImageViews: [UIImageView] = []
  
  private var heartStackView = UIStackView().then{
    $0.axis = .horizontal
    $0.spacing = 21
  }
  
  override init(frame: CGRect) {
    super.init(frame: frame)
  }
  
  @available(*, unavailable)
  required init?(coder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }
  
}

// MARK: - UI & Layout

extension ScoreCVC {
  
  private func render() {
    addSubview(heartStackView)
    
  }
  
  private func initStackView() {
    
    for i in 0..<5 {
      let imageView = UIImageView(image:ImageFactory.btnScoreFill)
      heartStackView.addArrangedSubview(imageView)
    }
  }
  
}


