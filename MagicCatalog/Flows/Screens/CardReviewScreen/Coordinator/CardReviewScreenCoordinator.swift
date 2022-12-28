//
//  CardReviewScreenCoordinator.swift
//  MagicCatalog
//
//  Created by Alexander Rubtsov on 22.12.2022.
//

import SwiftUI

enum CardReviewCoordinatorNavigation {
    case cardReview
    case mainScreen
}

class CardReviewScreenCoordinator: Coordinator {
    
    @Published var navigationStack: [(CardReviewCoordinatorNavigation, Any)] = []
    
    var onFinish: (() -> Void)?
    
    init(swiftFallCardModel: Card) {
        let viewModel = CardReviewScreenViewModel(swiftFallCardModel: swiftFallCardModel)
        viewModel.onNavigation = { [weak self] navigation in
            switch navigation {
            case .back:
                self?.onFinish?()
            }
        }
        pushToNavigationStack(.cardReview, viewModel: viewModel)
    }
}
