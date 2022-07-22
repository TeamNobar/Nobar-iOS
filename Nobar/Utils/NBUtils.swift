//
//  NBUtils.swift
//  Nobar
//
//  Created by Ian on 2022/07/22.
//

import UIKit

struct NBUtils {
  static func getSceneDelegate() -> SceneDelegate? {
    return UIApplication
      .shared
      .connectedScenes
      .first?.delegate as? SceneDelegate
  }
}
