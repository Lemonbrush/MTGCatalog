//
//  NetworkServiceError.swift
//  MagicCatalog
//
//  Created by Alexander Rubtsov on 24.12.2022.
//

import Foundation

enum NetworkServiceError: Error {
    case unknown(_ error: Error?)
    case notConnectedToInternet
    case failedToRecognizeData
    case timeOut
    case filedWithStatusCode(_ code: Int)
    case noResponse
}
