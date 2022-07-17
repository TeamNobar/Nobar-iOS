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
        // detailTableView.dataSource = self
    }
    
    // 셀 등록 관련 함수 정의
    private func registerXibs() {
        let nib = UINib(nibName: InfoTableViewCell.identifier, bundle: nil)
        detailTableView.register(nib, forCellReuseIdentifier: InfoTableViewCell.identifier)
    }
}
    
    extension DetailViewController: UITableViewDelegate {
        func tableView(_ tableView: UITableView,
                       heightForRowAt indexPath: IndexPath) -> CGFloat {
            return 90
        }
    }
