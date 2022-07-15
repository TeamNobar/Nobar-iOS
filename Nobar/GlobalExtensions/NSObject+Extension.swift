//
//  NSObject+Extension.swift
//  Nobar
//
//  Created by 김수연 on 2022/07/13.
//

import Foundation

extension NSObject {
    static var className: String {
        return String(describing: self)
    }
}
