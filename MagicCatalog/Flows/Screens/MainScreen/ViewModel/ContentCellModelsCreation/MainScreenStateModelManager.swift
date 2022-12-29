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
    
    // MARK: - Private functions
    
    func createEmptySearchStateCellModels() -> [MainScreenContentCell] {
        let errorCellModel = MainScreenStubContentCellModel(image: UIImage(systemName: "rectangle.portrait.on.rectangle.portrait.fill"),
                                                            topText: "Find a card",
                                                            bottomText: "Start searching for an mtg card or get a ",
                                                            buttonLabelText: "Random card")
        
        return [errorCellModel]
    }
    
    func createLoadedStateModel(resultsGridType: MainScreenGridType,
                                cardsSearchResults: [MainScreenCardCellModel]) -> [MainScreenContentCell] {
        return loadedStateAdapter.createMainScreenViewModelLoadedStateModel(gridType: resultsGridType,
                                                                            cardsSearchResults: cardsSearchResults)
    }
}
