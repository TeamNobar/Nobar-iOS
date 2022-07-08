//
//  UIStoryboard+Extensions.swift
//  Nobar
//
//  Created by Ian on 2022/07/08.
//

import UIKit

extension UIStoryboard {
  func instantiateViewController<T>(ofType type: T.Type = T.self) -> T where T: UIViewController {
    guard
      let viewController = instantiateViewController(withIdentifier: type.identifier) as? T
    else {
      return T()
    }
    
    return viewController
  }
}
