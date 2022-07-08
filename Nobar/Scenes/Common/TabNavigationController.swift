//
//  TabNavigationController.swift
//  Nobar
//
//  Created by Ian on 2022/07/08.
//

import UIKit

private enum TabRouterChild: Int {
  case main
  case search
  case writingNote
  case mypage
}

final class TabNavigationController: UITabBarController { }

// MARK: - Initialize
extension TabNavigationController {
  override func viewDidLoad() {
    super.viewDidLoad()
    
    self.delegate = self
  }
}

extension TabNavigationController {
  func start() {
    
  }
}


extension TabNavigationController: UITabBarControllerDelegate {
  
}
