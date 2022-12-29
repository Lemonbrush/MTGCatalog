//
//  MainScreenCellModel.swift
//  MagicCatalog
//
//  Created by Alexander Rubtsov on 24.12.2022.
//

import UIKit

protocol CardsGridCellModel { }

struct MainScreenCellModelContainer: Identifiable, MainScreenContentCell {
    var id: Int
    let model: CardsGridCellModel
}

struct CardsGridStubCellModel: MainScreenContentCell, CardsGridCellModel {
    let image: UIImage?
    let topText: String
    let bottomText: String
    let buttonLabelText: String
}

struct CardsGridSubtitledCardCellModel: CardsGridCellModel {
    let cellId: Int
    
    let stateManager: InteractiveCardStateManager
    
    let cardTitle: String
    let cardType: String
}

struct CardsGridSimpleCardCellModel: CardsGridCellModel {
    let cellId: Int
    let stateManager: InteractiveCardStateManager
}
