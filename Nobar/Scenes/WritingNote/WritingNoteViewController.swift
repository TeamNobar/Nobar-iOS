//
//  WritingNoteViewController.swift
//  Nobar
//
//  Created by Ian on 2022/07/08. // 작업자 이름 쓰세용
//

import UIKit
import SnapKit
import Then

final class WritingNoteViewController: BaseViewController {
  
  private let headerBarView = UIView()
  
  private let closeButton = UIButton().then {
    $0.setImage(ImageFactory.btnCancel, for: .normal)
  }
  
  private let titleLabel = UILabel().then{
    $0.text = "테이스팅 노트 기록하기"
    $0.textColor = Color.black.getColor()
    $0.font = Pretendard.size16.bold()
  }
  
  private let applyButton = UIButton().then {
    $0.setTitle("등록", for: .normal)
    $0.setTitleColor(Color.gray02.getColor(), for: .normal)
    $0.titleLabel?.font = Pretendard.size17.medium()
  }
  
  private let grayLine = UIView().then {
    $0.backgroundColor = Color.gray02.getColor()
  }
  
  override func setupConstraints() {
      super.setupConstraints()
      setLayout()
    }
}

extension WritingNoteViewController {

  override func viewDidLoad() {
    super.viewDidLoad()
    render()
  }

}

// MARK: - Private functions
extension WritingNoteViewController {
  
  private func render() {
    view.addSubview(grayLine)
  }
  
  private func setLayout() {
    navigationItem.leftBarButtonItem = UIBarButtonItem(customView: closeButton)
    navigationItem.titleView = titleLabel
    navigationItem.rightBarButtonItem = UIBarButtonItem(customView: applyButton)
    
    grayLine.snp.makeConstraints{
      $0.top.equalTo(view.safeAreaLayoutGuide.snp.top)
      $0.leading.trailing.equalToSuperview()
      $0.height.equalTo(1)
    }
  }
}
