//
//  StepDataModel.swift
//  Nobar
//
//  Created by Sua Han on 2022/07/22.
//

import Foundation

struct StepDataModel {
  let step: [String]
}

extension StepDataModel {
  static let sampleData: [StepDataModel] = [
    StepDataModel(
      step: [
        "하이브 글라스 테두리에 소금을 묻힌다",
        "하이브 글라스 테두리에 소금을 묻힌다",
        "하이브 글라스 테두리에 소금을 묻힌다"
        ]
    )
  ]
}
