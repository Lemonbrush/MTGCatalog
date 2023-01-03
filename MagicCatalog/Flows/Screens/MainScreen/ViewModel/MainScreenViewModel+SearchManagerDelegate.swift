//
//  MainScreenViewModel+SearchManagerDelegate.swift
//  MagicCatalog
//
//  Created by Alexander Rubtsov on 26.12.2022.
//

import Foundation

extension MainScreenViewModel: MainScreenCardSearchManagerDelegate {
    
    // MARK: - Functions
    
    func didReceiveCardData(_ cardListModel: CardList) {
        DispatchQueue.main.async { [weak self] in
            guard let self = self else {
                return
            }
            
            self.setupCardListModel(cardListModel)

            self.currentState = .loaded
            self.updateContentCells()
        }
    }
    
    func didReceiveNextPageData(_ cardListModel: CardList) {
        setupNextPageCardListModel(cardListModel)
        updateContentCells()
    }
    
    func didReceiveError(error: MainScreenStateError) {
        currentState = .error(error)
        updateContentCells()
    }
}
