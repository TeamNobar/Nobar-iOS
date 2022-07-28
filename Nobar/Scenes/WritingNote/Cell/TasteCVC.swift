//
//  tasteCVC.swift
//  Nobar
//
//  Created by 이유진 on 2022/07/18.
//

import UIKit

final class TasteCVC: UICollectionViewCell {
  
  var selectedTagListClosure: (([Int]) -> Void)?
  var selectedTagNumList: [Int] = []
  
  private var tags: [Tag] = []
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

  func setLayout(for status: WritingStatus){
    switch status{
    case .newWriting,.revising: addTagGesture()
    case .viewing: removeTagGesture()
    }

  }
  
  func bind(with tags: [Tag]) {
    self.tags = tags
    topStackView.removeAllSubViews()
    middleStackView.removeAllSubViews()
    bottomStackView.removeAllSubViews()
    
    guard tags.count == 9 else { return }
    
    for i in 0..<9 {
      let tagView = TastingTagView()
      tagView.setTastingTagView(with: tags[i])
      tagView.tag = i+1
      switch i {
      case 0..<3: topStackView.addArrangedSubview(tagView)
      case 3..<6: middleStackView.addArrangedSubview(tagView)
      case 6..<9: bottomStackView.addArrangedSubview(tagView)
      default: return
      }

    }
    
    setNeedsLayout()
    layoutIfNeeded()
  }
  
  private func addTagGesture(){
    for i in 1..<10 {
      if let tag = viewWithTag(i) as? TastingTagView{
        let gesture = UITapGestureRecognizer(target: self, action:  #selector(self.didTapTagView(sender:)))
        tag.addGestureRecognizer(gesture)
      }
    }
  }
  
  private func removeTagGesture(){
    for i in 1..<10 {
      if let tag = viewWithTag(i) as? TastingTagView{
        tag.gestureRecognizers?.removeLast()

      }
    }
  }

  @objc private func didTapTagView(sender: UITapGestureRecognizer) {
    if let tagView = sender.view as? TastingTagView {
      if (selectedTagNumList.count < 3){
        tagView.isSelected.toggle()
        switch tagView.isSelected{
        case true:
          selectedTagNumList.append(tagView.tag)
          selectedTagListClosure?(selectedTagNumList)
        case false:
          guard let idx = selectedTagNumList.firstIndex(of: tagView.tag) else {return}
          selectedTagNumList.remove(at: idx)
          selectedTagListClosure?(selectedTagNumList)
        }
      }else{
        if tagView.isSelected{
          tagView.isSelected.toggle()
          guard let idx = selectedTagNumList.firstIndex(of: tagView.tag) else {return}
          selectedTagNumList.remove(at: idx)
          selectedTagListClosure?(selectedTagNumList)
        }
      }
    }
  }
}



