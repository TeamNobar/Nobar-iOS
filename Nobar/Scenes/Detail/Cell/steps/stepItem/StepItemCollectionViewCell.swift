//
//  StepItemCollectionViewCell.swift
//  Nobar
//
//  Created by Sua Han on 2022/07/22.
//

import UIKit

class StepItemCollectionViewCell: UICollectionViewCell {
  
  @IBOutlet weak var stepBox: UIView!
  @IBOutlet weak var stepLabel: UILabel!
  @IBOutlet weak var stepExplain: UILabel!
    
  override func awakeFromNib() {
    super.awakeFromNib()
    // Initialization code
    stepBox.backgroundColor = Color.pink01.withAlphaColor(alpha: 0.2)
    stepBox.layer.cornerRadius = 12
    
    stepLabel.text = "step0"
    stepLabel.font = Pretendard.size12.semibold()
    stepLabel.textColor = Color.white.getColor()
      
    //stepExplain.text = "한줄짜리 설명을 입력하세요"
    stepExplain.font = Pretendard.size14.regular()
    stepExplain.textColor = Color.black.getColor()
  }
  
  func setData(stepData: StepDataModel) {
    stepExplain.text = stepData.step[0]
  }
}
