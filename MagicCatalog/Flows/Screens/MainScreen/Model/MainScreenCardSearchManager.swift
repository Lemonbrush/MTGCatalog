//
//  MainScreenCardSearchManager.swift
//  MagicCatalog
//
//  Created by Alexander Rubtsov on 24.12.2022.
//

import Foundation

protocol MainScreenCardSearchManagerDelegate: AnyObject {
    func didReceiveCardData(_ cardModel: Card)
    func didReceiveError(error: MainScreenStateError)
}

class MainScreenCardSearchManager {
    
    // MARK: - Properties
    
    weak var delegate: MainScreenCardSearchManagerDelegate?
    
    // MARK: - Private properties
    
    private let cardSearchService = Swiftfall(networkService: NetworkService())
    
    // MARK: - Functions
    
    func requestCardsSerach(cardName: String) {
        cardSearchService.getCardWithFuzzyName(cardName) { [weak self] result in
            guard let self = self else {
                return
            }
            
            if case .success(let cards) = result {
                self.delegate?.didReceiveCardData(cards)
            }
        }
    }
}
