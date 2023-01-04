//
//  MainScreenCellModel.swift
//  MagicCatalog
//
//  Created by Alexander Rubtsov on 24.12.2022.
//

import UIKit

protocol CardsGridCellModel { }

struct CardsGridSubtitledCardCellModel: CardsGridCellModel {
    let cellId: Int
    
    let stateManager: CardViewStateManager
    
    let cardTitle: String
    let cardType: String
}

struct CardsGridInlineCardCellModel: CardsGridCellModel {
    let cellId: Int
    
    let stateManager: CardViewStateManager
    
    let cardTitle: String
    let cardType: String
}

struct CardsGridSimpleCardCellModel: CardsGridCellModel {
    let cellId: Int
    let stateManager: CardViewStateManager
}
