//
//  SelectCocktailCVC.swift
//  Nobar
//
//  Created by 이유진 on 2022/07/18.
//

import UIKit

final class SelectCocktailCVC: UICollectionViewCell {
  
  private let searchCockTailTextField = SearchTextField().then {
    $0.placeholder = "칵테일 이름을 검색해보세요"
  }
  
  override init(frame: CGRect) {
    super.init(frame: frame)
    render()
  }
  
  @available(*, unavailable)
  required init?(coder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }
    
}

// MARK: - UI & Layout

extension SelectCocktailCVC {
  
  private func render() {
    addSubview(searchCockTailTextField)
    
    searchCockTailTextField.snp.makeConstraints {
      $0.top.bottom.equalToSuperview().inset(5)
      $0.leading.trailing.equalToSuperview().inset(26)
    }
    
  }
  
}

