//
//  Recipe.swift
//  Nobar
//
//  Created by Ian on 2022/07/13.
//

struct Recipe: Decodable, Hashable {
  let id: String
  var name: String
  var enName: String
  var version: [String]?
  var base: BaseRecipe?
  var defaultRecipes: String?
  var proof: Int
  var skill: Skill
  var glass: Glass
  var ingredients: [Ingredient]
  var steps: [String]
}


