//
//  Ingredient.swift
//  Nobar
//
//  Created by Ian on 2022/07/13.
//

struct Ingredient: Decodable, Hashable {
  let id: String
  var name: String
  var enName: String
  var proof: Int
  var category: String
  var quantity: String?
}
