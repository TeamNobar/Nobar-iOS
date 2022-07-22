//
//  BaseNavigationController.swift
//  Nobar
//
//  Created by Ian on 2022/07/23.
//

import UIKit

class BaseNavigationController: UINavigationController {
  override func viewDidLoad() {
    super.viewDidLoad()
    
    self.delegate = self
    self.interactivePopGestureRecognizer?.delegate = self
  }
}

extension BaseNavigationController: UINavigationControllerDelegate, UIGestureRecognizerDelegate {
  
}
