//
//  SwiftfallCardListService.swift
//  MagicCatalog
//
//  Created by Alexander Rubtsov on 24.12.2022.
//

import Foundation

class SwiftfallCardListService {
    
    // MARK: - Private properties
    
    private let networkService: SwiftfallNetworkServiceProtocol
    private let urlBase = SwiftFallConstants.scryfall + "cards"
    
    // MARK: - Construction
    
    init(_ networkService: SwiftfallNetworkServiceProtocol) {
        self.networkService = networkService
    }
    
    // MARK: - Functions
    
    func getCardList() throws -> CardList {
        let call = urlBase + "/"
        return try requestData(call)
    }
    
    func getCardList(page: Int) throws -> CardList {
        let call = urlBase + "?page=\(page)"
        return try requestData(call)
    }
    
    func getSetList() throws -> SetList {
        let call = "\(SwiftFallConstants.scryfall)sets/"
        return try networkService.requestData(call, type: SetList.self)
    }
    
    func getRulingList(code: String, number: Int) throws -> RulingList {
        let call = "\(SwiftFallConstants.scryfall)cards/\(code)/\(number)/rulings"
        return try networkService.requestData(call, type: RulingList.self)
    }
    
    func getSymbols() throws -> SymbolList {
        let call = "\(SwiftFallConstants.scryfall)symbology"
        return try networkService.requestData(call, type: SymbolList.self)
    }
    
    func getSetCards(searchURI: String) -> [CardList?] {
        guard let cardlist = try? networkService.requestData(searchURI, type: CardList.self) else {
            return []
        }
        
        var cardListArray: [CardList?] = []
        if let nextPage = cardlist.nextPage, cardlist.hasMore {
            cardListArray.append(contentsOf: getSetCards(searchURI: nextPage))
        }
        cardListArray.append(cardlist)
        
        return cardListArray
    }
    
    // MARK: - Private functions
    
    private func requestData(_ call: String) throws -> CardList {
        return try networkService.requestData(call, type: CardList.self)
    }
}
