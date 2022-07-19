//
//  EvaluationCVC.swift
//  Nobar
//
//  Created by 이유진 on 2022/07/19.
//

import UIKit

final class EvaluationCVC: UICollectionViewCell {
  
  private let evaluationTextView = TastingNoteTextView()
  
  private let characterNumLabel = UILabel().then {
    $0.font = Pretendard.size10.medium()
    $0.textColor = Color.gray03.getColor()
    $0.text = "(0/200자)"
  }
  
  override init(frame: CGRect) {
    super.init(frame: frame)
    setLayout()
  }
  
  @available(*, unavailable)
  required init?(coder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }
  
  private func setLayout() {
    addSubviews([evaluationTextView,
                 characterNumLabel])
    
    evaluationTextView.snp.makeConstraints{
      $0.leading.trailing.equalToSuperview().inset(26)
      $0.top.bottom.equalToSuperview().inset(8)
    }
    //TODO: 텍스트뷰 서브뷰로 넣고 싶은데 레이아웃이 이상하게 잡혀서 나중에 고치기
    characterNumLabel.snp.makeConstraints{
      $0.bottom.equalToSuperview().inset(20)
      $0.trailing.equalToSuperview().inset(40)
    }
  }
}
