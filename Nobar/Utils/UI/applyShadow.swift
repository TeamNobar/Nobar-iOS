//
//  applyShadow.swift
//  Nobar
//
//  Created by 이유진 on 2022/07/12.
//

import Foundation
import UIKit
/**

  - Description:
 
      View의 Layer 계층(CALayer)에 shadow를 간편하게 입힐 수 있는 메서드입니다.
      피그마에 나와있는 shadow 속성 값을 그대로 기입하면 됩니다!
 
*/
extension CALayer {
  func applyShadow(
    color: UIColor = .black.withAlphaComponent(0.05),
    alpha: Float = 0.5,
    x: CGFloat = 2,
    y: CGFloat = 2,
    blur: CGFloat = 2,
    spread: CGFloat = 0
  ) {
    
    masksToBounds = false
    shadowColor = color.cgColor
    shadowOpacity = alpha
    shadowOffset = CGSize(width: x, height: y)
    shadowRadius = blur / 2.0
    if spread == 0 {
      shadowPath = nil
    } else {
      let dx = -spread
      let rect = bounds.insetBy(dx: dx, dy: dx)
      shadowPath = UIBezierPath(rect: rect).cgPath
    }
  }
}
