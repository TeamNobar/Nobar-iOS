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
    
    var mypageResponse: MyPageResponse?
    if let path = Bundle.main.path(forResource: "mypagejson", ofType: "json"),
       let jsonData = try? String(contentsOfFile: path).data(using: .utf8) {
      mypageResponse = try? JSONDecoder().decode(MyPageResponse.self, from: jsonData)
    } else {
      mypageResponse = nil
    }
  
//    return networkService
//      .requestObservable(endpoint)
    return Observable.just(mypageResponse!)
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
              sectionElement.append(TastingNoteSectionType.date(element.readableCreatedAt))
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
    return before.readableCreatedAt != self.readableCreatedAt
  }
}
