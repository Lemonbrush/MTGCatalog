//
//  MainScreenCollectionViewAdapter.swift
//  MagicCatalog
//
//  Created by Alexander Rubtsov on 24.12.2022.
//

import SwiftUI

protocol CardsGridAdapterDelegate: AnyObject {
    func didPressCardCell(_ cellId: Int)
}

class CardsGridAdapter {
    
    // MARK: - Properties
    
    weak var delegate: CardsGridAdapterDelegate?
    
    // MARK: - Functions
    
    func getCell(_ cellModel: CardsGridCellModel) -> AnyView {
        switch cellModel {
        case let cardCellModel as CardsGridSubtitledCardCellModel:
            return AnyView(createGridThreeCardCellView(cardCellModel))
        case let cardCellModel as CardsGridSimpleCardCellModel:
            return AnyView(createGridTwoCardCellView(cardCellModel))
        case let cardCellModel as CardsGridInlineCardCellModel:
            return AnyView(createGridInlineCardCellView(cardCellModel))
        default:
            return AnyView(EmptyView())
        }
    }
    
    // MARK: - Private functions
    
    private func createGridInlineCardCellView(_ model: CardsGridInlineCardCellModel) -> AnyView {
        var cardCell = CardsGridInlineCardCell(stateManager: model.stateManager,
                                               cardTitle: model.cardTitle,
                                               cardType: model.cardType,
                                               cellId: model.cellId)
        cardCell.delegate = self
        
        return AnyView(cardCell)
    }
    
    private func createGridThreeCardCellView(_ model: CardsGridSubtitledCardCellModel) -> AnyView {
        var cardCell = CardsGridSubtitledCardCell(stateManager: model.stateManager,
                                                  cardTitle: model.cardTitle,
                                                  cardType: model.cardType,
                                                  cellId: model.cellId)
        cardCell.delegate = self
        
        return AnyView(cardCell)
    }
    
    private func createGridTwoCardCellView(_ model: CardsGridSimpleCardCellModel) -> AnyView {
        var cardCell = CardsGridCardCell(stateManager: model.stateManager, cellId: model.cellId)
        cardCell.delegate = self
        
        return AnyView(cardCell)
    }
}

extension CardsGridAdapter: CardsGridCardCellDelegate {
    func didPressOnCardCell(_ cellId: Int) {
        delegate?.didPressCardCell(cellId)
    }
}
