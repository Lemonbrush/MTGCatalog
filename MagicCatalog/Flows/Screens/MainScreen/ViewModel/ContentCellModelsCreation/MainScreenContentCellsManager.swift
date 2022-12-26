//
//  MainScreenContentCellsManager.swift
//  MagicCatalog
//
//  Created by Alexander Rubtsov on 24.12.2022.
//

import UIKit

class MainScreenContentCellsManager {
    
    // MARK: - Private functions
    
    func createEmptySearchStateCellModels() -> [MainScreenCellModel] {
        let errorCellModel = MainScreenErrorCellModel(image: UIImage(systemName: "rectangle.portrait.on.rectangle.portrait.fill"),
                                                      topText: "Find a card",
                                                      bottomText: "Start searching for an mtg card or get a ",
                                                      buttonLabelText: "Random card")
        return [MainScreenCellModel(id: 0, model: errorCellModel)]
    }
    
    func createCardSearchResultsCellModels(cards: [MainScreenCardCellModel],
                                           resultsGridType: MainScreenGridType) -> [MainScreenCellModel] {
        var cellModels: [MainScreenCellModel] = []
        
        for (id, card) in cards.enumerated() {
            let cellModel = MainScreenCellModel(id: id, model: card)
            cellModels.append(cellModel)
        }
        
        return cellModels
    }
}
