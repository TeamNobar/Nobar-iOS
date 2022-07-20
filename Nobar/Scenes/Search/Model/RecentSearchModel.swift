//
//  RecentSearchModel.swift
//  Nobar
//
//  Created by 김수연 on 2022/07/19.
//

import Foundation
import RealmSwift

class RecentSearchModel: Object {
    @objc dynamic var keyword: String = ""
}
