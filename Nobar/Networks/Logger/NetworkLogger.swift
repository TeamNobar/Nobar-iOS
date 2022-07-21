//
//  NetworkLogger.swift
//  Nobar
//
//  Created by Ian on 2022/07/13.
//

import Foundation

import Alamofire

final class NetworkLogger: EventMonitor {
  func requestDidFinish(_ request: Request) {
    print("\n------------------ 🥃 Request Log Start 🥃 -------------------")
    print("[Request] :", request.description)
    
    print(
      "[URL] : " + (request.request?.url?.absoluteString ?? "")  + "\n"
      + "[Method] : " + (request.request?.httpMethod ?? "") + "\n"
      + "[Headers] : " + "\(request.request?.allHTTPHeaderFields ?? [:])" + "\n"
    )
    print("[Body] : " + (request.request?.httpBody?.toPrettyPrintedString ?? "nil"))
  }
  
  func request<Value>(
    _ request: DataRequest,
    didParseResponse response: DataResponse<Value, AFError>
  ) {
    print("\n------------------ 🥃 Response Log Start 🥃 -------------------")
    print(
      "[URL] : " + (request.request?.url?.absoluteString ?? "") + "\n"
      + "[Result] : " + "\(response.result)" + "\n"
      + "[StatusCode] : " + "\(response.response?.statusCode ?? 0)" + "\n"
      + "[Data] : \(response.data?.toPrettyPrintedString ?? "nil")"
    )
  }
}
