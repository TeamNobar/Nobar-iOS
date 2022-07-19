//
//  NBPageViewController.swift
//  Nobar
//
//  Created by Ian on 2022/07/18.
//

import UIKit
import RxSwift

final class NBPageViewController: BaseView {
  private enum Metric {
    static let segmentControlHeight = 36.f
    static let segmentControlTopBottom = 8.f
  }
  
  private let pageViewController = UIPageViewController(
    transitionStyle: .scroll,
    navigationOrientation: .horizontal
  )
  private let segmentedControl: NBSegmentedControl
  private let disposeBag = DisposeBag()
  private let segmentTitles: [String]

  private var contentPages: [UIViewController] = []
  private var currentPageIndex: Int = 0
  
  init(
    segmentTitles: [String],
    on viewController: UIViewController
  ) {
    self.segmentedControl = NBSegmentedControl(buttonTitles: segmentTitles)
    self.segmentTitles = segmentTitles
    
    super.init(frame: .zero)
    
    viewController.addChild(pageViewController)
    pageViewController.didMove(toParent: viewController)
  }
  
  override func initialize() {
    super.initialize()
    
    addSubview(segmentedControl)
    addSubview(pageViewController.view)

    segmentedControl.delegate = self
    pageViewController.delegate = self
    pageViewController.dataSource = self    
  }
  
  override func setLayouts() {
    super.setLayouts()
    
    let segmentWidth = segmentedControl
      .segmentInfo
      .itemWidth * segmentTitles.count.f
    + segmentedControl
      .segmentInfo
      .padding * 2
    
    segmentedControl.snp.makeConstraints {
      $0.top.equalTo(safeAreaLayoutGuide.snp.top).inset(Metric.segmentControlTopBottom)
      $0.centerX.equalToSuperview()
      $0.height.equalTo(Metric.segmentControlHeight)
      $0.width.equalTo(segmentWidth)
    }
    
    pageViewController.view.snp.makeConstraints {
      $0.top.equalTo(segmentedControl.snp.bottom).offset(Metric.segmentControlTopBottom)
      $0.leading.trailing.equalToSuperview()
      $0.bottom.equalTo(safeAreaLayoutGuide.snp.bottom)
    }
  }
  
  required init?(coder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }
}

// MARK: - Public functions
extension NBPageViewController {
  func setTabContentsItem(contentPages: [UIViewController]) {
    self.contentPages = contentPages
    movePage(from: 0, to: 0, animated: true)
  }
}

// MARK: - Private functions
extension NBPageViewController {
  private func movePage(from currentIndex: Int, to targetIndex: Int, animated: Bool) {
    guard let targetPage = contentPages.safeget(index: targetIndex) else { return }
    
    let direction: UIPageViewController.NavigationDirection = currentIndex < targetIndex ? .forward : .reverse
    self.pageViewController.setViewControllers([targetPage], direction: direction, animated: true) { isCompleted in
    }
  }
}

extension NBPageViewController: NBSegmentedControlDelegate {
  func nbSegmentedControl(_ nbSegmentedControl: NBSegmentedControl, didChangedOn index: Int) {
    movePage(from: currentPageIndex, to: index, animated: true)
    currentPageIndex = index
  }
}

// MARK: - UIPageViewControllerDelegate
extension NBPageViewController: UIPageViewControllerDelegate { }

// MARK: - UIPageViewControllerDataSource
extension NBPageViewController: UIPageViewControllerDataSource {
  func pageViewController(
    _ pageViewController: UIPageViewController,
    viewControllerBefore viewController: UIViewController
  ) -> UIViewController? {
    guard let index = contentPages.firstIndex(of: viewController) else { return nil }

    return contentPages.safeget(index: index - 1)
  }

  func pageViewController(
    _ pageViewController: UIPageViewController,
    viewControllerAfter viewController: UIViewController
  ) -> UIViewController? {
    guard let index = contentPages.firstIndex(of: viewController) else { return nil }

    return contentPages.safeget(index: index + 1)
  }

  func pageViewController(
    _ pageViewController: UIPageViewController,
    didFinishAnimating finished: Bool,
    previousViewControllers: [UIViewController],
    transitionCompleted completed: Bool
  ) {
    guard
      finished,
      completed,
      let currentViewController = pageViewController.viewControllers?.first,
      let targetIndex = contentPages.lastIndex(of: currentViewController)
    else {
      return
    }

    currentPageIndex = targetIndex
    segmentedControl.selectIndex(targetIndex, shouldAnimate: true)
  }
}
