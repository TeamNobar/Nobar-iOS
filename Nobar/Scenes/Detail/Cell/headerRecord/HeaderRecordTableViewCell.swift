//
//  headerRecordTableViewCell.swift
//  Nobar
//
//  Created by Sua Han on 2022/07/17.
//

import UIKit

class HeaderRecordTableViewCell: UITableViewCell {
    
  @IBOutlet weak var headerTitleLabel: UILabel!
  
  static let identifier = "HeaderRecordTableViewCell"

    override func awakeFromNib() {
      super.awakeFromNib()
      // Initialization code
      headerTitleLabel.text = "오늘의 이 경험을, 기록해볼까요?"
      headerTitleLabel.font = Pretendard.size18.bold()

      let attributedStr = NSMutableAttributedString(string: headerTitleLabel.text!)
      attributedStr.addAttribute(.foregroundColor, value: Color.black.getColor(), range: (headerTitleLabel.text! as NSString).range(of: "오늘의 이 경험을,"))
      attributedStr.addAttribute(.foregroundColor, value: Color.navy01.getColor(), range: (headerTitleLabel.text! as NSString).range(of: "기록해볼까요?"))

      headerTitleLabel.attributedText = attributedStr
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
}
