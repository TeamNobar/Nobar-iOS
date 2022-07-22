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
      headerTitleLabel.text = "우선, 준비해볼까요?"
      headerTitleLabel.font = Pretendard.size18.bold()
      
      // NSMutableAttributedString Type으로 바꾼 text를 저장
      let attributedStr = NSMutableAttributedString(string: headerTitleLabel.text!)

      // text의 range 중에서 "우선,"라는 글자는 UIColor를 black으로 변경
      attributedStr.addAttribute(.foregroundColor, value: Color.black.getColor(), range: (headerTitleLabel.text! as NSString).range(of: "우선,"))
      // text의 range 중에서 "준비해볼까요?"라는 글자는 UIColor를 navy01로 변경
      attributedStr.addAttribute(.foregroundColor, value: Color.navy01.getColor(), range: (headerTitleLabel.text! as NSString).range(of: "준비해볼까요?"))

      // 설정이 적용된 text를 label의 attributedText에 저장
      headerTitleLabel.attributedText = attributedStr
    }
    
  
  

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
