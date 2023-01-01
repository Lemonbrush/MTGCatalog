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
                                                   cardsSearchResults: [MainScreenCardCellModel],
                                                   totalCards: Int) -> [MainScreenContentCell] {
        var mainScreenContentCells: [MainScreenContentCell] = []
        
        let textLineCellModel = createTextLineCellModel(text: "\(totalCards) cards were found")
        mainScreenContentCells.append(textLineCellModel)
        
        switch gridType {
        case .grid(columns: let columns):
            let contentCellModels =  createGridCell(cards: cardsSearchResults, columns: columns)
            mainScreenContentCells.append(contentCellModels)
        case .inline:
            let cardViewModels = createRegularCellModels(cards: cardsSearchResults)
            let contentCellModels =  MainScreenGridContentCellModel(viewModels: cardViewModels, columns: 5)
            mainScreenContentCells.append(contentCellModels)
        }
        
        mainScreenContentCells.append(createTextLineCellModel(text: "This search is finished. Now the real work can begin."))
        
        return mainScreenContentCells
    }
    
    // MARK: - Private functions
    
    private func createTextLineCellModel(text: String) -> MainScreenTextContentCellModel {
        return MainScreenTextContentCellModel(text: text)
    }
    
    private func createGridCell(cards: [MainScreenCardCellModel], columns: Int) -> MainScreenGridContentCellModel {
        switch columns {
        case 1...2:
            let cardViewModels = createRegularCellModels(cards: cards)
            return MainScreenGridContentCellModel(viewModels: cardViewModels, columns: columns)
        default:
            let cardViewModels = createSubtitledCellModels(cards: cards)
            return MainScreenGridContentCellModel(viewModels: cardViewModels, columns: columns)
        }
    }
    
    private func createRegularCellModels(cards: [MainScreenCardCellModel]) -> [CardsGridCellModel] {
        var cellModels: [CardsGridCellModel] = []
        for (cellId, cardCellModel) in cards.enumerated() {
            let cellModel = CardsGridSimpleCardCellModel(cellId: cellId, stateManager: cardCellModel.cardStateManager)
            cellModels.append(cellModel)
        }
        return cellModels
    }
    
    private func createSubtitledCellModels(cards: [MainScreenCardCellModel]) -> [CardsGridCellModel] {
        var cellModels: [CardsGridCellModel] = []
        for (cellId, cardCellModel) in cards.enumerated() {
            let cellModel = CardsGridSubtitledCardCellModel(cellId: cellId,
                                                            stateManager: cardCellModel.cardStateManager,
                                                            cardTitle: cardCellModel.cardModel.name ?? "",
                                                            cardType: cardCellModel.cardModel.typeLine ?? "")
            cellModels.append(cellModel)
        }
        return cellModels
    }
}
