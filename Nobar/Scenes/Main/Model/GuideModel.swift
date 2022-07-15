//
//  GuideModel.swift
//  Nobar
//
//  Created by 이유진 on 2022/07/14.
//

import Foundation

struct GuideModel {
  var thumbnailImageName: String
  var titleName: String
}

extension GuideModel {
  static let dummyGuideList: [GuideModel] = [
    GuideModel(thumbnailImageName: "dummy1", titleName: "칵테일 가이드 콘텐츠 02"),
    GuideModel(thumbnailImageName: "dummy2", titleName: "칵테일 가이드 콘텐츠 02"),
    GuideModel(thumbnailImageName: "dummy1", titleName: "칵테일 가이드 콘텐츠 02"),
    GuideModel(thumbnailImageName: "dummy2", titleName: "칵테일 가이드 콘텐츠 02"),
    GuideModel(thumbnailImageName: "dummy1", titleName: "칵테일 가이드 콘텐츠 02")
  ]
}

