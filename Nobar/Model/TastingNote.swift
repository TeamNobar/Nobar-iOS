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
  var rate: Double
  var experienceContent: String
  var tag: [Tag]
  var tasteContent: String?
  var createdAt: String
}
