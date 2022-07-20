//
//  ingredientsTableViewCell.swift
//  Nobar
//
//  Created by Sua Han on 2022/07/14.
// O

import UIKit

class IngredientsTableViewCell: UITableViewCell {
  
    @IBOutlet weak var ingredientsCollectionView: UICollectionView!
    var selectIngredients: (() -> ())?
    static let identifier = "IngredientsTableViewCell"
    var identifiers = [IngredientItemCollectionViewCell.identifier]
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
      
      self.backgroundColor = .systemRed.withAlphaComponent(0.4)
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
