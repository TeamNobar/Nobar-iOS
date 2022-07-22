//
//  TastingNoteCollectionViewCell.swift
//  Nobar
//
//  Created by Ian on 2022/07/21.
//

import UIKit


final class TastingNoteCollectionViewCell: UICollectionViewCell {
  private let tastingNoteDividerView = TastingNoteDividerView()
  private let tastingNoteContentView = TastingNoteContentView()
  private let containerStackView = UIStackView().then {
    $0.axis = .vertical
  }
  
  override init(frame: CGRect) {
    super.init(frame: frame)
    
    contentView.addSubview(containerStackView)
    
    containerStackView.addArrangedSubviews([
      tastingNoteDividerView,
      tastingNoteContentView
    ])
    
    setLayouts()
  }
  
  required init?(coder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }
  
  private func setLayouts() {
    containerStackView.snp.makeConstraints { $0.edges.equalToSuperview() }
  }
  
  override func prepareForReuse() {
    super.prepareForReuse()
    
    tastingNoteContentView.prepareForReuse()
  }
}

// MARK: - Public functions
extension TastingNoteCollectionViewCell {
  func bind(with cellModel: TastingNoteSectionType) {
    switch cellModel {
    case .date(let dateString):
      tastingNoteDividerView.updateDateString(to: dateString)
      
      tastingNoteContentView.isHidden = true
    case .content(let tastingNote):
      tastingNoteContentView.updateContent(with: tastingNote)

      tastingNoteDividerView.isHidden = true
    }
  }
}
