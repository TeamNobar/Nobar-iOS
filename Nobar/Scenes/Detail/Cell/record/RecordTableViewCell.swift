//
//  recordTableViewCell.swift
//  Nobar
//
//  Created by Sua Han on 2022/07/17.
//

import UIKit

import Then
import SnapKit

protocol RecordTapDelegate: AnyObject {
  func didClickOnWriteButton()
}

class RecordTableViewCell: UITableViewCell {

    @IBOutlet weak var contentLabel: UILabel!

  weak var delegate: RecordTapDelegate?

  private lazy var writeNoteButton = UIButton().then {
    $0.setTitle("테이스팅 노트 작성하기", for: .normal)
    $0.setTitleColor(Color.gray04.getColor(), for: .normal)
    $0.titleLabel?.font = Pretendard.size13.bold()
    $0.titleLabel?.textAlignment = .center
    $0.layer.cornerRadius = 20
    $0.layer.borderWidth = 0.5
    $0.layer.borderColor = Color.gray02.getColor().cgColor
    $0.addTarget(self, action: #selector(didClickOnWriteButton(_:)), for: .touchUpInside)
  }
    
    static let identifier = "RecordTableViewCell"
    
    override func awakeFromNib() {
      super.awakeFromNib()
      // Initialization code
      contentLabel.text = "같은 칵테일을 마셔도 테이스팅 노트는 여러 번 기록할 수 있어요\n어제의 홈텐딩과 오늘의 홈텐딩은 다르니까요\n오늘 마신 칵테일로 오늘을 기억해보는 것은 어때요?\n당신의 하루가 더 오래 기억되길 바라요"
      contentLabel.font = Pretendard.size12.light()
      contentLabel.textColor = Color.black.getColor()
      contentLabel.setAttributedText(defaultText: contentLabel.text ?? "", kernValue: -0.24, lineSpacing: 4)

      addSubview(writeNoteButton)
      writeNoteButton.snp.makeConstraints {
        $0.top.equalTo(contentLabel.snp.bottom).offset(18)
        $0.centerX.equalToSuperview()
        $0.width.equalTo(171)
        $0.height.equalTo(40)
      }
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

  @objc private func didClickOnWriteButton(_ sender: UIButton) {
    delegate?.didClickOnWriteButton()
  }
    
}
