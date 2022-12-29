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
        var mainScreenContentCells: [MainScreenGridContentCellModel] = []
        
        switch gridType {
        case .grid(columns: let columns):
            let cardViewModels = createSubtitledCellModels(cards: cardsSearchResults)
            let contentCellModels =  MainScreenGridContentCellModel(viewModels: cardViewModels, columns: columns)
            mainScreenContentCells.append(contentCellModels)
        default:
            let cardViewModels = createSubtitledCellModels(cards: cardsSearchResults)
            let contentCellModels =  MainScreenGridContentCellModel(viewModels: cardViewModels, columns: 4)
            mainScreenContentCells.append(contentCellModels)
        }
        
        return MainScreenViewModelLoadedStateModel(contentCellModels: mainScreenContentCells)
    }
    
    // MARK: - Private functions
    
    private func createRegularCellModels(cards: [MainScreenCardCellModel]) -> [MainScreenCellModelContainer] {
        var cellModels: [CardsGridCellModel] = []
        for (cellId, cardCellModel) in cards.enumerated() {
            let cellModel = CardsGridSimpleCardCellModel(cellId: cellId, stateManager: cardCellModel.cardStateManager)
            cellModels.append(cellModel)
        }
        return createCardSearchResultsCellModels(cards: cellModels)
    }
    
    private func createSubtitledCellModels(cards: [MainScreenCardCellModel]) -> [MainScreenCellModelContainer] {
        var cellModels: [CardsGridCellModel] = []
        for (cellId, cardCellModel) in cards.enumerated() {
            let cellModel = CardsGridSubtitledCardCellModel(cellId: cellId,
                                                            stateManager: cardCellModel.cardStateManager,
                                                            cardTitle: cardCellModel.cardModel.name ?? "",
                                                            cardType: cardCellModel.cardModel.typeLine ?? "")
            cellModels.append(cellModel)
        }
        return createCardSearchResultsCellModels(cards: cellModels)
    }
    
    private func createCardSearchResultsCellModels(cards: [CardsGridCellModel]) -> [MainScreenCellModelContainer] {
        var cellModels: [MainScreenCellModelContainer] = []
        
        for (id, card) in cards.enumerated() {
            let cellModel = MainScreenCellModelContainer(id: id, model: card)
            cellModels.append(cellModel)
        }
        
        return cellModels
    }
}
