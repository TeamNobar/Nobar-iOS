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
  // TODO: 나중에 서버에서 한꺼번에 리스트로 받아옴
  private var dummyCocktail: [String] = ["브랜디", "선라이즈피치", "피치크러쉬", "카시스 오렌지", "은비쨩", "칵테일어쩌구", "피치만 나와라", "피치어쩌구", "리큐르", "채원쨩"]

  private var dummyIngredient: [String] = ["여긴재료", "주스도있고요", "재료들이", "오렌지주스", "은비쨩", "재료어쩌구", "피치만 나와라", "피치어쩌구", "리큐르", "채원쨩"]

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

  private lazy var searchAutoResultCollectionView: UICollectionView = {
    let layout = createCompositionLayout()

    let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
    collectionView.showsHorizontalScrollIndicator = false
    collectionView.showsVerticalScrollIndicator = false
    return collectionView
  }()

  override func viewDidLoad() {
    super.viewDidLoad()
    render()
    configUI()
    setTextField()
    setRegistration()
    setDataSource()
    setSnapshot()
  }

  override func setupConstraints() {
    super.setupConstraints()
    setLayout()
  }

  override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
      view.endEditing(true)
  }
}

// MARK: - UI & Layout
extension SearchResultViewController {

  private func render() {
    view.addSubviews([searchView, searchAutoResultCollectionView])
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

    searchAutoResultCollectionView.snp.makeConstraints {
      $0.top.equalTo(underline.snp.bottom)
      $0.leading.trailing.bottom.equalToSuperview()
    }
  }

  private func configUI() {
    view.backgroundColor = .white
    navigationController?.navigationBar.isHidden = true
  }
}

// MARK: - Private Functions
extension SearchResultViewController {
  private func setTextField() {
    searchTextField.text = firstKeyword
    searchTextField.rightViewMode = .always
  }
  
  private func setRegistration() {
    searchAutoResultCollectionView.register(SearchHeaderView.self, forSupplementaryViewOfKind: SearchHeaderView.className, withReuseIdentifier: SearchHeaderView.className)
    searchAutoResultCollectionView.register(cell: SearchAutoResultCollectionViewCell.self)
  }
}

// MARK: - Action Functions
extension SearchResultViewController {
  @objc private func judgeHasText(_ sender: UITextField) {
    if searchTextField.hasText == false {
      navigationController?.popViewController(animated: false)
    }
  }

  @objc private func didClickOnBackButton(_ sender: UIButton) {
    self.navigationController?.popViewController(animated: false)
  }
}
