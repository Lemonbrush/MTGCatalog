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
    
    private let fade = AnyTransition.opacity.animation(Animation.linear(duration: 5))
    
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
        let view = CardView(image: stateModel.image, cardSize: stateModel.cardSize)
            .transition(fade)
        
        return AnyView(view)
    }
    
    private func createErrorCardView(errorStateModel: InteractiveCardErrorStateModel) -> AnyView {
        let view = InteractiveCardErrorView()
            .transition(fade)
        
        return AnyView(view)
    }
    
    private func createLoadingCardView(loadingStateModel: InteractiveCardLoadingStateModel) -> AnyView {
        let view = InteractiveCardLoadingView()
            .transition(fade)
        
        return AnyView(view)
    }
}
