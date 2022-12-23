//
//  SwiftfallError.swift
//  MagicCatalog
//
//  Created by Alexander Rubtsov on 23.12.2022.
//

import Foundation

// Sometimes we will cause and error and the API will tell us what it is.
struct ScryfallError: Codable, Error, CustomStringConvertible {
    let code: String
    let type: String
    let status: Int
    let details: String
    
    public var description: String {
        return "Error: \(code)\nDetails: \(details)\n"
    }
}
