//
//  SwiftFallJSONParser.swift
//  MagicCatalog
//
//  Created by Alexander Rubtsov on 23.12.2022.
//

import Foundation

protocol SwiftFallJSONParserProtocol {
    func parseResource<ResultType: Decodable>(call: String, completion: @escaping (SwiftfalResult<ResultType>) -> ())
}

struct SwiftFallJSONParser: SwiftFallJSONParserProtocol {
    func parseResource<ResultType: Decodable>(call: String, completion: @escaping (SwiftfalResult<ResultType>) -> ()) {
        guard let url = URL(string: call) else {
            return
        }
        
        let request = URLRequest(url: url)
        let config = URLSessionConfiguration.default
        config.timeoutIntervalForResource = 15

        URLSession(configuration: config).dataTask(with: request) { data, response, error in
            guard let receivedData = data else {
                print("Error: There was no data returned from JSON file.")
                return
            }
            
            do {
                if let strongResponse = response as? HTTPURLResponse, isStatusCodeValid(strongResponse) {
                    let decoded = try decode(ResultType.self, data: receivedData)
                    completion(.success(decoded))
                } else {
                    let decoded = try decode(ScryfallError.self, data: receivedData)
                    completion(.failure(decoded))
                }
            } catch {
                completion(.failure(error))
            }
        }.resume()
    }
    
    // MARK: - Private func
    
    private func isStatusCodeValid(_ response: HTTPURLResponse) -> Bool {
        return (200..<300).contains(response.statusCode)
    }
    
    private func decode<T: Decodable>(_ dataType: T.Type, data: Data) throws -> T {
        let decoder = JSONDecoder()
        decoder.keyDecodingStrategy = .convertFromSnakeCase
        
        return try decoder.decode(T.self, from: data)
    }
}
