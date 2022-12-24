//
//  SwiftfallCardService.swift
//  MagicCatalog
//
//  Created by Alexander Rubtsov on 23.12.2022.
//

import Foundation

class SwiftfallCardService {
    
    // MARK: - Private properties
    
    private let networkService: SwiftFallCoreNetworkServiceProtocol
    private let urlBase = SwiftFallConstants.scryfall + "cards"
    
    // MARK: - Construction
    
    init(_ networkService: SwiftFallCoreNetworkServiceProtocol) {
        self.networkService = networkService
    }
    
    // MARK: - Functions
    
    func getCard(code: String, number: Int, completion: @escaping (SwiftfalResult<Card>) -> Void) {
        let call = urlBase + "/\(code)/\(number)"
        requestData(call, completion: completion)
    }
    
    func getCard(arena: Int, completion: @escaping (SwiftfalResult<Card>) -> Void) {
        let call = urlBase + "/arena/\(arena)"
        requestData(call, completion: completion)
    }
    
    func getRandomCard(completion: @escaping (SwiftfalResult<Card>) -> Void) {
        let call = urlBase + "/random"
        requestData(call, completion: completion)
    }
    
    func getCard(fuzzy: String, completion: @escaping (SwiftfalResult<Card>) -> Void) {
        if let encodeFuzz = fuzzy.addingPercentEncoding(withAllowedCharacters: .urlHostAllowed) {
            let call = urlBase + "/named?fuzzy=\(encodeFuzz)"
            requestData(call, completion: completion)
        }
    }
    
    func getCard(exact: String, completion: @escaping (SwiftfalResult<Card>) -> Void) {
        if let encodeExactly = exact.addingPercentEncoding(withAllowedCharacters: .urlHostAllowed) {
            let call = urlBase + "/named?exact=\(encodeExactly)"
            requestData(call, completion: completion)
        }
    }
    
    // MARK: - Private functions
    
    private func requestData(_ call: String, completion: @escaping (SwiftfalResult<Card>) -> Void) {
        networkService.request(call: call, timeout: 15, completion: completion)
    }
}
