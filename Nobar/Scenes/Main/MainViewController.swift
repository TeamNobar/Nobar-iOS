//
//  MainViewController.swift
//  Nobar
//
//  Created by Ian on 2022/07/05.
//

import UIKit

import Then
import SnapKit

final class MainViewController: BaseViewController {

  private let logoView = UIView().then {
    $0.backgroundColor = .white
  }
  
  private let logoImageView = UIImageView().then {
    $0.image = ImageFactory.logo
  }

  override func viewDidLoad() {
    super.viewDidLoad()
  }
}

extension MainViewController {
  static func getLayout() -> UICollectionViewCompositionalLayout {
    UICollectionViewCompositionalLayout { (section, env) -> NSCollectionLayoutSection? in
      switch section {
      case 0:
//        let itemInset: CGFloat = 2.5
        
        // Item
        let itemSize = NSCollectionLayoutSize(
          widthDimension: .fractionalWidth(0.5),
          heightDimension: .fractionalHeight(1)
        )
        let item = NSCollectionLayoutItem(layoutSize: itemSize)
        item.contentInsets = NSDirectionalEdgeInsets(top: 0, leading: 4.5, bottom: 0, trailing: 4.5)
        
        // Group
        let groupSize = NSCollectionLayoutSize(
          widthDimension: .fractionalWidth(1.0),
          heightDimension: .estimated(120.0)
        )
        let group = NSCollectionLayoutGroup.horizontal(layoutSize: groupSize, subitems: [item])
        
        // Section
        var section = NSCollectionLayoutSection(group: group)
        section.contentInsets = NSDirectionalEdgeInsets(top: 12, leading: 26, bottom: 12, trailing: 26)
        
        section = addHeaderView(section: section)
        
        return section
      case 1:
        // Item
        let itemSize = NSCollectionLayoutSize(
          widthDimension: .fractionalWidth(1.0),
          heightDimension: .fractionalHeight(1.0)
        )
        let item = NSCollectionLayoutItem(layoutSize: itemSize)
        
        // Group
        let groupSize = NSCollectionLayoutSize(
          widthDimension: .absolute(172),
          heightDimension: .absolute(138)
        )
        let group = NSCollectionLayoutGroup.horizontal(layoutSize: groupSize, subitems: [item])
        
        // Section
        var section = NSCollectionLayoutSection(group: group)
        section.interGroupSpacing = 12
        section.contentInsets = NSDirectionalEdgeInsets(top: 12, leading: 26, bottom: 12, trailing: 26)
        
        section = addHeaderView(section: section)
        
        return section
      default:
        // Item
        let itemSize = NSCollectionLayoutSize(
          widthDimension: .fractionalWidth(1.0),
          heightDimension: .absolute(80)
        )
        let item = NSCollectionLayoutItem(layoutSize: itemSize)
        
        // Group
        let groupSize = NSCollectionLayoutSize(
          widthDimension: .fractionalWidth(1.0),
          heightDimension: .estimated(456)
        )
        let group = NSCollectionLayoutGroup.vertical(layoutSize: groupSize, subitem: item, count: 5)
        
        // Section
        var section = NSCollectionLayoutSection(group: group)

        section.orthogonalScrollingBehavior = .continuous
        section = addHeaderView(section: section)
        
        return section
      
      }
    }
  }
  
  private static func addHeaderView(section: NSCollectionLayoutSection) -> NSCollectionLayoutSection{
    let headerSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1.0), heightDimension: .absolute(50))
    let headerSupplementary = NSCollectionLayoutBoundarySupplementaryItem(
      layoutSize: headerSize,
      elementKind: "HomeHeaderView",
      alignment: .top)
    section.boundarySupplementaryItems = [headerSupplementary]
    section.supplementariesFollowContentInsets = false
    return section
  }
}
