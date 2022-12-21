//
//  MainScreenView.swift
//  MagicCatalog
//
//  Created by Alexander Rubtsov on 22.12.2022.
//

import SwiftUI

struct MainScreenView: View {
    
    // MARK: - Properties
    
    @ObservedObject var viewModel: MainScreenViewModel
    
    // MARK: - Body view
    
    var body: some View {
        Button("Random card") {
            viewModel.didPressRandomCardButton()
        }
    }
}
