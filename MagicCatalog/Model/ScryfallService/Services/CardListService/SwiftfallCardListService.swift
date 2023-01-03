//
//  SwiftfallCardListService.swift
//  MagicCatalog
//
//  Created by Alexander Rubtsov on 24.12.2022.
//

import Foundation

class SwiftfallCardListService {
    
    // MARK: - Private properties
    
    private let networkService: SwiftFallCoreNetworkServiceProtocol
    private let urlBase = SwiftFallConstants.scryfall + "cards"
    
    // MARK: - Construction
    
    init(_ networkService: SwiftFallCoreNetworkServiceProtocol) {
        self.networkService = networkService
    }
    
    // MARK: - Functions
    
    func getCardList(completion: @escaping (SwiftfalResult<CardList>) -> ()) {
        let call = urlBase + "/"
        requestData(call, completion: completion)
    }
    
    func getCardList(page: Int, completion: @escaping (SwiftfalResult<CardList>) -> ()) {
        let call = urlBase + "?page=\(page)"
        requestData(call, completion: completion)
    }
    
    func getSetList(completion: @escaping (SwiftfalResult<SetList>) -> ()) {
        let call = "\(SwiftFallConstants.scryfall)sets/"
        networkService.request(call: call, timeout: 15, completion: completion)
    }
    
    func getRulingList(code: String, number: Int, completion: @escaping (SwiftfalResult<RulingList>) -> ()) {
        let call = "\(SwiftFallConstants.scryfall)cards/\(code)/\(number)/rulings"
        networkService.request(call: call, timeout: 15, completion: completion)
    }
    
    func getSymbols(completion: @escaping (SwiftfalResult<SymbolList>) -> ()) {
        let call = "\(SwiftFallConstants.scryfall)symbology"
        networkService.request(call: call, timeout: 15, completion: completion)
    }
    
    func getCardListWithText(cardText: String, completion: @escaping (SwiftfalResult<CardList>) -> ()) {
        let call = "\(SwiftFallConstants.scryfall)cards/search?q=\(cardText)"
        networkService.request(call: call, timeout: 15, completion: completion)
    }
    
    func getNextCardListPage(cardListUrl: String, completion: @escaping (SwiftfalResult<CardList>) -> ()) {
        networkService.request(call: cardListUrl, timeout: 15, completion: completion)
    }
    
    // MARK: - Private functions
    
    private func requestData(_ call: String, completion: @escaping (SwiftfalResult<CardList>) -> ()) {
        networkService.request(call: call, timeout: 15, completion: completion)
    }
}
