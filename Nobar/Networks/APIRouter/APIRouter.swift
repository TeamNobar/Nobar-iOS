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
  
  var baseURL: String { Environment.URL.baseUrl }
  
  var path: String {
    switch self {
    case .getMyPage: return "/mypage"
    case .writeTastingNote: return "/note"
    case .auth: return "/auth"
    }
  }
  
  var method: HTTPMethod {
    switch self {
    case .getMyPage:
      return .get
      
    case .writeTastingNote,
        .auth:
      return .post
    }
  }
  
  var parameters: Parameters? {
    switch self {
    case .getMyPage:
      return nil
      
    case .writeTastingNote(let parameters),
        .auth(let parameters):
      return parameters
    }
  }
  
  var encoding: ParameterEncoding {
    switch self {
    case .getMyPage,
         .writeTastingNote,
         .auth:
      return JSONEncoding.default
    }
  }
  
  var headers: HTTPHeaders {
    switch self {
    case .getMyPage,
        .writeTastingNote:
      
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
