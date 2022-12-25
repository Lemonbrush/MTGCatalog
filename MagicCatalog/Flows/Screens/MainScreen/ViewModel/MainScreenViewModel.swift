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

class MainScreenViewModel: ObservableObject {
    
    // MARK: - Properties
    
    @Published var navigationTitle: String = "Magic cards"
    @Published var contentGridColumns = 3
    @Published var cardViewModels: [MainScreenCellModel] = []
    
    var onNavigation: ((MainScreenNavigation) -> Void)?
    
    // MARK: - Private properties
    
    private let cardSerachManager: MainScreenCardSearchManager
    
    private let contentCellsManager = MainScreenContentCellsManager()
    private var currentState: MainScreenState = .emptySearch
    
    private var cardsSearchResults: [MainScreenCardCellModel] = []
    
    init() {
        cardSerachManager = MainScreenCardSearchManager()
        cardSerachManager.delegate = self
        
        updateContentCells()
    }
    
    // MARK: - Functions
    
    func didPressSearch(query: String) {
        navigationTitle = query
        cardSerachManager.requestCardsSerach(cardName: query)
    }
    
    // MARK: - Private functions
    
    private func updateContentCells() {
        switch currentState {
        case .emptySearch:
            contentGridColumns = 1
            cardViewModels = contentCellsManager.createEmptySearchStateCellModels()
        case .loaded:
            contentGridColumns = 3
            cardViewModels = contentCellsManager.createCardSearchResultsCellModels(cardsSearchResults)
        case .loding:
            break
        case .error(_):
            break
        }
    }
}

extension MainScreenViewModel: MainScreenCardSearchManagerDelegate {
    func didReceiveCardData(_ cardListModel: CardList) {
        DispatchQueue.main.async { [weak self] in
            var cardCellModels: [MainScreenCardCellModel] = []
            for cardModel in cardListModel.data {
                cardCellModels.append(MainScreenCardCellModel(imageURLString: cardModel.imageUris?["normal"] ?? "",
                                                              cardViewSize: .medium,
                                                              cardTitle: cardModel.name ?? "",
                                                              cardType: cardModel.typeLine ?? ""))
            }
            
            self?.cardsSearchResults = cardCellModels
            
            self?.currentState = .loaded
            self?.updateContentCells()
        }
    }
    
    func didReceiveError(error: MainScreenStateError) { }
}

extension MainScreenViewModel: MainScreenCollectionViewAdapterDelegate {
    func didPressErrorCellButton() {
        onNavigation?(.cardReview)
    }
}
