//
//  TastingNoteHeaderView.swift
//  Nobar
//
//  Created by 이유진 on 2022/07/17.
//

import UIKit

final class TastingNoteHeaderView: UICollectionReusableView {
  enum TastingNoteHeaderType {
    case cocktail
    case date
    case taste
    case score
    case evaluation
    case experience
  }
  
  private let titleLabel = UILabel().then {
    $0.textColor = Color.navy01.getColor()
    $0.font = Pretendard.size18.extraBold()
  }
  
  private let notiLabel = UILabel().then {
    $0.textColor = Color.pink01.getColor()
    $0.font = Pretendard.size10.medium()
  }
  
  override init(frame: CGRect) {
    super.init(frame: frame)
    render()
  }
  
  required init?(coder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }
  
}

// MARK: - UI & Layout
extension TastingNoteHeaderView {
  
  private func render() {
    addSubview(titleLabel)
    titleLabel.snp.makeConstraints {
      $0.leading.equalToSuperview().offset(26)
      $0.centerY.equalToSuperview()
    }
  }
  
 func configUI(type: TastingNoteHeaderType) {
    switch type {
    case .cocktail:
      titleLabel.text = "기록하고 싶은 칵테일을 알려주세요"
    case .date:
      titleLabel.text = "칵테일을 만든 날짜를 알려주세요"
    case .taste:
      titleLabel.text = "맛은 어땠나요?"
      notiLabel.text = "최대 3개까지 선택 가능합니다"
      self.addNotiLabel()
    case .score:
      titleLabel.text = "제 점수는요!"
    case .evaluation:
      titleLabel.text = "자세한 평가를 듣고 싶어요"
    case .experience:
      titleLabel.text = "당신의 경험을 기억하고 싶어요"
    }
  }
  
  private func addNotiLabel() {
    addSubview(notiLabel)
    notiLabel.snp.makeConstraints {
      $0.centerY.equalToSuperview()
      $0.trailing.equalToSuperview().inset(26)
    }
  }
}
