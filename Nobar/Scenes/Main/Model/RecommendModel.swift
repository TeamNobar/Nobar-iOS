//
//  RecommendModel.swift
//  Nobar
//
//  Created by 이유진 on 2022/07/14.
//

import Foundation

struct RecommendModel {
  var title: String
  var color: String
  var imageName: String

}

extension RecommendModel {
  static let dummyRecommendList: [RecommendModel] = [
    RecommendModel(title: "12시 귀가를 보장하는 논알콜 칵테일, 신데렐라", color: "#0A2588",imageName: "dummy1"),
    RecommendModel(title: "블루하와이 마셔봤니? 편의점에서 간편하게 재료 겟!", color: "#0E30AA",imageName: "dummy2"),
    RecommendModel(title: "블루하와이 마셔봤니? 편의점에서 간편하게 재료 겟!", color: "#07207A",imageName: "dummy1"),
    RecommendModel(title: "블루하와이 마셔봤니? 편의점에서 간편하게 재료 겟!", color: "#1E43C7",imageName: "dummy2"),
    RecommendModel(title: "블루하와이 마셔봤니? 편의점에서 간편하게 재료 겟!", color: "#0029BC",imageName: "dummy1")
  ]
}

