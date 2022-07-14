//
//  RecommendCollectionViewCell.swift
//  Nobar
//
//  Created by 김수연 on 2022/07/12.
//

import UIKit

import Then
import SnapKit

final class RecommendCollectionViewCell: UICollectionViewCell {

  private let numberLabel = UILabel().then {
    $0.text = "1"
    $0.textColor = Color.black.getColor()
    $0.font = Pretendard.size15.regular()
  }

  private let keywordLabel = UILabel().then {
    $0.text = "추천 검색어 어쩌구"
    $0.textColor = Color.black.getColor()
    $0.font = Pretendard.size15.regular()
  }

  private let upImageView = UIImageView().then {
    $0.image = ImageFactory.icnUp
  }
  
  override init(frame: CGRect) {
    super.init(frame: frame)
    render()
  }

  @available(*, unavailable)
  required init?(coder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }

  override func prepareForReuse() {
    keywordLabel.text = ""
  }
}

// MARK: - UI & Layout
extension RecommendCollectionViewCell {
  private func render() {
    addSubviews([numberLabel, keywordLabel, upImageView])

    numberLabel.snp.makeConstraints {
      $0.leading.equalToSuperview()
      $0.top.bottom.equalToSuperview().inset(16)
    }

    keywordLabel.snp.makeConstraints {
      $0.leading.equalTo(numberLabel.snp.trailing).offset(16)
      $0.top.bottom.equalToSuperview().inset(16)
    }

    upImageView.snp.makeConstraints {
      $0.width.equalTo(22)
      $0.height.equalTo(24)
      $0.top.equalToSuperview().inset(13)
      $0.trailing.equalToSuperview().inset(21)
    }
  }

  func update(data: SearchModel) {
    numberLabel.text = "\(data.order)"
    keywordLabel.text = data.recommendKeyword
  }
}
