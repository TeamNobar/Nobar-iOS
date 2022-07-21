//
//  RecommendCVC.swift
//  Nobar
//
//  Created by 이유진 on 2022/07/14.
//

import UIKit

import Then
import SnapKit

final class RecommendCVC: UICollectionViewCell {
  
  private let titleLabel = UILabel().then {
    $0.textColor = Color.white.getColor()
    $0.font = Pretendard.size14.semibold()
    $0.lineBreakMode = .byWordWrapping
    $0.numberOfLines = 2
  }
  private let subTitleLabel = UILabel().then {
    $0.textColor = Color.skyblue02.getColor()
    $0.font = Pretendard.size10.medium()
    $0.text = "자세히 보기"
  }
  private let thumbImage = UIImageView().then {
    $0.image = ImageFactory.dummy1
    $0.layer.cornerRadius = 12
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

}

// MARK: - UI & Layout

extension RecommendCVC {
  
  private func render() {
    addSubviews([titleLabel,subTitleLabel,thumbImage])
    titleLabel.snp.makeConstraints {
      $0.leading.equalToSuperview().offset(20)
      $0.centerY.equalToSuperview().offset(-7)
      $0.width.equalTo(150)
     
    }
    subTitleLabel.snp.makeConstraints{
      $0.top.equalTo(titleLabel.snp.bottom)
      $0.leading.equalTo(titleLabel)
    }
    thumbImage.snp.makeConstraints{
      $0.top.bottom.trailing.equalToSuperview()
      $0.width.equalTo(80)
    }
                 
  }

  private func configUI() {
    layer.cornerRadius = 12
  }
  
  func setData(with data: RecommendModel){
    titleLabel.text = data.title
    backgroundColor = UIColor(hex: data.color)
    thumbImage.image = UIImage(named: data.imageName)
  }
  
}
