//
//  ingredientsTableViewCell.swift
//  Nobar
//
//  Created by Sua Han on 2022/07/14.
// O

import UIKit

class IngredientsTableViewCell: UITableViewCell {

  @IBOutlet weak var ingredientsCollectionView: UICollectionView!
  
  //var selectIngredients: (() -> ())?
  static let identifier = "IngredientsTableViewCell"
  var identifiers = [IngredientItemCollectionViewCell.identifier]
  let flowlayout = UICollectionViewFlowLayout()

  override func awakeFromNib() {
    super.awakeFromNib()
    collectionViewGetReady()
  }

  override func setSelected(_ selected: Bool, animated: Bool) {
      super.setSelected(selected, animated: animated)
  }

  private func setDelegate() {
    ingredientsCollectionView.delegate = self
    ingredientsCollectionView.dataSource = self
    flowlayout.sectionInset = UIEdgeInsets(top: 8, left: 26, bottom: 8, right: 27)
    flowlayout.minimumLineSpacing = 14
    flowlayout.minimumInteritemSpacing = 14
    ingredientsCollectionView.collectionViewLayout = flowlayout
  }
  
  private func registerXibs(){
      var nib : [UINib] = []
      identifiers.forEach{
          nib.append(UINib(nibName: $0, bundle: nil))
      }
      nib.enumerated().forEach{
        ingredientsCollectionView.register($1, forCellWithReuseIdentifier: identifiers[$0])
      }
  }
  
  func collectionViewGetReady() {
    setDelegate()
    registerXibs()
    setCollectionView()
  }

  func setCollectionView() {
    ingredientsCollectionView.showsVerticalScrollIndicator = false
    ingredientsCollectionView.showsHorizontalScrollIndicator = false
  }
  
  // ingredientModelList 받아오기
}


extension IngredientsTableViewCell : UICollectionViewDelegateFlowLayout, UICollectionViewDataSource {
  func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
      return 7  //ingredientModelList.count
  }
  
  func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
      guard let cell = collectionView.dequeueReusableCell(
        withReuseIdentifier: IngredientItemCollectionViewCell.identifier,
        for: indexPath
      ) as? IngredientItemCollectionViewCell
    else {
        return UICollectionViewCell()
      }
    print("ingredientModelList")
    cell.setData(cocktailData: IngredientDataModel.sampleData[indexPath.row])
      return cell
  }
  
  func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
      return 14
  }
  
  func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
    let cellWidth = 98.adjustedW
    let cellHeight = 90.adjustedH
      
      return CGSize(width: cellWidth, height: cellHeight)
  }
}


