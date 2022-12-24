//
//  CardReviewScreenSearchManager.swift
//  MagicCatalog
//
//  Created by Alexander Rubtsov on 24.12.2022.
//

import Foundation

protocol RandomCardReviewScreenSearchManagerDelegate: AnyObject {
    func didReceiveCardData(_ cardModel: Card)
    func didReceiveError(error: MainScreenStateError)
}

class RandomCardReviewScreenSearchManager {
    
    // MARK: - Properties
    
    weak var delegate: RandomCardReviewScreenSearchManagerDelegate?
    
    // MARK: - Private properties
    
    private let cardSearchService = Swiftfall(networkService: NetworkService())
    
    // MARK: - Functions
    
    func requestCardsSerach() {
        cardSearchService.getRandomCard { [weak self] result in
            guard let self = self else {
                return
            }
            
            if case .success(let cardData) = result {
                self.delegate?.didReceiveCardData(cardData)
            }
        }
    }
}
