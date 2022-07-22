//
//  SearchAutoResultCollectionViewCell.swift
//  Nobar
//
//  Created by 김수연 on 2022/07/14.
//

import UIKit

import Then
import SnapKit

final class SearchAutoResultCollectionViewCell: UICollectionViewCell {

  private let autoResultLabel = UILabel().then {
    $0.text = "자동완성 검색결과"
    $0.textColor = Color.black.getColor()
    $0.font = Pretendard.size15.regular()
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
    autoResultLabel.text = ""
  }
}

// MARK: - UI & Layout
extension SearchAutoResultCollectionViewCell {
  private func render() {
    addSubviews([autoResultLabel])

    autoResultLabel.snp.makeConstraints {
      $0.leading.equalToSuperview().inset(26)
      $0.top.bottom.equalToSuperview().inset(16)
    }
  }

  func updateResult(_ result: String) {
    autoResultLabel.text = result
  }

  func updateIngredientResult(_ result: Ingredient) {
    autoResultLabel.text = result.name
  }

  func updateAttributedText(_ keyword: String) {
    autoResultLabel.applyFont(to: keyword, with: Pretendard.size15.bold())
  }
}
