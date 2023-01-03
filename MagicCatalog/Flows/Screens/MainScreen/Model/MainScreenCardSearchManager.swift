//
//  MainScreenCardSearchManager.swift
//  MagicCatalog
//
//  Created by Alexander Rubtsov on 24.12.2022.
//

import Foundation

protocol MainScreenCardSearchManagerDelegate: AnyObject {
    func didReceiveCardData(_ cardListModel: CardList)
    func didReceiveNextPageData(_ cardListModel: CardList)
    func didReceiveError(error: MainScreenStateError)
    func didReceiveLoadMoreError(error: MainScreenLoadMoreError)
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
    
    func requestNextPage(_ nextPageUrl: String) {
        cardSearchService.getNextCardListPage(cardListUrl: nextPageUrl) { [weak self] result in
            guard let self = self else {
                return
            }
            
            switch result {
            case .success(let cards):
                self.delegate?.didReceiveNextPageData(cards)
            case .failure(let error):
                self.handleLoadMoreErrorResult(error)
            }
        }
    }
    
    // MARK: - Private functions
    
    private func handleLoadMoreErrorResult(_ error: SwiftFallResultError) {
        if case .networkError(error: let networkError) = error,
           case .notConnectedToInternet = networkError {
            delegate?.didReceiveLoadMoreError(error: .notReachable)
        }
        
        delegate?.didReceiveLoadMoreError(error: .notAvailable)
    }
    
    private func handleErrorResult(error: SwiftFallResultError) {
        
        switch error {
        case .networkError(let error):
            handleNetworkError(error: error)
        case .scryfallError(let error):
            delegate?.didReceiveError(error: .serviceError(error: error))
        case .unknownError(_):
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
