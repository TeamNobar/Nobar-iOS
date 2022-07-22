//
//  DetailDataModel.swift
//  Nobar
//
//  Created by Sua Han on 2022/07/16.
//

import Foundation

struct RecipeDetailResponse: Decodable {
  let id: String
  var name: String
  var enName: String
  var version: [String]
  var base: BaseRecipe
  var proof: Int
  var proofIcon: String
  var skill: Skill
  var glass: Glass
  var ingredients: [Ingredient]
  var steps: [String]
  var isScrap: Bool
}
