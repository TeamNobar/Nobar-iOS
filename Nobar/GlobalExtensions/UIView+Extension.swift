//
//  UIView+Extension.swift
//  Nobar
//
//  Created by 이유진 on 2022/07/11.
//

import Foundation

extension UIView {
    
    func addSubviews(_ views: [UIView]) {
        views.forEach { self.addSubview($0) }
    }
    
    func removeAllSubViews() {
        self.subviews.forEach { $0.removeFromSuperview() }
    }
  
}
