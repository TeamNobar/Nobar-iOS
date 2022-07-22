//
//  StoryboardRouter.swift
//  Nobar
//
//  Created by Ian on 2022/07/08.
//

import UIKit

enum StoryboardRouter: String {
  case main = "Main"
  case search = "Search"
  case writingNote = "WritingNote"
  case mypage = "MyPage"
  case detail = "Detail"
  
  var instance: UIStoryboard {
    return UIStoryboard(name: rawValue, bundle: .main)
  }
  
  func load<T: UIViewController>(viewControllerType: T.Type) -> T {
    let storyboardID = viewControllerType.identifier
    return instance.instantiateViewController(withIdentifier: storyboardID) as! T
  }
}

