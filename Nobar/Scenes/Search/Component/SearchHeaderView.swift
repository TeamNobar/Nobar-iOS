//
//  SearchHeaderView.swift
//  Nobar
//
//  Created by 김수연 on 2022/07/12.
//

import UIKit

import Then
import SnapKit

final class SearchHeaderView: UICollectionReusableView {

  var didClickOnDeleteButtonClosure: (() -> Void)?
  var didClickOnTotalButtonClosure: (() -> Void)?

  enum SeachHeaderType {
    case recent
    case recommend
    case cocktail
    case ingredient
    case total
    case baseResult
  }

  private var titleLabel = UILabel().then {
    $0.textColor = Color.pink01.getColor()
    $0.font = Pretendard.size17.semibold()
  }

  private(set) lazy var deleteButton = UIButton().then {
    $0.setTitle("전체 삭제", for: .normal)
    $0.setTitleColor(Color.gray03.getColor(), for: .normal)
    $0.titleLabel?.font = Pretendard.size13.medium()
    $0.addTarget(self, action: #selector(didClickOnDeleteButton(_:)), for: .touchUpInside)
  }

  private lazy var dateLabel = UILabel().then {
    $0.text = "2022.07.07 기준"
    $0.textColor = Color.gray03.getColor()
    $0.font = Pretendard.size13.regular()
    $0.addSpacing(kernValue: -0.78, lineSpacing: 0)
  }

  private lazy var totalButton = UIButton().then {
    $0.setTitle("전체 보기", for: .normal)
    $0.setTitleColor(Color.gray03.getColor(), for: .normal)
    $0.titleLabel?.font = Pretendard.size13.medium()
    $0.addTarget(self, action: #selector(didClickOnTotalButton(_:)), for: .touchUpInside)
  }

  private let topLine = UIView().then {
    $0.backgroundColor = Color.gray02.withAlphaColor(alpha: 0.5)
  }

  private let filterButton = UIButton().then {
    var configuration = UIButton.Configuration.plain()

    var container = AttributeContainer()
    container.font = Pretendard.size11.bold()

    configuration.attributedTitle = AttributedString("가나다 순", attributes: container)

    configuration.baseForegroundColor = Color.gray03.getColor()
    configuration.image = ImageFactory.icnFilterDown

    configuration.imagePadding = 4
    configuration.contentInsets = NSDirectionalEdgeInsets(top: 6, leading: 7, bottom: 6, trailing: 7)
    configuration.imagePlacement = .trailing

    $0.configuration = configuration
    $0.layer.borderWidth = 1
    $0.layer.borderColor = Color.gray02.withAlphaColor(alpha: 0.5).cgColor
    $0.layer.cornerRadius = 3
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
      getCurrentDate()
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
      remakeTitleLayout()
    case .baseResult:
      titleLabel.isHidden = true
      addFilterButton()
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
    dateLabel.addSpacing(kernValue: -0.78, lineSpacing: 0)
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
      $0.trailing.equalToSuperview()
    }
  }

  private func remakeTitleLayout() {
    titleLabel.snp.remakeConstraints {
      $0.top.bottom.equalToSuperview().inset(15)
      $0.leading.equalToSuperview()
    }
  }

  private func addFilterButton() {
    addSubview(filterButton)
    filterButton.snp.makeConstraints {
      $0.width.equalTo(69)
      $0.height.equalTo(27)
      $0.top.equalToSuperview().inset(21)
      $0.trailing.equalToSuperview()
    }
  }

  private func getCurrentDate() {
    let formatter = DateFormatter()
    formatter.dateStyle = .long
    formatter.timeStyle = .medium
    formatter.dateFormat = "yyyy.MM.dd 기준"
    let str = formatter.string(from: Date())
    dateLabel.text = "\(str)"
  }
}

// MARK: - Action Functions
extension SearchHeaderView {
  @objc private func didClickOnDeleteButton(_ sender: UIButton) {
    self.didClickOnDeleteButtonClosure?()
    self.deleteButton.isHidden = true
  }

  @objc private func didClickOnTotalButton(_ sender: UIButton) {
    self.didClickOnTotalButtonClosure?()
  }
}
