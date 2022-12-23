//
//  SwiftfallNetworkService.swift
//  MagicCatalog
//
//  Created by Alexander Rubtsov on 24.12.2022.
//

import Foundation

protocol SwiftfallNetworkServiceProtocol {
    func requestData<T: Decodable>(_ params: String, type: T.Type) throws -> T
}

struct SwiftfallNetworkService: SwiftfallNetworkServiceProtocol {
    
    // MARK: - Private properties
    
    private let jsonParser: SwiftFallJSONParserProtocol
    
    // MARK: - Construction
    
    init(jsonParser: SwiftFallJSONParserProtocol) {
        self.jsonParser = jsonParser
    }
    
    // MARK: - Punctions
    
    func requestData<T: Decodable>(_ params: String, type: T.Type) throws -> T {
        var card: SwiftfalResult<T>?
        
        let semaphore = DispatchSemaphore(value: 0)
        jsonParser.parseResource(call: params) { (newcard: SwiftfalResult<T>) in
            card = newcard
            semaphore.signal()
        }
        
        semaphore.wait()
        
        return try card!.promote()
    }
}


