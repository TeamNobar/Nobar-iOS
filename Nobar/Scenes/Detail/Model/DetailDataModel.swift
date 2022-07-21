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

struct IngredientDataModel {
    let IngredientName: String
    let IngredientQuantity: String
    let IngredientCategory: String
}

extension CocktailDetailDataModel {
    static let sampleData: [CocktailDetailDataModel] = [
        CocktailDetailDataModel(CocktailId:"1", CocktailName: "칵테일", CocktailEnName: "Cocktail"),
    ]
}
    
extension IngredientDataModel {
    static let sampleData: [IngredientDataModel] = [
        IngredientDataModel(
            IngredientName:"다크럼",
            IngredientQuantity:"40ml",
            IngredientCategory:"보드카"
        ),
        IngredientDataModel(
            IngredientName:"자몽주스",
            IngredientQuantity:"300ml",
            IngredientCategory:"주스"
        ),
        IngredientDataModel(
            IngredientName:"소금",
            IngredientQuantity:"",  // 이 경우 어떻게 처리하는지?
            IngredientCategory:"기타"
        ),
    ]
}
