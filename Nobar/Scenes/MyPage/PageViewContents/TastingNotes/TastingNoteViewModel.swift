//
//  TastingNoteViewModel.swift
//  Nobar
//
//  Created by Ian on 2022/07/20.
//

import Foundation

import RxSwift
import struct RxCocoa.Driver

protocol TastingNoteViewModelType {
  var repository: TastingNoteRepositoryType { get }
  
  func transform(to input: TastingNoteViewModel.Input) -> TastingNoteViewModel.Output
  func signalForErrorStream() -> Observable<Error>
}

final class TastingNoteViewModel {
  struct Input {
    let viewWillAppear: Observable<Void>
  }
  
  struct Output {
    let myPageResponse: Driver<[TastingNoteSectionType]>
  }
  
  let repository: TastingNoteRepositoryType
  let errorSubject = PublishSubject<Error>()
  
  init(repository: TastingNoteRepositoryType) {
    self.repository = repository
  }
}

extension TastingNoteViewModel: TastingNoteViewModelType {
  func transform(to input: Input) -> Output {
    let willAppearTrigger = input.viewWillAppear
    
    let myPageResponse = willAppearTrigger
      .flatMapLatest { [weak self] _ -> Observable<[TastingNoteSectionType]> in
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
