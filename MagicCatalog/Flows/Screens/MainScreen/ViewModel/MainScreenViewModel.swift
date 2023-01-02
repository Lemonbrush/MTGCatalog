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
    @Published var shoulScrollToTop = false
    
    var onNavigation: ((MainScreenNavigation, Card, UIImage?) -> Void)?
    
    var cardModels: [MainScreenCardCellModel] = []
    var currentState: MainScreenState = .emptySearch
    
    var cardList: CardList? = nil
    var totalCards: Int = 0
    var resultsGridType: MainScreenGridType = .grid(columns: 2)
    let cardSerachManager: MainScreenCardSearchManager
    
    // MARK: - Private properties
    
    private let contentCellsManager = MainScreenStateModelManager()
    
    // MARK: - Construction
    
    init() {
        cardSerachManager = MainScreenCardSearchManager()
        cardSerachManager.delegate = self
        
        updateContentCells()
    }
    
    // MARK: - Functions
    
    func updateContentCells() {
        DispatchQueue.main.async { [weak self] in
            guard let self = self else {
                return
            }
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
    
    func setupCardListModel(_ cardListModel: CardList) {
        cardList = cardListModel
        updateCardModels(cardListModel.data)
        totalCards = cardListModel.totalCards
    }
    
    func setupNextPageCardListModel(_ cardListModel: CardList) {
        
    }
    
    func loadMoreIfNeeded() {
        if let currentCardList = cardList,
            let nextPageUrl = cardList?.nextPage,
            currentCardList.hasMore {
            cardSerachManager.requestNextPage(nextPageUrl)
        }
    }
    
    // MARK: - Private functions
    
    private func updateCardModels(_ newCards: [Card]) {
        var cardCellModels: [MainScreenCardCellModel] = []
        for cardModel in newCards {
            let imageURL = cardModel.imageUris(imageType: .normal) ?? ""
            let cardCellStateManager = InteractiveCardStateManager(imageURLString: imageURL)
            cardCellModels.append(MainScreenCardCellModel(cardStateManager: cardCellStateManager, cardModel: cardModel))
        }
        
        cardModels = cardCellModels
        shoulScrollToTop.toggle()
    }
    
    private func updateLoadedState() {
        contentCellModels = contentCellsManager.createLoadedStateModel(resultsGridType: resultsGridType,
                                                                       cardsSearchResults: cardModels,
                                                                       totalCards: totalCards)
    }
    
    private func updateEmptySearchState() {
        contentCellModels = contentCellsManager.createEmptySearchStateCellModels()
    }
    
    private func updateErrorState(_ errorState: MainScreenStateError) {
        contentCellModels = contentCellsManager.createErrorStateCellModel(errorState)
    }
}
