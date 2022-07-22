//
//  MakeOnLaterRecipesCollectionViewCell.swift
//  Nobar
//
//  Created by Ian on 2022/07/22.
//

import UIKit
import Kingfisher

final class MakeOnLaterRecipesCollectionViewCell: UICollectionViewCell {
  
  private enum Metric {
    static let contentViewTopBottom = 16.f
    static let contentViewLeadingTrailing = 26.f
    static let containerRadius = 10.f
  }
  
  private let containerView = UIView().then {
    $0.backgroundColor = Color.skyblue01.getColor()
    $0.layer.cornerRadius = Metric.containerRadius
    $0.layer.applyShadow()
  }
  
  private let contentStackView = UIStackView().then {
    $0.axis = .vertical
    $0.spacing = 2.f
    $0.alignment = .leading
  }

  private let contentTitleLabel = UILabel().then {
    $0.font = Pretendard.size18.extraBold()
    $0.textColor = Color.black.getColor()
  }
  
  private let subtitleLabel = UILabel().then {
    $0.font = Pretendard.size10.light()
    $0.textColor = Color.gray03.getColor()
  }
  
  private let imageDescriptionStackView = UIStackView().then {
    $0.spacing = 26.f
    $0.axis = .horizontal
  }
  
  override init(frame: CGRect) {
    super.init(frame: frame)
    
    addSubview(containerView)
    containerView.addSubview(contentStackView)
    contentStackView.addArrangedSubviews([
      contentTitleLabel,
      subtitleLabel,
      imageDescriptionStackView
    ])
    
    setLayouts()
  }
  
  required init?(coder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }
  
  private func setLayouts() {
    containerView.snp.makeConstraints {
      $0.leading.trailing.equalToSuperview().inset(26.f)
      $0.top.equalToSuperview().inset(16.f)
      $0.bottom.equalToSuperview()

      $0.width.equalTo(UIScreen.main.bounds.width - (26.f * 2))
    }
    
    contentStackView.snp.makeConstraints {
      $0.top.bottom.equalToSuperview().inset(Metric.contentViewTopBottom)
      $0.leading.trailing.equalToSuperview().inset(Metric.contentViewLeadingTrailing)
    }
  }
  
  override func prepareForReuse() {
    super.prepareForReuse()
    
    imageDescriptionStackView.removeAllSubViews()
  }
}

extension MakeOnLaterRecipesCollectionViewCell {
  func updateContent(with recipes: Recipe) {
    contentTitleLabel.text = recipes.name
    subtitleLabel.text = recipes.enName
    imageDescriptionStackView.addArrangedSubviews([
//      베이스 도수 만드는 법 잔
      MakeOnLaterImageDescriptionView(
        imageURL: recipes.base.url,
        description: recipes.base.name,
        frame: self.bounds
      ),
      MakeOnLaterImageDescriptionView(
        imageURL: recipes.proofIcon,
        description: "도수",
        frame: self.bounds
      ),
      MakeOnLaterImageDescriptionView(
        imageURL: recipes.skill.url,
        description: recipes.skill.name,
        frame: self.bounds
      ),
      MakeOnLaterImageDescriptionView(
        imageURL: recipes.glass.url,
        description: recipes.glass.name,
        frame: self.bounds
      )
    ])
  }
}
