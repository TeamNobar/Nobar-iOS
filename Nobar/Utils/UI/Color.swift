//
//  Color.swift
//  Nobar
//
//  Created by Ian on 2022/07/09.
//

import UIKit

enum Color {
  static var gray01: UIColor {
    return .findProperColor(lightModeColor: ._gray01, darkModeColor: ._gray01)
  }
  
  static var gray02: UIColor {
    return .findProperColor(lightModeColor: ._gray02, darkModeColor: ._gray02)
  }

  static var gray03: UIColor {
    return .findProperColor(lightModeColor: ._gray03, darkModeColor: ._gray03)
  }

  static var gray04: UIColor {
    return .findProperColor(lightModeColor: ._gray04, darkModeColor: ._gray04)
  }

  static var gray05: UIColor {
    return .findProperColor(lightModeColor: ._gray05, darkModeColor: ._gray05)
  }
  
  static var black: UIColor {
    return .findProperColor(lightModeColor: ._black, darkModeColor: ._black)
  }

  static var white: UIColor {
    return .findProperColor(lightModeColor: ._white, darkModeColor: ._white)
  }
  
  static var navy01: UIColor {
    return .findProperColor(lightModeColor: ._navy01, darkModeColor: ._navy01)
  }

  static var pink01: UIColor {
    return .findProperColor(lightModeColor: ._pink01, darkModeColor: ._pink01)
  }

  static var gray_navigationbar: UIColor {
    return .findProperColor(lightModeColor: ._gray_navigationbar, darkModeColor: ._gray_navigationbar)
  }
}


private extension UIColor {
  static var _gray01: UIColor {
    UIColor(red: 0.983, green: 0.983, blue: 0.983, alpha: 1)
  }
  
  static var _gray02: UIColor {
    UIColor(red: 0.867, green: 0.867, blue: 0.867, alpha: 1)
  }
  
  static var _gray03: UIColor {
    UIColor(red: 0.629, green: 0.629, blue: 0.629, alpha: 1)
  }
  
  static var _gray04: UIColor {
    UIColor(red: 0.504, green: 0.504, blue: 0.504, alpha: 1)
  }
  
  static var _gray05: UIColor {
    UIColor(red: 0.375, green: 0.375, blue: 0.375, alpha: 1)
  }
  
  static var _black: UIColor {
    UIColor(red: 0, green: 0, blue: 0, alpha: 1)
  }
  
  static var _white: UIColor {
    UIColor(red: 1, green: 1, blue: 1, alpha: 1)
  }
  
  static var _navy01: UIColor {
    UIColor(red: 0, green: 0.027, blue: 0.508, alpha: 1)
  }
  
  static var _pink01: UIColor {
    UIColor(red: 0.914, green: 0.2, blue: 0.439, alpha: 1)
  }

  static var _gray_navigationbar: UIColor {
    UIColor(red: 0.921, green: 0.921, blue: 0.921, alpha: 1)
  }
}

private extension UIColor {
  static func findProperColor(lightModeColor: UIColor, darkModeColor: UIColor) -> UIColor {
    return UIColor { traits -> UIColor in
      return (traits.userInterfaceStyle == .dark) ? darkModeColor : lightModeColor
    }
  }
}
