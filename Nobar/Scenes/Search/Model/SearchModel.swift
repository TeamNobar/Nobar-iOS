//
//  Search.swift
//  Nobar
//
//  Created by 김수연 on 2022/07/13.
//

import Foundation

struct SearchModel {
  var order: Int
  var recommendKeyword: String
}

extension SearchModel {
  static let dummyRecommendList: [SearchModel] = [
    SearchModel(order: 1, recommendKeyword: "카시스 오렌지"),
    SearchModel(order: 2, recommendKeyword: "블루 하와이"),
    SearchModel(order: 3, recommendKeyword: "미도리 샤워"),
    SearchModel(order: 4, recommendKeyword: "선라이즈 피치"),
    SearchModel(order: 5, recommendKeyword: "브랜디")
  ]
}
