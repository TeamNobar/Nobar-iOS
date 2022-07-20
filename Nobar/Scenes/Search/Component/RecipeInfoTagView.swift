//
//  RecipeInfoTagView.swift
//  Nobar
//
//  Created by 김수연 on 2022/07/17.
//

import UIKit

import Then
import SnapKit

enum InfoTagType {
  case base
  case percent
  case skill
  case kind
}

final class RecipeInfoTagView: UIView {

  var type: InfoTagType

  var tagLabel = UILabel().then {
    $0.font = Pretendard.size9.medium()
    $0.textAlignment = .center
    $0.sizeToFit()
  }

  init(frame: CGRect, type: InfoTagType) {
      self.type = type
      super.init(frame: frame)
      render()
      configUI()
  }

  @available(*, unavailable)
  required init?(coder: NSCoder) {
      fatalError("init(coder:) has not been implemented")
  }
}

extension RecipeInfoTagView {
  private func render() {
    addSubview(tagLabel)
    
    tagLabel.snp.makeConstraints {
      $0.top.bottom.equalToSuperview().inset(2)
      $0.leading.trailing.equalToSuperview().inset(5)
    }
  }

  private func configUI() {
    backgroundColor = Color.white.getColor()
    layer.borderColor = Color.gray02.withAlphaColor(alpha: 0.5).cgColor
    layer.borderWidth = 1
    layer.cornerRadius = 8

    switch type {
    case .base:
      tagLabel.textColor = Color.black.getColor()
    case .percent:
      tagLabel.textColor = Color.red.getColor()
    case .skill:
      tagLabel.textColor = Color.navy01.getColor()
    case .kind:
      tagLabel.textColor = Color.pink01.getColor()
    }
  }

  func remakeLabelConstraints() {
    tagLabel.snp.remakeConstraints {
      $0.top.bottom.equalToSuperview().inset(2)
      $0.leading.trailing.equalToSuperview().inset(3)
    }
  }
}
