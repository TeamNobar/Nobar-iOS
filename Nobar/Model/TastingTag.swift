//
//  TastingTag.swift
//  Nobar
//
//  Created by Ian on 2022/07/13.
//

struct TastingTag: Decodable {
  let id: String
  var category: Int
  var content: String
  var isSelected: Bool
}
