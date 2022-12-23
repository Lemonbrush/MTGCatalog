//
//  CardFace.swift
//  MagicCatalog
//
//  Created by Alexander Rubtsov on 23.12.2022.
//

import Foundation

struct CardFace: Codable, CustomStringConvertible {
    let name: String?
    let manaCost: String?
    let typeLine: String?
    let oracleText: String?
    let colors: [String]?
    let power: String?
    let toughness: String?
    let loyalty: String?
    let flavorText: String?
    let illustrationId: String?
    let imageUris: [String: String]?
    
    var description: String {
        var text = "Name: \(name!)\n"
        
        if self.manaCost != nil {
            text += "Cost: \(manaCost!)\n"
        }
        if self.typeLine != nil {
            text += "Type Line: \(typeLine!)\n"
        }
        if self.oracleText != nil {
            text += "Oracle Text:\n\(oracleText!)\n"
        }
        if self.power != nil && self.toughness != nil {
            text += "Power: \(power!)\nToughness: \(toughness!)\n"
        }
        if self.loyalty != nil {
            text += "Loyalty: \(loyalty!)\n"
        }
        return text
    }
}
