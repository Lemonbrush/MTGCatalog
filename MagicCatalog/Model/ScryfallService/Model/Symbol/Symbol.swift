//
//  Symbol.swift
//  MagicCatalog
//
//  Created by Alexander Rubtsov on 23.12.2022.
//

import Foundation

struct Symbol: Codable, CustomStringConvertible {
    
    /// The plaintext symbol. Often surrounded with curly braces {}. Note that not all symbols are ASCII text (for example, {∞}).
    let symbol: String
    
    /// An alternate version of this symbol, if it is possible to write it without curly braces.
    let looseVariant: String?
    
    /// An English snippet that describes this symbol. Appropriate for use in alt text or other accessible communication formats.
    let english: String
    
    /// True if it is possible to write this symbol “backwards”. For example, the official symbol {U/P} is sometimes written as {P/U} or {P\U} in informal settings. Note that the Scryfall API never writes symbols backwards in other responses. This field is provided for informational purposes.
    let transposable: Bool
    
    /// True if this is a mana symbol.
    let representsMana: Bool?
    
    /// True if this symbol appears in a mana cost on any Magic card. For example {20} has this field set to false because {20} only appears in Oracle text, not mana costs.
    let appearsInManaCosts: Bool
    
    /// A decimal number representing this symbol’s converted mana cost. Note that mana symbols from funny sets can have fractional converted mana costs.
    let cmc: Double?
    
    /// True if this symbol is only used on funny cards or Un-cards.
    let funny: Bool
    
    /// An array of colors that this symbol represents.
    let colors: [String]
    
    /// String that is printed when print(self) is called.
    var description: String {
        return "Symbol: \(symbol)\nEnglish: \(english)\n"
    }
}
