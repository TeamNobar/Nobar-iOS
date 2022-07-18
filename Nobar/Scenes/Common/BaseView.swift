//
//  BaseView.swift
//  Nobar
//
//  Created by Ian on 2022/07/18.
//

import UIKit

class BaseView: UIView {
  override init(frame: CGRect) {
    super.init(frame: frame)
    
    initialize()
    setLayouts()
  }
  
  required init?(coder aDecoder: NSCoder) {
    super.init(coder: aDecoder)
    
  }
  
  func initialize() {
    // Override function
  }

  func setLayouts() {
    // Override function
  }
}
