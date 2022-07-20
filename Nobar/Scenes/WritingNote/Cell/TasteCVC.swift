//
//  tasteCVC.swift
//  Nobar
//
//  Created by 이유진 on 2022/07/18.
//

import UIKit

final class TasteCVC: UICollectionViewCell {
  
  var selectedTagNumList: [Int] = []
  
  private let dummyPhraseList = ["맛이좋아요","맛이쏘쏘쏘","아주별로야","네번쨰문구","다번째문구","여번째문구","일번째문구","여번쨰문구","아번째문구"]
  private var tagViews: [TastingTagView] = []
  
  private let wholeStackView = UIStackView().then{
    $0.axis = .vertical
    $0.spacing = 10
    $0.backgroundColor = .white
  }
  
  private let topStackView = UIStackView().then{
    $0.axis = .horizontal
    $0.spacing = 8
    $0.backgroundColor = .white
  }
  private let middleStackView = UIStackView().then{
    $0.axis = .horizontal
    $0.spacing = 8
    $0.backgroundColor = .white
  }
  private let bottomStackView = UIStackView().then{
    $0.axis = .horizontal
    $0.spacing = 8
    $0.backgroundColor = .white
  }
  
  
  override init(frame: CGRect) {
    super.init(frame: frame)
    bind()
    render()
    
  }
  
  @available(*, unavailable)
  required init?(coder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }
  
}

// MARK: - UI & Layout

extension TasteCVC {
  
  private func render() {
    addSubview(wholeStackView)
    
    wholeStackView.addArrangedSubview(topStackView)
    wholeStackView.addArrangedSubview(middleStackView)
    wholeStackView.addArrangedSubview(bottomStackView)
    
    wholeStackView.snp.makeConstraints{
      $0.centerX.centerY.equalToSuperview()
    }
    
  }
  
  private func bind() {
    
    for i in 0..<9 {
      let tagView = TastingTagView()
      tagView.setTasteLabel(with: dummyPhraseList[i])
      tagView.tag = i
      tagViews += [tagView]
      switch i {
      case 0..<3: topStackView.addArrangedSubview(tagView)
      case 3..<6: middleStackView.addArrangedSubview(tagView)
      case 6..<9: bottomStackView.addArrangedSubview(tagView)
      default: return
      }
      
      let gesture = UITapGestureRecognizer(target: self, action:  #selector(self.didTapTagView(sender:)))
      tagView.addGestureRecognizer(gesture)
    }
  }
  
  
  @objc private func didTapTagView(sender: UITapGestureRecognizer) {
    if let tagView = sender.view as? TastingTagView {
      if (selectedTagNumList.count < 3){
        tagView.isSelected.toggle()
        switch tagView.isSelected{
        case true:
          selectedTagNumList.append(tagView.tag)
        case false:
          guard let idx = selectedTagNumList.firstIndex(of: tagView.tag) else {return}
          selectedTagNumList.remove(at: idx)
        }
      }else{
        if tagView.isSelected{
          tagView.isSelected.toggle()
          guard let idx = selectedTagNumList.firstIndex(of: tagView.tag) else {return}
          selectedTagNumList.remove(at: idx)
        }
      }
    }
  }
}



