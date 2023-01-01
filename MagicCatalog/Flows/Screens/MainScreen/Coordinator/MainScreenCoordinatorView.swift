//
//  MainScreenCoordinatorView.swift
//  MagicCatalog
//
//  Created by Alexander Rubtsov on 22.12.2022.
//

import SwiftUI

struct MainScreenCoordinatorView: View {
    @ObservedObject var coordinator: MainScreenCoordinator
    
    var body: some View {
        ZStack {
            MainScreenView<MainScreenViewModel>(viewModel: coordinator.viewModel(for: .mainScreen))
            LazyNavigationLink(
                isActive: coordinator.isActive(.cardReview),
                destination: {
                    CardReviewScreenCoordinatorView(coordinator: coordinator.viewModel(for: .cardReview))
                })
        }
    }
}
