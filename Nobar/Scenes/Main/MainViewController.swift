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
  
  private lazy var homeCollectionView: UICollectionView = {
       let layout = getLayout()
       layout.configuration.interSectionSpacing = 0

       let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
       collectionView.showsHorizontalScrollIndicator = false
       collectionView.showsVerticalScrollIndicator = false
    collectionView.register(CocktailCVC.self, forCellWithReuseIdentifier: CocktailCVC.identifier)
       return collectionView
  }()
  

  override func viewDidLoad() {
    super.viewDidLoad()
  }
  
  override func setupConstraints() {
    <#code#>
  }
}

extension MainViewController {
  private func getLayout() -> UICollectionViewCompositionalLayout {
    UICollectionViewCompositionalLayout { (section, env) -> NSCollectionLayoutSection? in
      switch section {
      case 0:
//        let itemInset: CGFloat = 2.5
        
        let itemSize = NSCollectionLayoutSize(
          widthDimension: .fractionalWidth(0.5),
          heightDimension: .fractionalHeight(1)
        )
        let item = NSCollectionLayoutItem(layoutSize: itemSize)
        item.contentInsets = NSDirectionalEdgeInsets(top: 0, leading: 4.5, bottom: 0, trailing: 4.5)
        
        let groupSize = NSCollectionLayoutSize(
          widthDimension: .fractionalWidth(1.0),
          heightDimension: .estimated(120.0)
        )
        let group = NSCollectionLayoutGroup.horizontal(layoutSize: groupSize, subitems: [item])
        
        var section = NSCollectionLayoutSection(group: group)
        section.contentInsets = NSDirectionalEdgeInsets(top: 12, leading: 26, bottom: 12, trailing: 26)
        
        section = self.addHeaderView(section: section)
        
        return section
      case 1:
        let itemSize = NSCollectionLayoutSize(
          widthDimension: .fractionalWidth(1.0),
          heightDimension: .fractionalHeight(1.0)
        )
        let item = NSCollectionLayoutItem(layoutSize: itemSize)
        
        let groupSize = NSCollectionLayoutSize(
          widthDimension: .absolute(172),
          heightDimension: .absolute(138)
        )
        let group = NSCollectionLayoutGroup.horizontal(layoutSize: groupSize, subitems: [item])
        
        var section = NSCollectionLayoutSection(group: group)
        section.interGroupSpacing = 12
        section.contentInsets = NSDirectionalEdgeInsets(top: 12, leading: 26, bottom: 12, trailing: 26)
        
        section = self.addHeaderView(section: section)
        
        return section
      default:
        let itemSize = NSCollectionLayoutSize(
          widthDimension: .fractionalWidth(1.0),
          heightDimension: .absolute(80)
        )
        let item = NSCollectionLayoutItem(layoutSize: itemSize)
        
        let groupSize = NSCollectionLayoutSize(
          widthDimension: .fractionalWidth(1.0),
          heightDimension: .estimated(456)
        )
        let group = NSCollectionLayoutGroup.vertical(layoutSize: groupSize, subitem: item, count: 5)
        
        var section = NSCollectionLayoutSection(group: group)

        section.orthogonalScrollingBehavior = .continuous
        section = self.addHeaderView(section: section)
        
        return section
      
      }
    }
  }
  
  private func addHeaderView(section: NSCollectionLayoutSection) -> NSCollectionLayoutSection{
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

