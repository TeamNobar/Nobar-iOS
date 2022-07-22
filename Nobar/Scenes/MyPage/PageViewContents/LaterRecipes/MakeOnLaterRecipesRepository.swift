//
//  MakeOnLaterRecipesRepository.swift
//  Nobar
//
//  Created by Ian on 2022/07/20.
//

import Foundation
import RxSwift

protocol MakeOnLaterRecipiesRepositoryType {
  func fetchMyPageInfo() -> Observable<MyPageResponse>
}

final class MakeOnLaterRecipesRepository {
  private let networkService: Networking
  
  init(networkService: Networking) {
    self.networkService = networkService
  }
}

extension MakeOnLaterRecipesRepository: MakeOnLaterRecipiesRepositoryType {
  func fetchMyPageInfo() -> Observable<MyPageResponse> {
    let endpoint = Endpoint<MyPageResponse>(apiRouter: .getMyPage)
    
    var mypageResponse: MyPageResponse?
    if let path = Bundle.main.path(forResource: "mypagejson", ofType: "json"),
       let jsonData = try? String(contentsOfFile: path).data(using: .utf8) {
      mypageResponse = try? JSONDecoder().decode(MyPageResponse.self, from: jsonData)
    } else {
      mypageResponse = nil
    }
  
    return Observable.just(mypageResponse!)
//    return networkService.requestObservable(endpoint)
  }
}
