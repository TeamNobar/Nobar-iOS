//
//  NetworkingService.swift
//  Nobar
//
//  Created by Ian on 2022/07/13.
//

import Foundation

import Alamofire
import RxAlamofire
import RxSwift

final class NetworkingService {
  private let sessionManager: Alamofire.Session
  private let requestQueue: DispatchQueue
  
  init(
    configuration: URLSessionConfiguration = .default,
    requestQueue: DispatchQueue = DispatchQueue(label: "nobar.alamofireQueue")
  ) {
    self.sessionManager = Alamofire.Session(configuration: configuration, eventMonitors: [NetworkLogger()])
    self.requestQueue = requestQueue
  }
}

extension NetworkingService: Networking {
  func request<Response>(
    _ endpoint: Endpoint<Response>,
    then completion: @escaping (Result<Response, Error>) -> Void
  ) {
    let request = self.sessionManager.request(
      endpoint.url,
      method: endpoint.method,
      parameters: endpoint.parameters,
      encoding: endpoint.encoding,
      headers: endpoint.headers
    )
    
    request
      .validate(statusCode: 200...399)
      .responseData(queue: self.requestQueue) { (response) in
        switch response.result {
        case let .success(value):
          do {
            let response = try endpoint.decode(value)
            completion(.success(response))
          } catch (let err) {
            print(err.localizedDescription, #line)
            completion(.failure(err))
          }
        case let .failure(error):
          completion(.failure(error))
        }
      }
  }
  
  func requestObservable<Response>(_ endpoint: Endpoint<Response>) -> Observable<Response> {
    return sessionManager.rx.request(
      endpoint.method,
      endpoint.url,
      parameters: endpoint.parameters,
      encoding: endpoint.encoding,
      headers: endpoint.headers
    )
    .responseData()
    .debug()
    .map { request, data -> Response in
      return try endpoint.decode(data)
    }
  }
}
