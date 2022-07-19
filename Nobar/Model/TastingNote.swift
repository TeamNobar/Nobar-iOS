//
//  TastingNote.swift
//  Nobar
//
//  Created by Ian on 2022/07/13.
//

struct TastingNote: Decodable {
  let id: String
  var rate: Int
  var title: String
  var recipe: Recipe
  var tag: [TastingTag]
  var tasteContent: String
  var experienceContent: String
  var createdAt: Int
}
