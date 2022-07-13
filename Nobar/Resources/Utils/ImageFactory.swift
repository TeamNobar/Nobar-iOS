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

  static var btnBackSearch: UIImage? { UIImage(named: "btnBackSearch") }
  static var icnSearch: UIImage? { UIImage(named: "icnSearch") }
  static var icnUp: UIImage? { UIImage(named: "icnUp") }
  static var icnX: UIImage? { UIImage(named: "icnX") }
}
