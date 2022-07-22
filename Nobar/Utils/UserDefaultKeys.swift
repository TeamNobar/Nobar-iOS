//
//  UserDefaultHelper.swift
//  Nobar
//
//  Created by Ian on 2022/07/22.
//

import Foundation

enum UserDefaultKeys: String {
  case accessToken
  case refreshToken
  case onboarding
}

final class UserDefaultHelper<T> {
  class func value(forKey key: UserDefaultKeys) -> T? {
    if let data = UserDefaults.standard.value(forKey : key.rawValue) as? T {
      return data
    }
    else {
      return nil
    }
  }
  
  static func set(_ value: T, forKey key: UserDefaultKeys) {
    UserDefaults.standard.set(value, forKey : key.rawValue)
  }
  
  static func clearAll() {
    [
      UserDefaultKeys.accessToken.rawValue,
      UserDefaultKeys.refreshToken.rawValue,
      UserDefaultKeys.onboarding.rawValue
    ]
      .forEach {
        UserDefaults.standard.removeObject(forKey: $0)
      }
  }
}
