//
//  WritingNoteViewController.swift
//  Nobar
//
//  Created by 이유진 on 2022/07/08.
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
  
  var writingstatus = WritingStatus.viewing
  
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
  
  private let deleteButton = UIButton().then {
    $0.setImage(UIImage(systemName: "trash"), for: .normal)
  }
  private let reviseButton = UIButton().then {
    $0.setImage(UIImage(systemName: "pencil"), for: .normal)
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
    setTitleViewLayout()
    
  }
  
}

// MARK: - Private functions
extension WritingNoteViewController {
  
  private func render() {
    view.addSubviews([headerBarView,grayLine,tastingCollectionView])
  }
  private func setTitleViewLayout() {
    headerBarView.addSubviews([closeButton,titleLabel,applyButton,reviseButton,deleteButton])
    
    closeButton.snp.makeConstraints{
      $0.leading.equalToSuperview().offset(15)
      $0.centerY.equalToSuperview()
      $0.width.height.equalTo(42)
    }
    titleLabel.snp.makeConstraints{
      $0.centerX.centerY.equalToSuperview()
    }
    applyButton.snp.makeConstraints{
      $0.trailing.equalToSuperview().offset(-25)
      $0.centerY.equalToSuperview()
    }
    reviseButton.snp.makeConstraints{
      $0.trailing.equalTo(deleteButton.snp.leading).offset(-10)
      $0.centerY.equalToSuperview()
      $0.width.height.equalTo(30)
    }
    deleteButton.snp.makeConstraints{
      $0.trailing.equalToSuperview().offset(-10)
      $0.centerY.equalToSuperview()
      $0.width.height.equalTo(30)
    }
    
    switch writingstatus{
    case .newWriting:
      titleLabel.text = "테이스팅 노트 기록하기"
      applyButton.isHidden = false
      reviseButton.isHidden = true
      deleteButton.isHidden = true
    case .revising:
      titleLabel.text = "테이스팅 노트 수정하기"
      applyButton.isHidden = false
      reviseButton.isHidden = true
      deleteButton.isHidden = true
    case .viewing:
      titleLabel.text = "작성한 테이스팅 노트"
      applyButton.isHidden = true
      reviseButton.isHidden = false
      deleteButton.isHidden = false
    }
    
    
  }
  
  private func setLayout() {
    self.navigationController?.navigationBar.isHidden = true
    view.backgroundColor = .white
    headerBarView.snp.makeConstraints{
      $0.top.equalTo(view.safeAreaLayoutGuide.snp.top)
      $0.leading.trailing.equalToSuperview()
      $0.height.equalTo(44)
    }
    
    grayLine.snp.makeConstraints{
      $0.top.equalTo(headerBarView.snp.bottom)
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
      guard let cell = collectionView.dequeueReusableCell(ofType: SelectCocktailCVC.self,
                                                          at: indexPath) as? SelectCocktailCVC else {return UICollectionViewCell()}
      cell.setLayout(for: writingstatus)
      return cell
    case .date:
      guard let cell = tastingCollectionView.dequeueReusableCell(ofType: SelectDateCVC.self,
                                                                 at: indexPath) as? SelectDateCVC else { return UICollectionViewCell()}
      cell.setLayout(for: writingstatus)
      return cell
    case .taste:
      guard let cell = tastingCollectionView.dequeueReusableCell(ofType: TasteCVC.self,
                                                                 at: indexPath) as? TasteCVC else {return UICollectionViewCell()}
      cell.setLayout(for: writingstatus)
      return cell
    case .score:
      guard let cell = tastingCollectionView.dequeueReusableCell(ofType: ScoreCVC.self,
                                                                 at: indexPath) as? ScoreCVC else {return UICollectionViewCell()}
      cell.setLayout(for: writingstatus)
      return cell
    case .evaluation:
      guard let cell = tastingCollectionView.dequeueReusableCell(ofType: EvaluationCVC.self,
                                                                 at: indexPath) as? EvaluationCVC else {return UICollectionViewCell()}
      cell.setLayout(for: writingstatus)
      return cell
    case .experience:
      guard let cell = tastingCollectionView.dequeueReusableCell(ofType: ExperienceCVC.self,
                                                                 at: indexPath) as? ExperienceCVC else {return UICollectionViewCell()}
      cell.setLayout(for: writingstatus)
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
        headerView.cocktailName = "마티니"
        headerView.configUI(type: .cocktail, status: writingstatus)
      case .date:
        headerView.configUI(type: .date, status: writingstatus)
      case .taste:
        headerView.configUI(type: .taste, status: writingstatus)
      case .score:
        headerView.configUI(type: .score, status: writingstatus)
      case .evaluation:
        headerView.configUI(type: .evaluation, status: writingstatus)
      case .experience:
        headerView.configUI(type: .experience, status: writingstatus)
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
