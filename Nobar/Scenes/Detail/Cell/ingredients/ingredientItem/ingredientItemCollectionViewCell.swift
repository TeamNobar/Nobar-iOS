//
//  ingredientItemCollectionViewCell.swift
//  Nobar
//
//  Created by Sua Han on 2022/07/14.
//

import UIKit

class ingredientItemCollectionViewCell: UICollectionViewCell {
    @IBOutlet weak var ingredientsTitle: UILabel!
    @IBOutlet weak var categoryImage: UIImageView!
    @IBOutlet weak var categoryLabel: UILabel!
    @IBOutlet weak var proofLabel: UILabel!
    
    static let identifier = "ingredientItemCollectionViewCell"
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }
}
