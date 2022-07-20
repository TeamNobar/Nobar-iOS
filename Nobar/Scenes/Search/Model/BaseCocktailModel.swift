//
//  BaseCocktailModel.swift
//  Nobar
//
//  Created by 김수연 on 2022/07/18.
//

import UIKit

struct BaseCocktailModel {
  var baseImage: UIImage!
  var baseName: String
}

extension BaseCocktailModel {
  static let dummyBaseList: [BaseCocktailModel] = [
    BaseCocktailModel(baseImage: UIImage(named: "AppIcon"), baseName: "보드카"),
    BaseCocktailModel(baseImage: UIImage(named: "AppIcon"), baseName: "위스키"),
    BaseCocktailModel(baseImage: UIImage(named: "AppIcon"), baseName: "진"),
    BaseCocktailModel(baseImage: UIImage(named: "AppIcon"), baseName: "데낄라"),
    BaseCocktailModel(baseImage: UIImage(named: "AppIcon"), baseName: "럼"),
    BaseCocktailModel(baseImage: UIImage(named: "AppIcon"), baseName: "브랜디"),
    BaseCocktailModel(baseImage: UIImage(named: "AppIcon"), baseName: "이승호"),
    BaseCocktailModel(baseImage: UIImage(named: "AppIcon"), baseName: "하이")
  ]
}
