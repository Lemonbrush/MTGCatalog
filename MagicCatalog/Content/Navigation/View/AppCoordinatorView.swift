//
//  AppCoordinatorView.swift
//  MagicCatalog
//
//  Created by Alexander Rubtsov on 21.12.2022.
//

import SwiftUI

struct AppCoordinatorView: View {
    
    @ObservedObject var coordinator: AppCoordinator
    
    var body: some View {
        ZStack {
            CardReviewScreenView()
            
            LazyNavigationLink(isActive: coordinator.isActive(.cardReview), destination: {
                AppCoordinatorView(coordinator: coordinator.viewModel(for: .cardReview))
            })
        }
    }
}
