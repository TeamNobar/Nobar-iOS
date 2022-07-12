//
//  UICollectionView+Extensions.swift
//  Nobar
//
//  Created by Ian on 2022/07/08.
//

import UIKit

extension UICollectionView {
  func dequeueReusableCell<T>(
    ofType cellType: T.Type = T.self,
    at indexPath: IndexPath
  ) -> T where T: UICollectionViewCell {
    guard
      let cell = dequeueReusableCell(withReuseIdentifier: cellType.identifier, for: indexPath) as? T
    else {
      return T()
    }

    return cell
  }

  func register<T: UICollectionViewCell>(cell: T.Type,
                                         forCellWithReuseIdentifier reuseIdentifier: String = T.className) {
    register(cell, forCellWithReuseIdentifier: reuseIdentifier)
  }
}

