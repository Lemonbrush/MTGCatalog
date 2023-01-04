//
//  CardFace.swift
//  MagicCatalog
//
//  Created by Alexander Rubtsov on 23.12.2022.
//

import Foundation

struct CardFace: Codable {
    
    // MARK: - Properties
    
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
    
    // MARK: - Functions
    
    func imageUris(imageType: SwiftFallCardImagery) -> String? {
        switch imageType {
        case .png:
            return imageUris?["png"]
        case .borderCrop:
            return imageUris?["border_crop"]
        case .artCrop:
            return imageUris?["art_crop"]
        case .large:
            return imageUris?["large"]
        case .normal:
            return imageUris?["normal"]
        case .small:
            return imageUris?["small"]
        }
    }
}
