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
    case genericError
}

enum MainScreenLoadMoreError: Error {
    case notReachable
    case notAvailable
}

enum MainScreenState {
    case emptySearch
    case loaded
    case loading
    case loadingMore
    case loadingMoreError(MainScreenLoadMoreError)
    case error(MainScreenStateError)
}
