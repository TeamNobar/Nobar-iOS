//
//  UILabel+Extension.swift
//  Nobar
//
//  Created by 이유진 on 2022/07/12.
//

import UIKit

extension UILabel {
    func setAttributedText(defaultText: String, containText: String? = nil,
                           font: UIFont? = nil, color: UIColor? = nil,
                           kernValue: CGFloat? = nil, lineSpacing: CGFloat? = nil) {
        let mutableAttributedText = NSMutableAttributedString(string: defaultText)
        
        if let font = font {
            mutableAttributedText.addAttribute(.font, value: font, range: (defaultText as NSString).range(of: containText ?? defaultText))
        }
        
        if let color = color {
            mutableAttributedText.addAttribute(.foregroundColor, value: color, range: (defaultText as NSString).range(of: containText ?? defaultText))
        }
        
        if let kernValue = kernValue {
            mutableAttributedText.addAttribute(.kern, value: kernValue, range: NSRange(0...defaultText.count-1))
        }
        
        if let lineSpacing = lineSpacing {
            let paragraphStyle = NSMutableParagraphStyle()
            paragraphStyle.lineSpacing = lineSpacing
            paragraphStyle.lineBreakMode = .byTruncatingTail
            mutableAttributedText.addAttribute(NSAttributedString.Key.paragraphStyle, value: paragraphStyle, range: NSRange(0...defaultText.count-1))
        }
        
        self.attributedText = mutableAttributedText
    }
}
