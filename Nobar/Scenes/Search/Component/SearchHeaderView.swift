//
//  SearchHeaderView.swift
//  Nobar
//
//  Created by 김수연 on 2022/07/12.
//

import UIKit

import Then
import SnapKit

final class SearchHeaderView: UICollectionReusableView {

  enum SeachHeaderType {
    case recent
    case recommend
    case cocktail
    case ingredient
  }

  private var titleLabel = UILabel().then {
    $0.textColor = Color.pink01
    $0.font = Pretendard.size17.semibold()
  }

  private var deleteButton = UIButton().then {
    $0.setTitle("전체 삭제", for: .normal)
    $0.setTitleColor(Color.gray03, for: .normal)
    $0.titleLabel?.font = Pretendard.size13.medium()
  }

  private var dateLabel = UILabel().then {
    $0.text = "2022.07.07 기준"
    $0.textColor = Color.gray03
    $0.font = Pretendard.size13.regular()
  }

  private let topLine = UIView().then {
    $0.backgroundColor = Color.gray02
  }

  override init(frame: CGRect) {
    super.init(frame: frame)
    render()
  }

  required init?(coder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }

  private func render() {
    addSubview(titleLabel)
    titleLabel.snp.makeConstraints {
      $0.top.bottom.equalToSuperview().inset(15)
      $0.leading.equalToSuperview()
    }
  }

  func configUI(type: SeachHeaderType) {
    switch type {
    case .recent:
      titleLabel.text = "최근 검색어"
      self.addDeleteButton()
    case .recommend:
      titleLabel.text = "추천 검색어"
      self.addDateLabel()
      self.addSeparateLine()
    case .cocktail:
      titleLabel.text = "칵테일 레시피"
    case .ingredient:
      titleLabel.text = "재료"
      self.addSeparateLine()
    }
  }

  private func addDeleteButton() {
    addSubview(deleteButton)
    deleteButton.snp.makeConstraints {
      $0.top.equalToSuperview().inset(19)
      $0.bottom.equalToSuperview().inset(15)
      $0.trailing.equalToSuperview()
    }
  }

  private func addDateLabel() {
    addSubview(dateLabel)
    dateLabel.snp.makeConstraints {
      $0.top.equalToSuperview().inset(19)
      $0.bottom.equalToSuperview().inset(15)
      $0.trailing.equalToSuperview().inset(26)
    }

    titleLabel.snp.remakeConstraints {
      $0.top.bottom.equalToSuperview().inset(15)
      $0.leading.equalToSuperview().inset(26)
    }
  }

  private func addSeparateLine() {
    addSubview(topLine)
    topLine.snp.makeConstraints {
      $0.top.leading.trailing.equalToSuperview()
      $0.height.equalTo(0.8)
    }
  }
}
