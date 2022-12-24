import Foundation

protocol SwiftfallProtocol {
    func getCardByCode(_ code: String, number: Int, completion: @escaping (SwiftfalResult<Card>) -> Void)
    func getCardByArenaId(_ arenaId: Int, completion: @escaping (SwiftfalResult<Card>) -> Void)
    func getRandomCard(completion: @escaping (SwiftfalResult<Card>) -> Void)
    func getCardWithFuzzyName(_ cardName: String, completion: @escaping (SwiftfalResult<Card>) -> Void)
    func getCardByExactName(_ cardName: String, completion: @escaping (SwiftfalResult<Card>) -> Void)
    
    func getCardsList(completion: @escaping (SwiftfalResult<CardList>) -> ())
    func getCardsList(page: Int, completion: @escaping (SwiftfalResult<CardList>) -> ())
    func getCardSetsList(completion: @escaping (SwiftfalResult<SetList>) -> ())
    func getRulingsList(code:String, number:Int, completion: @escaping (SwiftfalResult<RulingList>) -> ())
    func getCardSymbols(completion: @escaping (SwiftfalResult<SymbolList>) -> ())
    
    func getCardSetByCode(code: String, completion: @escaping (SwiftfalResult<ScryfallSet>) -> ())
    
    func getCatalogCardNames() throws -> Catalog
    func getCatalogWordBank() throws -> Catalog
    func getCatalogCreatureTypes() throws -> Catalog
    func getCatalogPlaneswalkerTypes() throws -> Catalog
    func getCatalogLandTypes() throws -> Catalog
    func getCatalogSpellTypes() throws -> Catalog
    func getCatalogArtifactTypes() throws -> Catalog
    func getCatalogPowers() throws -> Catalog
    func getCatalogToughnesses() throws -> Catalog
    func getCatalogLoyalties() throws -> Catalog
    func getCatalogWatermarks() throws -> Catalog
    
    func getAutocomplete(_ cardNamePart: String) throws -> Catalog
}

class Swiftfall: SwiftfallProtocol {
    
    // MARK: - Private properties
    
    private let networkService: SwiftfallNetworkServiceProtocol
    
    private let setService: SwiftfallCardSetService
    private let catalogService: SwiftfallCatalogService
    private let cardService: SwiftfallCardService
    private let listService: SwiftfallCardListService
    
    // MARK: - Construction
    
    init() {
        let jsonParser = NetworkService()
        networkService = SwiftfallNetworkService(coreNetworkService: jsonParser)
        
        setService = SwiftfallCardSetService(NetworkService())
        catalogService = SwiftfallCatalogService(networkService)
        cardService = SwiftfallCardService(NetworkService())
        listService = SwiftfallCardListService(NetworkService())
    }
    
    // MARK: - Functions
    
    func getCardByCode(_ code: String, number: Int, completion: @escaping (SwiftfalResult<Card>) -> Void) {
        cardService.getCard(code: code, number: number, completion: completion)
    }
    
    func getCardByArenaId(_ arenaId: Int, completion: @escaping (SwiftfalResult<Card>) -> Void) {
        cardService.getCard(arena: arenaId, completion: completion)
    }
    
    func getRandomCard(completion: @escaping (SwiftfalResult<Card>) -> Void) {
        cardService.getRandomCard(completion: completion)
    }
    
    func getCardWithFuzzyName(_ cardName: String, completion: @escaping (SwiftfalResult<Card>) -> Void) {
        cardService.getCard(fuzzy: cardName, completion: completion)
    }
    
    func getCardByExactName(_ cardName: String, completion: @escaping (SwiftfalResult<Card>) -> Void) {
        cardService.getCard(exact: cardName, completion: completion)
    }
    
    func getCardsList(completion: @escaping (SwiftfalResult<CardList>) -> ()) {
        listService.getCardList(completion: completion)
    }
    
    func getCardsList(page: Int, completion: @escaping (SwiftfalResult<CardList>) -> ()) {
        listService.getCardList(page: page, completion: completion)
    }
    
    func getCardSetsList(completion: @escaping (SwiftfalResult<SetList>) -> ()) {
        listService.getSetList(completion: completion)
    }
    
    func getRulingsList(code: String, number: Int, completion: @escaping (SwiftfalResult<RulingList>) -> ()) {
        listService.getRulingList(code: code, number: number, completion: completion)
    }
    
    func getCardSymbols(completion: @escaping (SwiftfalResult<SymbolList>) -> ()) {
        listService.getSymbols(completion: completion)
    }
    
    func getCardSetByCode(code: String, completion: @escaping (SwiftfalResult<ScryfallSet>) -> ()) {
        setService.getSet(code: code, completion: completion)
    }
    
    func getCatalogCardNames() throws -> Catalog {
        return try catalogService.cardNames()
    }
    
    func getCatalogWordBank() throws -> Catalog {
        return try catalogService.wordBank()
    }
    
    func getCatalogCreatureTypes() throws -> Catalog {
        return try catalogService.creatureTypes()
    }
    
    func getCatalogPlaneswalkerTypes() throws -> Catalog {
        return try catalogService.planeswalkerTypes()
    }
    
    func getCatalogLandTypes() throws -> Catalog {
        return try catalogService.landTypes()
    }
    
    func getCatalogSpellTypes() throws -> Catalog {
        return try catalogService.spellTypes()
    }
    
    func getCatalogArtifactTypes() throws -> Catalog {
        return try catalogService.artifactTypes()
    }
    
    func getCatalogPowers() throws -> Catalog {
        return try catalogService.powers()
    }
    
    func getCatalogToughnesses() throws -> Catalog {
        return try catalogService.toughnesses()
    }
    
    func getCatalogLoyalties() throws -> Catalog {
        return try catalogService.loyalties()
    }
    
    func getCatalogWatermarks() throws -> Catalog {
        return try catalogService.watermarks()
    }
    
    func getAutocomplete(_ cardNamePart: String) throws -> Catalog {
        return try catalogService.autocomplete(cardNamePart)
    }
}
