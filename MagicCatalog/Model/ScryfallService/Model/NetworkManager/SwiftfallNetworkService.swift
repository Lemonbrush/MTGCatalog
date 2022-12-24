//
//  SwiftfallNetworkService.swift
//  MagicCatalog
//
//  Created by Alexander Rubtsov on 24.12.2022.
//

import Foundation

protocol SwiftFallCoreNetworkServiceProtocol {
    func request<ResultType: Decodable>(call: String, timeout: TimeInterval, completion: @escaping (SwiftfalResult<ResultType>) -> ())
}

protocol SwiftfallNetworkServiceProtocol {
    func requestData<T: Decodable>(_ params: String, type: T.Type) throws -> T
}

struct SwiftfallNetworkService: SwiftfallNetworkServiceProtocol {
    
    // MARK: - Private properties
    
    private let coreNetworkService: SwiftFallCoreNetworkServiceProtocol
    
    // MARK: - Construction
    
    init(coreNetworkService: SwiftFallCoreNetworkServiceProtocol) {
        self.coreNetworkService = coreNetworkService
    }
    
    // MARK: - Punctions
    
    func requestData<T: Decodable>(_ params: String, type: T.Type) throws -> T {
        var card: SwiftfalResult<T>?
        
        let semaphore = DispatchSemaphore(value: 0)
        coreNetworkService.request(call: params, timeout: 15) { (newcard: SwiftfalResult<T>) in
            card = newcard
            semaphore.signal()
        }
        
        semaphore.wait()
        
        return try card!.promote()
    }
}


