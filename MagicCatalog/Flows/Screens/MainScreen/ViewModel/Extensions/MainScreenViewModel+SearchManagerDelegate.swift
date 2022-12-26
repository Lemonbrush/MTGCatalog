//
//  MainScreenViewModel+SearchManagerDelegate.swift
//  MagicCatalog
//
//  Created by Alexander Rubtsov on 26.12.2022.
//

import Foundation

extension MainScreenViewModel: MainScreenCardSearchManagerDelegate {
    
    // MARK: - Functions
    
    func didReceiveCardData(_ cardListModel: CardList) {
        DispatchQueue.main.async { [weak self] in
            guard let self = self else {
                return
            }
            
            self.cardModels = cardListModel.data
            
            var cardCellModels: [MainScreenCardCellModel] = []
            for (cellId, cardModel) in cardListModel.data.enumerated() {
                cardCellModels.append(self.createCellModel(cellId: cellId, cardModel: cardModel))
            }
            
            self.cardsSearchResults = cardCellModels
            
            self.currentState = .loaded
            self.updateContentCells()
        }
    }
    
    func didReceiveError(error: MainScreenStateError) { }
    
    // MARK: - Private functions
    
    private func createCellModel(cellId: Int, cardModel: Card) -> MainScreenCardCellModel {
        let cardStateManager = InteractiveCardStateManager(imageURLString: cardModel.imageUris?["normal"] ?? "",
                                                           cardViewSize: CardSizeConfiguration.medium.cardSize)
        let cellModel = MainScreenCardCellModel(stateManager: cardStateManager,
                                                cardTitle: cardModel.name ?? "",
                                                cardType: cardModel.typeLine ?? "",
                                                cellId: cellId)
        return cellModel
    }
}
