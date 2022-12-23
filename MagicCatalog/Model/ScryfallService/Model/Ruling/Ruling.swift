//
//  Ruling.swift
//  MagicCatalog
//
//  Created by Alexander Rubtsov on 23.12.2022.
//

import Foundation

struct Ruling: Codable, CustomStringConvertible {
    //     A computer-readable string indicating which company produced this ruling, either wotc or scryfall.
    let source: String
    
    // The date when the ruling or note was published.
    let publishedAt: String
    
    // The text of the ruling.
    let comment: String
    
    // A simple print function for a ruling
    var description: String {
        return "Source: \(source)\nComments: \(comment)\n"
    }
}
