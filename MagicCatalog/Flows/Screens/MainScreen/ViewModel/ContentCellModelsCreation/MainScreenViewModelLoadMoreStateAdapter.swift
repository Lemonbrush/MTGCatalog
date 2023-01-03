//
//  MainScreenViewModelLoadMoreStateAdapter.swift
//  MagicCatalog
//
//  Created by Alexander Rubtsov on 03.01.2023.
//

import Foundation

class MainScreenViewModelLoadMoreStateAdapter {
    
    // MARK: - Functions
    
    func createLoadMoreErrorStateModel(_ loadMoreError: MainScreenLoadMoreError) -> MainScreenContentCell {
        switch loadMoreError {
        case .notReachable:
            return MainScreenLoadMoreErrorCellModel(errorText: "Lost connection",
                                                    systemImageName: "wifi.slash")
        case .notAvailable:
            return MainScreenLoadMoreErrorCellModel(errorText: "Ooops! Something went wrong",
                                                    systemImageName: "exclamationmark.triangle")
        }
    }
    
    func createLoadMoreLoadingStateModel() -> MainScreenContentCell {
        return MainScreenLoadMoreLoadingCellModel()
    }
}
