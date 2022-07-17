//
//  Networking.swift
//  Nobar
//
//  Created by Ian on 2022/07/13.
//

import Foundation

import RxAlamofire
import RxSwift

protocol Networking {
  func request<Response>(
    _ endpoint: Endpoint<Response>,
    then completion: @escaping (Swift.Result<Response, Error>) -> Void
  )
  func requestObservable<Response>(_ endpoint: Endpoint<Response>) -> Observable<Response>
}
