//
//  stepsTableViewCell.swift
//  Nobar
//
//  Created by Sua Han on 2022/07/17.
//

import UIKit

class StepsTableViewCell: UITableViewCell {
  
  @IBOutlet weak var stepsCollectionView: UICollectionView!
  
  var identifiers = [StepItemCollectionViewCell.identifier]
  let flowlayout = UICollectionViewFlowLayout()
    
  override func awakeFromNib() {
    super.awakeFromNib()
    collectionViewGetReady()
  }

  override func setSelected(_ selected: Bool, animated: Bool) {
      super.setSelected(selected, animated: animated)
  }

  private func setDelegate() {
    stepsCollectionView.delegate = self
    stepsCollectionView.dataSource = self
    flowlayout.sectionInset = UIEdgeInsets(top: 8, left: 26, bottom: 8, right: 27)
    flowlayout.minimumLineSpacing = 14
    flowlayout.minimumInteritemSpacing = 14
    stepsCollectionView.collectionViewLayout = flowlayout
  }
  
  private func registerXibs(){
      var nib : [UINib] = []
      identifiers.forEach{
          nib.append(UINib(nibName: $0, bundle: nil))
      }
      nib.enumerated().forEach {
        stepsCollectionView.register($1, forCellWithReuseIdentifier: identifiers[$0])
      }
  }
  
  func collectionViewGetReady() {
    setDelegate()
    registerXibs()
    setCollectionView()
  }

  func setCollectionView() {
    stepsCollectionView.showsVerticalScrollIndicator = false
    stepsCollectionView.showsHorizontalScrollIndicator = false
  }
  
  // stepModelList 받아오기
}


extension StepsTableViewCell : UICollectionViewDelegateFlowLayout, UICollectionViewDataSource {
  func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
      return 7  //stepModelList.count
  }
  
  func collectionView(
    _ collectionView: UICollectionView,
    cellForItemAt indexPath: IndexPath
  ) -> UICollectionViewCell {
    let cell = collectionView.dequeueReusableCell(ofType: StepItemCollectionViewCell.self, at: indexPath)
    
    guard let item = StepDataModel.sampleData.safeget(index: indexPath.row) else { return cell }
    
    cell.setData(stepData: item)
    return cell
  }
  
  func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
    return 14
  }
  
  func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
    let cellWidth = 375.adjustedW
    let cellHeight = 24.adjustedH
      
      return CGSize(width: cellWidth, height: cellHeight)
  }
}
