//
//  SwiftFallCoreNetworkServiceProtocol.swift
//  MagicCatalog
//
//  Created by Alexander Rubtsov on 23.12.2022.
//

import Foundation

extension NetworkService: SwiftFallCoreNetworkServiceProtocol {
    
    // MARK: - Functions
    
    func request<ResultType>(call: String, timeout: TimeInterval,
                             completion: @escaping (SwiftfalResult<ResultType>) -> ()) where ResultType: Decodable {
        get(nil, call, timeout: timeout) { [weak self] result in
            guard let self = self else {
                return
            }
            
            if case .failure(let error) = result {
                completion(.failure(.networkError(error: error)))
            }
            
            if case .success(let data) = result {
                guard let decoded = try? self.decode(ResultType.self, data: data) else {
                    do {
                        let decodedScryFallError = try self.decode(ScryfallError.self, data: data)
                        completion(.failure(.scryfallError(error: decodedScryFallError)))
                    } catch {
                        print(error.localizedDescription)
                        completion(.failure(.unknownError(error: error)))
                    }
                    return
                }
                
                completion(.success(decoded))
            }
        }
    }
    
    // MARK: - Private functions
    
    private func decode<T: Decodable>(_ dataType: T.Type, data: Data) throws -> T {
        let decoder = JSONDecoder()
        decoder.keyDecodingStrategy = .convertFromSnakeCase
        
        return try decoder.decode(T.self, from: data)
    }
}
