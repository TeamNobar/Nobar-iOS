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

    let identifiers = [infoTableViewCell.identifier, headerReadyTableViewCell.identifier, ingredientsTableViewCell.identifier ]

  override func viewDidLoad() {
    super.viewDidLoad()
  }
}
