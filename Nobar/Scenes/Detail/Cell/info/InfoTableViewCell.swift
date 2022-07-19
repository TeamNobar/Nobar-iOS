//
//  infoTableViewCell.swift
//  Nobar
//
//  Created by Sua Han on 2022/07/13.
//

import UIKit

class InfoTableViewCell: UITableViewCell {
    
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
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
