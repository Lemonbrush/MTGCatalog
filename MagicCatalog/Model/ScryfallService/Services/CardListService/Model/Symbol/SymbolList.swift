//
//  SymbolList.swift
//  MagicCatalog
//
//  Created by Alexander Rubtsov on 23.12.2022.
//

import Foundation

struct SymbolList: Codable, CustomStringConvertible {
    
    // if there are more pages, should always be false
    let hasMore: Bool
    let data: [Symbol]
    
    public var description: String {
        var text = ""
        for sym in data {
            text += sym.description
            text += "\n"
        }
        return text
    }
}
