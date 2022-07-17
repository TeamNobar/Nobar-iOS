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
  
  var baseURL: String { Environment.URL.baseUrl }
  
  var path: String {
    switch self {
    case .getMyPage: return "/mypage"
    case .writeTastingNote: return "/note"
    }
  }
  
  var method: HTTPMethod {
    switch self {
    case .getMyPage:
      return .get
      
    case .writeTastingNote:
      return .post
    }
  }
  
  var parameters: Parameters? {
    switch self {
    case .getMyPage:
      return nil
      
    case .writeTastingNote(let parameters):
      return parameters
    }
  }
  
  var encoding: ParameterEncoding {
    switch self {
    case .getMyPage,
         .writeTastingNote:
      return JSONEncoding.default
    }
  }
  
  var headers: HTTPHeaders {
    switch self {
    case .getMyPage,
         .writeTastingNote:
      return ["Content-type": "application/json"]
    }
  }
}
