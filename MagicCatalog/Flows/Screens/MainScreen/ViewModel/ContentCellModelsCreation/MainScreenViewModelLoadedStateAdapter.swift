//
//  MainScreenViewModelLoadedStateAdapter.swift
//  MagicCatalog
//
//  Created by Alexander Rubtsov on 26.12.2022.
//

import Foundation

class MainScreenViewModelLoadedStateAdapter {
    
    // MARK: - Functions
    
    func createMainScreenViewModelLoadedStateModel(gridType: MainScreenGridType,
                                                   cardsSearchResults: [MainScreenCardCellModel]) -> MainScreenViewModelLoadedStateModel {
        switch gridType {
        case .gridThree:
            let cardViewModels = createCardSearchResultsCellModels(cards: cardsSearchResults)
            return MainScreenViewModelLoadedStateModel(contentGridColumns: 3, cardViewModels: cardViewModels)
        case .gridTwo:
            let cardViewModels = createCardSearchResultsCellModels(cards: cardsSearchResults)
            return MainScreenViewModelLoadedStateModel(contentGridColumns: 2, cardViewModels: cardViewModels)
        case .gridOne:
            let cardViewModels = createCardSearchResultsCellModels(cards: cardsSearchResults)
            return MainScreenViewModelLoadedStateModel(contentGridColumns: 1, cardViewModels: cardViewModels)
        default:
            let cardViewModels = createCardSearchResultsCellModels(cards: cardsSearchResults)
            return MainScreenViewModelLoadedStateModel(contentGridColumns: 3, cardViewModels: cardViewModels)
        }
    }
    
    // MARK: - Private functions
    
    private func createCardSearchResultsCellModels(cards: [MainScreenCardCellModel]) -> [MainScreenCellModel] {
        var cellModels: [MainScreenCellModel] = []
        
        for (id, card) in cards.enumerated() {
            let cellModel = MainScreenCellModel(id: id, model: card)
            cellModels.append(cellModel)
        }
        
        return cellModels
    }
}
