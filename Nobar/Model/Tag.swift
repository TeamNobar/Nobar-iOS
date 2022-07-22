//
//  Tag.swift
//  Nobar
//
//  Created by Ian on 2022/07/21.
//

import Foundation

struct Tag: Decodable {
  let id: Int
  var isSelected: Bool
  var activeIcon: String
  var inActiveIcon: String
  var content: String
}
