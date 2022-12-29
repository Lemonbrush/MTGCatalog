//
//  MainScreenViewModel.swift
//  MagicCatalog
//
//  Created by Alexander Rubtsov on 22.12.2022.
//

import SwiftUI

enum MainScreenNavigation: Equatable {
    case cardReview
}

enum MainScreenGridType {
    case inline
    case grid(columns: Int)
}

class MainScreenViewModel: ObservableObject {
    
    // MARK: - Properties
    
    @Published var navigationTitle: String = "Magic cards"
    @Published var contentCellModels: [MainScreenContentCell] = []
    
    var onNavigation: ((MainScreenNavigation, Card) -> Void)?
    
    var cardModels: [MainScreenCardCellModel] = []
    var currentState: MainScreenState = .emptySearch
    
    // MARK: - Private properties
    
    private let cardSerachManager: MainScreenCardSearchManager
    
    private let contentCellsManager = MainScreenStateModelManager()
    private var resultsGridType: MainScreenGridType = .grid(columns: 1)
    
    // MARK: - Construction
    
    init() {
        cardSerachManager = MainScreenCardSearchManager()
        cardSerachManager.delegate = self
        
        updateContentCells()
    }
    
    // MARK: - Functions
    
    func didPressSearch(query: String) {
        guard query != navigationTitle else {
            return
        }
        
        navigationTitle = query
        cardSerachManager.requestCardsSerach(cardName: query)
    }
    
    func showRandomCardReviewScreen() {
        //onNavigation?(.randomCardScreen)
    }
    
    func didCancelSearch() {
        //currentState = .emptySearch
        //updateContentCells()
    }
    
    func updateContentGridType(_ newGridType: MainScreenGridType) {
        resultsGridType = newGridType
        updateContentCells()
    }
    
    func updateContentCells() {
        switch currentState {
        case .emptySearch:
            updateEmptySearchState()
        case .loaded:
            updateLoadedState()
        case .loding:
            break
        case .error(_):
            break
        }
    }
    
    func setupCardCelModels(_ cardModels: [Card]) {
        var cardCellModels: [MainScreenCardCellModel] = []
        for cardModel in cardModels {
            let cardCellStateManager = InteractiveCardStateManager(imageURLString: cardModel.imageUris?["normal"] ?? "")
            cardCellModels.append(MainScreenCardCellModel(cardStateManager: cardCellStateManager, cardModel: cardModel))
        }
        
        self.cardModels = cardCellModels
    }
    
    // MARK: - Private functions
    
    private func updateLoadedState() {
        let loadedStateModel = contentCellsManager.createLoadedStateModel(resultsGridType: resultsGridType,
                                                                          cardsSearchResults: cardModels)
        
        contentCellModels = loadedStateModel.contentCellModels
    }
    
    private func updateEmptySearchState() {
        let emptySearchState = contentCellsManager.createEmptySearchStateCellModels()
        contentCellModels = emptySearchState.contentCellModels
    }
}
