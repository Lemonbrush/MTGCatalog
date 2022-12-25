//
//  InteractiveCardView.swift
//  MagicCatalog
//
//  Created by Alexander Rubtsov on 25.12.2022.
//

import SwiftUI

struct InteractiveCardView: View {
    
    // MARK: - Properties
    
    @ObservedObject var viewModel: InteractiveCardViewModel
    
    // MARK: - Private properties

    private let stateViewAdapter = InteractiveCardStateViewAdapter()
    
    // MARK: - Construction
    
    init(viewModel: InteractiveCardViewModel) {
        self.viewModel = viewModel
    }
    
    // MARK: - Body view
    
    var body: some View {
        stateViewAdapter.createInteractiveCardStateView(viewModel.stateModel)
    }
}
