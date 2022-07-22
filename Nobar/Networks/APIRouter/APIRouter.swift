//
//  APIRouter.swift
//  Nobar
//
//  Created by Ian on 2022/07/08.
//

import Alamofire

enum APIRouter {
  case getMyPage
  case writeTastingNote(parameters: Parameters)
  case auth(Parameters)
  case searchTag
  case searchBase(base: String)
  case searchMain
  case searchKeyword(keyword: String)
  case home
  case getRecipe(id: String)
  
  var baseURL: String { Environment.URL.baseUrl }
  
  var path: String {
    switch self {
    case .getMyPage: return "/mypage"
    case .writeTastingNote: return "/note"
    case .auth: return "/auth"
    case .searchTag: return "/search/tag"
    case .searchBase: return "/search/base"
    case .searchMain: return "/search"
    case .searchKeyword: return "/search/keyword"
    case .home: return "/home"
    case .getRecipe(let id): return "/recipe/\(id)"
    }
  }
  
  var method: HTTPMethod {
    switch self {
    case .getMyPage,
        .searchTag,
        .searchBase,
        .searchMain,
        .searchKeyword,
        .home,
        .getRecipe:
      return .get
      
    case .writeTastingNote,
        .auth:
      return .post
    }
  }
  
  var parameters: Parameters? {
    switch self {
    case .getMyPage,
        .searchTag,
        .searchMain,
        .home,
        .getRecipe:
      return nil
      
    case .writeTastingNote(let parameters),
        .auth(let parameters):
      return parameters

    case .searchBase(let base):
      return [
        "base": base
      ]
    case .searchKeyword(let keyword):
      return [
        "keyword": keyword
      ]
    }
  }
  
  var encoding: ParameterEncoding {
    switch self {
    case .getMyPage,
        .writeTastingNote,
        .auth,
        .searchTag,
        .searchMain,
        .home,
        .getRecipe:
      return JSONEncoding.default

    case .searchBase,
        .searchKeyword:
      return URLEncoding.queryString
    }
  }
  
  var headers: HTTPHeaders {
    switch self {
    case .getMyPage,
        .writeTastingNote,
        .searchTag,
        .searchMain,
        .searchBase,
        .searchKeyword,
        .home,
        .getRecipe:
      
      guard
        let token = UserDefaultStorage.accessToken
      else {
        return [
          "Content-type": "application/json",
          "token": "eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJ1c2VyIjp7ImlkIjoiNjJkOWRkYmFkYmI1NDBiODhjZDVlZGM4In0sImlhdCI6MTY1ODQ3NjAwMCwiZXhwIjo0NzgyNjc4NDAwfQ.PDvodnxCJrq8XTxoZIcYdNheK9FSB-wjjfe2_t8-D-Q"
        ]
      }
      
      return [
          "Content-type": "application/json",
          "token": token
      ]

    case .auth: return ["Content-type": "application/json"]
    }
  }
}
