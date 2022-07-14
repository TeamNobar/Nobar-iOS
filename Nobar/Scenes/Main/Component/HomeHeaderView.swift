//
//  HomeHeaderView.swift
//  Nobar
//
//  Created by 이유진 on 2022/07/14.
//

import UIKit

import Then
import SnapKit

final class HomeHeaderView: UICollectionReusableView {
  
  enum HomeHeaderType {
    case archive
    case guide
    case recommend
  }
  
  private var subTitleLabel = UILabel().then {
    $0.textColor = Color.gray03.getColor()
    $0.font = Pretendard.size12.medium()
  }
  
  private var titleLabel = UILabel().then {
    $0.textColor = Color.navy01.getColor()
    $0.font = Pretendard.size20.black()
  }
  
  private var seeAllButton = UIButton().then {
    $0.setTitle("전체 보기", for: .normal)
    $0.setTitleColor(Color.gray03.getColor(), for: .normal)
    $0.titleLabel?.font = Pretendard.size13.medium()
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
extension HomeHeaderView {
  
  private func render() {
    addSubviews([
      subTitleLabel,
      titleLabel
    ])
    subTitleLabel.snp.makeConstraints {
      $0.top.equalToSuperview().offset(12)
      $0.leading.equalToSuperview().offset(31)
    }
    titleLabel.snp.makeConstraints {
      $0.top.equalTo(subTitleLabel.snp.bottom).offset(2)
      $0.leading.equalTo(subTitleLabel.snp.leading)
    }
  }
  
  func configUI(type: HomeHeaderType) {
    switch type {
    case .archive:
      subTitleLabel.text = "소제목소제목소제목"
      titleLabel.text = "노바님이 나중에 만들 레시피"
      self.addSeeAllButton()
    case .guide:
      subTitleLabel.text = "소제목소제목소제목"
      titleLabel.text = "칵테일 가이드"
    case .recommend:
      subTitleLabel.text = "소제목소제목소제목"
      titleLabel.text = "바가 필요 없는 레시피"
      
    }
  }
  
  private func addSeeAllButton() {
    addSubview(seeAllButton)
    seeAllButton.snp.makeConstraints {
      $0.top.equalToSuperview().offset(34)
      $0.bottom.equalToSuperview()
      $0.trailing.equalToSuperview().offset(-26)
    }
  }
  
}

