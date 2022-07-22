//
//  CocktailNameTVC.swift
//  Nobar
//
//  Created by 이유진 on 2022/07/22.
//

import UIKit

final class CocktailNameTVC: UITableViewCell{
  
  private var cocktailName = ""

  private let cocktailNameLabel = UILabel().then{
    $0.font = Pretendard.size15.regular()
    $0.textColor = Color.black.getColor()
  }
  
  override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
      super.init(style: style, reuseIdentifier: reuseIdentifier)
      render()
  }
  required init?(coder aDecoder: NSCoder) {
      fatalError("init(coder:) has not been implemented")
  }
}

extension CocktailNameTVC {
  
  private func render() {
   
    addSubview(cocktailNameLabel)
    
    cocktailNameLabel.snp.makeConstraints {
      $0.leading.equalToSuperview().offset(22)
      $0.centerY.equalToSuperview()
    }
    
  }
  
  func setData(name: String){
    cocktailName = name
    cocktailNameLabel.text = name
  }
}

