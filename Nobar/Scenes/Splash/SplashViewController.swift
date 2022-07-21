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

  private let animationView = AnimationView(name: "111529-rocket").then {
    $0.contentMode = .scaleAspectFit
  }

  private let logoImageView = UIImageView().then {
    $0.image = ImageFactory.splashLogo
  }

  override func viewDidLoad() {
    super.viewDidLoad()
    configUI()
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
      $0.top.equalToSuperview().inset(295)
      $0.width.equalTo(99)
      $0.height.equalTo(73)
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
    animationView.play(completion: { _ in
      let mainViewController = MainViewController()

      mainViewController.modalPresentationStyle = .overFullScreen
      mainViewController.modalTransitionStyle = .crossDissolve
      self.present(mainViewController, animated: true)
    })
  }
}
