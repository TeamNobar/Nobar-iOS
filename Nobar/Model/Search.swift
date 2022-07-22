//
//  Search.swift
//  Nobar
//
//  Created by 김수연 on 2022/07/21.
//

import Foundation

struct Search: Decodable, Hashable {
  var base: [BaseRecipe]?
  var recipes: [Recipe]?
  var recommends: [Recommend]?
  var ingredients: [Ingredient]?
}

struct Recommend: Decodable, Hashable {
  let recipeId: String
  let name: String
}
