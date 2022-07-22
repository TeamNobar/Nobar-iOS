//
//  Home.swift
//  Nobar
//
//  Created by 김수연 on 2022/07/23.
//

struct Home: Decodable, Hashable {
  var laterRecipeList: [Recipe]?
  var guideList: [Guide]?
  var noBarRecipe: [Recipe]?
}
