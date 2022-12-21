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
        viewModel.onNavigation = { [weak self] navigation in
            switch navigation {
            case .cardReview:
                self?.pushCardViewCoordinator()
            }
        }
        pushToNavigationStack(.mainScreen, viewModel: viewModel)
    }
    
    private func pushCardViewCoordinator() {
        let coordinator = CardReviewScreenCoordinator()
        coordinator.onFinish = { [weak self] in
            self?.popFromNavigationStack()
            
        }
        pushToNavigationStack(.cardReview, viewModel: coordinator)
    }
}
