//
//  TastingNoteTagView.swift
//  Nobar
//
//  Created by Ian on 2022/07/22.
//

import UIKit

final class TastingNoteTagView: BaseView {
  private let contentView = UIView()
  private let tagImage = UIImageView()
  private let tagNameLabel = UILabel().then {
    $0.textColor = Color.navy01.getColor()
    $0.font = Pretendard.size11.bold()
  }
  
  init(tagName: String, contentSize: CGRect) {
    tagNameLabel.text = tagName
    super.init(frame: contentSize)
  }
  
  required init?(coder aDecoder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }
  
  override func initialize() {
    super.initialize()
    
    addSubview(contentView)
    
    contentView.layer.cornerRadius = 16.f
    contentView.layer.borderWidth = 1
    contentView.layer.borderColor = Color.navy01.getColor().cgColor
    contentView.addSubviews([tagImage, tagNameLabel])
  }
  
  override func setLayouts() {
    super.setLayouts()
    
    // NOTE: Metric 넘 기찬아요 재송합니다
    contentView.snp.makeConstraints {
      $0.edges.equalToSuperview()
      $0.height.equalTo(36.f)
    }
    
    tagImage.snp.makeConstraints {
      $0.leading.equalToSuperview().inset(10.f)
      $0.size.equalTo(16.f)
      $0.centerY.equalToSuperview()
    }
    
    tagNameLabel.snp.makeConstraints {
      $0.leading.equalTo(tagImage.snp.trailing).offset(2.f)
      $0.trailing.equalToSuperview().inset(10.f)
      $0.centerY.equalToSuperview()
    }
  }
}
