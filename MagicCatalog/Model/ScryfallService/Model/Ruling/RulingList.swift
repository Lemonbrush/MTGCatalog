//
//  RulingList.swift
//  MagicCatalog
//
//  Created by Alexander Rubtsov on 23.12.2022.
//

import Foundation

struct RulingList: Codable, CustomStringConvertible {
    // Contains rulings
    let data: [Ruling]
    
    let hasMore: Bool
    
    var description: String {
        var text = ""
        for rule in data {
            text += rule.description
            text += "\n"
        }
        return text
    }
}
