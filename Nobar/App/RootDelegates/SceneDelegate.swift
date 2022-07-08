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

    // tabbar도 커스텀 해서 맥이시고요
    appRouter = AppRouter(tabbarController: UITabBarController())
    window = UIWindow(windowScene: scene)
    window?.rootViewController = appRouter?.tabbarController
    appRouter?.start()
    window?.makeKeyAndVisible()
  }
}
