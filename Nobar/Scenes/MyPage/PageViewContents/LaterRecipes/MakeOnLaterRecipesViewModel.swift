//
//  MakeOnLaterRecipesViewModel.swift
//  Nobar
//
//  Created by Ian on 2022/07/20.
//

import RxSwift
import struct RxCocoa.Driver

protocol MakeOnLaterRecipesViewModelType {
  var repository: MakeOnLaterRecipiesRepositoryType { get }
  
  func transform(to input: MakeOnLaterRecipesViewModel.Input) -> MakeOnLaterRecipesViewModel.Output
  func signalForErrorStream() -> Observable<Error>
}

final class MakeOnLaterRecipesViewModel {
  struct Input {
    let viewWillAppear: Observable<Void>
  }
  
  struct Output {
    let myPageResponse: Driver<MyPageResponse>
  }
  
  let repository: MakeOnLaterRecipiesRepositoryType
  let errorSubject = PublishSubject<Error>()
  
  init(repository: MakeOnLaterRecipiesRepositoryType) {
    self.repository = repository
  }
}

extension MakeOnLaterRecipesViewModel: MakeOnLaterRecipesViewModelType {
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
