//
//  ExperienceCVC.swift
//  Nobar
//
//  Created by 이유진 on 2022/07/19.
//

import UIKit

final class ExperienceCVC: UICollectionViewCell {
  
  private let experienceTextView = TastingNoteTextView()
  
  override init(frame: CGRect) {
    super.init(frame: frame)
    setLayout()
  }
  
  @available(*, unavailable)
  required init?(coder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }
  
  private func setLayout() {
    addSubview(experienceTextView)
    
    experienceTextView.snp.makeConstraints{
      $0.leading.trailing.equalToSuperview().inset(26)
      $0.top.bottom.equalToSuperview().inset(8)
    }
  }
}
