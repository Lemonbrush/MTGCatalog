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
    
    func didPressStubCellButton() {
        reloadContent()
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
        currentSearchQuery = query
        cardSerachManager.requestCardsSerach(cardName: query)
    }
    
    func didCancelSearch() {
        //currentState = .emptySearch
        //updateContentCells()
    }
    
    func didPressCardCell(_ cellId: Int) {
        let cardModel = cardModels[cellId]
        onNavigation?(.cardReview, cardModel.cardModel, cardModel.cardStateManager.cardFrontImage)
    }
    
    func didItemAppeared(index: Int) {
        if index == cardModels.count - 1 {
            loadMoreIfNeeded()
        }
    }
    
    func didPressLoadMoreErrorReload() {
        loadMoreIfNeeded()
    }
}
