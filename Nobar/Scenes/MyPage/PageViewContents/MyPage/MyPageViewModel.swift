//
//  MyPageViewModel.swift
//  Nobar
//
//  Created by Ian on 2022/07/20.
//

import Alamofire
import RxSwift
import struct RxCocoa.Driver

protocol MyPageViewModelType {
  var repository: MyPageRepositoryType { get }
  
  func transform(to input: MyPageViewModel.Input) -> MyPageViewModel.Output
  func signalForErrorStream() -> Observable<Error>
}

final class MyPageViewModel {
  struct Input {
    let viewWillAppear: Observable<Void>
  }
  
  struct Output {
    let myPageResponse: Driver<MyPageResponse>
  }
  
  let errorSubject = PublishSubject<Error>()
  let repository: MyPageRepositoryType
  
  init(repository: MyPageRepositoryType) {
    self.repository = repository
  }
}

extension MyPageViewModel: MyPageViewModelType {
  func transform(to input: Input) -> Output {
    let willAppearTrigger = input.viewWillAppear
    
    let myPageResponse = willAppearTrigger
      .flatMapLatest { [weak self] _ -> Observable<MyPageResponse> in
        guard let self = self else { return .error(NBError.weakReferenceError) }
        
        return self.repository
          .fetchMyPageInfo()
          .suppressAndFeedError(into: self.errorSubject)
      }
    
    return .init(myPageResponse: myPageResponse.asDriver { _ in .never() })
  }
  
  func signalForErrorStream() -> Observable<Error> {
    return errorSubject.asObserver()
  }
}
