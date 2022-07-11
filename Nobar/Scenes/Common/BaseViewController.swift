//
//  BaseViewController.swift
//  Nobar
//
//  Created by Ian on 2022/07/08.
//

import UIKit

class BaseViewController: UIViewController {
  
  private(set) var didSetupConstraints = false

  override func viewDidLoad() {
    super.viewDidLoad()
    
    self.overrideUserInterfaceStyle = .light
    self.view.setNeedsUpdateConstraints()
  }
  
  override func updateViewConstraints() {
    if !self.didSetupConstraints {
      self.setupConstraints()
      self.didSetupConstraints = true
    }
    super.updateViewConstraints()
  }

  @objc func setupConstraints() {
    // Override point
  }
}
