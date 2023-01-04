//
//  CardViewLoadedStateAdapter.swift
//  MagicCatalog
//
//  Created by Alexander Rubtsov on 04.01.2023.
//

import SwiftUI

struct CardViewLoadedStateAdapter {
    
    // MARK: - Body view
    
    func createCardViewCell(frontCardImage: UIImage, backCardImage: UIImage?, cardViewType: CardViewType) ->AnyView {
        switch cardViewType {
        case .normal:
            return createRegularCardView(frontCardImage: frontCardImage, backCardImage: backCardImage)
        case .transformCard:
            return createTransformCardView(frontCardImage: frontCardImage, backCardImage: backCardImage)
        default:
            return createRegularCardView(frontCardImage: frontCardImage, backCardImage: backCardImage)
        }
    }
    
    // MARK: - Private functions
    
    private func createTransformCardView(frontCardImage: UIImage, backCardImage: UIImage?) -> AnyView {
        let view = InteractiveCardView(frontCardImage: frontCardImage, backCardImage: backCardImage)
        return AnyView(view)
    }
    
    private func createRegularCardView(frontCardImage: UIImage, backCardImage: UIImage?) -> AnyView {
        let view = CardView(frontCardImage: frontCardImage, backCardImage: backCardImage)
        return AnyView(view)
    }
}
