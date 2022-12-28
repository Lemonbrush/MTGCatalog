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
    
    private let imageDownloader = ImageDownloaderManager()
    private let swiftFallCardModel: Card
    
    // MARK: - Construction
    
    init(swiftFallCardModel: Card) {
        self.swiftFallCardModel = swiftFallCardModel
        
        imageDownloader.delegate = self
        
        setupCardData(swiftFallCardModel)
        
        if let cardURLs = swiftFallCardModel.imageUris, let imageURLString = cardURLs["normal"] {
            self.imageDownloader.getImageByURL(imageURLString)
        }
    }
    
    // MARK: - Functions
    
    func didPressBackButton() {
        onNavigation?(.back)
    }
    
    // MARK: - Private functions
    
    private func setupCardData(_ swiftFallCardModel: Card) {
        let cardViewModel = CardReviewScreenCardModel(cardTitle: swiftFallCardModel.name,
                                  cardText: swiftFallCardModel.oracleText,
                                  cardArtist: swiftFallCardModel.artist,
                                  creatureType: swiftFallCardModel.typeLine,
                                  flavourText: swiftFallCardModel.flavorText)
        
        DispatchQueue.main.async { [weak self] in
            self?.cardModel = cardViewModel
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
