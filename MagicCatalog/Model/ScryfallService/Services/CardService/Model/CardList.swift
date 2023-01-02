//
//  CardList.swift
//  MagicCatalog
//
//  Created by Alexander Rubtsov on 23.12.2022.
//

import Foundation

struct CardList: Codable {
    let data: [Card]
    let hasMore: Bool
    let nextPage: String?
    let totalCards: Int
}
