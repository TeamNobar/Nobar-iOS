//
//  MyPageResponse.swift
//  Nobar
//
//  Created by Ian on 2022/07/20.
//

struct MyPageResponse: Decodable {
  let nickName: String
  let laterRecipes: [Recipe]
  let tastingNotes: [TastingNote]
}
