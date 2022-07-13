//
//  MyPageViewController.swift
//  Nobar
//
//  Created by Ian on 2022/07/08.
//

import UIKit

import Alamofire

final class MyPageViewController: BaseViewController {
  private let endPoint = Endpoint<MyPageResponse>(apiRouter: APIRouter.getMyPage)
  private let networkingService: Networking = NetworkingService()
  
  override func viewDidLoad() {
    super.viewDidLoad()
    
    networkingService.request(endPoint) { result in
      switch result {
      case .success(let data): break
      case .failure(let error): break
      }
    }
  }
  
  override func setupConstraints() {
    super.setupConstraints()
    
  }
}

// Example
struct MyPageResponse: Decodable {
  let nickName: String
  let laterRecipes: [Recipe]
  let tastingNotes: [TastingNote]
}
