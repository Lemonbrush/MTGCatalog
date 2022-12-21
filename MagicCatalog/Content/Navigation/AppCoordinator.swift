//
//  AppCoordinator.swift
//  MagicCatalog
//
//  Created by Alexander Rubtsov on 21.12.2022.
//

import Foundation

enum AppCoordinatorNavigation {
    case cardReview
    case mainScreen
}

final class AppCoordinator: Coordinator {
    @Published var navigationStack: [(AppCoordinatorNavigation, Any)] = []
    
    init() {
        pushToNavigationStack(.cardReview, viewModel: CardReviewScreenViewModel())
    }
}

enum CardReviewCoordinatorNavigation {
    case mainScreen
}

class CardReviewScreenCoordinator: Coordinator {
    
    @Published var navigationStack: [(CardReviewCoordinatorNavigation, Any)] = []
    
    init() {
        let viewModel = CardReviewScreenViewModel()
        viewModel.onNavigation = { [weak self] navigation in
            switch navigation {
            case .mainScreen:
                self?.pushMainScreenCoordinator()
            }
        }
    }
    
    // MARK: - Private functions
    
    private func pushMainScreenCoordinator() {
        let coordinator = MainScreenCoordinator()
        pushToNavigationStack(.mainScreen, viewModel: coordinator)
    }
}

class MainScreenCoordinator: Coordinator {
    @Published var navigationStack: [(CardReviewCoordinatorNavigation, Any)] = []
}
