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
      return [
          "Content-type": "application/json",
          "token": "eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJ1c2VyIjp7ImlkIjoiNjJkOWRkYmFkYmI1NDBiODhjZDVlZGM4In0sImlhdCI6MTY1ODQ3NjAwMCwiZXhwIjo0NzgyNjc4NDAwfQ.PDvodnxCJrq8XTxoZIcYdNheK9FSB-wjjfe2_t8-D-Q"
      ]

    case .auth: return ["Content-type": "application/json"]
    }
  }
}
