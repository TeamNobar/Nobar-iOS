//
//  BaseRecipe.swift
//  Nobar
//
//  Created by Ian on 2022/07/13.
//

struct BaseRecipe: Decodable {
  let id: String
  var name: String
  var url: String
  var recipes: [String]
}
