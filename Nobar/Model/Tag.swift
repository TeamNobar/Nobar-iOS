//
//  Tag.swift
//  Nobar
//
//  Created by Ian on 2022/07/21.
//

import Foundation

struct Tag: Decodable {
  let id: String
  var category: Int
  var content: String
}
