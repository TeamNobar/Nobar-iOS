//
//  CocktailModel.swift
//  Nobar
//
//  Created by 이유진 on 2022/07/14.
//

import Foundation

struct CocktailModel {
  var cocktailName: String
  var cocktailEngName: String
  var base: String
}

extension CocktailModel {
  static let dummyCocktailList: [CocktailModel] = [
    CocktailModel(cocktailName: "롱 아일랜드 아이스티", cocktailEngName: "Long Island Iced Tea", base: "진"),
    CocktailModel(cocktailName: "스트로베리 레몬 그라스 바질 진 샤워", cocktailEngName: "Long Island Iced Tea", base: "진"),
    CocktailModel(cocktailName: "위스키 토디", cocktailEngName: "Whisky Toddy", base: "위스키"),
    CocktailModel(cocktailName: "엘더플라워 퍼퓸 다이키리", cocktailEngName: "elder flower Perfume Daiguiri", base: "럼")
  ]
}
