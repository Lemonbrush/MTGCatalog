import Foundation

class Swiftfall {
    
    // MARK: - Private properties
    
    private let jsonParser: SwiftFallJSONParserProtocol
    private lazy var networkService = SwiftfallNetworkService(jsonParser: jsonParser)
    
    private let urlBase = SwiftFallConstants.scryfall + "cards"
    
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
