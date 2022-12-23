//
//  SwiftFallCatalogsService.swift
//  MagicCatalog
//
//  Created by Alexander Rubtsov on 23.12.2022.
//

import Foundation

class SwiftFallCatalogService {
    
    // MARK: - Private properties
    
    private let jsonParser: SwiftFallJSONParserProtocol
    private lazy var networkService = SwiftfallNetworkService(jsonParser: jsonParser)
    
    // MARK: - Construction
    
    init(jsonParser: SwiftFallJSONParserProtocol) {
        self.jsonParser = jsonParser
    }
    
    // MARK: - Functions
    
    func cardNames() throws -> Catalog {
        return try getCatalog(catalog: "card-names")
    }
    
    func wordBank() throws -> Catalog {
        return try getCatalog(catalog: "word-bank")
    }
    
    func creatureTypes() throws -> Catalog {
        return try getCatalog(catalog: "creature-types")
    }
    
    func planeswalkerTypes() throws -> Catalog {
        return try getCatalog(catalog: "planeswalker-types")
    }
    
    func landTypes() throws -> Catalog {
        return try getCatalog(catalog: "land-types")
    }
    
    func spellTypes() throws -> Catalog {
        return try getCatalog(catalog: "spell-types")
    }
    
    func artifactTypes() throws -> Catalog {
        return try getCatalog(catalog: "artifact-types")
    }
    
    func powers() throws -> Catalog {
        return try getCatalog(catalog: "powers")
    }
    
    func toughnesses() throws -> Catalog {
        return try getCatalog(catalog: "toughnesses")
    }
    
    func loyalties() throws -> Catalog {
        return try getCatalog(catalog: "loyalties")
    }
    
    func watermarks() throws -> Catalog {
        return try getCatalog(catalog: "watermarks")
    }
    
    // give a search term and return a catalog of similar cards
    func autocomplete(_ string: String) throws -> Catalog {
        let call = "\(SwiftFallConstants.scryfall)cards/autocomplete?q=\(string)"
        return try requestData(call)
    }
    
    // MARK: - Private functions
    
    private func getCatalog(catalog: String) throws -> Catalog {
        let encodeCatalog = catalog.addingPercentEncoding(withAllowedCharacters: .urlHostAllowed)!
        let call = "\(SwiftFallConstants.scryfall)catalog/\(encodeCatalog)"
        return try requestData(call)
    }
    
    // MARK: - Private functions
    
    private func requestData(_ call: String) throws -> Catalog {
        return try networkService.requestData(call, type: Catalog.self)
    }
}
