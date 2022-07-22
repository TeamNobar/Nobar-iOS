//
//  GuideDetailViewController.swift
//  Nobar
//
//  Created by 이유진 on 2022/07/21.
//

import UIKit
import SnapKit

final class GuideDetailViewController: BaseViewController {
  
  private let titleLabel = UILabel().then{
    $0.textColor = Color.black.getColor()
    $0.font = Pretendard.size16.bold()
    $0.text = "칵테일 가이드"
  }
  private lazy var closeButton = UIButton().then {
    $0.setImage(ImageFactory.btnCancel, for: .normal)
    $0.addTarget(self, action: #selector(didClickOnBackButton(_:)), for: .touchUpInside)
  }
  
  private let scrollView = UIScrollView().then{
    $0.isScrollEnabled = true
  }
  
  private var guideImageView = UIImageView().then{
    $0.image = ImageFactory.guide1
  }

  override func setupConstraints() {
    super.setupConstraints()
    setLayout()
    
  }
  
}

// MARK: - Initialize

extension GuideDetailViewController {
  
  override func viewDidLoad() {
    super.viewDidLoad()
    render()
  }
  
}

// MARK: - Private functions

extension GuideDetailViewController {
  
  private func render() {
    view.backgroundColor = Color.white.getColor()
    navigationController?.navigationBar.alpha = 1
    navigationItem.leftBarButtonItem = UIBarButtonItem(customView: closeButton)
    navigationItem.title = "칵테일 가이드"

    view.addSubview(scrollView)
    scrollView.addSubview(guideImageView)
  }
  
  private func setLayout() {
    scrollView.snp.makeConstraints{
      $0.top.equalTo(view.safeAreaLayoutGuide.snp.top)
      $0.leading.bottom.trailing.equalToSuperview()
    }
    guideImageView.snp.makeConstraints{
      $0.top.leading.trailing.bottom.equalToSuperview()
      $0.height.equalTo(3174)
    }
  }
  
}

// MARK: - Action Functions
extension GuideDetailViewController {
  @objc private func didClickOnBackButton(_ sender: UIButton) {
    self.dismiss(animated: false)
  }
}
