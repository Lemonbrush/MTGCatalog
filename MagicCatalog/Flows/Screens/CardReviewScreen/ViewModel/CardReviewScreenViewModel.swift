//
//  CardReviewScreenViewModel.swift
//  MagicCatalog
//
//  Created by Alexander Rubtsov on 21.12.2022.
//

import SwiftUI

struct CardModel {
    var cardTitle: String = ""
    var cardText: String = ""
    var cardArtist: String = ""
    var creatureType: String = ""
    var flavourText: String?
}

enum CardReviewScreenViewNavigation {
    case back
}

class CardReviewScreenViewModel: ObservableObject {
    
    // MARK: - Properties
    
    var onNavigation: ((CardReviewScreenViewNavigation) -> Void)?
    
    @Published var cardImage: UIImage = UIImage()
    @Published var cardModel = CardModel()
    
    // MARK: - Private properties
    
    private let imageDownloader = ImageDownloaderManager()
    
    // MARK: - Construction
    
    init() {
        imageDownloader.delegate = self
        fetchRandomCardData()
    }
    
    // MARK: - Functions
    
    func didPressBackButton() {
        onNavigation?(.back)
    }
    
    // MARK: - Private functions
    
    private func fetchRandomCardData() {
        guard let cardData = try? Swiftfall().getRandomCard() else {
            return
        }
            
        cardModel = CardModel(cardTitle: cardData.name ?? "",
                              cardText: cardData.oracleText ?? "",
                              cardArtist: cardData.artist ?? "",
                              creatureType: cardData.typeLine ?? "",
                              flavourText: cardData.flavorText)
            
        if let cardURLs = cardData.imageUris,
           let imageURLString = cardURLs["normal"] {
            imageDownloader.getImageByURL(imageURLString)
        }
    }
}

extension CardReviewScreenViewModel: ImageDownloaderManagerDelegate {
    func didReceiveImage(_ image: UIImage) {
        cardImage = image
    }
    
    func didReceiveError(_ error: ImageDownloaderManagerError) {
        
    }
}
