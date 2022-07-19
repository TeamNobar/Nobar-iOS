//
//  MyPageViewController.swift
//  Nobar
//
//  Created by Ian on 2022/07/08.
//

import UIKit

import RxSwift

final class MyPageViewController: BaseViewController {
  private lazy var pageViewController = NBPageViewController(
    segmentTitles: ["테이스팅 노트", "나중에 만들 레시피"],
    on: self
  )
  
  private let tastingNoteViewController = TastingNoteViewController()
  private let makeOnLaterViewcontroller = MakeOnLaterRecipesViewController()

  override func viewDidLoad() {
    super.viewDidLoad()
    
    view.addSubview(pageViewController)
    
    pageViewController.setTabContentsItem(
      contentPages: [
        tastingNoteViewController,
        makeOnLaterViewcontroller
      ]
    )
    
    setupNavigationBar()
  }
  
  override func setupConstraints() {
    super.setupConstraints()
    
    pageViewController.snp.makeConstraints {
      $0.leading.trailing.equalToSuperview()
      $0.top.equalTo(view.safeAreaLayoutGuide.snp.top)
      $0.bottom.equalTo(view.safeAreaLayoutGuide.snp.bottom)
    }
  }
}

extension MyPageViewController {
  private func setupNavigationBar() {
    navigationItem.titleView = MyPageNavigationView()
  }
}
