//
//  SwiftfallCardService.swift
//  MagicCatalog
//
//  Created by Alexander Rubtsov on 23.12.2022.
//

import Foundation

class SwiftfallCardService {
    
    // MARK: - Private properties
    
    private let networkService: SwiftfallNetworkServiceProtocol
    private let urlBase = SwiftFallConstants.scryfall + "cards"
    
    // MARK: - Construction
    
    init(_ networkService: SwiftfallNetworkServiceProtocol) {
        self.networkService = networkService
    }
    
    // MARK: - Functions
    
    func getCard(code: String, number: Int) throws -> Card {
        let call = urlBase + "/\(code)/\(number)"
        return try requestData(call)
    }
    
    func getCard(arena: Int) throws -> Card {
        let call = urlBase + "/arena/\(arena)"
        return try requestData(call)
    }
    
    func getRandomCard() throws -> Card {
        let call = urlBase + "/random"
        return try requestData(call)
    }
    
    func getCard(fuzzy: String) throws -> Card {
        let encodeFuzz = fuzzy.addingPercentEncoding(withAllowedCharacters: .urlHostAllowed)!
        let call = urlBase + "/named?fuzzy=\(encodeFuzz)"
        return try requestData(call)
    }
    
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
