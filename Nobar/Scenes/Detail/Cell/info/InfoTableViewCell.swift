//
//  infoTableViewCell.swift
//  Nobar
//
//  Created by Sua Han on 2022/07/13.
//

import UIKit

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
  
  static let identifier = "InfoTableViewCell"
  

  override func awakeFromNib() {
    super.awakeFromNib()
    // Initialization code
    rectBackgroundView.backgroundColor = Color.gray01.getColor()
    rectBackgroundView.layer.cornerRadius = 10
    
    baseImage.image = UIImage(named: "")  // Data
    baseTitleLabel.text = "베이스"
    baseTitleLabel.font = Pretendard.size10.light()
    baseTitleLabel.textColor = Color.gray04.getColor()
    baseNameLabel.text = "보드카"  // Data
    baseNameLabel.font = Pretendard.size14.medium()
    baseNameLabel.textColor = Color.black.getColor()
    
    proofImage.image = UIImage(named: "")  // Data
    proofTitleLabel.text = "도수"
    proofTitleLabel.font = Pretendard.size10.light()
    proofTitleLabel.textColor = Color.gray04.getColor()
    proofNameLabel.text = "21%"  // Data
    proofNameLabel.font = Pretendard.size14.medium()
    proofNameLabel.textColor = Color.black.getColor()
    
    skillImage.image = UIImage(named: "")  // Data
    skillTitleLabel.text = "만드는 법"
    skillTitleLabel.font = Pretendard.size10.light()
    skillTitleLabel.textColor = Color.gray04.getColor()
    skillNameLabel.text = "셰이킹"  // Data
    skillNameLabel.font = Pretendard.size14.medium()
    skillNameLabel.textColor = Color.black.getColor()
    
    glassImage.image = UIImage(named: "")  // Data
    glassTitleLabel.text = "글라스"
    glassTitleLabel.font = Pretendard.size10.light()
    glassTitleLabel.textColor = Color.gray04.getColor()
    glassNameLabel.text = "칵테일"  // Data
    glassNameLabel.font = Pretendard.size14.medium()
    glassNameLabel.textColor = Color.black.getColor()
  }
}
