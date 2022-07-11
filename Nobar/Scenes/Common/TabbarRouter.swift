//
//  TabbarRouter.swift
//  Nobar
//
//  Created by Ian on 2022/07/08.
//

import UIKit
import Then

private enum TabRouterChild: Int {
  case main
  case search
  case writingNote
  case mypage
  
  var title: String {
    switch self {
    case .main: return "main"
    case .search: return "search"
    case .writingNote: return "writingNote"
    case .mypage: return "mypage"
    }
  }
  
  var imageName: String {
    switch self {
    case .main: return "main"
    case .search: return "search"
    case .writingNote: return "writingNote"
    case .mypage: return "mypage"
    }
  }
  
  var storyboard: StoryboardRouter {
    switch self {
    case .main: return .main
    case .search: return .search
    case .writingNote: return .writingNote
    case .mypage: return .mypage
    }
  }
}

final class TabbarRouter: BaseRouter {
  let tabbarController: UITabBarController
  private var childRouter: [TabRouterChild: UINavigationController]
  
  init(with tabBarController: UITabBarController) {
    self.tabbarController = tabBarController
    self.childRouter = [:]
  }
  
  func start() {
    setupMainViewController()
    setupSearchViewController()
    setupWritingNoteViewController()
    setupMyPageViewController()
    
    configureTabbar()
  }
}

// MARK: - Private functions
extension TabbarRouter {
  private func configureTabbar() {
    self.tabbarController.viewControllers = childRouter
      .sorted(by: { $0.0.rawValue < $1.0.rawValue })
      .compactMap { $0.value }
    self.tabbarController.selectedIndex = 0
  }
  
  private func store(with navigationController: UINavigationController, as type: TabRouterChild) {
    childRouter[type] = navigationController
  }
  
  private func free(_ type: TabRouterChild) {
    childRouter[type] = nil
  }
}

// MARK: - Setup Methods
extension TabbarRouter {
  private func setupMainViewController() {
    let storyboard = TabRouterChild.main.storyboard.instance
    let viewController = storyboard.instantiateViewController(ofType: MainViewController.self)
    let navigationController = UINavigationController(rootViewController: viewController).then {
      $0.tabBarItem.title = TabRouterChild.main.title
      $0.tabBarItem.image = UIImage(named: TabRouterChild.main.imageName)
    }
    store(with: navigationController, as: .main)
  }
  
  private func setupSearchViewController() {
    let storyboard = TabRouterChild.search.storyboard.instance
    let viewController = storyboard.instantiateViewController(ofType: SearchViewController.self)
    let navigationController = UINavigationController(rootViewController: viewController).then {
      $0.tabBarItem.title = TabRouterChild.search.title
      $0.tabBarItem.image = UIImage(named: TabRouterChild.search.imageName)
    }
    store(with: navigationController, as: .search)
  }
  
  private func setupWritingNoteViewController() {
    let storyboard = TabRouterChild.writingNote.storyboard.instance
    let viewController = storyboard.instantiateViewController(ofType: WritingNoteViewController.self)
    let navigationController = UINavigationController(rootViewController: viewController).then {
      $0.tabBarItem.title = TabRouterChild.writingNote.title
      $0.tabBarItem.image = UIImage(named: TabRouterChild.writingNote.imageName)
    }
    store(with: navigationController, as: .writingNote)
  }
  
  private func setupMyPageViewController() {
    let storyboard = TabRouterChild.mypage.storyboard.instance
    let viewController = storyboard.instantiateViewController(ofType: MyPageViewController.self)
    let navigationController = UINavigationController(rootViewController: viewController).then {
      $0.tabBarItem.title = TabRouterChild.mypage.title
      $0.tabBarItem.image = UIImage(named: TabRouterChild.mypage.imageName)
    }
    store(with: navigationController, as: .mypage)
  }
}
