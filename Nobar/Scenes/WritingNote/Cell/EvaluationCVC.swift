//
//  EvaluationCVC.swift
//  Nobar
//
//  Created by 이유진 on 2022/07/19.
//

import UIKit

final class EvaluationCVC: UICollectionViewCell {
  
  private let evaluationTextView = TastingNoteTextView()
  
  override init(frame: CGRect) {
    super.init(frame: frame)
    setLayout()
  }
  
  @available(*, unavailable)
  required init?(coder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }
  
  private func setLayout() {
    addSubview(evaluationTextView)
    
    evaluationTextView.snp.makeConstraints{
      $0.leading.trailing.equalToSuperview().inset(26)
      $0.top.bottom.equalToSuperview().inset(8)
    }
  }
}
