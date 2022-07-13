//
//  CocktailCVC.swift
//  Nobar
//
//  Created by 이유진 on 2022/07/14.
//

import UIKit

import Then
import SnapKit

class CocktailCVC: UICollectionViewCell {

  private let cocktailNameLabel = UILabel().then {
    $0.textColor = Color.black.getColor()
    $0.font = Pretendard.size16.bold()
  }
  
  private let cocktailEngNameLabel = UILabel().then {
    $0.textColor = Color.gray03.getColor()
    $0.font = Pretendard.size10.light()
  }
  
  private let tagImageView = UIImageView().then {
    $0.image = ImageFactory.icnTag
  }
  
  private let baseLabel = UILabel().then {
    $0.textColor = Color.pink01.getColor()
    $0.font = Pretendard.size13.bold()
  }

  override init(frame: CGRect) {
    super.init(frame: frame)
    render()
    configUI()
  }

  @available(*, unavailable)
  required init?(coder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }

  override func prepareForReuse() {
    cocktailNameLabel.text = ""
    cocktailEngNameLabel.text = ""
    baseLabel.text = ""
  }

  private func render() {
    addSubviews([
    cocktailNameLabel,
    cocktailEngNameLabel,
    baseLabel
    ])
    cocktailNameLabel.snp.makeConstraints {
      $0.top.leading.equalToSuperview().inset(12)
      $0.centerY.equalToSuperview()
    }
    cocktailEngNameLabel.snp.makeConstraints{
      $0.top.equalTo(cocktailNameLabel.snp.bottom).offset(8)
      $0.leading.equalTo(cocktailNameLabel.snp.leading)
    }
    tagImageView.snp.makeConstraints{
      $0.leading.bottom.equalToSuperview().inset(12)
      $0.width.height.equalTo(16)
    }
    baseLabel.snp.makeConstraints{
      $0.leading.equalTo(tagImageView.snp.trailing).offset(6)
      $0.centerY.equalTo(tagImageView)
    }
  }

  private func configUI() {
    backgroundColor = Color.skyblue01.getColor()
    layer.cornerRadius = 10
    self.layer.applyShadow(alpha: 0.05, x: 1.0, y: 1.0, blur: 2.0, spread: 0.0)
  }

}
