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
    
    static let identifier = "ingredientItemCollectionViewCell"
    
    // 초기화 해주는 작업을 해당 메서드 안에서 진행
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    // 각 Cell 별로 다른 정보가 표시되어야 하므로, 값을 넣어주는 함수를 생성
    func setData(_ cocktailData: IngredientDataModel) {
        ingredientsTitle.text = cocktailData.IngredientName
        categoryLabel.text = cocktailData.IngredientCategory
        proofLabel.text = cocktailData.IngredientQuantity
    }
}


