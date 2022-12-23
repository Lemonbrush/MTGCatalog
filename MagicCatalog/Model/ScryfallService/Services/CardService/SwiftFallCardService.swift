//
//  SwiftFallCardService.swift
//  MagicCatalog
//
//  Created by Alexander Rubtsov on 23.12.2022.
//

import Foundation

class SwiftFallCardService {
    
    // MARK: - Private properties
    
    private let jsonParser: SwiftFallJSONParserProtocol
    private lazy var networkService = SwiftfallNetworkService(jsonParser: jsonParser)
    
    private let urlBase = SwiftFallConstants.scryfall + "cards"
    
    // MARK: - Construction
    
    init(jsonParser: SwiftFallJSONParserProtocol) {
        self.jsonParser = jsonParser
    }
    
    // MARK: - Functions
    
    // gets a Card by using the code and id number
    func getCard(code: String, number: Int) throws -> Card {
        let call = urlBase + "/\(code)/\(number)"
        return try requestData(call)
    }
    
    // gets a Card by using the arena code
    func getCard(arena: Int) throws -> Card {
        let call = urlBase + "/arena/\(arena)"
        return try requestData(call)
    }
    
    // fuzzy
    func getRandomCard() throws -> Card {
        let call = urlBase + "/random"
        return try requestData(call)
    }
    
    // fuzzy
    func getCard(fuzzy: String) throws -> Card {
        let encodeFuzz = fuzzy.addingPercentEncoding(withAllowedCharacters: .urlHostAllowed)!
        let call = urlBase + "/named?fuzzy=\(encodeFuzz)"
        return try requestData(call)
    }
    
    // exact
    func getCard(exact: String) throws -> Card {
        let encodeExactly = exact.addingPercentEncoding(withAllowedCharacters: .urlHostAllowed)!
        let call = urlBase + "/named?exact=\(encodeExactly)"
        return try requestData(call)
    }
    
    // MARK: - Private functions
    
    private func requestData(_ call: String) throws -> Card {
        return try networkService.requestData(call, type: Card.self)
    }
}
