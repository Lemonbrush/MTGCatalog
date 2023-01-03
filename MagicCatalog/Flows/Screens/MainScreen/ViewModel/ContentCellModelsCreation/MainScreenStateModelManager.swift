//
//  MainScreenContentCellsManager.swift
//  MagicCatalog
//
//  Created by Alexander Rubtsov on 24.12.2022.
//

import UIKit

class MainScreenStateModelManager {
    
    // MARK: - Private properties
    
    private let loadedStateAdapter = MainScreenViewModelLoadedStateAdapter()
    private let errorStateAdapter = MainScreenViewModelErrorStateAdapter()
    private let loadMoreStateAdapter = MainScreenViewModelLoadMoreStateAdapter()
    
    // MARK: - Private functions
    
    func createEmptySearchStateCellModels() -> [MainScreenContentCell] {
        let errorCellModel = MainScreenStubContentCellModel(systemImageName: "rectangle.portrait.on.rectangle.portrait.fill",
                                                            topText: "Find a card",
                                                            bottomText: "Start searching for an mtg card or get a ",
                                                            buttonLabelText: "Random card")
        
        return [errorCellModel]
    }
    
    func createLoadedStateModel(resultsGridType: MainScreenGridType,
                                cardsSearchResults: [MainScreenCardCellModel],
                                totalCards: Int,
                                hasMode: Bool) -> [MainScreenContentCell] {
        return loadedStateAdapter.createMainScreenViewModelLoadedStateModel(gridType: resultsGridType,
                                                                            cardsSearchResults: cardsSearchResults,
                                                                            totalCards: totalCards,
                                                                            hasMore: hasMode)
    }
    
    func updateLoadMoreErrorState(resultsGridType: MainScreenGridType,
                                  cardsSearchResults: [MainScreenCardCellModel],
                                  totalCards: Int,
                                  loadMoreError: MainScreenLoadMoreError,
                                  hasMode: Bool) -> [MainScreenContentCell] {
        var loadedStateModels = loadedStateAdapter.createMainScreenViewModelLoadedStateModel(gridType: resultsGridType,
                                                                                             cardsSearchResults: cardsSearchResults,
                                                                                             totalCards: totalCards,
                                                                                             hasMore: hasMode)
        let loadingLoadMoreCellModel = loadMoreStateAdapter.createLoadMoreErrorStateModel(loadMoreError)
        loadedStateModels.append(loadingLoadMoreCellModel)
        
        return loadedStateModels
    }
    
    func updateLoadMoreLoadingState(resultsGridType: MainScreenGridType,
                                    cardsSearchResults: [MainScreenCardCellModel],
                                    totalCards: Int,
                                    hasMode: Bool) -> [MainScreenContentCell] {
        var loadedStateModels = loadedStateAdapter.createMainScreenViewModelLoadedStateModel(gridType: resultsGridType,
                                                                                             cardsSearchResults: cardsSearchResults,
                                                                                             totalCards: totalCards,
                                                                                             hasMore: hasMode)
        let loadingLoadMoreCellModel = loadMoreStateAdapter.createLoadMoreLoadingStateModel()
        loadedStateModels.append(loadingLoadMoreCellModel)
        
        return loadedStateModels
    }
    
    func createErrorStateCellModel(_ errorState: MainScreenStateError) -> [MainScreenContentCell] {
        return errorStateAdapter.createMainScreenViewModelErrorStateModel(errorState)
    }
}
