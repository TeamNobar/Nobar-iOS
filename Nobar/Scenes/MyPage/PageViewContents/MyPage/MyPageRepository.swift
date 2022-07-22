//
//  MyPageRepository.swift
//  Nobar
//
//  Created by Ian on 2022/07/20.
//

import RxSwift

protocol MyPageRepositoryType {
  func fetchMyPageInfo() -> Observable<MyPageResponse>
}

final class MyPageRepository {
  private let networkService: Networking
  
  init(networkService: Networking) {
    self.networkService = networkService
  }
}

extension MyPageRepository: MyPageRepositoryType {
  func fetchMyPageInfo() -> Observable<MyPageResponse> {
    let endpoint = Endpoint<MyPageResponse>(apiRouter: .getMyPage)
    
    return networkService.requestObservable(endpoint)
  }
}
