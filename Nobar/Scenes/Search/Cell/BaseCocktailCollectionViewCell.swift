//
//  BaseCocktailCollectionViewCell.swift
//  Nobar
//
//  Created by 김수연 on 2022/07/18.
//

import UIKit

import Then
import SnapKit
import Kingfisher

final class BaseCocktailCollectionViewCell: UICollectionViewCell {

  override var isSelected: Bool {
    didSet {
      baseImageView.layer.borderWidth = isSelected ? 2 : 0
      baseImageView.layer.borderColor = isSelected ? Color.pink01.getColor().cgColor : nil
      baseLabel.font = isSelected ? Pretendard.size13.bold() : Pretendard.size13.regular()
      baseLabel.textColor = isSelected ? Color.navy01.getColor() : Color.black.getColor()
    }
  }

  private let baseImageView = UIImageView().then {
    $0.clipsToBounds = true
    $0.layer.cornerRadius = 10
  }

  private let baseLabel = UILabel().then {
    $0.text = "베이스"
    $0.font = Pretendard.size13.regular()
    $0.textColor = Color.black.getColor()
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
    baseImageView.image = nil
    baseLabel.text = ""
  }
}

extension BaseCocktailCollectionViewCell {
  private func render() {
    addSubviews([baseImageView, baseLabel])

    baseImageView.snp.makeConstraints {
      $0.width.height.equalTo(50)
      $0.top.leading.trailing.equalToSuperview()
    }

    baseLabel.snp.makeConstraints {
      $0.top.equalTo(baseImageView.snp.bottom).offset(4)
      $0.centerX.equalToSuperview()
    }
  }

  func updateModel(_ model: BaseRecipe) {
    if let url = URL(string: model.url) {
      baseImageView.kf.setImage(with: url)
    }
    baseLabel.text = model.name
  }
}
