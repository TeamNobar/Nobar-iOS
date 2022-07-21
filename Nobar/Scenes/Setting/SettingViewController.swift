//
//  SettingViewController.swift
//  Nobar
//
//  Created by 김수연 on 2022/07/21.
//

import UIKit

import Then
import SnapKit

class SettingViewController : BaseViewController {
  
  private lazy var backButton = UIButton().then {
    $0.setImage(ImageFactory.btnBackSearch, for: .normal)
    $0.addTarget(self, action: #selector(didClickOnBackButton(_:)), for: .touchUpInside)
  }

  private let underline = UIView().then {
    $0.backgroundColor = Color.gray02.getColor()
    $0.layer.applyShadow(color: Color.black.getColor(), alpha: 0.05, x: 1, y: 1, blur: 2, spread: 0)
  }

  private let centerHeader = SettingHeaderView(type: .center)
  private let serviceHeader = SettingHeaderView(type: .service)

  private let inquiryView = SettingDetailView(type: .inquiry)
  private let termsView = SettingDetailView(type: .terms)
  private let libraryView = SettingDetailView(type: .library)
  private let resignView = SettingDetailView(type: .resign)

  private let serviceStackView = UIStackView().then {
    $0.axis = .vertical
    $0.backgroundColor = Color.white.withAlphaColor(alpha: 0.0)
    $0.spacing = 0
    $0.distribution = .equalSpacing
  }


  override func viewDidLoad() {
    super.viewDidLoad()
    render()
    configUI()
    setDelegation()
  }

  override func setupConstraints() {
    super.setupConstraints()
    setLayout()
  }
}

// MARK: - UI & Layout
extension SettingViewController {
  private func render() {
    view.addSubviews([underline, centerHeader, inquiryView, serviceHeader, serviceStackView])
    serviceStackView.addArrangedSubviews([termsView, libraryView, resignView])
  }

  private func configUI() {
    view.backgroundColor = Color.white.getColor()

    navigationItem.leftBarButtonItem = UIBarButtonItem(customView: backButton)

    let titleAttribute = [NSAttributedString.Key.font: Pretendard.size16.bold(), NSAttributedString.Key.foregroundColor: Color.black.getColor()]
    self.navigationController?.navigationBar.titleTextAttributes = titleAttribute

    navigationItem.title = "설정"
  }

  private func setLayout() {
    underline.snp.makeConstraints {
      $0.top.equalTo(view.safeAreaLayoutGuide.snp.top)
      $0.leading.trailing.equalToSuperview()
      $0.height.equalTo(1)
    }

    centerHeader.snp.makeConstraints {
      $0.top.equalTo(underline.snp.bottom).offset(16)
      $0.leading.trailing.equalToSuperview()
      $0.height.equalTo(50)
    }

    inquiryView.snp.makeConstraints {
      $0.top.equalTo(centerHeader.snp.bottom)
      $0.leading.trailing.equalToSuperview()
      $0.height.equalTo(50)
    }

    serviceHeader.snp.makeConstraints {
      $0.top.equalTo(inquiryView.snp.bottom).offset(50)
      $0.leading.trailing.equalToSuperview()
      $0.height.equalTo(50)
    }

    serviceStackView.snp.makeConstraints {
      $0.top.equalTo(serviceHeader.snp.bottom)
      $0.leading.trailing.equalToSuperview()
    }

    [termsView, libraryView, resignView].forEach {
      $0.snp.makeConstraints {
        $0.height.equalTo(50)
      }
    }
  }
}

// MARK: - Action Functions
extension SettingViewController {
  @objc private func didClickOnBackButton(_ sender: UIButton) {
    self.navigationController?.popViewController(animated: true)
  }
}

// MARK: - Private Functions
extension SettingViewController {
  private func setDelegation() {
    [inquiryView, termsView, libraryView, resignView].forEach {
      $0.tapDelegate = self
    }
  }
}

// MARK: - Tap Delegate
extension SettingViewController: TapSettingViewDelegate {
  func presentViewController(type: SettingDetailType) {
    switch type {
    case .inquiry:
      print("문의하기- 메일 띄우기")
    case .terms:
      print("약관 및 정책- 노션 주소 연결")
    case .library:
      print("오픈소스 라이브러리- 노션 연결?")
    case .resign:
      print("회원 탈퇴- 다이얼로그 -> 어디로 문의주세요")
    }
  }
}

