//
//  Data+Extensions.swift
//  Nobar
//
//  Created by Ian on 2022/07/13.
//

import Foundation

extension Data {
  var toPrettyPrintedString: String? {
    guard
      let object = try? JSONSerialization.jsonObject(with: self, options: []),
      let data = try? JSONSerialization.data(withJSONObject: object, options: [.prettyPrinted]),
      let prettyPrintedString = NSString(data: data, encoding: String.Encoding.utf8.rawValue)
    else {
      return nil
    }
    
    return prettyPrintedString as String
  }
}
