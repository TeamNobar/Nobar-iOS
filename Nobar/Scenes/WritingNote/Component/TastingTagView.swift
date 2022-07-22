//
//  TastingTagView.swift
//  Nobar
//
//  Created by 이유진 on 2022/07/18.
//

import UIKit
import Kingfisher

final class TastingTagView: UIView {
  
  private var tastePhrase = "맛이 좋아요"
  
  var isSelected: Bool = false{
    willSet(newValue){
      switch newValue{
        case true:
        layoutSelectedTag()
        case false:
        layoutUnselectedTag()
      }
    }
  }

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
    
    layoutUnselectedTag()
    
    self.snp.makeConstraints({
      $0.width.equalTo(102)
      $0.height.equalTo(40)
    })
    
    iconImageView.snp.makeConstraints{
      $0.centerX.equalToSuperview().offset(-33)
      $0.centerY.equalToSuperview()
    }
    
    tasteLabel.snp.makeConstraints{
      $0.leading.equalTo(iconImageView.snp.trailing).offset(6)
      $0.centerY.equalToSuperview()
    }
    
  }
  public func setData(with data: TastingTag){
    self.tasteLabel.text = data.content
    if let url = URL(string: data.inActiveIcon){
      self.iconImageView.kf.setImage(with: url)
    }
   
  }
  
  private func layoutSelectedTag(){
    layer.cornerRadius = 20
    layer.borderWidth = 1
    backgroundColor = Color.pink01.getColor().withAlphaComponent(0.15)
    layer.borderColor = Color.pink01.getColor().cgColor
    tasteLabel.textColor = Color.pink01.getColor()
  }
  
  private func layoutUnselectedTag(){
    layer.cornerRadius = 20
    layer.borderWidth = 1
    backgroundColor = Color.gray01.getColor()
    layer.borderColor = Color.gray02.getColor().cgColor
    tasteLabel.textColor = Color.black.getColor()
  }
}


