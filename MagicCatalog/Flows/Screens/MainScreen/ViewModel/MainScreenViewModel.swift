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

class MainScreenViewModel: ObservableObject {
    
    // MARK: - Properties
    
    var onNavigation: ((MainScreenNavigation) -> Void)?
    
    // MARK: - Functions
    
    func didPressRandomCardButton() {
        onNavigation?(.cardReview)
    }
}
