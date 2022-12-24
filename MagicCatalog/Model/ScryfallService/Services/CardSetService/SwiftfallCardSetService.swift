//
//  SwiftfallCardSetService.swift
//  MagicCatalog
//
//  Created by Alexander Rubtsov on 24.12.2022.
//

import Foundation

class SwiftfallCardSetService {
    
    // MARK: - Private properties
    
    private let networkService: SwiftFallCoreNetworkServiceProtocol
    
    // MARK: - Construction
    
    init(_ networkService: SwiftFallCoreNetworkServiceProtocol) {
        self.networkService = networkService
    }
    
    // MARK: - Functions
    
    func getSet(code: String, completion: @escaping (SwiftfalResult<ScryfallSet>) -> ()) {
        let encodeExactly = code.addingPercentEncoding(withAllowedCharacters: .urlHostAllowed)!
        let call = "\(SwiftFallConstants.scryfall)sets/\(encodeExactly)"
        networkService.request(call: call, timeout: 15, completion: completion)
    }
}
