//
//  MainScreenViewModel+SearchManagerDelegate.swift
//  MagicCatalog
//
//  Created by Alexander Rubtsov on 26.12.2022.
//

import Foundation

struct MainScreenCardCellModel {
    let cardStateManager: InteractiveCardStateManager
    let cardModel: Card
}

extension MainScreenViewModel: MainScreenCardSearchManagerDelegate {
    
    // MARK: - Functions
    
    func didReceiveCardData(_ cardListModel: CardList) {
        DispatchQueue.main.async { [weak self] in
            guard let self = self else {
                return
            }
            
            self.setupCardCelModels(cardListModel.data)

            self.currentState = .loaded
            self.updateContentCells()
        }
    }
    
    func didReceiveError(error: MainScreenStateError) { }
}
