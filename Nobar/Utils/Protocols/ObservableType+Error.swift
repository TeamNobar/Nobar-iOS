//
//  ObservableType+Error.swift
//  Nobar
//
//  Created by Ian on 2022/07/22.
//

import Alamofire
import RxSwift

extension ObservableType {
  func suppressAndFeedError<T: ObserverType>(into listener: T) -> Observable<Element> where T.Element == Swift.Error {
    return `do`(onError: { error in
      guard let error = error as? AFError else { return }
      
      listener.onNext(error)
    })
    .suppressError()
  }
  
  func suppressError() -> Observable<Element> {
    return retry { e -> Observable<Element> in
      return Observable<Element>.empty()
    }
  }
  
  func feedError<T: ObserverType>(into lister: T) -> Observable<Element> where T.Element == Swift.Error {
    return `do`(onError: { lister.onNext($0) })
  }
}
