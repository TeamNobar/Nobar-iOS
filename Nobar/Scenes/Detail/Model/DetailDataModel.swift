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
    let CocktailVersion: [String]?
    let Cocktailproof: Int?
    let CocktailSkill: String?
    let CocktailGlass: String?
    let CocktailIngredient: [String]?
    let CocktailSteps: [String]?
    let IsScrap: Bool?
     */
}


extension CocktailDetailDataModel {
    static let sampleData: [CocktailDetailDataModel] = [
        CocktailDetailDataModel(CocktailId:"1", CocktailName: "칵테일", CocktailEnName: "Cocktail"),
    ]
}

