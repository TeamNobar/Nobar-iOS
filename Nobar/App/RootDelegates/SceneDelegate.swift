//
//  SceneDelegate.swift
//  Nobar
//
//  Created by Ian on 2022/07/05.
//

import UIKit

class SceneDelegate: UIResponder, UIWindowSceneDelegate {
  var window: UIWindow?
  private var appRouter: BaseRouter?
  
  func scene(
    _ scene: UIScene,
    willConnectTo session: UISceneSession,
    options connectionOptions: UIScene.ConnectionOptions
  ) {
    guard let scene = (scene as? UIWindowScene) else { return }

    window = UIWindow(windowScene: scene)
    window?.rootViewController = SplashViewController()
    window?.makeKeyAndVisible()
  }
}

// MARK: - Public functions
extension SceneDelegate {
  func startTabbar() {
    appRouter = AppRouter(tabbarController: NBTabbarController())
    appRouter?.start()
    
    window?.rootViewController = appRouter?.tabbarController
    window?.overrideUserInterfaceStyle = .light
    window?.makeKeyAndVisible()
  }
  
  func startSignIn() {
    window?.rootViewController = NicknameViewController()
  }
}
