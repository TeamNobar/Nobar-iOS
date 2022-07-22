//
//  UserDefaultStorage.swift
//  Nobar
//
//  Created by Ian on 2022/07/22.
//

import Foundation

enum UserDefaultStorage {
  static var accessToken: String? {
    return UserDefaultHelper<String>.value(forKey: .accessToken)
  }
  
  static var refreshToken: String? {
    return UserDefaultHelper<String>.value(forKey: .refreshToken)
  }
  
  static var isFirstVisit: Bool? {
    return UserDefaultHelper<Bool>.value(forKey: .onboarding)
  }
}
