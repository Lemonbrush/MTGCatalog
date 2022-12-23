//
//  CardSetService.swift
//  MagicCatalog
//
//  Created by Alexander Rubtsov on 24.12.2022.
//

import Foundation

class CardSetService {
    
    // MARK: - Private properties
    
    private let jsonParser: SwiftFallJSONParserProtocol
    private lazy var networkService = SwiftfallNetworkService(jsonParser: jsonParser)
    
    // MARK: - Construction
    
    init(jsonParser: SwiftFallJSONParserProtocol) {
        self.jsonParser = jsonParser
    }
    
    // MARK: - Functions
    
    // set
    func getSet(code: String) throws -> ScryfallSet {
        let encodeExactly = code.addingPercentEncoding(withAllowedCharacters: .urlHostAllowed)!
        let call = "\(SwiftFallConstants.scryfall)sets/\(encodeExactly)"
        return try networkService.requestData(call, type: ScryfallSet.self)
    }
}
