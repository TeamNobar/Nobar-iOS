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
    case .main: return "홈"
    case .search: return "검색"
    case .writingNote: return "writingNote"
    case .mypage: return "마이"
    }
  }
  
  var imageName: String {
    switch self {
    case .main: return "airtag"
    case .search: return "ipod"
    case .writingNote: return "writingNote"
    case .mypage: return "face.smiling"
    }
  }
  
  var selectedImageName: String {
    switch self {
    case .main: return "airtag.fill"
    case .search: return "ipod.fill"
    case .writingNote: return "writingNote"
    case .mypage: return "face.smiling.fill"
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
//    setupWritingNoteViewController()
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
    self.tabbarController.tabBar.tintColor = Color.navy01.getColor()
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
      $0.tabBarItem.image = UIImage(systemName: TabRouterChild.main.imageName)
      $0.tabBarItem.selectedImage = UIImage(systemName: TabRouterChild.main.selectedImageName)
    }
    store(with: navigationController, as: .main)
  }
  
  private func setupSearchViewController() {
    let storyboard = TabRouterChild.search.storyboard.instance
    let viewController = storyboard.instantiateViewController(ofType: SearchBaseViewController.self)
    let navigationController = UINavigationController(rootViewController: viewController).then {
      $0.tabBarItem.title = TabRouterChild.search.title
      $0.tabBarItem.image = UIImage(systemName: TabRouterChild.search.imageName)
      $0.tabBarItem.selectedImage = UIImage(systemName: TabRouterChild.search.selectedImageName)
//      $0.tabBarItem.
    }
    store(with: navigationController, as: .search)
  }
  
  private func setupWritingNoteViewController() {
    let storyboard = TabRouterChild.writingNote.storyboard.instance
    let viewController = storyboard.instantiateViewController(ofType: WritingNoteViewController.self)
    let navigationController = UINavigationController(rootViewController: viewController).then {
      $0.tabBarItem.title = TabRouterChild.writingNote.title
      $0.tabBarItem.image = UIImage(named: TabRouterChild.writingNote.imageName)
      $0.tabBarItem.selectedImage = UIImage(systemName: TabRouterChild.writingNote.selectedImageName)
    }
    store(with: navigationController, as: .writingNote)
  }
  
  private func setupMyPageViewController() {
    let storyboard = TabRouterChild.mypage.storyboard.instance
    let viewController = storyboard.instantiateViewController(ofType: MyPageViewController.self)
    let navigationController = UINavigationController(rootViewController: viewController).then {
      $0.tabBarItem.title = TabRouterChild.mypage.title
      $0.tabBarItem.image = UIImage(systemName: TabRouterChild.mypage.imageName)
      $0.tabBarItem.selectedImage = UIImage(systemName: TabRouterChild.mypage.selectedImageName)
    }
    store(with: navigationController, as: .mypage)
  }
}

