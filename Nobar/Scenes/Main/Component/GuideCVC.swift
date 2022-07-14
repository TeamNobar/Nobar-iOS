//
//  GuideCVC.swift
//  Nobar
//
//  Created by 이유진 on 2022/07/14.
//

import UIKit

import Then
import SnapKit

final class GuideCVC: UICollectionViewCell {
  
  private let thumbnailImageView = UIImageView()
  
  private let titleLabel = UILabel().then {
    $0.textColor = Color.black.getColor()
    $0.font = Pretendard.size13.bold()
    $0.lineBreakMode = .byWordWrapping
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
    titleLabel.text = ""
  }

  private func render() {
    addSubviews([
    thumbnailImageView,
    titleLabel
    ])
    thumbnailImageView.snp.makeConstraints {
      $0.top.leading.trailing.equalToSuperview().inset(12)
      $0.height.equalTo(74)
      
    }
    titleLabel.snp.makeConstraints{
      $0.top.equalTo(thumbnailImageView.snp.bottom).offset(8)
      $0.leading.trailing.equalTo(thumbnailImageView.snp.leading)
    }
  }

  private func configUI() {
    backgroundColor = Color.gray01.getColor()
    layer.cornerRadius = 2
    layer.applyShadow(alpha: 0.5, x: 1, y: 1, blur: 2, spread: 0)
  }
  
  private func setData(data: GuideModel){
    thumbnailImageView.image = UIImage(named: data.thumbnailImageName)
    titleLabel.text = data.titleName
  }

}
