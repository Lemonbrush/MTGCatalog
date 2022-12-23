//
//  SwiftFallResult.swift
//  MagicCatalog
//
//  Created by Alexander Rubtsov on 23.12.2022.
//

import Foundation

// Result enum to control possible end states
enum SwiftfalResult<Value> {
    case success(Value)
    case failure(Error)
    
    // MARK: - Functions
    
    func promote() throws -> Value {
        switch self {
        case .success(let value):
            return value
        case .failure(let error):
            throw error
        }
    }
}
