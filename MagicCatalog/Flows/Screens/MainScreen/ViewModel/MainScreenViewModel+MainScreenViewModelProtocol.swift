//
//  MainScreenViewModel+MainScreenViewModelProtocol.swift
//  MagicCatalog
//
//  Created by Alexander Rubtsov on 01.01.2023.
//

import Foundation

extension MainScreenViewModel: MainScreenViewModelProtocol {
    
    // MARK: - Functions
    
    func showRandomCardReviewScreen() {
        //onNavigation?(.randomCardScreen)
    }
    
    func updateContentGridType(_ newGridType: MainScreenGridType) {
        resultsGridType = newGridType
        updateContentCells()
    }
    
    func didPressSearch(query: String) {
        guard query != navigationTitle else {
            return
        }
        
        navigationTitle = query
        cardSerachManager.requestCardsSerach(cardName: query)
    }
    
    func didCancelSearch() {
        //currentState = .emptySearch
        //updateContentCells()
    }
    
    func didPressCardCell(_ cellId: Int) {
        let cardModel = cardModels[cellId]
        onNavigation?(.cardReview, cardModel.cardModel, cardModel.cardStateManager.cardImage)
    }
    
    func didItemAppeared(index: Int) {
        print("\(index) / \(cardModels.count)")
        if index == cardModels.count {
            loadMoreIfNeeded()
        }
    }
}
