//
//  NBTabbarController.swift
//  Nobar
//
//  Created by Ian on 2022/07/08.
//

import UIKit

final class NBTabbarController: UITabBarController { }

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
    appearance.backgroundColor = .white
    self.tabBar.standardAppearance = appearance
    self.tabBar.scrollEdgeAppearance = appearance
  }
}
