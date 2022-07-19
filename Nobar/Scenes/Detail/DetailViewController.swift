//
//  Detail.swift
//  Nobar
//
//  Created by Sua Han on 2022/07/12.
//

import UIKit

final class DetailViewController: BaseViewController {
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
      
    setupTableView()
    registerXibs()
  }
    
    // 테이블 뷰 세팅 관련 함수 정의
    private func setupTableView() {
      detailTableView.delegate = self
      detailTableView.dataSource = self
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
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        return UITableViewCell()
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return identifiers.count
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
      /*
      if indexPath.row == 0 {
          let width = tableView.bounds.width
          let tableHeight = width * (100/375)
          return tableHeight
      }
      else if indexPath.row == 1{
          let width = tableView.bounds.width
          let tableHeight = width * (100/375)
          return tableHeight
      }
      else if indexPath.row == 2{
          let width = tableView.bounds.width
          let tableHeight = width * (150/375)
          return tableHeight
      }
      else if indexPath.row == 3{
          let width = tableView.bounds.width
          let tableHeight = width * (150/375)
          return tableHeight
      }
      */
        return UITableView.automaticDimension
    }
}
