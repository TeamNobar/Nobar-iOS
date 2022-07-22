//
//  RecommendModel.swift
//  Nobar
//
//  Created by 이유진 on 2022/07/14.
//

import Foundation
import UIKit

struct RecommendModel {
  var title: String
  var color: String
  var image: UIImage

}

extension RecommendModel {
  static let dummyRecommendList: [RecommendModel] = [
    RecommendModel(title: "몰디브 아니죠.쿠바가 원조입니다.\n모히또 가서 쿠바 한 잔?", color: "#0A2588", image: ImageFactory.imgMojito ?? UIImage()),
    RecommendModel(title: "달콤한 화이트 럼과 떠나는\n와이키키 해변, 블루하와이", color: "#0E30AA",image: ImageFactory.imgBluehawaii ?? UIImage()),
    RecommendModel(title: "뜨거운 여름엔 이 칵테일!\n섹스 온 더 비치", color: "#07207A",image: ImageFactory.imgSexonthebeach ?? UIImage()),
    RecommendModel(title: "그 그 복숭아 맛 나는 칵테일\n달달한 아 그 피치 크러쉬!", color: "#1E43C7",image: ImageFactory.imgPeachcrush ?? UIImage()),
    RecommendModel(title: "12시 귀가를 보장하는\n논알콜 칵테일, 신데렐라", color: "#0029BC",image: ImageFactory.imgCinderella ?? UIImage())
  ]
}

