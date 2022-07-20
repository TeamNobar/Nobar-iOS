//
//  NBSegmentedController.swift
//  Nobar
//
//  Created by Ian on 2022/07/16.
//

import UIKit
import RxSwift

protocol NBSegmentedControlDelegate: AnyObject {
  func nbSegmentedControl(_ nbSegmentedControl: NBSegmentedControl, didChangedOn index: Int)
}

struct SegmentInfo {
  let selectItemBackgroundColor: Color = .white
  let selectedItemTintColor: Color = .navy01
  
  let nonSelectedItemTitleColor: Color = .skyblue02
  let backgroundColor: Color = .navy01
  let padding = 4.f
  let cornerRadius = 12.f
  let itemWidth = 105.f
}

final class NBSegmentedControl: UIControl {
  private(set) var segmentInfo: SegmentInfo
  private let buttonTitles: [String]
  private let disposeBag = DisposeBag()
  
  private var selectorButtons: [UIButton] = []
  private lazy var selectorView = UIControl(
    frame: CGRect(x: .zero, y: .zero, width: buttonWidth, height: bounds.height - (segmentInfo.padding * 2))
  ).then {
    $0.layer.cornerRadius = segmentInfo.cornerRadius
    $0.backgroundColor = segmentInfo.selectItemBackgroundColor.getColor()
  }
  
  private var buttonWidth: CGFloat { (self.bounds.width - segmentInfo.padding * 2) / buttonTitles.count.f }
  public private(set) var selectedIndex: Int = 0

  weak var delegate: NBSegmentedControlDelegate?
    
  private init(
    frame: CGRect,
    segmentInfo: SegmentInfo,
    buttonTitles: [String]
  ) {
    self.segmentInfo = segmentInfo
    self.buttonTitles = buttonTitles
    
    super.init(frame: .zero)
  }
  
  convenience init(
    segmentInfo: SegmentInfo = SegmentInfo(),
    buttonTitles: [String]
  ) {
    self.init(
      frame: .zero,
      segmentInfo: segmentInfo,
      buttonTitles: buttonTitles
    )
  }

  required init?(coder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }
  
  override func draw(_ rect: CGRect) {
    super.draw(rect)
    
    drawSegmentControl()
  }
}

// MARK: - Public functions
extension NBSegmentedControl {
  func selectIndex(_ index: Int, shouldAnimate: Bool) {
    guard 0..<selectorButtons.count ~= index else { return }
    
    selectorButtons.forEach { $0.setTitleColor(segmentInfo.nonSelectedItemTitleColor.getColor(), for: .normal) }
    selectedIndex = index
    
    let button = selectorButtons[index]
    delegate?.nbSegmentedControl(self, didChangedOn: selectedIndex)
    sendActions(for: .valueChanged)
    button.setTitleColor(segmentInfo.selectedItemTintColor.getColor(), for: .normal)
    button.titleLabel?.font = Pretendard.size13.medium()
    
    guard shouldAnimate else { return }
    
    animateSelectedItem(to: buttonWidth * index.f)
  }
}

// MARK: - Private functions
extension NBSegmentedControl {
  private func drawSegmentControl() {
    createButton()
    configureStackView()
  }
  
  private func createButton() {
    selectorButtons.removeAll()
    subviews.forEach { $0.removeFromSuperview() }
    
    buttonTitles.forEach { buttonTitle in
      let button = UIButton(type: .custom).then {
        $0.setTitle(buttonTitle, for: .normal)
        $0.titleLabel?.font = Pretendard.size13.regular()
        $0.addTarget(self, action: #selector(self.didClickOnButton(sender:)), for: .touchUpInside)
        $0.setTitleColor(segmentInfo.nonSelectedItemTitleColor.getColor(), for: .normal)
      }
      
      selectorButtons.append(button)
    }
    
    selectorButtons.first?.setTitleColor(segmentInfo.selectedItemTintColor.getColor(), for: .normal)
    selectorButtons.first?.titleLabel?.font = Pretendard.size13.medium()
  }
  
  private func configureStackView() {
    let containerView = UIView(frame: .zero)
    let stackView = UIStackView(arrangedSubviews: selectorButtons).then {
      $0.distribution = .fillEqually
      $0.backgroundColor = segmentInfo.backgroundColor.getColor()
      $0.layer.cornerRadius = segmentInfo.cornerRadius + 3
      $0.addGestureRecognizer(UIPanGestureRecognizer(target: self, action: #selector(self.didReceivePanAction(_:))))
    }
    
    addSubview(stackView)
    stackView.addSubview(containerView)
    stackView.exchangeSubview(at: 0, withSubviewAt: 2)
    
    stackView.snp.makeConstraints { $0.directionalEdges.equalToSuperview() }
    
    containerView.addSubview(selectorView)
    containerView.snp.makeConstraints { $0.directionalEdges.equalToSuperview().inset(segmentInfo.padding) }
  }
  
  private func processSelectedIndex(_ index: Int) {
    Observable.just(index)
      .distinctUntilChanged()
      .asDriver(onErrorDriveWith: .empty())
      .drive { [weak self] index in
        self?.selectedIndex = index
        self?.selectIndex(index, shouldAnimate: false)
      }.disposed(by: self.disposeBag)
  }
  
  private func animateSelectedItem(to point: CGFloat) {
    UIView.animate(withDuration: 0.3) { [weak self] in
      self?.selectorView.frame.origin.x = point
    }
  }
}

// MARK: - Selectors
extension NBSegmentedControl {
  @objc private func didClickOnButton(sender: UIButton) {
    selectorButtons.enumerated().forEach { index, button in
      button.setTitleColor(segmentInfo.nonSelectedItemTitleColor.getColor(), for: .normal)
      
      guard button == sender else { return }
      
      let selectorPosition = buttonWidth * index.f
      selectedIndex = index
      delegate?.nbSegmentedControl(self, didChangedOn: selectedIndex)
      sendActions(for: .valueChanged)
      button.setTitleColor(segmentInfo.selectedItemTintColor.getColor(), for: .normal)
      animateSelectedItem(to: selectorPosition)
    }
  }
  
  @objc private func didReceivePanAction(_ pangesture: UIPanGestureRecognizer) {
    let containerViewWidth = self.bounds.width - (segmentInfo.padding * 2).f
    let buttonFrame = self.buttonWidth
    let panLocationXCoordinate = pangesture.location(in: self).x
    let xCoordinateCorrenctionValue = panLocationXCoordinate + (buttonFrame / 2)
    let compensatedXValue: CGFloat
    
    switch xCoordinateCorrenctionValue {
    case ...buttonFrame:
      compensatedXValue = buttonFrame / 2
    case 0...containerViewWidth:
      compensatedXValue = panLocationXCoordinate
    case containerViewWidth...:
      compensatedXValue = containerViewWidth - (buttonFrame / 2)
    default:
      compensatedXValue = buttonFrame / 2
    }
    
    switch pangesture.state {
    case .changed:
      selectorView.center.x = compensatedXValue
      self.processSelectedIndex(Int(round(panLocationXCoordinate / containerViewWidth)))
    case .ended:
      let selectorPosition = buttonWidth * selectedIndex.f
      self.animateSelectedItem(to: selectorPosition)
    default: break
    }
  }
}
