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
    
    func getCatalogCardNames(completion: @escaping (SwiftfalResult<Catalog>) -> ())
    func getCatalogWordBank(completion: @escaping (SwiftfalResult<Catalog>) -> ())
    func getCatalogCreatureTypes(completion: @escaping (SwiftfalResult<Catalog>) -> ())
    func getCatalogPlaneswalkerTypes(completion: @escaping (SwiftfalResult<Catalog>) -> ())
    func getCatalogLandTypes(completion: @escaping (SwiftfalResult<Catalog>) -> ())
    func getCatalogSpellTypes(completion: @escaping (SwiftfalResult<Catalog>) -> ())
    func getCatalogArtifactTypes(completion: @escaping (SwiftfalResult<Catalog>) -> ())
    func getCatalogPowers(completion: @escaping (SwiftfalResult<Catalog>) -> ())
    func getCatalogToughnesses(completion: @escaping (SwiftfalResult<Catalog>) -> ())
    func getCatalogLoyalties(completion: @escaping (SwiftfalResult<Catalog>) -> ())
    func getCatalogWatermarks(completion: @escaping (SwiftfalResult<Catalog>) -> ())
    
    func getAutocomplete(_ cardNamePart: String, completion: @escaping (SwiftfalResult<Catalog>) -> ())
}

class Swiftfall: SwiftfallProtocol {
    
    // MARK: - Private properties
    
    private let setService: SwiftfallCardSetService
    private let catalogService: SwiftfallCatalogService
    private let cardService: SwiftfallCardService
    private let listService: SwiftfallCardListService
    
    // MARK: - Construction
    
    init(networkService: SwiftFallCoreNetworkServiceProtocol) {
        setService = SwiftfallCardSetService(networkService)
        catalogService = SwiftfallCatalogService(networkService)
        cardService = SwiftfallCardService(networkService)
        listService = SwiftfallCardListService(networkService)
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
    
    func getCatalogCardNames(completion: @escaping (SwiftfalResult<Catalog>) -> ()) {
        catalogService.cardNames(completion: completion)
    }
    
    func getCatalogWordBank(completion: @escaping (SwiftfalResult<Catalog>) -> ()) {
        catalogService.wordBank(completion: completion)
    }
    
    func getCatalogCreatureTypes(completion: @escaping (SwiftfalResult<Catalog>) -> ()) {
        catalogService.creatureTypes(completion: completion)
    }
    
    func getCatalogPlaneswalkerTypes(completion: @escaping (SwiftfalResult<Catalog>) -> ()) {
        catalogService.planeswalkerTypes(completion: completion)
    }
    
    func getCatalogLandTypes(completion: @escaping (SwiftfalResult<Catalog>) -> ()) {
        catalogService.landTypes(completion: completion)
    }
    
    func getCatalogSpellTypes(completion: @escaping (SwiftfalResult<Catalog>) -> ()) {
        catalogService.spellTypes(completion: completion)
    }
    
    func getCatalogArtifactTypes(completion: @escaping (SwiftfalResult<Catalog>) -> ()) {
        catalogService.artifactTypes(completion: completion)
    }
    
    func getCatalogPowers(completion: @escaping (SwiftfalResult<Catalog>) -> ()) {
        catalogService.powers(completion: completion)
    }
    
    func getCatalogToughnesses(completion: @escaping (SwiftfalResult<Catalog>) -> ()) {
        catalogService.toughnesses(completion: completion)
    }
    
    func getCatalogLoyalties(completion: @escaping (SwiftfalResult<Catalog>) -> ()) {
        catalogService.loyalties(completion: completion)
    }
    
    func getCatalogWatermarks(completion: @escaping (SwiftfalResult<Catalog>) -> ()) {
        catalogService.watermarks(completion: completion)
    }
    
    func getAutocomplete(_ cardNamePart: String, completion: @escaping (SwiftfalResult<Catalog>) -> ()) {
        catalogService.autocomplete(cardNamePart, completion: completion)
    }
}
