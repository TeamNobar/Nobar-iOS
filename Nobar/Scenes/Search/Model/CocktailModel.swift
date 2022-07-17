//
//  CocktailModel.swift
//  Nobar
//
//  Created by 김수연 on 2022/07/16.
//

import Foundation

// dummy model 입니당 
struct CocktailModel: Hashable {
  var cocktailko: String
  var cocktaileng: String
  var base: String
  var percent: Int
  var skill: String
  var kind: String
}

extension CocktailModel {
  static let dummyCocktailList: [CocktailModel] = [
    CocktailModel(cocktailko: "솔티도그", cocktaileng: "Salty Dog", base: "보드카", percent: 17, skill: "쉐이킹", kind: "온더락"),
    CocktailModel(cocktailko: "모스크바 뮬", cocktaileng: "Moscow Mule", base: "보드카", percent: 40, skill: "빌드", kind: "필스너"),
    CocktailModel(cocktailko: "보드카 에스프레소", cocktaileng: "Vodka Espresso", base: "보드카", percent: 17, skill: "쉐이킹", kind: "칵테일"),
    CocktailModel(cocktailko: "블러디 메리", cocktaileng: "Bloody Mary", base: "보드카", percent: 17, skill: "빌드", kind: "하이볼"),
    CocktailModel(cocktailko: "시 브리즈", cocktaileng: "Sea Breeze", base: "보드카", percent: 10, skill: "스터", kind: "온더락"),
    CocktailModel(cocktailko: "블랙 러시안", cocktaileng: "Black Russian", base: "보드카", percent: 25, skill: "쉐이킹", kind: "칵테일"),
    CocktailModel(cocktailko: "키스 오브 파이어", cocktaileng: "Kiss of Fire", base: "보드카", percent: 40, skill: "쉐이킹", kind: "하이볼"),
    CocktailModel(cocktailko: "애플 마티니", cocktaileng: "Appletini", base: "보드카", percent: 17, skill: "쉐이킹", kind: "알랄랄랄라")
    ]
}
