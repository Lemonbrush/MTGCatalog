//
//  InteractiveCardView.swift
//  MagicCatalog
//
//  Created by Alexander Rubtsov on 25.12.2022.
//

import SwiftUI

struct InteractiveCardView: View {
    
    // MARK: - Properties
    
    @ObservedObject var stateManager: InteractiveCardStateManager
    
    // MARK: - Private properties

    private let stateViewAdapter = InteractiveCardStateViewAdapter()
    
    // MARK: - Body view
    
    var body: some View {
        stateViewAdapter.createInteractiveCardStateView(stateManager.stateModel)
    }
}
