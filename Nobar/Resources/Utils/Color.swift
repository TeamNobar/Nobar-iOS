//
//  Color.swift
//  Nobar
//
//  Created by Ian on 2022/07/09.
//

import UIKit

enum Color {
  case gray01
  case gray02
  case gray03
  case gray04
  case gray05
  case black
  case white
  case navy01
  case pink01
  case skyblue01
  case red
  case gray_navigationbar
  
  func getColor() -> UIColor {
    switch self {
    case .gray01: return .findProperColor(lightModeColor: ._gray01, darkModeColor: ._gray01)
    case .gray02: return .findProperColor(lightModeColor: ._gray02, darkModeColor: ._gray02)
    case .gray03: return .findProperColor(lightModeColor: ._gray03, darkModeColor: ._gray03)
    case .gray04: return .findProperColor(lightModeColor: ._gray04, darkModeColor: ._gray04)
    case .gray05: return .findProperColor(lightModeColor: ._gray05, darkModeColor: ._gray05)
    case .black: return .findProperColor(lightModeColor: ._black, darkModeColor: ._black)
    case .white: return .findProperColor(lightModeColor: ._white, darkModeColor: ._white)
    case .navy01: return .findProperColor(lightModeColor: ._navy01, darkModeColor: ._navy01)
    case .pink01: return .findProperColor(lightModeColor: ._pink01, darkModeColor: ._pink01)
    case .skyblue01: return .findProperColor(lightModeColor: ._skyblue01, darkModeColor: ._skyblue01)
    case .red: return .findProperColor(lightModeColor: ._red, darkModeColor: ._red)
    case .gray_navigationbar:
      return .findProperColor(lightModeColor: ._gray_navigationbar, darkModeColor: ._gray_navigationbar)
    }
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

  static var _skyblue01: UIColor {
    UIColor(red: 0.979, green: 0.985, blue: 1, alpha: 1)
  }

  static var _red: UIColor {
    UIColor(red: 0.922, green: 0.341, blue: 0.341, alpha: 1)
  }
}

private extension UIColor {
  static func findProperColor(lightModeColor: UIColor, darkModeColor: UIColor) -> UIColor {
    return UIColor { traits -> UIColor in
      return (traits.userInterfaceStyle == .dark) ? darkModeColor : lightModeColor
    }
  }
}
