//
//  CardFace.swift
//  MagicCatalog
//
//  Created by Alexander Rubtsov on 23.12.2022.
//

import Foundation

struct CardFace: Codable {
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
}
