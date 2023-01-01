//
//  MainScreenState.swift
//  MagicCatalog
//
//  Created by Alexander Rubtsov on 26.12.2022.
//

import Foundation

enum MainScreenStateError: Error {
    case notReachable
    case notAvailable
    case timeout
    case serviceError(error: ScryfallError)
}

enum MainScreenState {
    case emptySearch
    case loaded
    case loding
    case error(MainScreenStateError)
}
