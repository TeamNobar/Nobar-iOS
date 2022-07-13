//
//  ImageFactory.swift
//  Nobar
//
//  Created by Ian on 2022/07/09.
//

import UIKit

enum ImageFactory {
  static var someImage: UIImage? {
    UIImage(named: "someImage")
  }
  
    static var logo: UIImage? {
      UIImage(named: "logo")
    }
    
    static var icnTag: UIImage? {
      UIImage(named: "icnTag")
    }
    
    static var dummy1: UIImage? {
      UIImage(named: "dummy1")
    }
    
    static var dummy2: UIImage? {
      UIImage(named: "dummy2")
    }
    
}
