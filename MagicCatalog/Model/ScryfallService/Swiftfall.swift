import Foundation

// Sometimes we will cause and error and the API will tell us what it is.
struct ScryfallError: Codable, Error, CustomStringConvertible {
    
    let code: String
    let type: String
    let status: Int
    let details: String
    
    public var description: String {
        return "Error: \(code)\nDetails: \(details)\n"
    }
}

class Swiftfall {
    
    // Result enum to control possible end states
    enum Result<Value> {
        case success(Value)
        case failure(Error)
        func promote() throws -> Value {
            switch self {
            case .success(let value):
                return value
            case .failure(let error):
                throw error
            }
        }
    }
    
    let scryfall = "https://api.scryfall.com/"
    
    /// Retreives JSON data from URL and parses it with JSON decoder.
    private func parseResource<ResultType: Decodable>(call: String, completion: @escaping (Result<ResultType>) -> ()) {
        
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
                    let decoded:ResultType = try decoder.decode(ResultType.self, from: content)
                    completion(.success(decoded))
                } else {
                    let decoded:ScryfallError = try decoder.decode(ScryfallError.self, from: content)
                    completion(.failure(decoded))
                }
            } catch {
                completion(.failure(error))
            }
        }
        task.resume()
    }
    
    // gets a Card by using the code and id number
    func getCard(code: String, number: Int) throws -> Card {
        let call = "\(scryfall)cards/\(code)/\(number)"
        var card: Result<Card>?
        
        let semaphore = DispatchSemaphore(value: 0)
        parseResource(call: call){
            (newcard: Result<Card>) in
            card = newcard
            semaphore.signal()
        }
        
        semaphore.wait()
        
        return try card!.promote()
    }
    
    // gets a Card by using the arena code
    func getCard(arena: Int) throws -> Card {
        let call = "\(scryfall)cards/arena/\(arena)"
        var card: Result<Card>?
        
        let semaphore = DispatchSemaphore(value: 0)
        parseResource(call: call){
            (newcard: Result<Card>) in
            card = newcard
            semaphore.signal()
        }
        
        semaphore.wait()
        
        return try card!.promote()
    }
    
    // fuzzy
    func getCard(fuzzy: String) throws -> Card {
        let encodeFuzz = fuzzy.addingPercentEncoding(withAllowedCharacters: .urlHostAllowed)!
        let call = "\(scryfall)cards/named?fuzzy=\(encodeFuzz)"
        
        
        var card: Result<Card>?
        let semaphore = DispatchSemaphore(value: 0)
        parseResource(call: call) {
            (newcard:Result<Card>) in
            card = newcard
            semaphore.signal()
        }
        
        semaphore.wait()
        
        return try card!.promote()
    }
    
    
    // exact
    func getCard(exact: String) throws -> Card {
        let encodeExactly = exact.addingPercentEncoding(withAllowedCharacters: .urlHostAllowed)!
        let call = "\(scryfall)cards/named?exact=\(encodeExactly)"
        
        var card: Result<Card>?
        
        let semaphore = DispatchSemaphore(value: 0)
        parseResource(call: call) {
            (newcard: Result<Card>) in
            card = newcard
            semaphore.signal()
        }
        
        semaphore.wait()
        
        return try card!.promote()
    }
    
    // fuzzy
    func getRandomCard() throws -> Card {
        let call = "\(scryfall)cards/random"
        
        var card: Result<Card>?
        
        let semaphore = DispatchSemaphore(value: 0)
        parseResource(call: call) {
            (newcard: Result<Card>) in
            card = newcard
            semaphore.signal()
        }
        
        semaphore.wait()
        
        return try card!.promote()
    }
    
    // get a catalog
    func getCatalog(catalog: String) throws -> Catalog {
        let encodeCatalog = catalog.addingPercentEncoding(withAllowedCharacters: .urlHostAllowed)!
        let call = "\(scryfall)catalog/\(encodeCatalog)"
        var cat: Result<Catalog>?
        
        let semaphore = DispatchSemaphore(value: 0)
        parseResource(call: call) {
            (newcat: Result<Catalog>) in
            cat = newcat
            semaphore.signal()
            
        }
        semaphore.wait()
        
        return try cat!.promote()
    }
    
    // set
    func getSet(code: String) throws -> ScryfallSet {
        let encodeExactly = code.addingPercentEncoding(withAllowedCharacters: .urlHostAllowed)!
        let call = "\(scryfall)sets/\(encodeExactly)"
        
        var set: Result<ScryfallSet>?
        
        let semaphore = DispatchSemaphore(value: 0)
        parseResource(call: call) {
            (newset: Result<ScryfallSet>) in
            set = newset
            semaphore.signal()
        }
        
        semaphore.wait()
        
        return try set!.promote()
    }
    
    
    func getSetList() throws -> SetList {
        let call = "\(scryfall)sets/"
        
        var setlist: Result<SetList>?
        
        let semaphore = DispatchSemaphore(value: 0)
        parseResource(call: call) {
            (newsetlist: Result<SetList>) in
            setlist = newsetlist
            semaphore.signal()
        }
        
        semaphore.wait()
        
        return try setlist!.promote()
    }
    
    
    func getCardList() throws -> CardList {
        let call = "\(scryfall)cards/"
        
        var cardlist: Result<CardList>?
        
        let semaphore = DispatchSemaphore(value: 0)
        parseResource(call: call) {
            (newcardlist: Result<CardList>) in
            cardlist = newcardlist
            semaphore.signal()
        }
        
        semaphore.wait()
        
        return try cardlist!.promote()
    }
    
    func getCardList(page:Int) throws -> CardList {
        let call = "\(scryfall)cards?page=\(page)"
        
        var cardlist: Result<CardList>?
        
        let semaphore = DispatchSemaphore(value: 0)
        parseResource(call: call) {
            (newcardlist: Result<CardList>) in
            cardlist = newcardlist
            semaphore.signal()
        }
        
        semaphore.wait()
        
        return try cardlist!.promote()
    }
    
    
    func getRulingList(code:String,number:Int) throws -> RulingList {
        let call = "\(scryfall)cards/\(code)/\(number)/rulings"
        
        var rulelist: Result<RulingList>?
        
        let semaphore = DispatchSemaphore(value: 0)
        parseResource(call: call) {
            (newrulelist: Result<RulingList>) in
            rulelist = newrulelist
            semaphore.signal()
        }
        
        semaphore.wait()
        
        return try rulelist!.promote()
        
    }
    
    func getSymbols() throws -> SymbolList {
        let call = "\(scryfall)symbology"
        
        var symbollist: Result<SymbolList>?
        let semaphore = DispatchSemaphore(value: 0)
        parseResource(call: call) {
            (newsym: Result<SymbolList>) in
            symbollist = newsym
            semaphore.signal()
        }
        
        semaphore.wait()
        
        return try symbollist!.promote()
    }
    
    func getSetCards(searchURI:String) -> [CardList?] {
        let call = searchURI
        
        var cardlist: Result<CardList>?
        
        let semaphore = DispatchSemaphore(value: 0)
        parseResource(call: call) {
            (newcardlist: Result<CardList>) in
            cardlist = newcardlist
            semaphore.signal()
        }
        
        semaphore.wait()
        var cardListArray: [CardList?] = []
        do {
            if try cardlist!.promote().hasMore {
                cardListArray += (self.getSetCards(searchURI: try cardlist!.promote().nextPage!))
            }
            let newlist = try cardlist!.promote()
            cardListArray.append(newlist)
            return cardListArray
        } catch {
            return []
        }
    }
    
    // give a search term and return a catalog of similar cards
    func autocomplete(_ string: String) throws -> Catalog {
        let call = "\(scryfall)cards/autocomplete?q=\(string)"
        
        var cat: Result<Catalog>?
        
        let semaphore = DispatchSemaphore(value: 0)
        parseResource(call: call) {
            (newcat: Result<Catalog>) in
            cat = newcat
            semaphore.signal()
        }
        
        semaphore.wait()
        
        return try cat!.promote()
    }
    
    // prints a list of all catalogs for the user
    func catalogs() {
        print("There are 11 catalogs.\n* card-names\n* word-bank\n* creature-types\n* planeswalker-types\n* land-types\n* spell-types\n* artifact-types\n* powers\n* toughnesses\n* loyalties\n* watermarks")
    }
    
    func cardNames() throws -> Catalog {
        return try Swiftfall().getCatalog(catalog: "card-names")
    }
    
    func wordBank() throws -> Catalog {
        return try Swiftfall().getCatalog(catalog: "word-bank")
    }
    
    func creatureTypes() throws -> Catalog {
        return try Swiftfall().getCatalog(catalog: "creature-types")
    }
    
    func planeswalkerTypes() throws -> Catalog {
        return try Swiftfall().getCatalog(catalog: "planeswalker-types")
    }
    
    func landTypes() throws -> Catalog {
        return try Swiftfall().getCatalog(catalog: "land-types")
    }
    
    func spellTypes() throws -> Catalog {
        return try Swiftfall().getCatalog(catalog: "spell-types")
    }
    
    func artifactTypes() throws -> Catalog {
        return try Swiftfall().getCatalog(catalog: "artifact-types")
    }
    
    func powers() throws -> Catalog {
        return try Swiftfall().getCatalog(catalog: "powers")
    }
    
    func toughnesses() throws -> Catalog {
        return try Swiftfall().getCatalog(catalog: "toughnesses")
    }
    
    func loyalties() throws -> Catalog {
        return try Swiftfall().getCatalog(catalog: "loyalties")
    }
    
    func watermarks() throws -> Catalog {
        return try Swiftfall().getCatalog(catalog: "watermarks")
    }
}

