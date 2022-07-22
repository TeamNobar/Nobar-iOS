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
  case searchTag
  case searchBase(base: String)
  case searchMain
  case searchKeyword(keyword: String)
  
  var baseURL: String { Environment.URL.baseUrl }
  
  var path: String {
    switch self {
    case .getMyPage: return "/mypage"
    case .writeTastingNote: return "/note"
    case .searchTag: return "/search/tag"
    case .searchBase: return "/search/base"
    case .searchMain: return "/search"
    case .searchKeyword: return "/search/keyword"
    }
  }
  
  var method: HTTPMethod {
    switch self {
    case .getMyPage,
        .searchTag,
        .searchBase,
        .searchMain,
        .searchKeyword:
      return .get
      
    case .writeTastingNote:
      return .post
    }
  }
  
  var parameters: Parameters? {
    switch self {
    case .getMyPage,
        .searchTag,
        .searchMain:
      return nil
      
    case .writeTastingNote(let parameters):
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
        .searchTag,
        .searchMain:
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
         .searchBase,
         .searchMain,
         .searchKeyword:
      return [
        "Content-type": "application/json",
        "token": "eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJ1c2VyIjp7ImlkIjoiNjJkOWRkYmFkYmI1NDBiODhjZDVlZGM4In0sImlhdCI6MTY1ODQ3NjAwMCwiZXhwIjo0NzgyNjc4NDAwfQ.PDvodnxCJrq8XTxoZIcYdNheK9FSB-wjjfe2_t8-D-Q"
      ]
    }
  }
}
