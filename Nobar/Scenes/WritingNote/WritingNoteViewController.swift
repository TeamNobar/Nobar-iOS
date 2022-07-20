//
//  WritingNoteViewController.swift
//  Nobar
//
//  Created by Ian on 2022/07/08. // 작업자 이름 쓰세용
//

import UIKit
import SnapKit
import Then

final class WritingNoteViewController: BaseViewController {
  
  enum SectionType:Int, CaseIterable {
    case cocktail = 0
    case date = 1
    case taste = 2
    case score = 3
    case evaluation = 4
    case experience = 5
  }
  
  private let headerBarView = UIView()
  
  private let closeButton = UIButton().then {
    $0.setImage(ImageFactory.btnCancel, for: .normal)
  }
  
  private let titleLabel = UILabel().then{
    $0.text = "테이스팅 노트 기록하기"
    $0.textColor = Color.black.getColor()
    $0.font = Pretendard.size16.bold()
  }
  
  private let applyButton = UIButton().then {
    $0.setTitle("등록", for: .normal)
    $0.setTitleColor(Color.gray02.getColor(), for: .normal)
    $0.titleLabel?.font = Pretendard.size17.medium()
  }
  
  private let grayLine = UIView().then {
    $0.backgroundColor = Color.gray02.getColor()
  }
  
  private let tastingCollectionView = UICollectionView(frame: .zero, collectionViewLayout: UICollectionViewFlowLayout()).then {
    let layout: UICollectionViewFlowLayout = UICollectionViewFlowLayout()
    layout.scrollDirection = .vertical
    $0.setCollectionViewLayout(layout, animated: false)
    $0.contentInset = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
    $0.backgroundColor = .none
    $0.bounces = true
    $0.showsVerticalScrollIndicator = false
  }
  
  override func setupConstraints() {
    super.setupConstraints()
    setLayout()
  }
}

extension WritingNoteViewController {
  
  override func viewDidLoad() {
    super.viewDidLoad()
    render()
    setDelegation()
    setRegistration()
    
  }
  
}

// MARK: - Private functions
extension WritingNoteViewController {
  
  private func render() {
    view.addSubviews([grayLine,tastingCollectionView])
  }
  
  private func setLayout() {
    navigationItem.leftBarButtonItem = UIBarButtonItem(customView: closeButton)
    navigationItem.titleView = titleLabel
    navigationItem.rightBarButtonItem = UIBarButtonItem(customView: applyButton)
    
    grayLine.snp.makeConstraints{
      $0.top.equalTo(view.safeAreaLayoutGuide.snp.top)
      $0.leading.trailing.equalToSuperview()
      $0.height.equalTo(1)
    }
    
    tastingCollectionView.snp.makeConstraints{
      $0.top.equalTo(grayLine.snp.bottom)
      $0.leading.bottom.trailing.equalToSuperview()
    }
    
  }
  
  private func setDelegation(){
    tastingCollectionView.dataSource = self
    tastingCollectionView.delegate = self
  }
  private func setRegistration() {
    tastingCollectionView.register(TastingNoteHeaderView.self,
                                   forSupplementaryViewOfKind: UICollectionView.elementKindSectionHeader,
                                   withReuseIdentifier: "TastingNoteHeaderView")
    tastingCollectionView.register(SelectCocktailCVC.self,
                                   forCellWithReuseIdentifier: "SelectCocktailCVC")
    tastingCollectionView.register(SelectDateCVC.self,
                                   forCellWithReuseIdentifier: "SelectDateCVC")
    tastingCollectionView.register(TasteCVC.self,
                                   forCellWithReuseIdentifier: "TasteCVC")
    tastingCollectionView.register(ScoreCVC.self,
                                   forCellWithReuseIdentifier: "ScoreCVC")
    tastingCollectionView.register(EvaluationCVC.self,
                                   forCellWithReuseIdentifier: "EvaluationCVC")
    tastingCollectionView.register(ExperienceCVC.self,
                                   forCellWithReuseIdentifier: "ExperienceCVC")
    
  }
}

// MARK: - CollectionViewDelegate
extension WritingNoteViewController: UICollectionViewDelegate{
  
}

// MARK: - CollectionViewDataSource

extension WritingNoteViewController: UICollectionViewDataSource{
  func numberOfSections(in collectionView: UICollectionView) -> Int {
    return SectionType.allCases.count
  }
  
  func collectionView(_ collectionView: UICollectionView,
                      numberOfItemsInSection section: Int) -> Int {
    return 1
  }
  
  func collectionView(_ collectionView: UICollectionView,
                      cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
    guard let sectionType = SectionType(rawValue: indexPath.section) else {
      return UICollectionViewCell()
    }
    
    switch sectionType {
    case .cocktail:
      let cell = collectionView.dequeueReusableCell(ofType: SelectCocktailCVC.self,
                                                    at: indexPath)
      return cell
    case .date:
      let cell = tastingCollectionView.dequeueReusableCell(ofType: SelectDateCVC.self,
                                                           at: indexPath)
      return cell
    case .taste:
      let cell = tastingCollectionView.dequeueReusableCell(ofType: TasteCVC.self,
                                                           at: indexPath)
      return cell
    case .score:
      let cell = tastingCollectionView.dequeueReusableCell(ofType: ScoreCVC.self,
                                                           at: indexPath)
      return cell
    case .evaluation:
      let cell = tastingCollectionView.dequeueReusableCell(ofType: EvaluationCVC.self,
                                                           at: indexPath)
      return cell
    case .experience:
      let cell = tastingCollectionView.dequeueReusableCell(ofType: ExperienceCVC.self,
                                                           at: indexPath)
      return cell
    }
  }
  
  func collectionView(_ collectionView: UICollectionView,
                      viewForSupplementaryElementOfKind kind: String,
                      at indexPath: IndexPath) -> UICollectionReusableView {
    
    if kind == UICollectionView.elementKindSectionHeader{
      let headerView = collectionView.dequeueReusableSupplementaryView(ofKind: kind,
                                                                       withReuseIdentifier: "TastingNoteHeaderView",
                                                                       for: indexPath)
      
      guard let headerView = headerView as? TastingNoteHeaderView else { return UICollectionReusableView() }
      
      guard let sectionType = SectionType(rawValue: indexPath.section) else {
        return UICollectionViewCell()
      }
      
      switch sectionType {
      case .cocktail:
        headerView.configUI(type: .cocktail)
      case .date:
        headerView.configUI(type: .date)
      case .taste:
        headerView.configUI(type: .taste)
      case .score:
        headerView.configUI(type: .score)
      case .evaluation:
        headerView.configUI(type: .evaluation)
      case .experience:
        headerView.configUI(type: .experience)
      }
      return headerView
    } else {
      return UICollectionReusableView()
    }
  }
  
  func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, referenceSizeForHeaderInSection section: Int) -> CGSize { // 섹션의 헤더 너비와 높이 설정
    let width = collectionView.frame.width
    let height: CGFloat = 42
    return CGSize(width: width, height: height)
  }
}

extension WritingNoteViewController: UICollectionViewDelegateFlowLayout {
  func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
    
    guard let sectionType = SectionType(rawValue: indexPath.section) else {
      return CGSize.zero
    }
    
    let cellWidth = collectionView.frame.width
    switch sectionType {
    case .cocktail:
      return CGSize(width: cellWidth, height: 58)
    case .date:
      return CGSize(width: cellWidth, height: 58)
    case .taste:
      return CGSize(width: cellWidth, height: 156)
    case .score:
      return CGSize(width: cellWidth, height: 58)
    case .evaluation:
      return CGSize(width: cellWidth, height: 231)
    case .experience:
      return CGSize(width: cellWidth, height: 231)
    }
  }
}
