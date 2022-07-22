//
//  MakeOnLaterImageDescriptionView.swift
//  Nobar
//
//  Created by Ian on 2022/07/22.
//

import UIKit

import Kingfisher

final class MakeOnLaterImageDescriptionView: BaseView {
  private let contentsView = UIStackView().then {
    $0.axis = .vertical
    $0.spacing = 8.f
  }
  
  private let imageView = UIImageView().then {
    $0.layer.cornerRadius = 21.f
    $0.layer.borderWidth = 1.f
    $0.layer.borderColor = Color.navy01.getColor().cgColor
  }
  private let descriptionLabel = UILabel().then {
    $0.font = Pretendard.size11.bold()
    $0.textColor = Color.black.getColor()
  }
  
  init(imageURL: String, description: String, frame: CGRect) {
    super.init(frame: frame)
    
    if let url = URL(string: imageURL) {
      imageView.kf.setImage(with: url)
    }
    descriptionLabel.text = description
  }
  
  required init?(coder aDecoder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }
  
  override func initialize() {
    super.initialize()
    
    addSubview(contentsView)
    contentsView.addArrangedSubviews([
      imageView,
      descriptionLabel
    ])
  }
  
  override func setLayouts() {
    super.setLayouts()
    
    contentsView.snp.makeConstraints { $0.edges.equalToSuperview() }
    imageView.snp.makeConstraints { $0.size.equalTo(42.f) }
  }
}

extension MakeOnLaterImageDescriptionView {
  func updateImageDescriptionPair(imageUrl url: String, description: String) {
    if let url = URL(string: url) {
      imageView.kf.setImage(with: url)
    }
    descriptionLabel.text = description
  }
}

