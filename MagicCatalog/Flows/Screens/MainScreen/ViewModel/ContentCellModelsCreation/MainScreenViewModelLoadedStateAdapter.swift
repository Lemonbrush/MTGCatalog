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
                                                   cardsSearchResults: [Card]) -> MainScreenViewModelLoadedStateModel {
        switch gridType {
        case .gridThree:
            let cardViewModels = createGridThreeCellModels(cards: cardsSearchResults)
            return MainScreenViewModelLoadedStateModel(contentGridColumns: 3, cardViewModels: cardViewModels)
        case .gridTwo:
            let cardViewModels = createGridTwoCellModels(cards: cardsSearchResults)
            return MainScreenViewModelLoadedStateModel(contentGridColumns: 2, cardViewModels: cardViewModels)
        case .gridOne:
            let cardViewModels = createGridThreeCellModels(cards: cardsSearchResults)
            return MainScreenViewModelLoadedStateModel(contentGridColumns: 1, cardViewModels: cardViewModels)
        default:
            let cardViewModels = createGridThreeCellModels(cards: cardsSearchResults)
            return MainScreenViewModelLoadedStateModel(contentGridColumns: 3, cardViewModels: cardViewModels)
        }
    }
    
    // MARK: - Private functions
    
    private func createGridTwoCellModels(cards: [Card]) -> [MainScreenCellModel] {
        var cellModels: [MainScreenCellModelProtocol] = []
        for (cellId, cardModel) in cards.enumerated() {
            let cardStateManager = InteractiveCardStateManager(imageURLString: cardModel.imageUris?["normal"] ?? "")
            let cellModel = MainScreenTwoGridCardCellModel(stateManager: cardStateManager,
                                                           cellId: cellId)
            cellModels.append(cellModel)
        }
        return createCardSearchResultsCellModels(cards: cellModels)
    }
    
    private func createGridThreeCellModels(cards: [Card]) -> [MainScreenCellModel] {
        var cellModels: [MainScreenCellModelProtocol] = []
        for (cellId, cardModel) in cards.enumerated() {
            let cardStateManager = InteractiveCardStateManager(imageURLString: cardModel.imageUris?["normal"] ?? "")
            let cellModel = MainScreenThreeGridCardCellModel(stateManager: cardStateManager,
                                                    cardTitle: cardModel.name ?? "",
                                                    cardType: cardModel.typeLine ?? "",
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
