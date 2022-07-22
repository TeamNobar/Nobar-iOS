//
//  ingredientItemCollectionViewCell.swift
//  Nobar
//
//  Created by Sua Han on 2022/07/14.
//

import UIKit

class IngredientItemCollectionViewCell: UICollectionViewCell {
    @IBOutlet weak var ingredientsTitle: UILabel!
    @IBOutlet weak var categoryImage: UIImageView!
    @IBOutlet weak var categoryLabel: UILabel!
    @IBOutlet weak var proofLabel: UILabel!
    
    static let identifier = "IngredientItemCollectionViewCell"
    
    // 초기화 해주는 작업을 해당 메서드 안에서 진행
    override func awakeFromNib() {
      super.awakeFromNib()
      backgroundColor = Color.gray01.getColor()
      layer.cornerRadius = 8
      // Initialization code
      //ingredientsTitle.text = "자몽주스"  //Data
      ingredientsTitle.font = Pretendard.size12.semibold()
      ingredientsTitle.textColor = Color.black.getColor()
      
      categoryImage.image = ImageFactory.icnTag
      
      //categoryLabel.text = "카테고리" // Data
      categoryLabel.font = Pretendard.size10.medium()
      categoryLabel.textColor = Color.pink01.getColor()
      
      //categoryLabel.text = "자몽주스" // Data
      categoryLabel.font = Pretendard.size10.medium()
      categoryLabel.textColor = Color.pink01.getColor()

      proofLabel.textColor = Color.navy01.getColor()
      proofLabel.font = Pretendard.size20.bold()

    }
    
    // 각 Cell 별로 다른 정보가 표시되어야 하므로, 값을 넣어주는 함수를 생성
    func setData(cocktailData: IngredientDataModel) {
        ingredientsTitle.text = cocktailData.IngredientName
        categoryLabel.text = cocktailData.IngredientCategory
        proofLabel.text = cocktailData.IngredientQuantity
    }
}


