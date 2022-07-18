//
//  TastingTagView.swift
//  Nobar
//
//  Created by 이유진 on 2022/07/18.
//

import UIKit

final class TastingTagView: UIView {
  
  private var tastePhrase = "맛이 좋아요"

  private let iconImageView = UIImageView().then{
    $0.image = ImageFactory.tagIconGray
  }
  
  private let tasteLabel = UILabel().then {
    $0.textColor = Color.black.getColor()
    $0.font = Pretendard.size13.bold()
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
    addSubviews([iconImageView,tasteLabel])
    
    backgroundColor = Color.gray01.getColor()
    layer.cornerRadius = 100
    tasteLabel.text = tastePhrase
    
    self.snp.makeConstraints({
      $0.width.equalTo(102)
      $0.height.equalTo(40)
    })
    
    iconImageView.snp.makeConstraints{
      $0.centerX.equalToSuperview().offset(-40)
      $0.centerY.equalToSuperview()
    }
    
    tasteLabel.snp.makeConstraints{
      $0.leading.equalTo(iconImageView.snp.trailing).offset(6)
      $0.centerY.equalToSuperview()
    }
    
  }
  func setTasteLabel(with phrase: String){
    self.tasteLabel.text = phrase
    self.tastePhrase = phrase
  }
  
}


