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
  case getTastingTag
  
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
    case .getTastingTag: return "/note/tag"
    }
  }
  
  var method: HTTPMethod {
    switch self {
    case .getMyPage,
        .searchTag,
        .searchBase,
        .searchMain,
        .searchKeyword,
        .getTastingTag:
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
        .getTastingTag:
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
        .getTastingTag:
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
        .getTastingTag:
      
      guard
        let token = UserDefaultStorage.accessToken
      else {
        return ["Content-type": "application/json"]
      }
      
      return [
          "Content-type": "application/json",
          "token": token
      ]

    case .auth: return ["Content-type": "application/json"]
    }
  }
}
