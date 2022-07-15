//
//  RecentKeywordCollectionViewCell.swift
//  Nobar
//
//  Created by 김수연 on 2022/07/12.
//

import UIKit

import Then
import SnapKit

final class RecentCollectionViewCell: UICollectionViewCell {

  private let keywordLabel = UILabel().then {
    $0.textColor = Color.black.getColor()
    $0.font = Pretendard.size13.semibold()
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
    keywordLabel.text = ""
  }
}

// MARK: - UI & Layout
extension RecentCollectionViewCell {
  private func render() {
    addSubview(keywordLabel)
    keywordLabel.snp.makeConstraints {
      $0.leading.trailing.equalToSuperview().inset(16)
      $0.centerY.equalToSuperview()
    }
  }

  private func configUI() {
    backgroundColor = Color.gray01.getColor()
    layer.borderWidth = 1
    layer.borderColor = Color.gray02.getColor().cgColor
    layer.cornerRadius = 19
    layer.applyShadow(color: .black, alpha: 0.05, x: 1, y: 1, blur: 2, spread: 0)
  }

  func updateKeyword(_ keyword: String) {
    keywordLabel.text = keyword
  }
}
