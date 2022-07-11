//
//  UILabel+Extension.swift
//  Nobar
//
//  Created by 이유진 on 2022/07/12.
//

import UIKit

extension UILabel {
    func setAttributedText(
        defaultText: String,
        containText: String? = nil,
        font: UIFont? = nil,
        color: UIColor? = nil,
        kernValue: CGFloat? = nil,
        lineSpacing: CGFloat? = nil
    ) {
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
    
    func addSpacing(
        kernValue: CGFloat = -0.6,
        lineSpacing: CGFloat = 0
    ) {
        if let labelText = text, labelText.count > 0 {
            let attributedString = NSMutableAttributedString(string: labelText)
            let paragraphStyle = NSMutableParagraphStyle()
            paragraphStyle.lineSpacing = lineSpacing
            paragraphStyle.alignment = .left
            attributedString.addAttribute(NSAttributedString.Key.kern,
                                          value: kernValue,
                                          range: NSRange(location: 0,
                                                         length: attributedString.length - 1))
            attributedString.addAttribute(NSAttributedString.Key.paragraphStyle,
                                          value: paragraphStyle,
                                          range: NSMakeRange(0, attributedString.length))
            attributedText = attributedString
            
            if #available(iOS 14.0, *) {
                lineBreakStrategy = .hangulWordPriority
            } else {
                lineBreakMode = .byWordWrapping
            }
        }
    }
}
