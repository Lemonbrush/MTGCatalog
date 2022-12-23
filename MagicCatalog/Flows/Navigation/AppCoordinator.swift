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
    
    // MARK: - Properties
    
    @Published var navigationStack: [(AppCoordinatorNavigation, Any)] = []
    
    // MARK: - Construction
    
    init() {
        pushToNavigationStack(.mainScreen, viewModel: MainScreenCoordinator())
        pushToNavigationStack(.cardReview, viewModel: CardReviewScreenCoordinator())
    }
}
