//
//  SetList.swift
//  MagicCatalog
//
//  Created by Alexander Rubtsov on 23.12.2022.
//

import Foundation

// struct which contains all sets
struct SetList: Codable, CustomStringConvertible {
    // data is an array of Sets
    let data: [ScryfallSet]
    
    let hasMore: Bool
    
    // prints each set
    var description: String {
        var text = ""
        var i = 0
        for set in data {
            text += "Set Number: \(i)\n"
            text += set.description
            text += "\n"
            i = i + 1
        }
        return text
    }
}
