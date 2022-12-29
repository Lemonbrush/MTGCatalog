//
//  Card.swift
//  MagicCatalog
//
//  Created by Alexander Rubtsov on 23.12.2022.
//

import Foundation

enum SwiftFallCardImagery {
    case png, borderCrop, artCrop, large, normal, small
}

struct Card: Codable, CustomStringConvertible {
    
    let prices: CardPrice?
    
    /// A unique ID for this card in Scryfall’s database.
    let id: String
    
    /// A unique ID for this card’s oracle identity. This value is consistent across reprinted card editions, and unique among different cards with the same name (tokens, Unstable variants, etc).
    let oracleId: String
    
    /// This card’s multiverse IDs on Gatherer, if any, as an array of integers. Note that Scryfall includes many promo cards, tokens, and other esoteric objects that do not have these identifiers.
    let multiverseIds: [Int]
    
    /// This card’s Magic Online ID (also known as the Catalog ID), if any. A large percentage of cards are not available on Magic Online and do not have this ID.
    let mtgoId: Int?
    
    /// This card’s foil Magic Online ID (also known as the Catalog ID), if any. A large percentage of cards are not available on Magic Online and do not have this ID.
    let mtgoFoilId: Int?
    
    /// The name of this card. If this card has multiple faces, this field will contain both names separated by ␣//␣.
    let name: String?
    
    /// A link to this card object on Scryfall’s API.
    let uri: String?
    
    /// A link to this card’s permapage on Scryfall’s website.
    let scryfallUri: String
    
    /// If the card has multiple face this is an array of the card faces
    let cardFaces: [CardFace]?
    
    /// A link to where you can begin paginating all re/prints for this card on Scryfall’s API.
    let printsSearchUri: String
    
    /// A link to this card’s rulings on Scryfall’s API.
    let rulingsUri: String
    
    /// A computer-readable designation for this card’s layout. See the layout article.
    let layout: String
    
    /// The card’s converted mana cost. Note that some funny cards have fractional mana costs.
    let cmc: Double?
    
    /// The type line of this card.
    let typeLine: String?
    
    /// The Oracle text for this card, if any.
    let oracleText: String?
    
    /// The mana cost for this card. This value will be any empty string "" if the cost is absent. Remember that per the game rules, a missing mana cost and a mana cost of {0} are different values.
    let manaCost: String?
    
    /// This card’s power, if any. Note that some cards have powers that are not numeric, such as *.
    let power: String?
    
    /// This card’s toughness, if any. Note that some cards have toughnesses that are not numeric, such as *.
    let toughness: String?
    
    /// This loyalty if any. Note that some cards have loyalties that are not numeric, such as X.
    let loyalty: String?
    
    /// This card’s colors.
    let colors: [String]?
    
    /// Online listings for these cards names.
    let purchaseUris: [String: String]
    
    /// Flavor text on the card, if there is any
    let flavorText: String?
    
    /// id of the illustration
    let illustrationId: String?
    
    /// uris of the images
    let imageUris: [String: String]?
    
    /// legality in different formats
    let legalities: [String: String]
    
    /// is or is not on the reserved list
    let reserved: Bool
    
    /// This card’s overall rank/popularity on EDHREC. Not all carsd are ranked.
    let edhrecRank: Int?
    
    /// If this card is closely related to other cards, this property will be an array with.
    let allParts: [RelatedCard]?
    
    /// This card's set code
    let set: String
    
    /// This card's set's full name
    let setName: String
    
    /// This card's rarity. This is not the same for all versions of the card.
    let rarity: String
    
    /// This card's artist
    let artist: String?
    
    /// True if this is a digital card on Magic Online.
    let digital: Bool
    
    /// True if this card’s imagery is high resolution.
    let highresImage: Bool
    
    /// True if this card’s artwork is larger than normal.
    let fullArt: Bool
    
    /// This card’s watermark, if any.
    let watermark: String?
    
    /// This card’s border color: black, borderless, gold, silver, or white.
    let borderColor: String
    
    /// This card’s story spotlight number, if any.
    let storySpotlightNumber: Int?
    
    /// A URL to this cards’s story article, if any.
    let storySpotlightUri: String?
    
    /// Return string when self is used as a parameter for print
    var description: String {
        var text = ""
        // if the card has multiple faces, print them
        if (self.cardFaces) != nil {
            for face in cardFaces! {
                text += face.description
                text += "\n"
            }
            return text
        }
        // Each variable is tested to see if printing it makes sense.
        if self.name != nil {
            text += "Name: \(name!)\n"
        }
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
