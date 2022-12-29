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
        case .gridThree:
            let cardViewModels = createSubtitledCellModels(cards: cardsSearchResults)
            let contentCellModels =  MainScreenGridContentCellModel(viewModels: cardViewModels, columns: 3)
            mainScreenContentCells.append(contentCellModels)
        case .gridTwo:
            let cardViewModels = createRegularCellModels(cards: cardsSearchResults)
            let contentCellModels =  MainScreenGridContentCellModel(viewModels: cardViewModels, columns: 2)
            mainScreenContentCells.append(contentCellModels)
        case .gridOne:
            let cardViewModels = createRegularCellModels(cards: cardsSearchResults)
            let contentCellModels =  MainScreenGridContentCellModel(viewModels: cardViewModels, columns: 1)
            mainScreenContentCells.append(contentCellModels)
        case .gridFour:
            let cardViewModels = createSubtitledCellModels(cards: cardsSearchResults)
            let contentCellModels =  MainScreenGridContentCellModel(viewModels: cardViewModels, columns: 4)
            mainScreenContentCells.append(contentCellModels)
        default:
            let cardViewModels = createSubtitledCellModels(cards: cardsSearchResults)
            let contentCellModels =  MainScreenGridContentCellModel(viewModels: cardViewModels, columns: 4)
            mainScreenContentCells.append(contentCellModels)
        }
        
        return MainScreenViewModelLoadedStateModel(contentCellModels: mainScreenContentCells)
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
