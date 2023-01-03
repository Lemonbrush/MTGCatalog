//
//  MainScreenGridCollectionViewAdapter.swift
//  MagicCatalog
//
//  Created by Alexander Rubtsov on 28.12.2022.
//

import SwiftUI

protocol MainScreenCollectionViewAdapterDelegate  {
    func didPressCardCell(_ cellId: Int)
    func didItemAppeared(index: Int)
    func didPressLoadMoreErrorReload()
}

class MainScreenCollectionViewAdapter {
    
    // MARK: - Properties
    
    var delegate: MainScreenCollectionViewAdapterDelegate?
    
    // MARK: - Private properties
    
    private let contentAdapter = CardsGridAdapter()
    
    // MARK: - Construction
    
    init() {
        contentAdapter.delegate = self
    }
    
    // MARK: - Functions
    
    func createContentCell(_ contentCellModel: MainScreenContentCell) -> AnyView {
        switch contentCellModel {
        case let contentGridCell as MainScreenGridContentCellModel:
            return createContentGridCell(contentGridCell)
        case let contentGridInlineCell as MainScreenGridInlineContentCellModel:
            return createContentGridInlineCell(contentGridInlineCell)
        case _ as MainScreenSearchContentCellModel:
            return createSearchContentCell()
        case let stubViewModel as MainScreenStubContentCellModel:
            return createStubView(stubViewModel)
        case let textLineViewModel as MainScreenTextContentCellModel:
            return createTextLineView(textLineViewModel)
        case let loadMoreErrorModel as MainScreenLoadMoreErrorCellModel:
            return createLoadMoreErrorView(loadMoreErrorModel)
        case _ as MainScreenLoadMoreLoadingCellModel:
            return createLoadMoreLoadingView()
        default:
            let view = EmptyView()
            return AnyView(view)
        }
    }
    
    // MARK: - Private functions
    
    private func createLoadMoreLoadingView() -> AnyView {
        let view = MainScreenActivityIndicatorContentCell()
        return AnyView(view)
    }
    
    private func createLoadMoreErrorView(_ loadMoreErrorModel: MainScreenLoadMoreErrorCellModel) -> AnyView {
        var view = MainScreenLoadMoreErrorContentCell(text: loadMoreErrorModel.errorText, systemImageName: loadMoreErrorModel.systemImageName)
        view.delegate = self
        return AnyView(view)
    }
    
    private func createTextLineView(_ textCellViewModel: MainScreenTextContentCellModel) -> AnyView {
        let view = MainScreenTextContentCell(text: textCellViewModel.text)
        return AnyView(view)
    }
    
    private func createStubView(_ stubViewModel: MainScreenStubContentCellModel) -> AnyView {
        let view = MainScreenErrorStateCell(systemImageName: stubViewModel.systemImageName,
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
        var grid = GridStack(cellModel.viewModels,
                             columns: cellModel.columns,
                             hSpacing: 5,
                             vSpacing: 5,
                             isLazyLoad:  true) { [weak self] viewModel in
            self?.contentAdapter.getCell(viewModel)
        }
        grid.delegate = self
        
        return AnyView(grid)
    }
    
    private func createContentGridInlineCell(_ cellModel: MainScreenGridInlineContentCellModel) -> AnyView {
        var grid = GridStack(cellModel.viewModels, isLazyLoad:  true) { [weak self] viewModel in
            self?.contentAdapter.getCell(viewModel)
        }
        grid.delegate = self
        
        return AnyView(grid)
    }
}

extension MainScreenCollectionViewAdapter: CardsGridAdapterDelegate {
    func didPressCardCell(_ cellId: Int) {
        delegate?.didPressCardCell(cellId)
    }
}


extension MainScreenCollectionViewAdapter: GridStackDelegate {
    func didItemAppeared(index: Int) {
        delegate?.didItemAppeared(index: index)
    }
}

extension MainScreenCollectionViewAdapter: MainScreenLoadMoreErrorContentCellDelegate {
    func didPressReload() {
        delegate?.didPressLoadMoreErrorReload()
    }
}

