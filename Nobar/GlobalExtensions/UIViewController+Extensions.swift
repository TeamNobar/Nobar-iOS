//
//  UIViewController+Extensions.swift
//  Nobar
//
//  Created by Ian on 2022/07/06.
//

import UIKit

extension UIView {
    
    func addSubviews(_ views: [UIView]) {
        views.forEach { self.addSubview($0) }
    }
  
}
