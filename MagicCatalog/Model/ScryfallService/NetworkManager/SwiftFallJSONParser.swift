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
        let url = URL(string: call)
        //print(url)
        let task = URLSession.shared.dataTask(with: url!) {(data, response, error) in
            
            guard let content = data else {
                print("Error: There was no data returned from JSON file.")
                return
            }
            
            let decoder = JSONDecoder()
            decoder.keyDecodingStrategy = .convertFromSnakeCase
            let httpStatus = (response as! HTTPURLResponse).statusCode
            do {
                if (200..<300).contains(httpStatus) {
                    // Decode JSON file starting from Response struct.
                    let decoded: ResultType = try decoder.decode(ResultType.self, from: content)
                    completion(.success(decoded))
                } else {
                    let decoded: ScryfallError = try decoder.decode(ScryfallError.self, from: content)
                    completion(.failure(decoded))
                }
            } catch {
                completion(.failure(error))
            }
        }
        task.resume()
    }
}
