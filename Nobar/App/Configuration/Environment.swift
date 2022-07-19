//
//  Environment.swift
//  Nobar
//
//  Created by Ian on 2022/07/06.
//

import Foundation

// TODO: BaseURL 나오면 교체 - 승호, 2022. 07. 13 -
struct Environment {
  enum URL {
    #if DEBUG
    static let baseUrl = "https://api.itbook.store/1.0"
    #else
    static let baseUrl = ""
    #endif
  }
}
