//
//  CardSizeConfigurator.swift
//  MagicCatalog
//
//  Created by Alexander Rubtsov on 25.12.2022.
//

import Foundation

enum CardSizeConfiguration {
    case large, medium, small
    
    var cardSize: CardViewSize {
        switch self {
        case .large:
            return createLargeCardViewSizeModel()
        case .medium:
            return createMediumCardViewSizeModel()
        case .small:
            return createSmallCardViewSizeModel()
        }
    }
    
    // MARK: - Private functions
    
    private func createLargeCardViewSizeModel() -> CardViewSize {
        return CardViewSize(width: 350, height: 490, cornerRadius: 20)
    }
    
    private func createMediumCardViewSizeModel() -> CardViewSize {
        return CardViewSize(width: 80, height: 110, cornerRadius: 5)
    }
    
    private func createSmallCardViewSizeModel() -> CardViewSize {
        return CardViewSize(width: 50, height: 190, cornerRadius: 10)
    }
}
