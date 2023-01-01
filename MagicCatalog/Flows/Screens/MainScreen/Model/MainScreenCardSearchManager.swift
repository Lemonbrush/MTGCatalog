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
            guard let self = self else {
                return
            }
            
            switch result {
            case .success(let cards):
                self.delegate?.didReceiveCardData(cards)
            case .failure(let error):
                self.handleErrorResult(error: error)
            }
        }
    }
    
    // MARK: - Private functions
    
    private func handleErrorResult(error: SwiftFallResultError) {
        switch error {
        case .networkError(let error):
            handleNetworkError(error: error)
        case .scryfallError(let error):
            delegate?.didReceiveError(error: .serviceError(error: error))
        case .unknownError(let error):
            print(error.localizedDescription)
            delegate?.didReceiveError(error: .notAvailable)
        }
    }
    
    private func handleNetworkError(error: NetworkServiceError) {
        switch error {
        case .notConnectedToInternet:
            delegate?.didReceiveError(error: .notReachable)
        case .timeOut:
            delegate?.didReceiveError(error: .timeout)
        default:
            delegate?.didReceiveError(error: .genericError)
        }
    }
}
