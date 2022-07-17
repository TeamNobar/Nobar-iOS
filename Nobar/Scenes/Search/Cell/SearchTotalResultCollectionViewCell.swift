//
//  SearchCardResultCollectionViewCell.swift
//  Nobar
//
//  Created by 김수연 on 2022/07/16.
//

import UIKit

import Then
import SnapKit

final class SearchTotalResultCollectionViewCell: UICollectionViewCell {

  private let cocktailLabel = UILabel().then {
    $0.textColor = Color.black.getColor()
    $0.font = Pretendard.size13.bold()
  }

  private let cocktailEngLabel = UILabel().then {
    $0.textColor = Color.gray04.getColor()
    $0.font = Pretendard.size10.light()
  }

  private let infoStackView = UIStackView().then {
    $0.axis = .horizontal
    $0.spacing = 2
    $0.alignment = .leading
    $0.distribution = .equalSpacing
  }

  private let baseTagView = RecipeInfoTagView(frame: CGRect(), type: .base)
  private let percentTagView = RecipeInfoTagView(frame: CGRect(), type: .percent)
  private let skillTagView = RecipeInfoTagView(frame: CGRect(), type: .skill)
  private let kindTagView = RecipeInfoTagView(frame: CGRect(), type: .kind)

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
    cocktailLabel.text = ""
    cocktailEngLabel.text = ""
  }
}

// MARK: - UI & Layout
extension SearchTotalResultCollectionViewCell {
  private func render() {
    addSubviews([cocktailLabel, cocktailEngLabel, infoStackView])
    cocktailLabel.snp.makeConstraints {
      $0.top.equalToSuperview().inset(8)
      $0.leading.equalToSuperview().inset(6)
    }

    cocktailEngLabel.snp.makeConstraints {
      $0.top.equalTo(cocktailLabel.snp.bottom).offset(2)
      $0.leading.equalToSuperview().inset(6)
    }

    infoStackView.snp.makeConstraints {
      $0.top.equalTo(cocktailEngLabel.snp.bottom).offset(13)
      $0.leading.equalToSuperview().inset(6)
      $0.bottom.equalToSuperview().inset(7)
    }
    infoStackView.addArrangedSubviews([baseTagView, percentTagView, skillTagView, kindTagView])
  }

  private func configUI() {
    backgroundColor = Color.skyblue01.getColor()
    layer.cornerRadius = 5
    layer.applyShadow(color: Color.black.getColor(),
                      alpha: 0.05,
                      x: 2,
                      y: 2,
                      blur: 2,
                      spread: 0)
  }

  func updateModel(_ model: CocktailModel) {
    cocktailLabel.text = model.cocktailko
    cocktailEngLabel.text = model.cocktaileng
    baseTagView.tagLabel.text = model.base
    percentTagView.tagLabel.text = "\(model.percent)도"
    skillTagView.tagLabel.text = model.skill
    kindTagView.tagLabel.text = model.kind
  }
}
