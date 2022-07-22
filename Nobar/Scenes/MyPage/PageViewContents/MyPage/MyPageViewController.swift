//
//  MyPageViewController.swift
//  Nobar
//
//  Created by Ian on 2022/07/08.
//

import UIKit

import RxSwift

final class MyPageViewController: BaseViewController {
  typealias Input = MyPageViewModel.Input
  typealias Output = MyPageViewModel.Output
  
  private lazy var pageViewController = NBPageViewController(
    segmentTitles: ["테이스팅 노트", "나중에 만들 레시피"],
    on: self
  )

  private let viewModel: MyPageViewModelType
  private let disposeBag = DisposeBag()
    
  init(viewModel: MyPageViewModelType) {
    self.viewModel = viewModel
    
    super.init(nibName: nil, bundle: nil)
  }
  
  required init?(coder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }
  
  override func viewDidLoad() {
    super.viewDidLoad()

    layoutSubviews()
    setViewControllerBackgroundColor()
    setupTabbarControllersChild()

    bind()
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
  func bind() {
    let input = Input(
      viewWillAppear: self
        .rx
        .methodInvoked(#selector(UIViewController.viewWillAppear(_:))).map { _ in }
    )
    
    let output = viewModel.transform(to: input)
    
    output
      .myPageResponse
      .asDriver { _ in .never() }
      .drive { [weak self] myPageResponse in
        self?.setupNavigationBar(with: myPageResponse.nickName)
      }.disposed(by: self.disposeBag)
  }
}

extension MyPageViewController {
  private func setViewControllerBackgroundColor() {
    self.view.backgroundColor = Color.white.getColor()
  }
  
  private func layoutSubviews() {
    view.addSubview(pageViewController)
  }
  
  private func setupTabbarControllersChild() {
    pageViewController.setTabContentsItem(
      contentPages: [
        createTastingNoteViewController(),
        createMakeOnLaterRecipesViewController()
      ]
    )
  }
  
  private func setupNavigationBar(with nickname: String) {
    navigationItem.titleView = MyPageNavigationView(nickName: nickname)
  }
}

extension MyPageViewController {
  private func createMakeOnLaterRecipesViewController() -> MakeOnLaterRecipesViewController {
    let repository = MakeOnLaterRecipesRepository(networkService: NetworkingService())
    let viewModel = MakeOnLaterRecipesViewModel(repository: repository)
    
    return MakeOnLaterRecipesViewController(viewModel: viewModel)
  }
  
  private func createTastingNoteViewController() -> TastingNoteViewController {
    let repository = TastingNoteRepository(networkService: NetworkingService())
    let viewModel = TastingNoteViewModel(repository: repository)
    
    return TastingNoteViewController(viewModel: viewModel)
  }
}

enum NBError: Error {
  case unknownError
  case weakReferenceError
}
