//
//  SwiftfallCardSetService.swift
//  MagicCatalog
//
//  Created by Alexander Rubtsov on 24.12.2022.
//

import Foundation

class SwiftfallCardSetService {
    
    // MARK: - Private properties
    
    private let networkService: SwiftfallNetworkServiceProtocol
    
    // MARK: - Construction
    
    init(_ networkService: SwiftfallNetworkServiceProtocol) {
        self.networkService = networkService
    }
    
    // MARK: - Functions
    
    // set
    func getSet(code: String) throws -> ScryfallSet {
        let encodeExactly = code.addingPercentEncoding(withAllowedCharacters: .urlHostAllowed)!
        let call = "\(SwiftFallConstants.scryfall)sets/\(encodeExactly)"
        return try networkService.requestData(call, type: ScryfallSet.self)
    }
}
