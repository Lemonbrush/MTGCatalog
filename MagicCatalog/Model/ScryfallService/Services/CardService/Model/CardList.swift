//
//  CardList.swift
//  MagicCatalog
//
//  Created by Alexander Rubtsov on 23.12.2022.
//

import Foundation

public struct CardList: Codable, CustomStringConvertible {

    let data: [Card]
    let hasMore: Bool
    let nextPage: String?
    
    // prints each set
    public var description: String {
        var text = ""
        var i = 0
        for card in data {
            text += "\n"
            text += card.description
            text += "\n"
            i = i + 1
        }
        return text
    }
}
