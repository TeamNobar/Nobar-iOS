//
//  SplashViewController.swift
//  Nobar
//
//  Created by 김수연 on 2022/07/21.
//

import UIKit

import Then
import SnapKit
import Lottie

final class SplashViewController: BaseViewController {

  private let animationView = AnimationView(name: "nobar").then {
    $0.contentMode = .scaleAspectFit
  }

  private let logoImageView = UIImageView().then {
    $0.image = ImageFactory.splashLogo
  }

  override func viewDidLoad() {
    super.viewDidLoad()
    
    configUI()
  }
  
  override func viewWillAppear(_ animated: Bool) {
    super.viewWillAppear(animated)
    
    playAnimation()
  }

  override func setupConstraints() {
    super.setupConstraints()
    setLayout()
  }
}

// MARK: - UI & Layout
extension SplashViewController {
  private func configUI() {
    view.backgroundColor = Color.white.getColor()
  }

  private func setLayout() {
    self.view.addSubviews([animationView, logoImageView])

    animationView.snp.makeConstraints {
      $0.top.equalToSuperview().inset(295.adjustedH)
      $0.width.equalTo(140)
      $0.height.equalTo(110)
      $0.centerX.equalToSuperview()
    }

    logoImageView.snp.makeConstraints {
      $0.top.equalTo(animationView.snp.bottom).offset(22)
      $0.width.equalTo(162)
      $0.height.equalTo(35)
      $0.centerX.equalToSuperview()
    }
  }

  private func playAnimation() {
    animationView.play { [weak self] _ in
      self?.processOnboardingIfNeeded()
    }
  }
  
  private func processOnboardingIfNeeded() {
    guard let sceneDelegate = NBUtils.getSceneDelegate() else { return }
    
    let isFirstUser = UserDefaultHelper<String>.value(forKey: .accessToken) == nil

    switch isFirstUser {
    case true: sceneDelegate.startSignIn()
    case false: sceneDelegate.startTabbar()
    }
  }
}
