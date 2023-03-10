//
//  MainScreenCoordinator.swift
//  MagicCatalog
//
//  Created by Alexander Rubtsov on 22.12.2022.
//

import SwiftUI

enum MainScreenCoordinatorNavigation {
    case cardReview
    case mainScreen
}

class MainScreenCoordinator: Coordinator {
    @Published var navigationStack: [(MainScreenCoordinatorNavigation, Any)] = []
    
    init() {
        let viewModel = MainScreenViewModel()
        viewModel.onNavigation = { [weak self] navigation, cardModel, cardImage in
            switch navigation {
            case .cardReview:
                self?.pushCardViewCoordinator(swiftFallCardModel: cardModel, cardImage: cardImage)
            }
        }
        pushToNavigationStack(.mainScreen, viewModel: viewModel)
    }
    
    private func pushCardViewCoordinator(swiftFallCardModel: Card, cardImage: UIImage?) {
        let coordinator = CardReviewScreenCoordinator(swiftFallCardModel: swiftFallCardModel, cardImage: cardImage)
        coordinator.onFinish = { [weak self] in
            self?.popFromNavigationStack()
        }
        
        pushToNavigationStack(.cardReview, viewModel: coordinator)
    }
}
