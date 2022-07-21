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
    addSubview(titleLabel)
  
    titleLabel.snp.makeConstraints {
      $0.centerY.equalToSuperview()
      $0.leading.equalToSuperview().offset(31)
    }
  }
  
  func configUI(type: HomeHeaderType) {
    switch type {
    case .archive:
      titleLabel.text = "나중에 만들 레시피"
      self.addSeeAllButton()
    case .guide:
      titleLabel.text = "칵테일 가이드"
    case .recommend:
      titleLabel.text = "바가 필요 없는 레시피"
      
    }
  }
  
  private func addSeeAllButton() {
    addSubview(seeAllButton)
    seeAllButton.snp.makeConstraints {
      $0.top.equalToSuperview().offset(19)
      $0.trailing.equalToSuperview().offset(-26)
    }
  }
  
}

