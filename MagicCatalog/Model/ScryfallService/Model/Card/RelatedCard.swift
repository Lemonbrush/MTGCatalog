//
//  RelatedCard.swift
//  MagicCatalog
//
//  Created by Alexander Rubtsov on 23.12.2022.
//

import Foundation

// Some cards have cards closely related to them. They will contain an array of RelatedCards.
struct RelatedCard: Codable, CustomStringConvertible {
    
    // An unique ID for this card in Scryfall’s database.
    let id: String
    
    // The name of this particular related card.
    let name: String
    
    // A URI where you can retrieve a full object describing this card on Scryfall’s API.
    let uri: String
    
    var description: String {
        return "Name: \(name)\nURI: \(uri)"
    }
}
