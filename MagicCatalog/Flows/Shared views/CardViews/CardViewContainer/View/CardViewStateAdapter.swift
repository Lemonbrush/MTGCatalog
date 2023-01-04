//
//  CardViewStateAdapter.swift
//  MagicCatalog
//
//  Created by Alexander Rubtsov on 25.12.2022.
//

import SwiftUI

struct CardViewStateAdapter: View {
    
    // MARK: - Properties
    
    @ObservedObject var stateManager: CardViewStateManager
    
    // MARK: - Private properties
    
    private let loadedStateAdapter = CardViewLoadedStateAdapter()
    
    // MARK: - Body view
    
    var body: some View {
        switch stateManager.stateModel {
        case let loadedStateModel as InteractiveCardLoadedStateModel:
            return createLoadedCardView(stateModel: loadedStateModel)
        case let loadingStateModel as InteractiveCardLoadingStateModel:
            return createLoadingCardView(loadingStateModel: loadingStateModel)
        case let errorStateModel as InteractiveCardErrorStateModel:
            return createErrorCardView(errorStateModel: errorStateModel)
        default:
            return AnyView(EmptyView())
        }
    }
    
    // MARK: - Private functions
    
    private func createLoadedCardView(stateModel: InteractiveCardLoadedStateModel) -> AnyView {
        let view = loadedStateAdapter.createCardViewCell(frontCardImage: stateModel.frontFace,
                                                         backCardImage: stateModel.backFace,
                                                         cardViewType: stateModel.cardViewType)
        return AnyView(view)
    }
    
    private func createErrorCardView(errorStateModel: InteractiveCardErrorStateModel) -> AnyView {
        let view = InteractiveCardErrorView()
        return AnyView(view)
    }
    
    private func createLoadingCardView(loadingStateModel: InteractiveCardLoadingStateModel) -> AnyView {
        let view = InteractiveCardLoadingView()
        return AnyView(view)
    }
}
