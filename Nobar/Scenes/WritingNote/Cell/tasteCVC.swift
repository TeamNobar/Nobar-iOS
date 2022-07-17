//
//  tasteCVC.swift
//  Nobar
//
//  Created by 이유진 on 2022/07/18.
//

import UIKit

class tasteCVC: UICollectionViewCell {
  private let stackView = UIStackView().then{
    $0.backgroundColor = .red
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

extension tasteCVC {
  
  private func render() {
    addSubview(stackView)
    
    stackView.snp.makeConstraints {
      $0.centerX.centerY.equalToSuperview()
    }
    
  }
  
}


