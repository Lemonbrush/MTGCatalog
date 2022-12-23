import Foundation

protocol SwiftfallProtocol {
    func getCardByCode(_ cardName: String, number: Int) throws -> Card
    func getCardByArenaId(_ arenaId: Int) throws -> Card
    func getRandomCard() throws -> Card
    func getCardWithFuzzyName(_ cardName: String) throws -> Card
    func getCardByExactName(_ cardName: String) throws -> Card
    
    func getCardsList() throws -> CardList
    func getCardsList(page:Int) throws -> CardList
    func getCardSetsList() throws -> SetList
    func getRulingsList(code:String,number:Int) throws -> RulingList
    func getCardSymbols() throws -> SymbolList
    func getAllCardsFromSet(searchURI:String) -> [CardList?]
    
    func getCardSetByCode(_ code: String) throws -> ScryfallSet
    
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
        let jsonParser = SwiftFallJSONParser()
        networkService = SwiftfallNetworkService(jsonParser: jsonParser)
        
        setService = SwiftfallCardSetService(networkService)
        catalogService = SwiftfallCatalogService(networkService)
        cardService = SwiftfallCardService(networkService)
        listService = SwiftfallCardListService(networkService)
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
    
    func getCardsList() throws -> CardList {
        return try listService.getCardList()
    }
    
    func getCardsList(page: Int) throws -> CardList {
        return try listService.getCardList(page: page)
    }
    
    func getCardSetsList() throws -> SetList {
        return try listService.getSetList()
    }
    
    func getRulingsList(code: String, number: Int) throws -> RulingList {
        return try listService.getRulingList(code: code, number: number)
    }
    
    func getCardSymbols() throws -> SymbolList {
        return try listService.getSymbols()
    }
    
    func getAllCardsFromSet(searchURI: String) -> [CardList?] {
        return listService.getSetCards(searchURI: searchURI)
    }
    
    func getCardSetByCode(_ code: String) throws -> ScryfallSet {
        return try setService.getSet(code: code)
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
