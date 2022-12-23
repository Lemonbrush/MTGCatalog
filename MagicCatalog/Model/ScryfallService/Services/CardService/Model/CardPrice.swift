//
//  CardPrice.swift
//  MagicCatalog
//
//  Created by Alexander Rubtsov on 23.12.2022.
//

import Foundation

struct CardPrice: Codable, CustomStringConvertible {
    let usd: String?
    let usdFoil: String?
    let eur: String?
    let tix: String?
    
    var description: String {
        var text = ""
        if let usd = self.usd {
            text += "usd: \(usd)"
        }
        if let usdFoil = self.usdFoil {
            text += "usdFoil: \(usdFoil)"
        }
        if let eur = self.eur {
            text += "eur: \(eur)"
        }
        if let tix = self.tix {
            text += "tix: \(tix)"
        }
        return text
    }
    
}
