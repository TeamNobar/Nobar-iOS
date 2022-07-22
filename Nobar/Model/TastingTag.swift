//
//  TastingTag.swift
//  Nobar
//
//  Created by Ian on 2022/07/13.
//

// MARK: - MainElement
struct TastingTag: Codable {
    let id: Int
    let content: String
    let activeIcon, inActiveIcon: String
    let isSelected: Bool
}

