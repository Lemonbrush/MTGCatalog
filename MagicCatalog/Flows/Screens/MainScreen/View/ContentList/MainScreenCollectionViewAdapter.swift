//
//  MainScreenGridCollectionViewAdapter.swift
//  MagicCatalog
//
//  Created by Alexander Rubtsov on 28.12.2022.
//

import SwiftUI

class MainScreenCollectionViewAdapter {
    
    // MARK: - Private properties
    
    private let contentAdapter = CardsGridAdapter()
    
    // MARK: - Functions
    
    func createContentCell(_ contentCellModel: MainScreenContentCell) -> AnyView {
        switch contentCellModel {
        case let contentGridCell as MainScreenGridContentCellModel:
            return createContentGridCell(contentGridCell)
        case _ as MainScreenSearchContentCellModel:
            return createSearchContentCell()
        case let stubViewModel as MainScreenStubContentCellModel:
            return createStubView(stubViewModel)
        case let textLineViewModel as MainScreenTextContentCellModel:
            return createTextLineView(textLineViewModel)
        default:
            let view = EmptyView()
            return AnyView(view)
        }
    }
    
    // MARK: - Private functions
    
    private func createTextLineView(_ textCellViewModel: MainScreenTextContentCellModel) -> AnyView {
        let view = MainScreenTextContentCell(text: textCellViewModel.text)
        return AnyView(view)
    }
    
    private func createStubView(_ stubViewModel: MainScreenStubContentCellModel) -> AnyView {
        let view = MainScreenErrorStateCell(image: stubViewModel.image,
                                            topText: stubViewModel.topText,
                                            bottomText: stubViewModel.bottomText,
                                            buttonTLabelText: stubViewModel.buttonLabelText)
        return AnyView(view)
    }
    
    private func createSearchContentCell() -> AnyView {
        let view = MainScreenSearchContentCell()
        return AnyView(view)
    }
    
    private func createContentGridCell(_ cellModel: MainScreenGridContentCellModel) -> AnyView {
        let view = GridStack(cellModel.viewModels,
                             columns: cellModel.columns,
                             hSpacing: 5,
                             vSpacing: 5) { [weak self] viewModel in
            self?.contentAdapter.getCell(viewModel)
        }
        
        return AnyView(view)
    }
}
