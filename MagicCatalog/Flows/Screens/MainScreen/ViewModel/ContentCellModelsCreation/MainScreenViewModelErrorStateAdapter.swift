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
        case .genericError:
            return createGenericErrorStateModel()
        }
    }
    
    // MARK: - Private functions
    
    func createNotReachableErrorStateModel() -> [MainScreenContentCell] {
        let errorStateModel = MainScreenStubContentCellModel(systemImageName: "wifi.slash",
                                                             topText: "Lost connection",
                                                             buttonLabelText: "Try again")
        return [errorStateModel]
    }
    
    func createNotAvailableErrorStateModel() -> [MainScreenContentCell] {
        let errorStateModel = MainScreenStubContentCellModel(systemImageName: "exclamationmark.triangle",
                                                             topText: "Service unavailable",
                                                             bottomText: "Try later",
                                                             buttonLabelText: "Try again")
        return [errorStateModel]
    }
    
    func createTimeoutErrorStateModel() -> [MainScreenContentCell] {
        let errorStateModel = MainScreenStubContentCellModel(systemImageName: "arrow.clockwise",
                                                             topText: "Request timeout",
                                                             buttonLabelText: "Try again")
        return [errorStateModel]
    }
    
    func createServiceErrorStateModel(_ serviceError: ScryfallError) -> [MainScreenContentCell] {
        let errorStateModel = MainScreenStubContentCellModel(systemImageName: "rectangle.portrait.on.rectangle.portrait.slash.fill",
                                                             topText: "Service error occured",
                                                             bottomText: serviceError.description,
                                                             buttonLabelText: "Try again")
        return [errorStateModel]
    }
    
    func createGenericErrorStateModel() -> [MainScreenContentCell] {
        let errorStateModel = MainScreenStubContentCellModel(systemImageName: "rectangle.portrait.on.rectangle.portrait.slash",
                                                             topText: "Ooops!",
                                                             bottomText: "Something went wrong",
                                                             buttonLabelText: "Try again")
        return [errorStateModel]
    }
}
