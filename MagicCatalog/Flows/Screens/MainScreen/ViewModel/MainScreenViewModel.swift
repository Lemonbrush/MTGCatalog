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
    case gridOne
    case gridTwo
    case gridThree
}

class MainScreenViewModel: ObservableObject {
    
    // MARK: - Properties
    
    @Published var navigationTitle: String = "Magic cards"
    @Published var contentGridColumns = 3
    @Published var cardViewModels: [MainScreenCellModel] = []
    
    var onNavigation: ((MainScreenNavigation, Card) -> Void)?
    
    var cardModels: [Card] = []
    var currentState: MainScreenState = .emptySearch
    
    // MARK: - Private properties
    
    private let cardSerachManager: MainScreenCardSearchManager
    
    private let contentCellsManager = MainScreenStateModelManager()
    private var resultsGridType: MainScreenGridType = .gridThree
    
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
        guard newGridType != resultsGridType else {
            return
        }
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
    
    // MARK: - Private functions
    
    private func updateLoadedState() {
        let loadedStateModel = contentCellsManager.createLoadedStateModel(resultsGridType: resultsGridType,
                                                                          cardsSearchResults: cardModels)
        cardViewModels = loadedStateModel.cardViewModels
        contentGridColumns = loadedStateModel.contentGridColumns
    }
    
    private func updateEmptySearchState() {
        let emptySearchState = contentCellsManager.createEmptySearchStateCellModels()
        contentGridColumns = emptySearchState.contentGridColumns
        cardViewModels = emptySearchState.cardViewModels
    }
}
