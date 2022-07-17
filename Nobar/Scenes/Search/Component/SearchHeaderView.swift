//
//  SearchHeaderView.swift
//  Nobar
//
//  Created by 김수연 on 2022/07/12.
//

import UIKit

import Then
import SnapKit

protocol HeaderViewDelegate: AnyObject {
  func didClickOnDeleteButton()
}

final class SearchHeaderView: UICollectionReusableView {

  weak var delegate: HeaderViewDelegate?

  enum SeachHeaderType {
    case recent
    case recommend
    case cocktail
    case ingredient
    case total
  }

  private var titleLabel = UILabel().then {
    $0.textColor = Color.pink01.getColor()
    $0.font = Pretendard.size17.semibold()
  }

  private lazy var deleteButton = UIButton().then {
    $0.setTitle("전체 삭제", for: .normal)
    $0.setTitleColor(Color.gray03.getColor(), for: .normal)
    $0.titleLabel?.font = Pretendard.size13.medium()
    $0.addTarget(self, action: #selector(didClickOnDeleteButton(_:)), for: .touchUpInside)
  }

  private var dateLabel = UILabel().then {
    $0.text = "2022.07.07 기준"
    $0.textColor = Color.gray03.getColor()
    $0.font = Pretendard.size13.regular()
    $0.addSpacing(kernValue: -0.78, lineSpacing: 0)
  }

  private lazy var totalButton = UIButton().then {
    $0.setTitle("전체 보기", for: .normal)
    $0.setTitleColor(Color.gray03.getColor(), for: .normal)
    $0.titleLabel?.font = Pretendard.size13.medium()
  }

  private let topLine = UIView().then {
    $0.backgroundColor = Color.gray02.getColor()
  }

  override init(frame: CGRect) {
    super.init(frame: frame)
    render()
  }

  required init?(coder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }
}

// MARK: - UI & Layout
extension SearchHeaderView {
  private func render() {
    addSubview(titleLabel)
    titleLabel.snp.makeConstraints {
      $0.top.bottom.equalToSuperview().inset(15)
      $0.leading.equalToSuperview().inset(26)
    }
  }

  func configUI(type: SeachHeaderType) {
    switch type {
    case .recent:
      titleLabel.text = "최근 검색어"
      addDeleteButton()
      remakeTitleLayout()
    case .recommend:
      titleLabel.text = "추천 검색어"
      addDateLabel()
      addSeparateLine()
    case .cocktail:
      titleLabel.text = "칵테일 레시피"
    case .ingredient:
      titleLabel.text = "재료"
      addSeparateLine()
    case .total:
      titleLabel.text = "칵테일 레시피"
      addTotalButton()
    }
  }

  private func addDeleteButton() {
    addSubview(deleteButton)
    deleteButton.snp.makeConstraints {
      $0.top.equalToSuperview().inset(19)
      $0.bottom.equalToSuperview().inset(15)
      $0.trailing.equalToSuperview()
    }
  }

  private func addDateLabel() {
    addSubview(dateLabel)
    dateLabel.snp.makeConstraints {
      $0.top.equalToSuperview().inset(19)
      $0.bottom.equalToSuperview().inset(15)
      $0.trailing.equalToSuperview().inset(26)
    }
  }

  private func addSeparateLine() {
    addSubview(topLine)
    topLine.snp.makeConstraints {
      $0.top.leading.trailing.equalToSuperview()
      $0.height.equalTo(1)
    }
  }

  private func addTotalButton() {
    addSubview(totalButton)
    totalButton.snp.makeConstraints {
      $0.top.equalToSuperview().inset(18)
      $0.bottom.equalToSuperview().inset(15)
      $0.trailing.equalToSuperview().inset(26)
    }
  }

  private func remakeTitleLayout() {
    titleLabel.snp.remakeConstraints {
      $0.top.bottom.equalToSuperview().inset(15)
      $0.leading.equalToSuperview()
    }
  }
}

// MARK: - Action Functions
extension SearchHeaderView {
  @objc private func didClickOnDeleteButton(_ sender: UIButton) {
    delegate?.didClickOnDeleteButton()
    self.deleteButton.isHidden = true
  }
}
