//
//  SearchResultViewController.swift
//  Nobar
//
//  Created by 김수연 on 2022/07/11.
//

import UIKit

import Then
import SnapKit

final class SearchResultViewController: BaseViewController {

  var firstKeyword: String?

  private let searchView = UIView().then {
    $0.backgroundColor = .white
  }

  private lazy var searchTextField = SearchTextField().then {
    $0.addTarget(self, action: #selector(judgeHasText(_:)), for: .editingChanged)
  }

  private lazy var backButton = UIButton().then {
    $0.setImage(ImageFactory.btnBackSearch, for: .normal)
    $0.addTarget(self, action: #selector(didClickOnBackButton(_:)), for: .touchUpInside)
  }

  private lazy var underline = UIView().then {
    $0.backgroundColor = Color.gray02.getColor()
    $0.layer.applyShadow(color: .black, alpha: 0.2, x: 1, y: 1, blur: 2, spread: 0)
  }

  override func viewDidLoad() {
    super.viewDidLoad()
    render()
    configUI()
  }

  override func viewWillAppear(_ animated: Bool) {
    super.viewWillAppear(animated)
    searchTextField.text = firstKeyword
    searchTextField.rightViewMode = .always
  }

  override func setupConstraints() {
    super.setupConstraints()
    setLayout()
  }
}

// MARK: - UI & Layout
extension SearchResultViewController {

  private func render() {
    view.addSubviews([searchView])
    searchView.addSubviews([backButton, searchTextField, underline])
  }

  private func setLayout() {
    searchView.snp.makeConstraints {
      $0.top.equalTo(view.safeAreaLayoutGuide.snp.top)
      $0.leading.trailing.equalToSuperview()
      $0.height.equalTo(62)
    }

    backButton.snp.makeConstraints {
      $0.top.equalToSuperview().inset(2)
      $0.leading.equalToSuperview().inset(10)
      $0.width.height.equalTo(44)
    }

    searchTextField.snp.makeConstraints {
      $0.top.equalToSuperview().inset(6)
      $0.bottom.equalToSuperview().inset(20)
      $0.leading.equalTo(backButton.snp.trailing)
      $0.trailing.equalToSuperview().inset(54)
    }

    underline.snp.makeConstraints {
      $0.top.equalTo(searchTextField.snp.bottom).offset(20)
      $0.leading.trailing.equalToSuperview()
      $0.height.equalTo(0.4)
    }
  }

  private func configUI() {
    view.backgroundColor = .white
    navigationController?.navigationBar.isHidden = true
  }
}
  }
}
