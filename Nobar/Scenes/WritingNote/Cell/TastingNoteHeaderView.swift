//
//  TastingNoteHeaderView.swift
//  Nobar
//
//  Created by 이유진 on 2022/07/17.
//

import UIKit

final class TastingNoteHeaderView: UICollectionReusableView {
  
   var cocktailName = ""
  
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
  
  func configUI(type: TastingNoteHeaderType,status: WritingStatus) {
    switch type {
    case .cocktail:
      switch status{
      case .newWriting,.revising:
        titleLabel.text = "어떤 칵테일을 기록할까요?"
      case .viewing:
        titleLabel.text = "\(cocktailName)의 노트"
      }
      
    case .date:
      switch status{
      case .newWriting,.revising:
        titleLabel.text = "언제 칵테일을 마셨나요?"
      case .viewing:
        titleLabel.text = "칵테일을 만든 날짜"
      }
      
    case .taste:
      switch status{
      case .newWriting,.revising:
        titleLabel.text = "맛은 어땠나요?"
        notiLabel.text = "최대 3개까지 선택 가능합니다"
        self.addNotiLabel()
      case .viewing:
        titleLabel.text = "내가 고른 맛 태그"
      }
      
    case .score:
      switch status{
      case .newWriting,.revising:
        titleLabel.text = "칵테일이 얼마나 마음에 들었나요?"
      case .viewing:
        titleLabel.text = "칵테일 만족도"
      }
      
    case .evaluation:
      switch status{
      case .newWriting,.revising:
        titleLabel.text = "자세한 평가를 듣고 싶어요"
      case .viewing:
        titleLabel.text = "칵테일 맛 평가"
      }
      
      
    case .experience:
      switch status{
      case .newWriting,.revising:
        titleLabel.text = "당신의 경험을 기억하고 싶어요"
      case .viewing:
        titleLabel.text = "당신의 경험을 기억하고 싶어요"
      }
      
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
