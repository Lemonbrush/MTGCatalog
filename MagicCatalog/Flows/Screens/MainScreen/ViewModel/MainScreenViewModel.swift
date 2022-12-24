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
    case none
    case loaded
    case loding
    case error(MainScreenStateError)
}

class MainScreenViewModel: ObservableObject {
    
    // MARK: - Properties
    
    @State var navigationTitle: String = "Magic cards"
    
    var onNavigation: ((MainScreenNavigation) -> Void)?
    
    // MARK: - Private properties
    
    private let cardSerachManager: MainScreenCardSearchManager
    private var currentState: MainScreenState = .none
    
    init() {
        cardSerachManager = MainScreenCardSearchManager()
        cardSerachManager.delegate = self
    }
    
    // MARK: - Functions
    
    func didPressRandomCardButton() {
        onNavigation?(.cardReview)
    }
    
    func didPressSearch(query: String) {
        cardSerachManager.requestCardsSerach(cardName: query)
    }
}

extension MainScreenViewModel: MainScreenCardSearchManagerDelegate {
    func didReceiveCardData(_ cardModel: Card) {
        navigationTitle = cardModel.name ?? ""
    }
    
    func didReceiveError(error: MainScreenStateError) { }
}
