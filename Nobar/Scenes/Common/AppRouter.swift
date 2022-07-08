//
//  AppRouter.swift
//  Nobar
//
//  Created by Ian on 2022/07/08.
//

import UIKit

private enum AppRouterChild {
  case onboarding(navigationController: UINavigationController)
  case tabs(tabNavigationController: UITabBarController)
}

final class AppRouter: BaseRouter {
  var tabbarController: UITabBarController
  
  init(tabbarController: UITabBarController) {
    self.tabbarController = tabbarController
  }
}

// MARK: - Public functions
extension AppRouter {
  func start() {
    showTabbar()
  }
}

// MARK: - Private functions
extension AppRouter {
  private func showTabbar() {
    let tabbarRouter = TabbarRouter(with: tabbarController)
    tabbarRouter.start()
  }
}
