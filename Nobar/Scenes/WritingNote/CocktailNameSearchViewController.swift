//
//  CocktailNameSearchViewController.swift
//  Nobar
//
//  Created by 이유진 on 2022/07/22.
//

import UIKit

class CocktailNameSearchViewController: BaseViewController {
  
  private var cocktailNameList: [String] =  ["피치크러쉬","피노키오","가나슈","말리부","커피","우유","모히또","와인","피머시기","피"]
  private var filteredCoctailNameList: [String] = ["피치크러쉬","피노키오","가나슈","말리부","커피","우유","모히또","와인","피머시기","피"]
  
  private let headerBarView = UIView()
  
  private lazy var previousButton = UIButton().then {
    $0.setImage(ImageFactory.btnBackSearch, for: .normal)
    $0.addTarget(self, action: #selector(didTapPreviousButton(_:)), for: .touchUpInside)
  }
  
  private let searchTextField = UISearchTextField().then{
    $0.placeholder = "칵테일을 검색하세요"
  }
  private let searchTableView: UITableView = {
    let searchTableView = UITableView()
    searchTableView.register(CocktailNameTVC.self, forCellReuseIdentifier: CocktailNameTVC.identifier)
    searchTableView.separatorStyle = .none
    return searchTableView
  }()
  
  
  override func setupConstraints() {
    super.setupConstraints()
    setLayout()
  }
}

extension CocktailNameSearchViewController {
  
  override func viewDidLoad() {
    super.viewDidLoad()
    render()
    setDelegation()
    
    
  }
  private func render() {
    view.addSubviews([headerBarView,searchTableView])
    headerBarView.addSubviews([previousButton,searchTextField])
    
  }
  
  private func setLayout() {
    self.navigationController?.navigationBar.isHidden = true
    view.backgroundColor = .white
    searchTextField.isUserInteractionEnabled = true
    headerBarView.snp.makeConstraints{
      $0.top.equalTo(view.safeAreaLayoutGuide.snp.top)
      $0.leading.trailing.equalToSuperview()
      $0.height.equalTo(62)
    }
    
    previousButton.snp.makeConstraints{
      $0.leading.equalToSuperview().offset(10)
      $0.centerY.equalToSuperview()
      $0.width.height.equalTo(44)
    }
    
    searchTextField.snp.makeConstraints{
      $0.leading.equalTo(previousButton.snp.trailing).offset(5)
      $0.trailing.equalToSuperview().offset(-54)
      $0.centerY.equalToSuperview()
      $0.height.equalTo(36)
    }
    
    searchTableView.snp.makeConstraints{
      $0.top.equalTo(headerBarView.snp.bottom)
      $0.leading.bottom.trailing.equalToSuperview()
    }
    
  }
  
  private func setDelegation(){
    searchTableView.dataSource = self
    searchTableView.delegate = self
    searchTextField.delegate = self
  }
  
  func setGesture(){
    searchTextField.addTarget(self, action: #selector(self.textFieldDidChange(_:)), for: .editingChanged)
    previousButton.addTarget(self, action: #selector(self.didTapPreviousButton(_:)), for: .touchUpInside)
  }
  
  
  @objc func didTapPreviousButton(_ sender: UIButton){
    self.dismiss(animated: false)
  }
}

extension CocktailNameSearchViewController: UITableViewDataSource{
  func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    filteredCoctailNameList.count
  }
  
  func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    guard let cell = tableView.dequeueReusableCell(withIdentifier: CocktailNameTVC.identifier,for: indexPath) as? CocktailNameTVC else {return UITableViewCell()}
    cell.setData(name: filteredCoctailNameList[indexPath.row])
    return cell
  }
}

extension CocktailNameSearchViewController: UITableViewDelegate{
  func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
    return 60
  }
  
  func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
    guard let vc = self.presentingViewController as? WritingNoteViewController else {return}
    vc.selectedCocktail = filteredCoctailNameList[indexPath.row]
    self.dismiss(animated: false)
  }
}

extension CocktailNameSearchViewController: UITextFieldDelegate{
  
  func textFieldDidBeginEditing(_ textField: UITextField) {
    
    
    filteredCoctailNameList = cocktailNameList
    print("하냐?!!?")
    searchTableView.reloadData()
    
    
  }
  
  @objc func textFieldDidChange(_ sender: Any?) {
    if searchTextField.text == ""{
        filteredCoctailNameList = cocktailNameList
        searchTableView.reloadData()
        
    }else{
    filteredCoctailNameList = cocktailNameList.filter { $0.lowercased().prefix(searchTextField.text!.count) == searchTextField.text!.lowercased() }
    searchTableView.reloadData()
    }
  }
  
  func textFieldShouldReturn(_ textField: UITextField) -> Bool {
    
    textField.resignFirstResponder()
    searchTableView.isHidden = true
    return true
  }
}



