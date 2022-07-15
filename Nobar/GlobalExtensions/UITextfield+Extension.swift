//
//  UITextfield+Extension.swift
//  Nobar
//
//  Created by 이유진 on 2022/07/12.
//

import UIKit

extension UITextField {
  func addLeftPadding(width : CGFloat = 10) {
    let paddingView = UIView(frame: CGRect(x: 0, y: 0, width: width, height: self.frame.height))
    self.leftView = paddingView
    self.leftViewMode = ViewMode.always
  }

  func addRightPadding(width : CGFloat = 10) {
    let paddingView = UIView(frame: CGRect(x: 0, y: 0, width: width, height: self.frame.height))
    self.rightView = paddingView
    self.rightViewMode = ViewMode.always
  }

  /// placeholder 컬러, 폰트 변경 메서드
  func setPlaceholderAttributes(_ placeholderColor: UIColor, _ placeholderFont: UIFont) {
    attributedPlaceholder = NSAttributedString(string: placeholder ?? "", attributes: [
      .foregroundColor: placeholderColor,
      .font: placeholderFont].compactMapValues { $0 }
    )
  }
}
