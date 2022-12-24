//
//  CardReviewScreenViewModel.swift
//  MagicCatalog
//
//  Created by Alexander Rubtsov on 21.12.2022.
//

import SwiftUI

enum CardReviewScreenViewNavigation {
    case back
}

class CardReviewScreenViewModel: ObservableObject {
    
    // MARK: - Properties
    
    var onNavigation: ((CardReviewScreenViewNavigation) -> Void)?
    
    @Published var cardImage: UIImage = UIImage()
    @Published var cardModel = CardReviewScreenCardModel()
    
    // MARK: - Private properties
    
    private let randomCardReviewScreenManager: RandomCardReviewScreenSearchManager
    private let imageDownloader = ImageDownloaderManager()
    
    // MARK: - Construction
    
    init() {
        randomCardReviewScreenManager = RandomCardReviewScreenSearchManager()
        randomCardReviewScreenManager.delegate = self
        
        imageDownloader.delegate = self
        fetchRandomCardData()
    }
    
    // MARK: - Functions
    
    func didPressBackButton() {
        onNavigation?(.back)
    }
    
    // MARK: - Private functions
    
    private func fetchRandomCardData() {
        randomCardReviewScreenManager.requestCardsSerach()
    }
}

extension CardReviewScreenViewModel: RandomCardReviewScreenSearchManagerDelegate {
    func didReceiveCardData(_ cardModel: Card) {
        let cardViewModel = CardReviewScreenCardModel(cardTitle: cardModel.name ?? "",
                                  cardText: cardModel.oracleText ?? "",
                                  cardArtist: cardModel.artist ?? "",
                                  creatureType: cardModel.typeLine ?? "",
                                  flavourText: cardModel.flavorText)
        
        DispatchQueue.main.async { [weak self] in
            self?.cardModel = cardViewModel
        }
        
        if let cardURLs = cardModel.imageUris, let imageURLString = cardURLs["normal"] {
            self.imageDownloader.getImageByURL(imageURLString)
        }
    }
    
    func didReceiveError(error: MainScreenStateError) {
        
    }
}

extension CardReviewScreenViewModel: ImageDownloaderManagerDelegate {
    func didReceiveImage(_ image: UIImage) {
        cardImage = image
    }
    
    func didReceiveError(_ error: ImageDownloaderManagerError) {
        
    }
}
