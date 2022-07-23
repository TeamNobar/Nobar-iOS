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
  
  enum SectionType: Int, CaseIterable {
    case cocktail = 0
    case date = 1
    case taste = 2
    case score = 3
    case evaluation = 4
    case experience = 5
  }
  
  private(set) var writingstatus = WritingStatus.newWriting
  private let networkService = NetworkingService()
  var selectedCocktail = ""
  private var selectedDate = ""
  private var tagOptions: [Tag] = []
  private var selectedTags: [TastingTagDTO] = []
  private var score: Double = 0
  private var evaluationText = ""
  private var exprienceText = ""
  
  private var id: String
  
  init(
    id: String = "62dafdc9c146e2cc2d52f3e2",
    status: WritingStatus
  ) {
    self.id = id
    self.writingstatus = status
    super.init(nibName: nil, bundle: nil)
  }

  required init?(coder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }
  
  private let headerBarView = UIView()
  
  private lazy var closeButton = UIButton().then {
    $0.setImage(ImageFactory.btnCancel, for: .normal)
    $0.addTarget(self, action: #selector(didTapCancelButton(_:)), for: .touchUpInside)
  }
  
  private let titleLabel = UILabel().then{
    $0.text = "테이스팅 노트 기록하기"
    $0.textColor = Color.black.getColor()
    $0.font = Pretendard.size16.bold()
  }
  
  private lazy var applyButton = UIButton().then {
    $0.setTitle("등록", for: .normal)
    $0.setTitleColor(Color.pink01.getColor(), for: .normal)
    $0.titleLabel?.font = Pretendard.size17.medium()
    $0.addTarget(self, action: #selector(didTapApplyButton(_:)), for: .touchUpInside)
  }
  
  private let deleteButton = UIButton().then {
    $0.setImage(ImageFactory.icnDelete, for: .normal)
  }
  private let reviseButton = UIButton().then {
    $0.setImage(ImageFactory.icnModify, for: .normal)
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
    $0.keyboardDismissMode = .onDrag
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
    setNotification()
    fetchTastingNoteTags()
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
      $0.width.height.equalTo(42)
    }
    deleteButton.snp.makeConstraints{
      $0.trailing.equalToSuperview().offset(-10)
      $0.centerY.equalToSuperview()
      $0.width.height.equalTo(42)
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
      $0.leading.trailing.bottom.equalToSuperview()
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
  
  private func setNotification(){
    NotificationCenter.default.addObserver(
      self,
      selector: #selector(keyboardWillShow),
      name: UIResponder.keyboardWillShowNotification,
      object: nil
    )
    
    NotificationCenter.default.addObserver(
      self,
      selector: #selector(keyboardWillHide),
      name: UIResponder.keyboardWillHideNotification,
      object: nil
    )
  }
  
  override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
    view.endEditing(true)
  }
  
  @objc func keyboardWillShow(noti: Notification){
    if let keyboardFrame: NSValue = noti.userInfo?[UIResponder.keyboardFrameEndUserInfoKey] as? NSValue {
      if self.view.frame.origin.y == 0 {
        
        self.view.frame.origin.y -= keyboardFrame.cgRectValue.size.height
      }
    }
  }
  
  @objc func keyboardWillHide(_ noti: NSNotification){
    // 키보드의 높이만큼 화면을 내려준다.
    if let keyboardFrame: NSValue = noti.userInfo?[UIResponder.keyboardFrameEndUserInfoKey] as? NSValue {
      if self.view.frame.origin.y != 0 {
        
        /// naviBar 만큼 내림
        self.view.frame.origin.y += keyboardFrame.cgRectValue.size.height
      }
    }
  }
  
  @objc private func didTapApplyButton(_ sender: UIButton) {
    let param: [String: Any] = [
      "recipeId": "62dafdc9c146e2cc2d52f417",
      "rate": self.score,
      "tagList": self.selectedTags.map { $0.toDictionary() },
      "tasteContent": self.evaluationText,
      "experienceContent": self.exprienceText,
      "createdAt": self.selectedDate
    ]

    let endpoint = Endpoint<WritingNoteResponse>(apiRouter: .writeTastingNote(parameters: param))
    
    networkService.request(endpoint) { result in
      switch result {
      case .success(_):
        DispatchQueue.main.async {
          self.dismiss(animated: true)
        }
      case .failure(let error):
        print("[\(#file) \(#line)번째 줄, \(#function):]", String(describing: error))
      }
    }
  }
  
  @objc private func didTapCancelButton(_ sender: UIButton){
    print("closetapped")
    self.dismiss(animated: true)
  }
}

struct TastingTagDTO {
  let id: Int
  let isSelected: Bool = true
  
  func toDictionary() -> [String: Any] {
    return [
      "id": id,
      "isSelected": isSelected
    ]
  }
}

struct WritingNoteResponse: Decodable {
  
}

extension WritingNoteViewController {
  private func fetchTastingNoteTags() {
    let endpoint = Endpoint<[Tag]>(apiRouter: .getTastingTagList)
    
    networkService.request(endpoint) { result in
      switch result {
      case .success(let response):
        self.tagOptions = response
        DispatchQueue.main.async {
          self.tastingCollectionView.reloadData()
        }
      case .failure(let error):
        print("[\(#file) \(#line)번째 줄, \(#function):]", String(describing: error))
      }
    }
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
      let cell = collectionView.dequeueReusableCell(ofType: SelectCocktailCVC.self, at: indexPath)
      cell.setPlacholder(placeholder: self.selectedCocktail)
      cell.didTapSearchTextfieldClosure = {
        let searchTotalViewController = CocktailNameSearchViewController()
        searchTotalViewController.modalPresentationStyle = .fullScreen
        searchTotalViewController.didTapNameCellClosure = {
          self.selectedCocktail = searchTotalViewController.selectedCocktailName
          cell.setPlacholder(placeholder: self.selectedCocktail)
        }
        
        self.present(searchTotalViewController, animated: false)
      }
      cell.setLayout(for: writingstatus)
      return cell
    case .date:
      let cell = tastingCollectionView.dequeueReusableCell(ofType: SelectDateCVC.self, at: indexPath)
      cell.dateClosure = { [weak self] dateString in
        self?.selectedDate = dateString
      }
      cell.setLayout(for: writingstatus)
      return cell
    case .taste:
      let cell = tastingCollectionView.dequeueReusableCell(ofType: TasteCVC.self, at: indexPath)
      
      cell.selectedTagListClosure = { [weak self] indexArray in
        self?.selectedTags = indexArray.map { TastingTagDTO(id: $0) }
      }
      cell.bind(with: self.tagOptions)
      cell.setLayout(for: writingstatus)
      return cell
    case .score:
      let cell = tastingCollectionView.dequeueReusableCell(ofType: ScoreCVC.self, at: indexPath)
      
      cell.scoreClosure = { [weak self] score in
        self?.score = score
      }
      cell.setLayout(for: writingstatus)
      return cell
    case .evaluation:
      let cell = tastingCollectionView.dequeueReusableCell(ofType: EvaluationCVC.self, at: indexPath)
      
      cell.textCotentClosure = { [weak self] text in
        self?.evaluationText = text
      }
      
      cell.setLayout(for: writingstatus)
      return cell
    case .experience:
      let cell = tastingCollectionView.dequeueReusableCell(ofType: ExperienceCVC.self, at: indexPath)
      
      cell.textContent = { [weak self] text in
        self?.exprienceText = text
      }
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
