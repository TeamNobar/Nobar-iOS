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
  enum SectionType: Int {
    case archive = 0
    case guide = 1
    case recommend = 2
  }
  
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
    render()
    setDelegation()
    setRegistration()
  }
  
  override func setupConstraints() {
    super.setupConstraints()
    setLayout()
    
  }
  
  private func render() {
    view.addSubviews([logoView,
                      homeCollectionView])
    logoView.addSubview(logoImageView)
  }
  
  private func setLayout() {
    logoView.snp.makeConstraints {
      $0.top.equalTo(view.safeAreaLayoutGuide.snp.top)
      $0.leading.trailing.equalToSuperview()
      $0.height.equalTo(46)
    }
    
    logoImageView.snp.makeConstraints {
      $0.top.equalToSuperview().offset(10)
      $0.leading.equalToSuperview().offset(28)
      $0.width.equalTo(120)
      $0.height.equalTo(24)
    }
    
    homeCollectionView.snp.makeConstraints {
      $0.top.equalTo(logoImageView.snp.bottom)
      $0.leading.trailing.bottom.equalToSuperview()
    }
  }
  
  private func setDelegation() {
      homeCollectionView.delegate = self
      homeCollectionView.dataSource = self
    }
  
  private func setRegistration() {
    homeCollectionView.register(HomeHeaderView.self, forSupplementaryViewOfKind: "HomeHeaderView", withReuseIdentifier: "HomeHeaderView")
    homeCollectionView.register(CocktailCVC.self, forCellWithReuseIdentifier: "CocktailCVC")
    homeCollectionView.register(GuideCVC.self, forCellWithReuseIdentifier: "GuideCVC")
    homeCollectionView.register(RecommendCVC.self, forCellWithReuseIdentifier: "RecommendCVC")
    }
  
}

extension MainViewController {
  private func getArchiveSectionLayout() -> NSCollectionLayoutSection {
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
  }
  private func getGuideSectionLayout() -> NSCollectionLayoutSection {
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
  }
  
  private func getRecommendSectionLayout() -> NSCollectionLayoutSection {
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
  }
  
  private func getLayout() -> UICollectionViewCompositionalLayout {
    UICollectionViewCompositionalLayout { (section, env) -> NSCollectionLayoutSection? in
      switch section {
      case 0: return self.getArchiveSectionLayout()
      case 1: return self.getGuideSectionLayout()
      default: return self.getRecommendSectionLayout()
        
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


extension MainViewController: UICollectionViewDelegate{
  
}

extension MainViewController: UICollectionViewDataSource{
  func numberOfSections(in collectionView: UICollectionView) -> Int {
    return 3
  }
  
  func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
    guard let sectionType = SectionType(rawValue: section) else { return 1 }
    
    switch sectionType {
    case .archive:
      return CocktailModel.dummyCocktailList.count
    case .guide:
      return GuideModel.dummyGuideList.count
    case .recommend:
      return RecommendModel.dummyRecommendList.count
    }
    
  }
  
  func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
    guard let sectionType = SectionType(rawValue: indexPath.section) else {
      return UICollectionViewCell()
    }
    
    switch sectionType {
    case .archive:
      let cell = homeCollectionView.dequeueReusableCell(ofType: CocktailCVC.self, at: indexPath)
      cell.setData(data: CocktailModel.dummyCocktailList[indexPath.row])
      return cell
    case .guide:
      let cell = homeCollectionView.dequeueReusableCell(ofType: GuideCVC.self, at: indexPath)
      cell.setData(data: GuideModel.dummyGuideList[indexPath.row])
      return cell
    case .recommend:
      let cell = homeCollectionView.dequeueReusableCell(ofType: RecommendCVC.self, at: indexPath)
      cell.setData(data: RecommendModel.dummyRecommendList[indexPath.row])
      return cell
    }
  }
  
  func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
    
    if kind == "HomeHeaderView" {
      let headerView = collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: "HomeHeaderView", for: indexPath)
      
      guard let headerView = headerView as? HomeHeaderView else { return UICollectionReusableView() }
      
      guard let sectionType = SectionType(rawValue: indexPath.section) else {
        return UICollectionViewCell()
      }
      
      switch sectionType {
      case .archive:
        headerView.configUI(type: .archive)
      case .guide:
        headerView.configUI(type: .guide)
      case .recommend:
        headerView.configUI(type: .recommend)
      }
      
      return headerView
    } else {
      return UICollectionReusableView()
    }
  }
}
