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
            let cardViewModels = createSubtitledCellModels(cards: cardsSearchResults)
            return MainScreenViewModelLoadedStateModel(contentGridColumns: 3, cardViewModels: cardViewModels)
        case .gridTwo:
            let cardViewModels = createRegularCellModels(cards: cardsSearchResults)
            return MainScreenViewModelLoadedStateModel(contentGridColumns: 2, cardViewModels: cardViewModels)
        case .gridOne:
            let cardViewModels = createRegularCellModels(cards: cardsSearchResults)
            return MainScreenViewModelLoadedStateModel(contentGridColumns: 1, cardViewModels: cardViewModels)
        case .gridFour:
            let cardViewModels = createSubtitledCellModels(cards: cardsSearchResults)
            return MainScreenViewModelLoadedStateModel(contentGridColumns: 4, cardViewModels: cardViewModels)
        default:
            let cardViewModels = createSubtitledCellModels(cards: cardsSearchResults)
            return MainScreenViewModelLoadedStateModel(contentGridColumns: 4, cardViewModels: cardViewModels)
        }
    }
    
    // MARK: - Private functions
    
    private func createRegularCellModels(cards: [MainScreenCardCellModel]) -> [MainScreenCellModel] {
        var cellModels: [MainScreenCellModelProtocol] = []
        for (cellId, cardCellModel) in cards.enumerated() {
            let cellModel = MainScreenTwoGridCardCellModel(stateManager: cardCellModel.cardStateManager,
                                                           cellId: cellId)
            cellModels.append(cellModel)
        }
        return createCardSearchResultsCellModels(cards: cellModels)
    }
    
    private func createSubtitledCellModels(cards: [MainScreenCardCellModel]) -> [MainScreenCellModel] {
        var cellModels: [MainScreenCellModelProtocol] = []
        for (cellId, cardCellModel) in cards.enumerated() {
            let cellModel = MainScreenThreeGridCardCellModel(stateManager: cardCellModel.cardStateManager,
                                                             cardTitle: cardCellModel.cardModel.name ?? "",
                                                             cardType: cardCellModel.cardModel.typeLine ?? "",
                                                    cellId: cellId)
            cellModels.append(cellModel)
        }
        return createCardSearchResultsCellModels(cards: cellModels)
    }
    
    private func createCardSearchResultsCellModels(cards: [MainScreenCellModelProtocol]) -> [MainScreenCellModel] {
        var cellModels: [MainScreenCellModel] = []
        
        for (id, card) in cards.enumerated() {
            let cellModel = MainScreenCellModel(id: id, model: card)
            cellModels.append(cellModel)
        }
        
        return cellModels
    }
}
