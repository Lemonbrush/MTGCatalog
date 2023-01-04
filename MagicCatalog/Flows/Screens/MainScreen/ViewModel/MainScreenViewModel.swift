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
            case .loadingMore:
                self.updateLoadingMoreState()
            case .loadingMoreError(let loadingMoreError):
                self.updateLoadingMoreErrorState(loadingMoreError)
            }
        }
    }
    
    func setupCardListModel(_ cardListModel: CardList) {
        cardList = cardListModel
        updateCardModels(cardListModel.data)
        totalCards = cardListModel.totalCards
    }
    
    func setupNextPageCardListModel(_ cardListModel: CardList) {
        cardList = cardListModel
        addMoreCardModels(cardListModel.data)
    }
    
    func loadMoreIfNeeded() {
        if let currentCardList = cardList,
            let nextPageUrl = cardList?.nextPage,
            currentCardList.hasMore {
            cardSerachManager.requestNextPage(nextPageUrl)
            currentState = .loadingMore
            updateContentCells()
        }
    }
    
    // MARK: - Private functions
    
    private func updateCardModels(_ newCards: [Card]) {
        cardModels = createCardCellModels(newCards)
        shoulScrollToTop.toggle()
    }
    
    private func addMoreCardModels(_ newCards: [Card]) {
        let newCardModels = createCardCellModels(newCards)
        cardModels.append(contentsOf: newCardModels)
    }
    
    private func createCardCellModels(_ cards: [Card]) -> [MainScreenCardCellModel] {
        var cardCellModels: [MainScreenCardCellModel] = []
        for cardModel in cards {
            let cardManagerModel = createCardStateManagerModel(cardModel)
            let cardCellStateManager = InteractiveCardStateManager(cardManagerModel: cardManagerModel)
            cardCellModels.append(MainScreenCardCellModel(cardStateManager: cardCellStateManager, cardModel: cardModel))
        }
        return cardCellModels
    }
    
    private func createCardStateManagerModel(_ cardModel: Card) -> InteractiveCardStateManagerModel {
        if let cardFaces = cardModel.cardFaces, let frontImage = cardFaces[safe: 0]?.imageUris(imageType: .normal) {
            let backImageURLString = cardFaces[safe: 1]?.imageUris(imageType: .normal)
            return InteractiveCardStateManagerModel(frontImageURLString: frontImage, backImageURLString: backImageURLString)
        }
        
        return InteractiveCardStateManagerModel(frontImageURLString: cardModel.imageUris(imageType: .normal) ?? "")
    }
    
    private func updateLoadedState() {
        contentCellModels = contentCellsManager.createLoadedStateModel(resultsGridType: resultsGridType,
                                                                       cardsSearchResults: cardModels,
                                                                       totalCards: totalCards,
                                                                       hasMode: cardList?.hasMore ?? false)
    }
    
    private func updateEmptySearchState() {
        contentCellModels = contentCellsManager.createEmptySearchStateCellModels()
    }
    
    private func updateErrorState(_ errorState: MainScreenStateError) {
        contentCellModels = contentCellsManager.createErrorStateCellModel(errorState)
    }
    
    private func updateLoadingMoreState() {
        contentCellModels = contentCellsManager.updateLoadMoreLoadingState(resultsGridType: resultsGridType,
                                                                           cardsSearchResults: cardModels,
                                                                           totalCards: totalCards,
                                                                           hasMode: cardList?.hasMore ?? false)
    }
    
    private func updateLoadingMoreErrorState(_ loadingMoreError: MainScreenLoadMoreError) {
        contentCellModels = contentCellsManager.updateLoadMoreErrorState(resultsGridType: resultsGridType,
                                                                         cardsSearchResults: cardModels,
                                                                         totalCards: totalCards,
                                                                         loadMoreError: loadingMoreError,
                                                                         hasMode: cardList?.hasMore ?? false)
    }
}
