//
//  CardReviewScreenCoordinatorView.swift
//  MagicCatalog
//
//  Created by Alexander Rubtsov on 22.12.2022.
//

import SwiftUI

struct CardReviewScreenCoordinatorView: View {
    @ObservedObject var coordinator: CardReviewScreenCoordinator
    
    var body: some View {
        ZStack {
            CardReviewScreenView(viewModel: coordinator.viewModel(for: .cardReview))
            LazyNavigationLink(
                isActive: coordinator.isActive(.mainScreen),
                destination: {
                    MainScreenCoordinatorView(coordinator: coordinator.viewModel(for: .mainScreen))
                }).navigationBarHidden(true)
        }
    }
}
