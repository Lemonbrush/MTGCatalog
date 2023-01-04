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
    
    init(swiftFallCardModel: Card, cardImage: UIImage? = nil) {
        self.swiftFallCardModel = swiftFallCardModel
        
        if let cardImage = cardImage {
            self.cardImage = cardImage
        }
        
        setupCardData(swiftFallCardModel)
        
        if let cardURL = swiftFallCardModel.imageUris(imageType: .normal) {
            imageDownloader.getImageByURL(cardURL) { [weak self] cardImage, error in
                if let cardImage = cardImage {
                    self?.cardImage = cardImage
                }
            }
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
