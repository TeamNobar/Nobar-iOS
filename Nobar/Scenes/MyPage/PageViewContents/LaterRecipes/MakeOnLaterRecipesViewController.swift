//
//  MakeOnLaterRecipesViewController.swift
//  Nobar
//
//  Created by Ian on 2022/07/18.
//

import UIKit

import RxSwift

final class MakeOnLaterRecipesViewController: BaseViewController {
  typealias Input = MakeOnLaterRecipesViewModel.Input
  typealias Output = MakeOnLaterRecipesViewModel.Output
  
  private enum Metric {
    static let collectionColumnSpacing = 16.f
    static let collectionRowSpacing = 16.f
  }

  private let viewModel: MakeOnLaterRecipesViewModelType
  private let disposeBag = DisposeBag()
  
  private lazy var flowLayout = UICollectionViewFlowLayout().then {
    $0.scrollDirection = .vertical
    $0.estimatedItemSize = UICollectionViewFlowLayout.automaticSize
    $0.minimumInteritemSpacing = Metric.collectionColumnSpacing
    $0.minimumLineSpacing = Metric.collectionRowSpacing
  }
  
  private lazy var collectionView = UICollectionView(
    frame: self.view.bounds,
    collectionViewLayout: self.flowLayout
  ).then {
    $0.alwaysBounceVertical = false
    $0.alwaysBounceHorizontal = false
    $0.showsHorizontalScrollIndicator = false
    $0.backgroundColor = Color.white.getColor()

    $0.register(cell: MakeOnLaterRecipesCollectionViewCell.self)
  }
  
  init(viewModel: MakeOnLaterRecipesViewModelType) {
    self.viewModel = viewModel
    
    super.init(nibName: nil, bundle: nil)
  }
  
  required init?(coder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }
  
  override func viewDidLoad() {
    super.viewDidLoad()
    
    view.addSubview(collectionView)
    
    bind()
  }
  
  override func setupConstraints() {
    super.setupConstraints()
    
    collectionView.snp.makeConstraints { $0.edges.equalToSuperview() }
  }
}

extension MakeOnLaterRecipesViewController {
  func bind() {
    let input = Input(
      viewWillAppear: self
        .rx
        .methodInvoked(#selector(UIViewController.viewWillAppear(_:))).map { _ in }
    )
    
    let output = viewModel.transform(to: input)
    
    output
      .myPageResponse
      .map { $0.laterRecipes }
      .drive(
        collectionView.rx.items(
          cellIdentifier: MakeOnLaterRecipesCollectionViewCell.identifier,
          cellType: MakeOnLaterRecipesCollectionViewCell.self
        )
      ) { row, item, cell in
        cell.updateContent(with: item)
      }.disposed(by: self.disposeBag)
    
    viewModel
      .signalForErrorStream()
      .subscribe(onNext: { [weak self] _ in
      }).disposed(by: self.disposeBag)
    
    collectionView
      .rx
      .modelSelected(Recipe.self)
      .observe(on: MainScheduler.instance)
      .bind(onNext: { [weak self] response in
        let storyboard = StoryboardRouter.detail.instance
        let viewController = storyboard.instantiateViewController(
          identifier: DetailViewController.identifier,
          creator: { coder in
            DetailViewController(
              recipeId: response.id,
              coder: coder
            )
          })
        
        self?.navigationController?.pushViewController(viewController, animated: true)
      }).disposed(by: self.disposeBag)
  }
}
