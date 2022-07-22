//
//  IngredientDataModel.swift
//  Nobar
//
//  Created by Sua Han on 2022/07/22.
//

import Foundation

struct IngredientDataModel {
  let Name: String
  let Quantity: String
  let Category: String
}

extension IngredientDataModel {
  static let sampleData: [IngredientDataModel] = [
    IngredientDataModel(
      Name:"다크럼",
      Quantity:"40ml",
      Category:"보드카"
      ),
    IngredientDataModel(
      Name:"자몽주스",
      Quantity:"300ml",
      Category:"주스"
      ),
    IngredientDataModel(
      Name:"소금",
      Quantity:"0ml",  // 이 경우 어떻게 처리하는지?
      Category:"기타"
      ),
    IngredientDataModel(
      Name:"소금",
      Quantity:"50",  // 이 경우 어떻게 처리하는지?
      Category:"기타"
      ),
    IngredientDataModel(
      Name:"소금",
      Quantity:"43",  // 이 경우 어떻게 처리하는지?
      Category:"밍미임"
      ),
    IngredientDataModel(
      Name:"소금",
      Quantity:"10",  // 이 경우 어떻게 처리하는지?
      Category:"기타"
      ),
    IngredientDataModel(
      Name:"소금",
      Quantity:"200",  // 이 경우 어떻게 처리하는지?
      Category:"랄라라"
      )
  ]
}
