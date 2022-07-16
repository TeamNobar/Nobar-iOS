//
//  DetailDataModel.swift
//  Nobar
//
//  Created by Sua Han on 2022/07/16.
//

import Foundation

struct CocktailDetailDataModel {
    let CocktailId: String
    let CocktailName: String
    let CocktailEnName: String
    /*
    let CocktailBase: String?
    let Cocktail: String?
    let CocktailVersion: [String]?
    let Cocktailproof: Int?
    let CocktailSkill: String?
    let CocktailGlass: String?
    let CocktailIngredient: [String]?
    let CocktailSteps: [String]?
    let IsScrap: Bool?
     */
}

struct IngredientDataModel {
    let Ingredient1: String
    let Ingredient2: String
    let Ingredient3: String
    let Ingredient4: String
}

extension CocktailDetailDataModel {
    static let sampleData: [CocktailDetailDataModel] = [
        CocktailDetailDataModel(CocktailId:"1", CocktailName: "칵테일", CocktailEnName: "Cocktail"),
    ]
}
    
extension IngredientDataModel {
    static let sampleData: [IngredientDataModel] = [
        IngredientDataModel(Ingredient1:"보드카", Ingredient2:"21%", Ingredient3:"셰이킹", Ingredient4:"칵테일")
    ]
}
