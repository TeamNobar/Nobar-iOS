//
//  TastingNoteTextView.swift
//  Nobar
//
//  Created by 이유진 on 2022/07/19.
//

import UIKit

final class TastingNoteTextView: UITextView {
  
  enum TextViewType {
    case evaluation
    case experience
  }
  
  private let characterNumLabel = UILabel().then {
    $0.font = Pretendard.size10.medium()
    $0.textColor = Color.gray03.getColor()
    $0.text = "(0/200자)"
  }
  
  override init(frame: CGRect, textContainer: NSTextContainer?) {
    super.init(frame: frame, textContainer: textContainer)
  }
  
  @available(*, unavailable)
  required init?(coder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }
  
  private func setLayout() {
    layer.borderWidth = 1
    layer.borderColor = Color.gray02.getColor().cgColor
    layer.cornerRadius = 10
    contentInset = UIEdgeInsets(top: 16, left: 16, bottom: 16, right: 16)
    font = Pretendard.size14.medium()
    
    addSubview(characterNumLabel)
    characterNumLabel.snp.makeConstraints{
      $0.bottom.trailing.equalToSuperview().inset(8)
    }
  }
}
