//
//  EndPoint.swift
//  Nobar
//
//  Created by Ian on 2022/07/13.
//

import Foundation

import Alamofire

typealias Parameters = [String: Any]
typealias Path = String

final class Endpoint<Response> {
  let method: HTTPMethod
  let url: URL
  let parameters: Parameters?
  let encoding: ParameterEncoding
  let decode: (Data) throws -> Response
  let headers: HTTPHeaders
  
  private init(
    method: HTTPMethod,
    url: URL,
    parameters: Parameters? = nil,
    encoding: ParameterEncoding = JSONEncoding.default,
    headers: HTTPHeaders = .default,
    decode: @escaping (Data) throws -> Response
  ) {
    self.method = method
    self.url = url
    self.parameters = parameters
    self.encoding = encoding
    self.headers = headers
    self.decode = decode
  }
}

extension Endpoint where Response: Decodable {
  convenience init(apiRouter: APIRouter) {
    self.init(
      method: apiRouter.method,
      url: URL(string: apiRouter.baseURL + apiRouter.path)!,
      parameters: apiRouter.parameters,
      encoding: apiRouter.encoding,
      headers: apiRouter.headers
    ) {
      try JSONDecoder().decode(Response.self, from: $0)
    }
  }
  
  convenience init(
    method: HTTPMethod = .get,
    url: URL,
    parameters: Parameters? = nil,
    encoding: ParameterEncoding = JSONEncoding.default,
    headers: HTTPHeaders = .default
  ) {
    self.init(
      method: method,
      url: url,
      parameters: parameters,
      encoding: encoding
    ) {
      try JSONDecoder().decode(Response.self, from: $0)
    }
  }
}
