//
//  Identifiable.swift
//  Nobar
//
//  Created by Ian on 2022/07/07.
//

import UIKit

protocol Identifiable {
  static var identifier: String { get }
}

extension Identifiable {
  static var identifier: String {
    return String(describing: self)
  }
}

extension UITableViewCell: Identifiable { }
extension UICollectionViewCell: Identifiable { }
extension UIViewController: Identifiable { }
