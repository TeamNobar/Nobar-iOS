//
//  TastingNoteRepository.swift
//  Nobar
//
//  Created by Ian on 2022/07/20.
//

import Foundation

import RxSwift
import RxRelay

protocol TastingNoteRepositoryType {
  func fetchMyPageInfo() -> Observable<[TastingNoteSectionType]>
}

final class TastingNoteRepository {
  private let networkService: Networking
  
  init(networkService: Networking) {
    self.networkService = networkService
  }
}

extension TastingNoteRepository: TastingNoteRepositoryType {
  func fetchMyPageInfo() -> Observable<[TastingNoteSectionType]> {
    let endpoint = Endpoint<MyPageResponse>(apiRouter: .getMyPage)
    var sectionElement: [TastingNoteSectionType] = []
  
    return networkService
      .requestObservable(endpoint)
      .map { myPageResponse -> [TastingNoteSectionType] in
        let sortedTastingNotesByCreatedAt = myPageResponse
          .tastingNotes
          .sorted(by: { $0.createdAt < $1.createdAt })
        
        sortedTastingNotesByCreatedAt
          .enumerated()
          .forEach { index, element in
            let isDiffCreatedAtWithBefore = sortedTastingNotesByCreatedAt
              .getBeforeIndexElement(index: index)?
              .getIsDiffCreatedAt(with: element) == true
            
            if isDiffCreatedAtWithBefore || index == 0 {
              sectionElement.append(TastingNoteSectionType.date(element.createdAt))
            }
            
            sectionElement.append(TastingNoteSectionType.content(element))
          }

        return sectionElement
      }
  }
}

enum TastingNoteSectionType {
  case date(String)
  case content(TastingNote)
}

extension Array where Element == TastingNote {
  func getBeforeIndexElement(index: Int) -> Element? {
    guard 1..<count ~= index else { return nil }
    
    return self[index]
  }
}

extension TastingNote {
  func getIsDiffCreatedAt(with before: TastingNote) -> Bool {
    return before.createdAt != self.createdAt
  }
}
