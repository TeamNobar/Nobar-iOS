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
  }
  
  private let containerView = UIView().then {
    $0.backgroundColor = Color.skyblue01.getColor()
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
  
  private let imageDescriptionView = MakeOnLaterImageDescriptionView()
  
  override init(frame: CGRect) {
    super.init(frame: frame)
    
    addSubview(containerView)
    containerView.addSubview(contentStackView)
    contentStackView.addArrangedSubviews([
      contentTitleLabel,
      subtitleLabel,
      imageDescriptionView
    ])
    
    setLayouts()
  }
  
  required init?(coder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }
  
  private func setLayouts() {
    containerView.snp.makeConstraints {
      $0.edges.equalToSuperview()
      $0.width.equalTo(UIScreen.main.bounds.width)
    }
    
    contentStackView.snp.makeConstraints {
      $0.top.bottom.equalToSuperview().inset(Metric.contentViewTopBottom)
      $0.leading.trailing.equalToSuperview().inset(Metric.contentViewLeadingTrailing)
    }
  }
  
  override func prepareForReuse() {
    super.prepareForReuse()
    
  }
}

extension MakeOnLaterRecipesCollectionViewCell {
  func updateContent(with recipes: Recipe) {
    
    print("[\(#file) \(#line)번째 줄, \(#function):]", recipes)
    contentTitleLabel.text = recipes.name
    subtitleLabel.text = recipes.enName
    
  }
}
