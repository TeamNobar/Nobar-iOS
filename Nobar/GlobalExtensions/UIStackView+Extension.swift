//
//  UIStackView+Extension.swift
//  Nobar
//
//  Created by 김수연 on 2022/07/17.
//

import UIKit

extension UIStackView {
  func addArrangedSubviews(_ views: [UIView]) {
    views.forEach { self.addArrangedSubview($0) }
  }
}
