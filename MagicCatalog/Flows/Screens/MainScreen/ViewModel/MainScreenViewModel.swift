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
    private var resultsGridType: MainScreenGridType = .grid(columns: 2)
    
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
        DispatchQueue.main.async { [weak self] in
            guard let self = self else {
                return
            }
            self.currentState = .error(.genericError)
            switch self.currentState {
            case .emptySearch:
                self.updateEmptySearchState()
            case .loaded:
                self.updateLoadedState()
            case .loding:
                break
            case .error(let errorState):
                self.updateErrorState(errorState)
            }
        }
    }
    
    func setupCardCelModels(_ cardModels: [Card]) {
        var cardCellModels: [MainScreenCardCellModel] = []
        for cardModel in cardModels {
            let imageURL = cardModel.imageUris(imageType: .normal) ?? ""
            let cardCellStateManager = InteractiveCardStateManager(imageURLString: imageURL)
            cardCellModels.append(MainScreenCardCellModel(cardStateManager: cardCellStateManager, cardModel: cardModel))
        }
        
        self.cardModels = cardCellModels
    }
    
    // MARK: - Private functions
    
    private func updateLoadedState() {
        contentCellModels = contentCellsManager.createLoadedStateModel(resultsGridType: resultsGridType,
                                                                       cardsSearchResults: cardModels)
    }
    
    private func updateEmptySearchState() {
        contentCellModels = contentCellsManager.createEmptySearchStateCellModels()
    }
    
    private func updateErrorState(_ errorState: MainScreenStateError) {
        contentCellModels = contentCellsManager.createErrorStateCellModel(errorState)
    }
}
