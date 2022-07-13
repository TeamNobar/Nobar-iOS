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
    $0.textColor = .black
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

  private func render() {
    addSubview(keywordLabel)
    keywordLabel.snp.makeConstraints {
      $0.leading.trailing.equalToSuperview().inset(16)
      $0.centerY.equalToSuperview()
    }
  }

  private func configUI() {
    backgroundColor = Color.gray01.getColor()
    layer.borderWidth = 0.4
    layer.borderColor = Color.gray02.getColor().cgColor
    layer.cornerRadius = 19
    makeShadow(color: UIColor(red: 0, green: 0, blue: 0, alpha: 0.05), opacity: 1, offset: CGSize(width: 1, height: 1), radius: 2)
  }

  func update(data: String) {
    keywordLabel.text = data
  }
}
