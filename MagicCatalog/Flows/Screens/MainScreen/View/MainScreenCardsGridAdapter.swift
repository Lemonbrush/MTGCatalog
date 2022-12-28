//
//  MainScreenCollectionViewAdapter.swift
//  MagicCatalog
//
//  Created by Alexander Rubtsov on 24.12.2022.
//

import SwiftUI

protocol MainScreenCardsGridAdapterDelegate: AnyObject {
    func didPressErrorCellButton()
    func didPressCardCell(_ cellId: Int)
}

class MainScreenCardsGridAdapter {
    
    // MARK: - Properties
    
    weak var delegate: MainScreenCardsGridAdapterDelegate?
    
    // MARK: - Functions
    
    func getCell(_ cellModel: MainScreenCellModel) -> AnyView {
        let cellViewModel = cellModel.model
        
        switch cellViewModel {
        case let errorCellModel as MainScreenErrorCellModel:
            return AnyView(createErrorStateCellView(errorCellModel))
        case let cardCellModel as MainScreenThreeGridCardCellModel:
            return AnyView(createGridThreeCardCellView(cardCellModel))
        case let cardCellModel as MainScreenTwoGridCardCellModel:
            return AnyView(createGridTwoCardCellView(cardCellModel))
        default:
            return AnyView(EmptyView())
        }
    }
    
    // MARK: - Private functions
    
    private func createErrorStateCellView(_ model: MainScreenErrorCellModel) -> AnyView {
        var errorStateCell = MainScreenErrorStateCell(image: model.image,
                                                      topText: model.topText,
                                                      bottomText: model.bottomText,
                                                      buttonTLabelText: model.buttonLabelText)
        errorStateCell.delegate = self
        return AnyView(errorStateCell)
    }
    
    private func createGridThreeCardCellView(_ model: MainScreenThreeGridCardCellModel) -> AnyView {
        var cardCell = MainScreenSubtitledCardCell(stateManager: model.stateManager,
                                          cardTitle: model.cardTitle,
                                          cardType: model.cardType,
                                          cellId: model.cellId)
        cardCell.delegate = self
        
        return AnyView(cardCell)
    }
    
    private func createGridTwoCardCellView(_ model: MainScreenTwoGridCardCellModel) -> AnyView {
        var cardCell = MainScreenCardCell(stateManager: model.stateManager,
                                                 cellId: model.cellId)
        cardCell.delegate = self
        
        return AnyView(cardCell)
    }
}

extension MainScreenCardsGridAdapter: MainScreenCardCellDelegate {
    func didPressOnCardCell(_ cellId: Int) {
        delegate?.didPressCardCell(cellId)
    }
}

extension MainScreenCardsGridAdapter: MainScreenErrorStateCellDelegate {
    func didPressButton() {
        delegate?.didPressErrorCellButton()
    }
}
