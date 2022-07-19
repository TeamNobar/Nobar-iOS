//
//  Array+Extensions.swift
//  Nobar
//
//  Created by Ian on 2022/07/18.
//

import Foundation

extension Array {
  func safeget(index: Int) -> Element? {
    return index >= 0 && index < count ? self[index] : nil
  }
}
