//
//  recordTableViewCell.swift
//  Nobar
//
//  Created by Sua Han on 2022/07/17.
//

import UIKit

class RecordTableViewCell: UITableViewCell {

    @IBOutlet weak var contentLabel: UILabel!
    @IBOutlet weak var writeNoteButton: UIButton!
    
    static let identifier = "RecordTableViewCell"
    
    override func awakeFromNib() {
      super.awakeFromNib()
      // Initialization code
      contentLabel.text = "같은 칵테일을 마셔도 테이스팅 노트는 여러 번 기록할 수 있어요\n어제의 홈텐딩과 오늘의 홈텐딩은 다르니까요\n오늘 마신 칵테일로 오늘을 기억해보는 것은 어때요?\n당신의 하루가 더 오래 기억되길 바라요"
      contentLabel.font = Pretendard.size12.light()
      contentLabel.textColor = Color.black.getColor()

      writeNoteButton.setTitle("테이스팅 노트 작성하기", for: .normal)
      writeNoteButton.setTitleColor(Color.gray04.getColor(), for: .normal)
      writeNoteButton.layer.cornerRadius = 20
      writeNoteButton.layer.borderWidth = 0.5
      writeNoteButton.layer.borderColor = Color.gray02.getColor().cgColor
      
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
