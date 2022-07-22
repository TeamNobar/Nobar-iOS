//
//  Guide.swift
//  Nobar
//
//  Created by 김수연 on 2022/07/23.
//

import UIKit

struct Guide: Decodable, Hashable {
    var id, title: String?
    var subtitle: String?
    var content: String?
    var images: [String]?
    var thumbnail: String?
}
