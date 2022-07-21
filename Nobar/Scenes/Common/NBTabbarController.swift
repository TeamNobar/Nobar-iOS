//
//  NBTabbarController.swift
//  Nobar
//
//  Created by Ian on 2022/07/08.
//

import UIKit

final class NBTabbarController: UITabBarController {
  private let newLine = UIView().then {
    $0.backgroundColor = Color.gray01.getColor()
    $0.frame.size = CGSize(width: UIScreen.main.bounds.size.width, height: 1)
  }
}

// MARK: - Initialize
extension NBTabbarController {
  override func viewDidLoad() {
    super.viewDidLoad()
        
    self.setTabbarAppearance()
  }
}

// MARK: - Private functions
extension NBTabbarController {
  private func setTabbarAppearance() {
    let appearance = UITabBarAppearance()
    appearance.configureWithOpaqueBackground()
    appearance.backgroundColor = Color.skyblue01.getColor()
    self.tabBar.insertSubview(newLine, at: 1)
    self.tabBar.standardAppearance = appearance
    self.tabBar.scrollEdgeAppearance = appearance
  }
}
