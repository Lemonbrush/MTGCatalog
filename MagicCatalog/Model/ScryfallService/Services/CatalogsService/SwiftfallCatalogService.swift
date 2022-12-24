//
//  SwiftfallCatalogService.swift
//  MagicCatalog
//
//  Created by Alexander Rubtsov on 23.12.2022.
//

import Foundation

class SwiftfallCatalogService {
    
    // MARK: - Private properties
    
    private let networkService: SwiftFallCoreNetworkServiceProtocol
    
    // MARK: - Construction
    
    init(_ networkService: SwiftFallCoreNetworkServiceProtocol) {
        self.networkService = networkService
    }
    
    // MARK: - Functions
    
    func cardNames(completion: @escaping (SwiftfalResult<Catalog>) -> Void) {
        getCatalog(catalog: "card-names", completion: completion)
    }
    
    func wordBank(completion: @escaping (SwiftfalResult<Catalog>) -> Void) {
        getCatalog(catalog: "word-bank", completion: completion)
    }
    
    func creatureTypes(completion: @escaping (SwiftfalResult<Catalog>) -> Void) {
        getCatalog(catalog: "creature-types", completion: completion)
    }
    
    func planeswalkerTypes(completion: @escaping (SwiftfalResult<Catalog>) -> Void) {
        getCatalog(catalog: "planeswalker-types", completion: completion)
    }
    
    func landTypes(completion: @escaping (SwiftfalResult<Catalog>) -> Void) {
        getCatalog(catalog: "land-types", completion: completion)
    }
    
    func spellTypes(completion: @escaping (SwiftfalResult<Catalog>) -> Void) {
        getCatalog(catalog: "spell-types", completion: completion)
    }
    
    func artifactTypes(completion: @escaping (SwiftfalResult<Catalog>) -> Void) {
        getCatalog(catalog: "artifact-types", completion: completion)
    }
    
    func powers(completion: @escaping (SwiftfalResult<Catalog>) -> Void) {
        getCatalog(catalog: "powers", completion: completion)
    }
    
    func toughnesses(completion: @escaping (SwiftfalResult<Catalog>) -> Void) {
        getCatalog(catalog: "toughnesses", completion: completion)
    }
    
    func loyalties(completion: @escaping (SwiftfalResult<Catalog>) -> Void) {
        getCatalog(catalog: "loyalties", completion: completion)
    }
    
    func watermarks(completion: @escaping (SwiftfalResult<Catalog>) -> Void) {
        getCatalog(catalog: "watermarks", completion: completion)
    }
    
    // give a search term and return a catalog of similar cards
    func autocomplete(_ string: String, completion: @escaping (SwiftfalResult<Catalog>) -> Void) {
        let call = "\(SwiftFallConstants.scryfall)cards/autocomplete?q=\(string)"
        getCatalog(catalog: call, completion: completion)
    }
    
    // MARK: - Private functions
    
    private func getCatalog(catalog: String, completion: @escaping (SwiftfalResult<Catalog>) -> Void) {
        if let encodeCatalog = catalog.addingPercentEncoding(withAllowedCharacters: .urlHostAllowed) {
            let call = "\(SwiftFallConstants.scryfall)catalog/\(encodeCatalog)"
            networkService.request(call: call, timeout: 15, completion: completion)
        }
    }
}
