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
    $0.numberOfLines = 2
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
    addSubview(titleLabel)
    titleLabel.snp.makeConstraints {
      $0.leading.equalToSuperview().offset(20)
      $0.trailing.equalToSuperview().inset(80)
      $0.centerY.equalToSuperview()
    }
  }

  private func configUI() {
    layer.cornerRadius = 12
  }
  
  func setData(with data: RecommendModel){
    titleLabel.text = data.title
    backgroundColor = UIColor(hex: data.color)
  }
  
}
