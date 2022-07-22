//
//  MyPageViewModel.swift
//  Nobar
//
//  Created by Ian on 2022/07/20.
//

import RxSwift
import struct RxCocoa.Driver

protocol MyPageViewModelType {
  var repository: MyPageRepositoryType { get }
  
  func transform(to input: MyPageViewModel.Input) -> MyPageViewModel.Output
}

final class MyPageViewModel {
  struct Input {
    let viewWillAppear: Observable<Void>
  }
  
  struct Output {
    let myPageResponse: Driver<MyPageResponse>
  }
  
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
        
        return self.repository.fetchMyPageInfo()
      }
    
    return .init(myPageResponse: myPageResponse.asDriver { _ in .never() })
  }
}
