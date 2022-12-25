//
//  InteractiveCardStateViewAdapter.swift
//  MagicCatalog
//
//  Created by Alexander Rubtsov on 25.12.2022.
//

import SwiftUI

class InteractiveCardStateViewAdapter {
    
    // MARK: - Functions
    
    func createInteractiveCardStateView(_ stateModel: InteractiveCardStateProtocol) -> AnyView {
        switch stateModel {
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
        return AnyView(CardView(image: stateModel.image, cardSize: stateModel.cardSize))
    }
    
    private func createErrorCardView(errorStateModel: InteractiveCardErrorStateModel) -> AnyView {
        return AnyView(InteractiveCardErrorView())
    }
    
    private func createLoadingCardView(loadingStateModel: InteractiveCardLoadingStateModel) -> AnyView {
        return AnyView(InteractiveCardLoadingView())
    }
}
