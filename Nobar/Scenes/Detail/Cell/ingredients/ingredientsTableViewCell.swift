//
//  ingredientsTableViewCell.swift
//  Nobar
//
//  Created by Sua Han on 2022/07/14.
//

import UIKit

class ingredientsTableViewCell: UITableViewCell {

    @IBOutlet weak var ingredientsCollectionView: UICollectionView!
    var selectIngredients: (() -> ())?
    static let identifier = "ingredientsTableViewCell"
    var identifiers = [ingredientItemCollectionViewCell.identifier]
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
