//
//  MainScreenViewModelErrorStateAdapter.swift
//  MagicCatalog
//
//  Created by Alexander Rubtsov on 01.01.2023.
//

import Foundation
import UIKit

class MainScreenViewModelErrorStateAdapter {
    
    // MARK: - Functions
    
    func createMainScreenViewModelErrorStateModel(_ errorState: MainScreenStateError) -> [MainScreenContentCell] {
        switch errorState {
        case .notReachable:
            return createNotReachableErrorStateModel()
        case .notAvailable:
            return createNotAvailableErrorStateModel()
        case .timeout:
            return createTimeoutErrorStateModel()
        case .serviceError(let error):
            return createServiceErrorStateModel(error)
        }
    }
    
    // MARK: - Private functions
    
    func createNotReachableErrorStateModel() -> [MainScreenContentCell] {
        let errorStateModel = MainScreenStubContentCellModel(image: UIImage(systemName: "wifi.slash"),
                                                             topText: "Lost connection",
                                                             buttonLabelText: "Retry")
        return [errorStateModel]
    }
    
    func createNotAvailableErrorStateModel() -> [MainScreenContentCell] {
        let errorStateModel = MainScreenStubContentCellModel(image: UIImage(systemName: "exclamationmark.triangle"),
                                                             topText: "Service unavailable",
                                                             bottomText: "Try later",
                                                             buttonLabelText: "Retry")
        return [errorStateModel]
    }
    
    func createTimeoutErrorStateModel() -> [MainScreenContentCell] {
        let errorStateModel = MainScreenStubContentCellModel(image: UIImage(systemName: "arrow.clockwise"),
                                                             topText: "Request timeout",
                                                             buttonLabelText: "Retry")
        return [errorStateModel]
    }
    
    func createServiceErrorStateModel(_ serviceError: ScryfallError) -> [MainScreenContentCell] {
        let errorStateModel = MainScreenStubContentCellModel(image: UIImage(systemName: "rectangle.portrait.on.rectangle.portrait.slash.fill"),
                                                             topText: "Service error occured",
                                                             bottomText: serviceError.description)
        return [errorStateModel]
    }
}
