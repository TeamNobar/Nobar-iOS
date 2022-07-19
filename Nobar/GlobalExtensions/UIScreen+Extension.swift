//
//  UIScreen+Extension.swift
//  Nobar
//
//  Created by 이유진 on 2022/07/12.
//

import UIKit

public let widthRatio: CGFloat = UIScreen.main.bounds.width / 375
public let heightRatio: CGFloat = UIScreen.main.bounds.height / 812

extension UIScreen {
    
    class public var hasNotch: Bool {
        let deviceRatio
            = UIScreen.main.bounds.width / UIScreen.main.bounds.height
        if deviceRatio > 0.5 {
            return false
        }
        else{
            return true
        }
    }
    
    class public func getNotchHeight() -> Int {
        var topPadding: CGFloat?
        if #available(iOS 11.0, *) {
            let window = UIApplication.shared.keyWindow
            topPadding = window?.safeAreaInsets.top
        }
        
        if #available(iOS 13.0, *) {
            let window = UIApplication.shared.windows[0]
            topPadding = window.safeAreaInsets.top
        }
        return Int(topPadding!)
    }
    
    
    class public func getBottomOfNotchHeight() -> Int {
        var bottomPadding: CGFloat?
        if #available(iOS 11.0, *) {
            let window = UIApplication.shared.keyWindow
            bottomPadding = window?.safeAreaInsets.bottom
        }
        
        if #available(iOS 13.0, *) {
            let window = UIApplication.shared.windows[0]
            bottomPadding = window.safeAreaInsets.top
        }
        return Int(bottomPadding!)
    }
    
    
    class public func getDeviceHeight() -> Int{
        return Int(UIScreen.main.bounds.height)
    }
    
    class public func getDeviceHeight() -> CGFloat{
        return UIScreen.main.bounds.height
    }
    
    
    class func getDeviceWidth() -> Int{
        return Int(UIScreen.main.bounds.width)
    }
    
    class func getDeviceWidth() -> CGFloat{
        return UIScreen.main.bounds.width
    }
}


