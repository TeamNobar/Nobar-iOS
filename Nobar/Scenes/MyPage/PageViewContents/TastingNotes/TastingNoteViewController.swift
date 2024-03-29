//
//  TastingNoteViewController.swift
//  Nobar
//
//  Created by Ian on 2022/07/18.
//

import UIKit

import RxSwift
import RxGesture

final class TastingNoteViewController: BaseViewController {
  private enum Metric {
    static let collectionColumnSpacing = 16.f
    static let collectionRowSpacing = 16.f
  }
  
  typealias Input = TastingNoteViewModel.Input
  typealias Output = TastingNoteViewModel.Output
  
  private let viewModel: TastingNoteViewModelType
  private let disposeBag = DisposeBag()
  
  private lazy var flowLayout = UICollectionViewFlowLayout().then {
    $0.scrollDirection = .vertical
    $0.estimatedItemSize = UICollectionViewFlowLayout.automaticSize
    $0.minimumInteritemSpacing = 0.f
    $0.minimumLineSpacing = 0.f
  }
  
  private lazy var collectionView = UICollectionView(
    frame: self.view.bounds,
    collectionViewLayout: self.flowLayout
  ).then {
    $0.alwaysBounceVertical = false
    $0.alwaysBounceHorizontal = false
    $0.showsHorizontalScrollIndicator = false
    $0.backgroundColor = Color.white.getColor()
    $0.contentInset = UIEdgeInsets(
      top: 89, left: 0, bottom: 0, right: 0
    )

    $0.register(cell: TastingNoteCollectionViewCell.self)
  }
  
  private let addNewTastingNoteButton = TastingNoteAddNewButtonView(frame: CGRect(x: 0, y: -89, width: 375, height: 89))
  
  init(viewModel: TastingNoteViewModelType) {
    self.viewModel = viewModel
    
    super.init(nibName: nil, bundle: nil)
  }
  
  required init?(coder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }
  
  override func viewDidLoad() {
    super.viewDidLoad()
    
    view.addSubview(collectionView)
    collectionView.addSubview(addNewTastingNoteButton)

    bind()
  }
  
  override func setupConstraints() {
    super.setupConstraints()
    
    collectionView.snp.makeConstraints { $0.edges.equalToSuperview() }
  }
}

extension TastingNoteViewController {
  func bind() {
    let input = Input(
      viewWillAppear: self.rx.methodInvoked(#selector(UIViewController.viewWillAppear(_:))).map { _ in }
    )
    
    let output = viewModel.transform(to: input)

    output
      .myPageResponse
      .drive(
        collectionView.rx.items(
          cellIdentifier: TastingNoteCollectionViewCell.identifier,
          cellType: TastingNoteCollectionViewCell.self
        )
      ) { row, item, cell in
        cell.bind(with: item)
      }.disposed(by: self.disposeBag)
    
    viewModel
      .signalForErrorStream()
      .subscribe(onNext: { [weak self] _ in
      }).disposed(by: self.disposeBag)
    
    addNewTastingNoteButton
      .rx
      .tapGesture()
      .skip(1)
      .asDriver { _ in .never() }
      .drive { [weak self] _ in
        let viewController = WritingNoteViewController(status: .newWriting)
        viewController.modalPresentationStyle = .fullScreen
        self?.present(viewController, animated: true)
      }.disposed(by: self.disposeBag)
    
    collectionView
      .rx
      .modelSelected(TastingNoteSectionType.self)
      .asDriver { _ in .never() }
      .drive { [weak self] sectionType in
        guard
          let self = self,
          case let .content(tastingNote) = sectionType
        else {
          return
        }
        
        let writingViewController = WritingNoteViewController(
          id: tastingNote.id,
          status: .viewing
        )
        
        writingViewController.modalPresentationStyle = .fullScreen
        self.present(writingViewController, animated: true)
      }.disposed(by: self.disposeBag)
  }
}
