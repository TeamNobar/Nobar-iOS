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
    $0.font = Pretendard.size17.bold()
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
    addSubview(titleLabel)
    titleLabel.snp.makeConstraints {
      $0.leading.equalToSuperview().offset(20)
      $0.centerY.equalToSuperview()
    }
  }

  private func configUI() {
    backgroundColor = Color.navy01.getColor()
    layer.cornerRadius = 2
  }
  
  func setData(data: RecommendModel){
    titleLabel.text = data.title
    backgroundColor = UIColor(hex: data.color)
  }
  
}
