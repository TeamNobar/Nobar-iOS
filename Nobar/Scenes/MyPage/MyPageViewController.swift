//
//  MyPageViewController.swift
//  Nobar
//
//  Created by Ian on 2022/07/08.
//

import UIKit

final class MyPageViewController: BaseViewController {
  override func viewDidLoad() {
    super.viewDidLoad()
    
    let segmented = NBSegmentedControl(buttonTitles: ["테이스팅 노트", "나중에 만들 레시피"])
    segmented.addTarget(self, action: #selector(test(_:)), for: .valueChanged)
    
    self.view.addSubview(segmented)
    
    segmented.snp.makeConstraints {
      $0.center.equalToSuperview()
      $0.width.equalTo(217)
      $0.height.equalTo(36)
    }
  }
  
  override func setupConstraints() {
    super.setupConstraints()
    
  }
}

extension MyPageViewController {
  @objc private func test(_ sender: NBSegmentedControl) {
    print(sender.selectedIndex)
  }
}

// Example
struct MyPageResponse: Decodable {
  let nickName: String
  let laterRecipes: [Recipe]
  let tastingNotes: [TastingNote]
}
