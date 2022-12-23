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
    
    private var currentState: MainScreenState = .none
    
    // MARK: - Functions
    
    func didPressRandomCardButton() {
        onNavigation?(.cardReview)
    }
    
    func didPressSearch(query: String) {
        
    }
}

extension MainScreenViewModel: CardSearchManagerDelegate {
    func didReceiveCardData(_ cardModel: Swiftfall.Card) {
        
    }
    
    func didReceiveError(error: MainScreenStateError) { }
}

protocol CardSearchManagerDelegate: AnyObject {
    func didReceiveCardData(_ cardModel: Swiftfall.Card)
    func didReceiveError(error: MainScreenStateError)
}

class CardSearchManager {
    
    // MARK: - Properties
    
    weak var delegate: CardSearchManagerDelegate?
    
    // MARK: - Functions
    
    func requestCardsSerach(cardName: String) {
        do {
            delegate?.didReceiveCardData(try Swiftfall.getCard(exact: cardName))
        } catch {
            print(error.localizedDescription)
        }
    }
}
