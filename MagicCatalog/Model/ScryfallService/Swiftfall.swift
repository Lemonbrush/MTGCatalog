import Foundation

protocol SwiftfallProtocol {
    func getCardByCode(_ cardName: String, number: Int) throws -> Card
    func getCardByArenaId(_ arenaId: Int) throws -> Card
    func getRandomCard() throws -> Card
    func getCardWithFuzzyName(_ cardName: String) throws -> Card
    func getCardByExactName(_ cardName: String) throws -> Card
    
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
        cardService = SwiftfallCardService(networkService)
        listService = SwiftfallCardListService(NetworkService())
    }
    
    // MARK: - Functions
    
    func getCardByCode(_ cardName: String, number: Int) throws -> Card {
        return try cardService.getCard(code: cardName, number: number)
    }
    
    func getCardByArenaId(_ arenaId: Int) throws -> Card {
        return try cardService.getCard(arena: arenaId)
    }
    
    func getRandomCard() throws -> Card {
        return try cardService.getRandomCard()
    }
    
    func getCardWithFuzzyName(_ cardName: String) throws -> Card {
        return try cardService.getCard(fuzzy: cardName)
    }
    
    func getCardByExactName(_ cardName: String) throws -> Card {
        return try cardService.getCard(exact: cardName)
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
