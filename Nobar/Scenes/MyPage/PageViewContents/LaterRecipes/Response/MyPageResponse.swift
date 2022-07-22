//
//  MyPageResponse.swift
//  Nobar
//
//  Created by Ian on 2022/07/20.
//

struct MyPageResponse: Decodable {
  let nickname: String
  let laterRecipes: [Recipe]
  let tastingNotes: [TastingNote]
}
