//
//  Catalog.swift
//  MagicCatalog
//
//  Created by Alexander Rubtsov on 23.12.2022.
//

import Foundation

// A Catalog object contains an array of Magic datapoints (words, card values, etc).

// Catalog objects are provided by the API as aids for building other Magic software
// and understanding possible values for a field on Card objects.

struct Catalog: Codable, CustomStringConvertible {
    let uri: String?
    let totalValues: Int?
    let totalItems: Int?
    let data:[String]
    
    var description: String {
        var text = ""
        for thing in data {
            text += "\(thing)\n"
        }
        return text
    }
}
