//
//  TastingNote.swift
//  Nobar
//
//  Created by Ian on 2022/07/13.
//

import Foundation

struct TastingNote: Decodable {
  let id: String
  var recipe: Recipe
  var rate: Int
  var experienceContent: String
  var tag: [Int]
  var tasteContent: String
  var createdAt: Int
}

extension Date {
  func getReadableDateString() -> String {
    let formatter = DateFormatter().then {
      $0.dateFormat = "yyyy-MM-dd"
    }
    
    return formatter.string(from: self)
  }
}

extension TastingNote {
  var readableCreatedAt: String {
    let date = Date(timeIntervalSince1970: TimeInterval(createdAt))

    return date.getReadableDateString()
  }
}
