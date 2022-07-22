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
    
    return networkService.requestObservable(endpoint)
  }
}
