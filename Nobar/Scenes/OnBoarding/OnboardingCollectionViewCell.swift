//
//  OnboardingCollectionViewCell.swift
//  Nobar
//
//  Created by 김수연 on 2022/07/22.
//

import UIKit

import Then
import SnapKit

final class OnboardingCollectionViewCell: UICollectionViewCell {

  private let titleLabel = UILabel().then {
    $0.font = Pretendard.size26.extraBold()
    $0.text = "수많은 홈텐딩 레시피를\n한 곳에서 확인할 수 있어요"
    $0.textColor = Color.navy01.getColor()
    $0.textAlignment = .center
    $0.numberOfLines = 2
  }

  private let onboardingImage = UIImageView().then {
    $0.image = ImageFactory.AppIcon
    $0.layer.cornerRadius = 25
  }

  override init(frame: CGRect) {
    super.init(frame: frame)
    render()
    configUI()
  }

  @available(*, unavailable)
  required init?(coder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }

  override func prepareForReuse() {
    titleLabel.text = ""
    onboardingImage.image = nil
  }
}

// MARK: - UI & Layout
extension OnboardingCollectionViewCell {
  private func render() {
    addSubviews([titleLabel, onboardingImage])
  }

  private func configUI() {
    titleLabel.snp.makeConstraints {
      $0.top.equalToSuperview()
      $0.centerX.equalToSuperview()
      $0.height.equalTo(78)
    }

    onboardingImage.snp.makeConstraints {
      $0.top.equalTo(titleLabel.snp.bottom).offset(27)
      $0.centerX.equalToSuperview()
      $0.width.equalTo(263)
      $0.bottom.equalToSuperview()
    }
  }

  func updateContentModel(_ model: OnboardingContentModel) {
    onboardingImage.image = model.image
    titleLabel.text = model.title
  }
}
