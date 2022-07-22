//
//  Font.swift
//  Nobar
//
//  Created by Ian on 2022/07/09.
//

import UIKit

enum FontType: String {
  case black
  case bold
  case extraBold
  case extraLightBold
  case light
  case medium
  case regular
  case semibold
  case thin
  
  var fontName: String {
    switch self {
    case .black: return "Pretendard-Black"
    case .bold: return "Pretendard-Bold"
    case .extraBold: return "Pretendard-ExtraBold"
    case .extraLightBold: return "Pretendard-ExtraLight"
    case .light: return "Pretendard-Light"
    case .medium: return "Pretendard-Medium"
    case .regular: return "Pretendard-Regular"
    case .semibold: return "Pretendard-SemiBold"
    case .thin: return "Pretendard-Thin"
    }
  }
}

enum Pretendard {
  case size9
  case size10
  case size11
  case size12
  case size13
  case size14
  case size15
  case size16
  case size17
  case size18
  case size19
  case size20
  case size26
  
  var size: CGFloat {
    switch self {
    case .size9: return 9
    case .size10: return 10
    case .size11: return 11
    case .size12: return 12
    case .size13: return 13
    case .size14: return 14
    case .size15: return 15
    case .size16: return 16
    case .size17: return 17
    case .size18: return 18
    case .size19: return 19
    case .size20: return 20
    case .size26: return 26
    }
  }
  
  func bold() -> UIFont {
    return UIFont(name: FontType.bold.fontName, size: self.size)!
  }
  
  func black() -> UIFont {
    return UIFont(name: FontType.black.fontName, size: self.size)!
  }
  
  func extraBold() -> UIFont {
    return UIFont(name: FontType.extraBold.fontName, size: self.size)!
  }
  
  func extraLightBold() -> UIFont {
    return UIFont(name: FontType.extraLightBold.fontName, size: self.size)!
  }
  
  func light() -> UIFont {
    return UIFont(name: FontType.light.fontName, size: self.size)!
  }
  
  func medium() -> UIFont {
    return UIFont(name: FontType.medium.fontName, size: self.size)!
  }
  
  func regular() -> UIFont {
    return UIFont(name: FontType.regular.fontName, size: self.size)!
  }
  
  func semibold() -> UIFont {
    return UIFont(name: FontType.semibold.fontName, size: self.size)!
  }
  
  func thin() -> UIFont {
    return UIFont(name: FontType.thin.fontName, size: self.size)!
  }
}
