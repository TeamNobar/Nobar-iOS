//
//  infoTableViewCell.swift
//  Nobar
//
//  Created by Sua Han on 2022/07/13.
//

import UIKit

import Kingfisher
import SnapKit

class InfoTableViewCell: UITableViewCell {
  
  @IBOutlet weak var rectBackgroundView: UIView!
  
  @IBOutlet weak var baseImage: UIImageView!
  @IBOutlet weak var baseTitleLabel: UILabel!
  @IBOutlet weak var baseNameLabel: UILabel!
  
  @IBOutlet weak var proofImage: UIImageView!
  @IBOutlet weak var proofTitleLabel: UILabel!
  @IBOutlet weak var proofNameLabel: UILabel!
  
  @IBOutlet weak var skillImage: UIImageView!
  @IBOutlet weak var skillTitleLabel: UILabel!
  @IBOutlet weak var skillNameLabel: UILabel!
  
  @IBOutlet weak var glassImage: UIImageView!
  @IBOutlet weak var glassTitleLabel: UILabel!
  @IBOutlet weak var glassNameLabel: UILabel!
  
  override func awakeFromNib() {
    super.awakeFromNib()
    
    layoutViews()
    setupConstraint()
  }
  
  override func prepareForReuse() {
    super.prepareForReuse()
    
  }
}

extension InfoTableViewCell {
  func updateCocktailInfo(with response: RecipeDetailResponse) {
    if let imageURL = URL(string: response.base.url) {
      baseImage.kf.setImage(with: imageURL)
    }
    baseTitleLabel.text = "베이스"
    baseNameLabel.text = response.base.name
    
    if let imageURL = URL(string: response.proofIcon) {
      proofImage.kf.setImage(with: imageURL)
    }
    proofTitleLabel.text = "도수"
    proofNameLabel.text = "\(response.proof)%"
    
    if let imageURL = URL(string: response.skill.url) {
      skillImage.kf.setImage(with: imageURL)
    }
    skillTitleLabel.text = "만드는 법"
    skillNameLabel.text = response.skill.name
    
    if let imageURL = URL(string: response.glass.url) {
      glassImage.kf.setImage(with: imageURL)
    }
    skillTitleLabel.text = "글라스"
    skillNameLabel.text = response.glass.name
  }
}

// MARK: - Private functions
extension InfoTableViewCell {
  private func layoutViews() {
    rectBackgroundView.backgroundColor = Color.gray01.getColor()
    rectBackgroundView.layer.cornerRadius = 10
    
    baseImage.image = UIImage(named: "AppIcon")  // Data
    baseTitleLabel.text = "베이스"
    baseTitleLabel.font = Pretendard.size10.light()
    baseTitleLabel.textColor = Color.gray04.getColor()
    baseNameLabel.text = "보드카"  // Data
    baseNameLabel.font = Pretendard.size14.medium()
    baseNameLabel.textColor = Color.black.getColor()
    
    proofImage.image = UIImage(named: "AppIcon")  // Data
    proofTitleLabel.text = "도수"
    proofTitleLabel.font = Pretendard.size10.light()
    proofTitleLabel.textColor = Color.gray04.getColor()
    proofNameLabel.text = "21%"  // Data
    proofNameLabel.font = Pretendard.size14.medium()
    proofNameLabel.textColor = Color.black.getColor()
    
    skillImage.image = UIImage(named: "AppIcon")  // Data
    skillTitleLabel.text = "만드는 법"
    skillTitleLabel.font = Pretendard.size10.light()
    skillTitleLabel.textColor = Color.gray04.getColor()
    skillNameLabel.text = "셰이킹"  // Data
    skillNameLabel.font = Pretendard.size14.medium()
    skillNameLabel.textColor = Color.black.getColor()
    
    glassImage.image = UIImage(named: "AppIcon")  // Data
    glassTitleLabel.text = "글라스"
    glassTitleLabel.font = Pretendard.size10.light()
    glassTitleLabel.textColor = Color.gray04.getColor()
    glassNameLabel.text = "칵테일"  // Data
    glassNameLabel.font = Pretendard.size14.medium()
    glassNameLabel.textColor = Color.black.getColor()
  }
  
  private func setupConstraint() {
    [baseTitleLabel, baseNameLabel].forEach {
      $0.snp.makeConstraints {
        $0.centerX.equalTo(baseImage.snp.centerX)
      }
    }
    [proofTitleLabel, proofNameLabel].forEach {
      $0.snp.makeConstraints {
        $0.centerX.equalTo(proofImage.snp.centerX)
      }
    }
    [skillTitleLabel, skillNameLabel].forEach {
      $0.snp.makeConstraints {
        $0.centerX.equalTo(skillImage.snp.centerX)
      }
    }
    [glassTitleLabel, glassNameLabel].forEach {
      $0.snp.makeConstraints {
        $0.centerX.equalTo(glassImage.snp.centerX)
      }
    }
    
    [baseImage, proofImage, skillImage, glassImage].forEach {
      $0.snp.makeConstraints {
        $0.height.equalTo(42)
        $0.width.equalTo(42)
      }
    }
    
    baseImage.snp.makeConstraints {
      $0.leading.equalToSuperview().inset(35)
      $0.top.equalToSuperview().inset(12)
    }
    
    [proofImage, skillImage, glassImage].forEach {
      $0.snp.makeConstraints {
        $0.top.equalTo(baseImage.snp.top)
      }
    }
    proofImage.snp.makeConstraints {
      $0.leading.equalTo(baseImage.snp.trailing).offset(32)
    }
    skillImage.snp.makeConstraints {
      $0.leading.equalTo(proofImage.snp.trailing).offset(32)
    }
    glassImage.snp.makeConstraints {
      $0.leading.equalTo(skillImage.snp.trailing).offset(32)
    }
    
    [baseImage, proofImage, skillImage, glassImage].forEach {
      $0.snp.makeConstraints {
        $0.bottom.equalToSuperview().inset(46)
      }
    }
  }
}
