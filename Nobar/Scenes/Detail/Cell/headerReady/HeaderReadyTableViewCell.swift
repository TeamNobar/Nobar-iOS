//
//  headerReadyTableViewCell.swift
//  Nobar
//
//  Created by Sua Han on 2022/07/14.
//

import UIKit

class HeaderReadyTableViewCell: UITableViewCell {

    @IBOutlet weak var headerTitleLabel: UILabel!
    
    static let identifier = "HeaderReadyTableViewCell"
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
