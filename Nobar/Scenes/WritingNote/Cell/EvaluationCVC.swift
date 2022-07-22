//
//  EvaluationCVC.swift
//  Nobar
//
//  Created by 이유진 on 2022/07/19.
//

import UIKit
import SwiftUI

final class EvaluationCVC: UICollectionViewCell {
  
  private let placeholder = "맛에 대한 주관적인 평가를 들려주세요"
  private let evaluationText = "너무 맛있땅"
  
  private let evaluationTextView = TastingNoteTextView()
  private let characterNumLabel = UILabel().then {
    $0.font = Pretendard.size10.medium()
    $0.textColor = Color.gray03.getColor()
    $0.text = "(0/200자)"
  }
  
  override init(frame: CGRect) {
    super.init(frame: frame)
    setLayout()
    initTextView()
    setDelegate()
    dismissKeyboardWhenTappedAround()
  }
  
  @available(*, unavailable)
  required init?(coder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }
  
  private func initTextView(){
    evaluationTextView.text = placeholder
    evaluationTextView.textColor = Color.gray03.getColor()
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
  
  private func setDelegate(){
      evaluationTextView.delegate = self
  }

}

extension EvaluationCVC: UITextViewDelegate{
    func textViewDidBeginEditing(_ textView: UITextView) {
        if textView.text.isEmpty {
          evaluationTextView.textColor = Color.gray03.getColor()
        }else if textView.text == placeholder {
          evaluationTextView.textColor = Color.black.getColor()
          evaluationTextView.text = nil
        }
        
    }

    func textViewDidEndEditing(_ textView: UITextView) {
        if textView.text.isEmpty {
            evaluationTextView.textColor = Color.gray03.getColor()
          evaluationTextView.text = placeholder
        }
    }
    
    func textViewDidChange(_ textView: UITextView) {
        if evaluationTextView.text.count > 200 {
          evaluationTextView.deleteBackward()
        }
        
        characterNumLabel.text = "(\(evaluationTextView.text.count)/200자)"

    }
  
  func setLayout(for status: WritingStatus){
    switch status{
    case .newWriting,.revising:
      evaluationTextView.isEditable = true
      characterNumLabel.isHidden = false
      
    case .viewing:
      evaluationTextView.isEditable = false
      characterNumLabel.isHidden = true
      evaluationTextView.text = evaluationText
      evaluationTextView.textColor = .black
    }

  }

}
