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

    appRouter = AppRouter(tabbarController: NBTabbarController())
    appRouter?.start()
    
    window = UIWindow(windowScene: scene)
//    window?.rootViewController = appRouter?.tabbarController
    window?.rootViewController = UINavigationController(rootViewController: WritingNoteViewController())
    window?.makeKeyAndVisible()
  }
}
