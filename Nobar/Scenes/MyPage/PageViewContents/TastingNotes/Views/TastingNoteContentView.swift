//
//  TastingNoteContentView.swift
//  Nobar
//
//  Created by Ian on 2022/07/21.
//

import UIKit

final class TastingNoteContentView: BaseView {
  private enum Constant {
    static let heartFactor = 0.5
  }
  
  private enum Metric {
    static let contentViewTopBottom = 16.f
    static let contentViewLeadingTrailing = 26.f
    static let subtitleTop = 2.f
    static let heartRateTop = 16.f
    static let tagsTop = 16.f
    static let tagSpacing = 10.f
  }

  private let backgroundView = UIView().then {
    $0.backgroundColor = Color.skyblue01.getColor()
    $0.layer.cornerRadius = 10.f
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
  
  private let heartRateView = TastingNoteHeartRateView()
  
  private let tagsStackView = UIStackView().then {
    $0.spacing = Metric.tagSpacing
  }
    
  override func initialize() {
    super.initialize()
    
    addSubview(backgroundView)
    
    backgroundView.addSubview(contentStackView)
    
    contentStackView.addArrangedSubviews([
      contentTitleLabel,
      subtitleLabel,
      heartRateView,
      tagsStackView
    ])
    
    contentStackView.setCustomSpacing(
      Metric.heartRateTop,
      after: subtitleLabel
    )
    
    contentStackView.setCustomSpacing(
      Metric.tagsTop,
      after: heartRateView
    )
  }
  
  override func setLayouts() {
    super.setLayouts()
        
    backgroundView.snp.makeConstraints {
      $0.top.bottom.equalToSuperview().inset(Metric.contentViewTopBottom)
      $0.leading.trailing.equalToSuperview().inset(Metric.contentViewLeadingTrailing)
    }

    contentStackView.snp.makeConstraints {
      $0.top.bottom.equalToSuperview().inset(Metric.contentViewTopBottom)
      $0.leading.trailing.equalToSuperview().inset(Metric.contentViewLeadingTrailing)
    }
  }
}

extension TastingNoteContentView {
  func updateContent(with tastingNote: TastingNote) {
    contentTitleLabel.text = tastingNote.recipe.name
    subtitleLabel.text = tastingNote.recipe.enName
    heartRateView.updateHeartRate(with: tastingNote.rate)
    tastingNote.tag.prefix(3).forEach {
      tagsStackView.addArrangedSubview(
        TastingNoteTagView(
          tagName: $0.content,
          tagURL: $0.inActiveIcon,
          contentSize: self.bounds
        )
      )
    }
  }
  
  func prepareForReuse() {
    tagsStackView.removeAllSubViews()
  }
}
