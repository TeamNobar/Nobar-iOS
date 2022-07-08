//
//  BaseRouter.swift
//  Nobar
//
//  Created by Ian on 2022/07/08.
//

import UIKit

@objc protocol BaseRouter {
  @objc optional var navigationController: UINavigationController { get set }
  @objc optional var tabbarController: UITabBarController { get set }
  
  func start()
}
