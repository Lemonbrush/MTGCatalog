//
//  MainScreenCardSearchManager.swift
//  MagicCatalog
//
//  Created by Alexander Rubtsov on 24.12.2022.
//

import Foundation

protocol MainScreenCardSearchManagerDelegate: AnyObject {
    func didReceiveCardData(_ cardListModel: CardList)
    func didReceiveError(error: MainScreenStateError)
}

class MainScreenCardSearchManager {
    
    // MARK: - Properties
    
    weak var delegate: MainScreenCardSearchManagerDelegate?
    
    // MARK: - Private properties
    
    private let cardSearchService = Swiftfall(networkService: NetworkService())
    
    // MARK: - Functions
    
    func requestCardsSerach(cardName: String) {
        cardSearchService.getCardListWithText(cardText: cardName) { [weak self] result in
            guard let self = self, case .success(let cards) = result else {
                return
            }
            
            self.delegate?.didReceiveCardData(cards)
        }
    }
}
