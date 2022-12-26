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

enum MainScreenStateError: String {
    case notReachable
    case notAvailable
    case timeout
}

enum MainScreenState {
    case emptySearch
    case loaded
    case loding
    case error(MainScreenStateError)
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
    
    // MARK: - Private properties
    
    private let cardSerachManager: MainScreenCardSearchManager
    
    private let contentCellsManager = MainScreenContentCellsManager()
    private var currentState: MainScreenState = .emptySearch
    private var resultsGridType: MainScreenGridType = .gridThree
    
    private var cardsSearchResults: [MainScreenCardCellModel] = []
    private var cardModels: [Card] = []
    
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
        //onNavigation?(.cardReview)
    }
    
    func didCancelSearch() {
        currentState = .emptySearch
        updateContentCells()
    }
    
    // MARK: - Private functions
    
    private func updateContentCells() {
        switch currentState {
        case .emptySearch:
            contentGridColumns = 1
            cardViewModels = contentCellsManager.createEmptySearchStateCellModels()
        case .loaded:
            contentGridColumns = 3
            cardViewModels = contentCellsManager.createCardSearchResultsCellModels(cards: cardsSearchResults,
                                                                                   resultsGridType: resultsGridType)
        case .loding:
            break
        case .error(_):
            break
        }
    }
}

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

extension MainScreenViewModel: MainScreenCollectionViewAdapterDelegate {
    func didPressCardCell(_ cellId: Int) {
        let cardModel = cardModels[cellId]
        onNavigation?(.cardReview, cardModel)
    }
    
    func didPressErrorCellButton() {
        showRandomCardReviewScreen()
    }
}
