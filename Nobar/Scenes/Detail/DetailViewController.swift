//
//  Detail.swift
//  Nobar
//
//  Created by Sua Han on 2022/07/12.
//

import UIKit

final class DetailViewController: BaseViewController {
  
  private let networkService = NetworkingService()
  private var recipeDetailResponse: RecipeDetailResponse?
  
  @IBOutlet weak var cocktailNameLabel: UILabel!
  @IBOutlet weak var cocktailEngNameLabel: UILabel!
  
  @IBOutlet weak var cocktailNameHeaderView: UIView!
  @IBOutlet weak var detailTableView: UITableView!
  
    private lazy var backButton = UIButton().then {
    $0.setImage(ImageFactory.btnBackSearch, for: .normal)
    $0.addTarget(self, action: #selector(didClickOnBackButton(_:)), for: .touchUpInside)
  }
  
  private lazy var heartButton = UIButton().then {
    $0.setImage(ImageFactory.iconHeart, for: .normal)
  }
  
  private let identifiers = [
    InfoTableViewCell.identifier,
    HeaderReadyTableViewCell.identifier,
    IngredientsTableViewCell.identifier,
    HeaderMakeTableViewCell.identifier,
    StepsTableViewCell.identifier,
    HeaderRecordTableViewCell.identifier,
    RecordTableViewCell.identifier
  ]
  
  var recipeId: String
  
  init?(
    recipeId: String = "62d9dd8e660f5dfade9a4f77",
    coder: NSCoder
  ) {
    self.recipeId = recipeId
    
    super.init(coder: coder)
  }
  
  required init?(coder: NSCoder) {
    self.recipeId = "62d9dd8e660f5dfade9a4f77"
    
    super.init(coder: coder)
  }
  
  override func viewDidLoad() {
    super.viewDidLoad()
    
    initializeView()
    setupTableView()
    registerXibs()
    setNavigationBar()
    
    fetchDetaileViewInfo()
  }
  
  private func initializeView() {
    cocktailNameLabel.font = Pretendard.size20.bold()
    cocktailNameLabel.textColor = Color.black.getColor()
    
    cocktailEngNameLabel.font = Pretendard.size12.regular()
    cocktailEngNameLabel.textColor = Color.gray04.getColor()
  }
  
  // 테이블 뷰 세팅 관련 함수 정의
  private func setupTableView() {
    detailTableView.delegate = self
    detailTableView.dataSource = self
  }
  
  // 셀 등록 관련 함수 정의
  private func registerXibs() {
    var nib: [UINib] = []
    
    identifiers.forEach {
      nib.append(UINib(nibName: $0, bundle: nil))
    }
    nib.enumerated().forEach {
      detailTableView.register($1, forCellReuseIdentifier: identifiers[$0])
    }
  }
  
  private func setNavigationBar() {
    navigationController?.navigationBar.isHidden = false
    navigationItem.leftBarButtonItem = UIBarButtonItem(customView: backButton)
    navigationItem.rightBarButtonItem = UIBarButtonItem(customView: heartButton)
  }
  
  @objc func didClickOnBackButton(_ sender: UIButton) {
    self.navigationController?.popViewController(animated: true)
  }
}

// MARK: - Private function
extension DetailViewController {
  private func fetchDetaileViewInfo() {
    let endpoint = Endpoint<RecipeDetailResponse>(apiRouter: .getRecipe(id: recipeId))
    
    networkService.request(endpoint) { result in
      switch result {
      case .success(let response):
        DispatchQueue.main.async {
          self.recipeDetailResponse = response
          self.cocktailNameLabel.text = response.name
          self.cocktailEngNameLabel.text = response.enName
          self.detailTableView.reloadData()
        }

      case .failure(let error):
        print("[\(#file) \(#line)번째 줄, \(#function):]", String(describing: error))
      }
    }
  }
}

extension DetailViewController: UITableViewDelegate, UITableViewDataSource {
  
  func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    return identifiers.count
  }
  
  func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
    
    if indexPath.row == 0 {
      let width = tableView.bounds.width
      let tableHeight = width * (112/375)
      return tableHeight
    }
    else if indexPath.row == 1 {
      let width = tableView.bounds.width
      let tableHeight = width * (63/375)
      return tableHeight
    }
    else if indexPath.row == 2 { //반응형
      let width = tableView.bounds.width
      let tableHeight = width * (194/375)
      return tableHeight
    }
    else if indexPath.row == 3 {
      let width = tableView.bounds.width
      let tableHeight = width * (79/375)
      return tableHeight
    }
    else if indexPath.row == 4 {
      let width = tableView.bounds.width
      let tableHeight = width * (150/375)
      return tableHeight
    }
    else if indexPath.row == 5 {
      let width = tableView.bounds.width
      let tableHeight = width * (73/375)
      return tableHeight
    }
    else if indexPath.row == 6 {
      let width = tableView.bounds.width
      let tableHeight = width * (216/375)
      return tableHeight
    }
    
    return UITableView.automaticDimension
  }
  
  func tableView(
    _ tableView: UITableView,
    cellForRowAt indexPath: IndexPath
  ) -> UITableViewCell {
    switch indexPath.row {
    case 0:
      guard
        let cell = detailTableView.dequeueReusableCell(
        withIdentifier: identifiers[0],
        for: indexPath
      ) as? InfoTableViewCell
      else {
        return UITableViewCell()
      }
      
      if let recipeDetailResponse = recipeDetailResponse {
        cell.updateCocktailInfo(with: recipeDetailResponse)
      }
      
      return cell
    case 1:
      guard
        let cell = detailTableView.dequeueReusableCell(
        withIdentifier: identifiers[1],
        for: indexPath
      ) as? HeaderReadyTableViewCell
      else {
        return UITableViewCell()
      }
      
      return cell
    case 2:
      guard
        let cell = detailTableView.dequeueReusableCell(
        withIdentifier: identifiers[2],
        for: indexPath
      ) as? IngredientsTableViewCell
      else {
        return UITableViewCell()
      }
      
      guard let ingredients = recipeDetailResponse?.ingredients else { return cell }
      
      cell.updateIngredientInfo(ingredients)
      return cell
    case 3:
      guard
        let cell = detailTableView.dequeueReusableCell(
        withIdentifier: identifiers[3],
        for: indexPath
      ) as? HeaderMakeTableViewCell
      else {
        return UITableViewCell()
      }
      
      return cell
    case 4:
      guard
        let cell = detailTableView.dequeueReusableCell(
        withIdentifier: identifiers[4],
        for: indexPath
      ) as? StepsTableViewCell
      else {
        return UITableViewCell()
      }
      
      guard let response = recipeDetailResponse else { return cell }
      
      cell.addRecipeStep(with: response.steps)
      return cell
    case 5:
      guard
        let cell = detailTableView.dequeueReusableCell(
        withIdentifier: identifiers[5],
        for: indexPath
      ) as? HeaderRecordTableViewCell
      else {
        return UITableViewCell()
      }
      
      return cell
    case 6:
      guard
        let cell = detailTableView.dequeueReusableCell(
        withIdentifier: identifiers[6],
        for: indexPath
      ) as? RecordTableViewCell
      else {
        return UITableViewCell()
      }
      
      cell.delegate = self
      
      return cell
    default:
      return UITableViewCell()
    }
  }
}

extension DetailViewController: RecordTapDelegate {
  func didClickOnWriteButton() {
    let writingNoteViewController = WritingNoteViewController(status: .newWriting)
    writingNoteViewController.modalPresentationStyle = .fullScreen
    self.present(writingNoteViewController, animated: true)
  }
}
