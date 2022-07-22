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
}

final class TastingNoteViewModel {
  struct Input {
    let viewWillAppear: Observable<Void>
  }
  
  struct Output {
    let myPageResponse: Driver<[TastingNoteSectionType]>
  }
  
  let repository: TastingNoteRepositoryType
  
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
        
        return self.repository.fetchMyPageInfo()
      }
    
        
    return .init(myPageResponse: myPageResponse.asDriver { _ in .never() })
  }
}
