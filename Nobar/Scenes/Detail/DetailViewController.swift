//
//  Detail.swift
//  Nobar
//
//  Created by Sua Han on 2022/07/12.
//

import UIKit


final class DetailViewController: BaseViewController {
  
  @IBOutlet weak var cocktailNameLabel: UILabel!
  @IBOutlet weak var cocktailEngNameLabel: UILabel!
  
  @IBOutlet weak var cocktailNameHeaderView: UIView!
  @IBOutlet weak var detailTableView: UITableView!

  let identifiers = [
    InfoTableViewCell.identifier,
    HeaderReadyTableViewCell.identifier,
    IngredientsTableViewCell.identifier,
    HeaderMakeTableViewCell.identifier,
    StepsTableViewCell.identifier,
    HeaderRecordTableViewCell.identifier,
    RecordTableViewCell.identifier
  ]

  override func viewDidLoad() {
    super.viewDidLoad()
    // Initialization code
    cocktailNameLabel.text = "코스모폴리탄"  //Data
    cocktailNameLabel.font = Pretendard.size20.bold()
    cocktailNameLabel.textColor = Color.black.getColor()
    
    cocktailEngNameLabel.text = "Cosmopolitan"  //Data
    cocktailEngNameLabel.font = Pretendard.size12.regular()
    cocktailEngNameLabel.textColor = Color.gray04.getColor()
    
    
    
    setupTableView()
    registerXibs()
  }
    
    // 테이블 뷰 세팅 관련 함수 정의
    private func setupTableView() {
      detailTableView.delegate = self
      detailTableView.dataSource = self
//      detailTableView.separatorStyle = .none
    }
    
    // 셀 등록 관련 함수 정의
    private func registerXibs() {
      var nib : [UINib] = []
    
      identifiers.forEach{
          nib.append(UINib(nibName: $0, bundle: nil))
      }
      nib.enumerated().forEach{
          detailTableView.register($1, forCellReuseIdentifier: identifiers[$0])
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
      else if indexPath.row == 1{
          let width = tableView.bounds.width
          let tableHeight = width * (63/375)
          return tableHeight
      }
      else if indexPath.row == 2{ //반응형
          let width = tableView.bounds.width
          let tableHeight = width * (194/375)
          return tableHeight
      }
      else if indexPath.row == 3{
          let width = tableView.bounds.width
          let tableHeight = width * (79/375)
          return tableHeight
      }
      else if indexPath.row == 4{
          let width = tableView.bounds.width
          let tableHeight = width * (110/375)
          return tableHeight
      }
      else if indexPath.row == 5{
          let width = tableView.bounds.width
          let tableHeight = width * (73/375)
          return tableHeight
      }
      else if indexPath.row == 6{
          let width = tableView.bounds.width
          let tableHeight = width * (216/375)
          return tableHeight
      }

      return UITableView.automaticDimension
    }
  
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
      switch indexPath.row{
      case 0:
          guard let cell = detailTableView.dequeueReusableCell(
            withIdentifier: identifiers[0], for: indexPath
          ) as? InfoTableViewCell else {return UITableViewCell()}
          return cell
      case 1:
          guard let cell = detailTableView.dequeueReusableCell(
            withIdentifier: identifiers[1], for: indexPath
          ) as? HeaderReadyTableViewCell else {return UITableViewCell()}
          return cell
      case 2:
        guard let cell = detailTableView.dequeueReusableCell(
          withIdentifier: identifiers[2], for: indexPath
          ) as? IngredientsTableViewCell else { return UITableViewCell()}
      case 3:
        guard let cell = detailTableView.dequeueReusableCell(
          withIdentifier: identifiers[3], for: indexPath
        ) as? HeaderMakeTableViewCell else {return UITableViewCell()}
      case 4:
        guard let cell = detailTableView.dequeueReusableCell(
          withIdentifier: identifiers[4], for: indexPath
        ) as? StepsTableViewCell else {return UITableViewCell()}
      case 5:
        guard let cell = detailTableView.dequeueReusableCell(
          withIdentifier: identifiers[5], for: indexPath
        ) as? HeaderRecordTableViewCell else {return UITableViewCell()}
        
      case 6:
        guard let cell = detailTableView.dequeueReusableCell(
          withIdentifier: identifiers[6], for: indexPath
        ) as? RecordTableViewCell else {return UITableViewCell()}
        
      default:
          let cell = UITableViewCell()
          return cell
      }
    return UITableViewCell()
    }
}
