//
//  ExperienceCVC.swift
//  Nobar
//
//  Created by 이유진 on 2022/07/19.
//

import UIKit

final class ExperienceCVC: UICollectionViewCell {
  
  private let placeholder = "칵테일을 만들고 마셨던 경험을 자유롭게 기록해주세요"
  
  private let experienceTextView = TastingNoteTextView()
  
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
  }
  
  @available(*, unavailable)
  required init?(coder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }
  
  private func initTextView(){
    experienceTextView.text = placeholder
    experienceTextView.textColor = Color.gray03.getColor()
  }
  
  private func setLayout() {
    addSubviews([experienceTextView,
                 characterNumLabel])
    
    experienceTextView.snp.makeConstraints{
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
      experienceTextView.delegate = self
  }
}

extension ExperienceCVC: UITextViewDelegate{
    func textViewDidBeginEditing(_ textView: UITextView) {
        if textView.text.isEmpty {
          experienceTextView.textColor = Color.gray03.getColor()
        }else if textView.text == placeholder {
          experienceTextView.textColor = Color.black.getColor()
          experienceTextView.text = nil
        }
        
    }
    
    func textViewDidEndEditing(_ textView: UITextView) {
        if textView.text.isEmpty {
          experienceTextView.textColor = Color.gray03.getColor()
          experienceTextView.text = placeholder
        }
    }
    
    func textViewDidChange(_ textView: UITextView) {
        if experienceTextView.text.count > 200 {
          experienceTextView.deleteBackward()
        }
        characterNumLabel.text = "(\(experienceTextView.text.count)/200자)"
    }
}

