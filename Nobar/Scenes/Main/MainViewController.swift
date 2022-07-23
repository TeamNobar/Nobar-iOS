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
  enum SectionType: Int, CaseIterable {
    case archive = 0
    case guide = 1
    case recommend = 2
  }

  private var networkingService = NetworkingService()
  private var laterRecipeList: [Recipe] = []
  private var guideList: [Guide] = []
  
  private let logoView = UIView().then {
    $0.backgroundColor = .white
  }
  
  private let logoImageView = UIImageView().then {
    $0.image = ImageFactory.logo
  }
  private let grayLine = UIView().then{
    $0.backgroundColor = Color.gray02.getColor()
  }
  private lazy var homeCollectionView: UICollectionView = {
    let layout = getLayout()
    layout.configuration.interSectionSpacing = 0
    
    let collectionView = UICollectionView(
      frame: .zero,
      collectionViewLayout: layout)
    collectionView.showsHorizontalScrollIndicator = false
    collectionView.showsVerticalScrollIndicator = false
    collectionView.register(
      SearchTotalResultCollectionViewCell.self,
      forCellWithReuseIdentifier: SearchTotalResultCollectionViewCell.identifier)
    return collectionView
  }()
  
  override func setupConstraints() {
    super.setupConstraints()
    setLayout()
    
  }
  
}

// MARK: - Initialize

extension MainViewController {
  
  override func viewDidLoad() {
    super.viewDidLoad()
    render()
    setDelegation()
    setRegistration()
    getHomeData()
  }

  override func viewWillAppear(_ animated: Bool) {
    super.viewWillAppear(animated)
    navigationController?.navigationBar.isHidden = true
  }
}

// MARK: - Private functions

extension MainViewController {
  
  private func render() {
    view.addSubviews(
      [logoView,grayLine,
       homeCollectionView])
    logoView.addSubview(logoImageView)
  }
  
  private func setLayout() {
    grayLine.isHidden = true
    navigationController?.navigationBar.isHidden = true
    
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
    grayLine.snp.makeConstraints{
      $0.top.equalTo(logoView.snp.bottom)
      $0.leading.trailing.equalToSuperview()
      $0.height.equalTo(1)
    }
    homeCollectionView.snp.makeConstraints {
      $0.top.equalTo(grayLine.snp.bottom)
      $0.leading.trailing.bottom.equalToSuperview()
    }
  }
  
  private func setDelegation() {
    homeCollectionView.delegate = self
    homeCollectionView.dataSource = self
  }
  
  private func setRegistration() {
    homeCollectionView.register(HomeHeaderView.self,
                                forSupplementaryViewOfKind: "HomeHeaderView",
                                withReuseIdentifier: "HomeHeaderView")
    homeCollectionView.register(SearchTotalResultCollectionViewCell.self,
                                forCellWithReuseIdentifier: "SearchTotalResultCollectionViewCell")
    homeCollectionView.register(GuideCVC.self,
                                forCellWithReuseIdentifier: "GuideCVC")
    homeCollectionView.register(RecommendCVC.self,
                                forCellWithReuseIdentifier: "RecommendCVC")
  }
  
}

// MARK: - CollectionView Flow Layout

extension MainViewController {
  private func getArchiveSectionLayout() -> NSCollectionLayoutSection {
    
    let columns = 2
    let spacing = CGFloat(9)
    
    let itemSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1.0),
                                          heightDimension: .estimated(75))
    let item = NSCollectionLayoutItem(layoutSize: itemSize)
    
    let groupSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1.0),
                                           heightDimension: .absolute(75))
    let group = NSCollectionLayoutGroup.horizontal(layoutSize: groupSize, subitem: item, count: columns)
    group.interItemSpacing = .fixed(spacing)
    
    var section = NSCollectionLayoutSection(group: group)
    section.interGroupSpacing = spacing
    section.contentInsets = NSDirectionalEdgeInsets(top: 12, leading: 26, bottom: 30, trailing: 26)
    
    
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
    let group = NSCollectionLayoutGroup.horizontal(
      layoutSize: groupSize,
      subitems: [item])
    
    var section = NSCollectionLayoutSection(group: group)
    section.interGroupSpacing = 12
    section.contentInsets = NSDirectionalEdgeInsets(
      top: 0,
      leading: 26,
      bottom: 12,
      trailing: 32)
    section.orthogonalScrollingBehavior = .continuous
    
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
      widthDimension: .absolute(323),
      heightDimension: .absolute(80)
    )
    let group = NSCollectionLayoutGroup.horizontal(
      layoutSize: groupSize,
      subitems: [item])
    
    var section = NSCollectionLayoutSection(group: group)
    section.interGroupSpacing = 12
    section.contentInsets = NSDirectionalEdgeInsets(
      top: 12,
      leading: 26,
      bottom: 12,
      trailing: 26)
    
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
    let headerSize = NSCollectionLayoutSize(
      widthDimension: .fractionalWidth(1.0),
      heightDimension: .absolute(47))
    let headerSupplementary = NSCollectionLayoutBoundarySupplementaryItem(
      layoutSize: headerSize,
      elementKind: "HomeHeaderView",
      alignment: .top)
    section.boundarySupplementaryItems = [headerSupplementary]
    section.supplementariesFollowContentInsets = false
    return section
  }
}


extension MainViewController: UIScrollViewDelegate{
  func scrollViewDidScroll(_ scrollView: UIScrollView) {
    if scrollView.contentOffset.y > 0{
      grayLine.isHidden = false
    }else{
      grayLine.isHidden = true
    }
  }
}
// MARK: - CollectionViewDelegate
extension MainViewController: UICollectionViewDelegate{
  func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
    guard let sectionType = SectionType(rawValue: indexPath.section) else {return}
    
    switch sectionType {
    case .archive:
      let item = indexPath.item
      if let recipeId = recipeList.safeget(index: item)?.id {
        let storyboard = StoryboardRouter.detail.instance

        let detailViewController = storyboard.instantiateViewController(ofType: DetailViewController.self)
        detailViewController.recipeId = recipeId
        navigationController?.pushViewController(detailViewController, animated: true)
      }
    case .guide:
      let guideVC = GuideDetailViewController()
      let guideNavigationController = UINavigationController(rootViewController: guideVC)
      guideNavigationController.modalPresentationStyle = .fullScreen
      self.present(guideNavigationController, animated: false)
    case .recommend:
      let storyboard = StoryboardRouter.detail.instance
      let detailViewController = storyboard.instantiateViewController(ofType: DetailViewController.self)
      navigationController?.pushViewController(detailViewController, animated: true)

    }
  }
  
}

// MARK: - CollectionViewDataSource

extension MainViewController: UICollectionViewDataSource{
  func numberOfSections(in collectionView: UICollectionView) -> Int {
    return SectionType.allCases.count
  }
  
  func collectionView(_ collectionView: UICollectionView,
                      numberOfItemsInSection section: Int) -> Int {
    guard let sectionType = SectionType(rawValue: section) else { return 1 }
    
    switch sectionType {
    case .archive:
      if laterRecipeList.count>6{
        return 6
      }else{
        return laterRecipeList.count
      }
    case .guide:
      return guideList.count
    case .recommend:
      return RecommendModel.dummyRecommendList.count
    }
    
  }
  
  func collectionView(_ collectionView: UICollectionView,
                      cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
    guard let sectionType = SectionType(rawValue: indexPath.section) else {
      return UICollectionViewCell()
    }
    
    switch sectionType {
    case .archive:
      let cell = homeCollectionView.dequeueReusableCell(ofType: SearchTotalResultCollectionViewCell.self,
                                                        at: indexPath)

      guard let item = laterRecipeList.safeget(index: indexPath.row) else { return cell }
      cell.updateModel(item)
      return cell
    case .guide:
      let cell = homeCollectionView.dequeueReusableCell(ofType: GuideCVC.self,
                                                        at: indexPath)
      guard let item = guideList.safeget(index: indexPath.row) else { return cell }
      cell.setData(with: item)
      return cell
    case .recommend:
      let cell = homeCollectionView.dequeueReusableCell(ofType: RecommendCVC.self,
                                                        at: indexPath)
      cell.setData(with: RecommendModel.dummyRecommendList[indexPath.row])
      return cell
    }
  }
  
  func collectionView(_ collectionView: UICollectionView,
                      viewForSupplementaryElementOfKind kind: String,
                      at indexPath: IndexPath) -> UICollectionReusableView {
    
    if kind == "HomeHeaderView" {
      let headerView = collectionView.dequeueReusableSupplementaryView(ofKind: kind,
                                                                       withReuseIdentifier: "HomeHeaderView",
                                                                       for: indexPath)
      
      guard let headerView = headerView as? HomeHeaderView else { return UICollectionReusableView() }
      
      guard let sectionType = SectionType(rawValue: indexPath.section) else {
        return UICollectionViewCell()
      }
      
      switch sectionType {
      case .archive:
        headerView.configUI(type: .archive)
        headerView.didClickOnSeeAllButtonClosure = {
          let laterRecipeAllViewController = LaterRecipeAllViewController(laterRecipeList: self.laterRecipeList)
          let laterRecipehNavigationController = UINavigationController(rootViewController: laterRecipeAllViewController)
          laterRecipehNavigationController.modalPresentationStyle = .fullScreen
          self.present(laterRecipehNavigationController, animated: true)
        }
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

extension MainViewController {
  private func getHomeData() {
    let endPoint = Endpoint<Home>(apiRouter: .home)

    networkingService.request(endPoint) { [weak self] result in
      switch result {
      case .success(let homeData):
        guard let laterRecipeList = homeData.laterRecipeList,
              let guideList = homeData.guideList
        else { return }

        self?.laterRecipeList = laterRecipeList
        self?.guideList = guideList

        DispatchQueue.main.async {
          self?.homeCollectionView.collectionViewLayout.invalidateLayout()
        }

      case .failure(let error):
        print(String(describing: error), #line)
      }
    }
  }
}
