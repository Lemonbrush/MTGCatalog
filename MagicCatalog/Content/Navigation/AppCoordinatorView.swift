//
//  AppCoordinatorView.swift
//  MagicCatalog
//
//  Created by Alexander Rubtsov on 21.12.2022.
//

import SwiftUI

struct AppCoordinatorView: View {
    
    // MARK: - Properties
    
    @ObservedObject var coordinator: AppCoordinator
    
    // MARK: - Body view
    
    var body: some View {
        NavigationView {
            MainScreenCoordinatorView(coordinator: coordinator.viewModel(for: .mainScreen))
        }
    }
}
