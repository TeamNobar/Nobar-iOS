//
//  stepsTableViewCell.swift
//  Nobar
//
//  Created by Sua Han on 2022/07/17.
//

import UIKit

class StepsTableViewCell: UITableViewCell {

    @IBOutlet weak var stepBox: UIView!
    @IBOutlet weak var stepLabel: UILabel!
    @IBOutlet weak var stepExplain: UILabel!
    
    static let identifier = "StepsTableViewCell"
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
      stepBox.layer.cornerRadius = 12
      stepBox.backgroundColor = Color.pink01.withAlphaColor(alpha: 0.2)
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
