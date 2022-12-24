//
//  MainScreenCollectionViewAdapter.swift
//  MagicCatalog
//
//  Created by Alexander Rubtsov on 24.12.2022.
//

import SwiftUI

protocol MainScreenCollectionViewAdapterDelegate: AnyObject {
    func didPressErrorCellButton()
}

class MainScreenCollectionViewAdapter {
    
    // MARK: - Properties
    
    weak var delegate: MainScreenCollectionViewAdapterDelegate?
    
    // MARK: - Functions
    
    func getCell(_ cellModel: MainScreenCellModel) -> AnyView {
        let cellViewModel = cellModel.model
        
        switch cellViewModel {
        case let errorCellModel as MainScreenErrorCellModel:
            return AnyView(createErrorStateCellView(errorCellModel))
        case let cardCellModel as MainScreenCardCellModel:
            return AnyView(createCardCellView(cardCellModel))
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
    
    private func createCardCellView(_ model: MainScreenCardCellModel) -> AnyView {
        let cardCell = MainScreenCardCell(cardTitle: model.cardTitle)
        return AnyView(cardCell)
    }
}

extension MainScreenCollectionViewAdapter: MainScreenErrorStateCellDelegate {
    func didPressButton() {
        delegate?.didPressErrorCellButton()
    }
}
