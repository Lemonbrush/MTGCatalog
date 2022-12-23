//
//  ScryFallSet.swift
//  MagicCatalog
//
//  Created by Alexander Rubtsov on 23.12.2022.
//

import Foundation

struct ScryfallSet: Codable, CustomStringConvertible {
    
    // The unique three or four-letter code for this set.
    let code: String?
    
    // The unique code for this set on MTGO, which may differ from the regular code.
    let mtgo: String?
    
    //The English name of the set.
    let name: String
    
    // A URI where you can retrieve a full object describing this card on Scryfall’s API.
    let uri: String
    
    // Scryfall API URI
    let scryfallUri: String
    
    // A Scryfall API URI that you can request to begin paginating over the cards in this set.
    let searchUri: String
    
    // the release date of the set
    let releasedAt: String?
    
    // A computer-readable classification for this set. See below.
    let setType: String
    
    // The number of cards in this set.
    let cardCount: Int
    
    // Bool for if the card is digital
    let digital: Bool
    
    // Bool for if the card is foil
    let foilOnly: Bool
    
    // Block code, like self.code but the for the block the set is a member of
    let blockCode: String?
    
    // The block or group name code for this set, if any.
    let block: String?
    
    //A URI to an SVG file for this set’s icon on Scryfall’s CDN. Hotlinking this image isn’t recommended, because it may change slightly over time. You should download it and use it locally for your particular user interface needs.
    let iconSvgUri: String?
    
    // prints the minimal data for the set
    public var description: String{
        var text = ""
        text += "Name: \(name)\n"
        if self.code != nil {
            text += "Code: \(self.code!)\n"
        }
        if self.block != nil {
            text += "Block: \(self.block!)\n"
        }
        text += "Number of Cards: \(self.cardCount)\n"
        if self.releasedAt != nil {
            text += "Release Date: \(self.releasedAt!)\n"
        }
        text += "Set Type: \(setType)\n"
        
        return text
    }
}
