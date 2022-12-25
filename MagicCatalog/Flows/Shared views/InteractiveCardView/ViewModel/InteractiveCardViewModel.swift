//
//  InteractiveCardViewModel.swift
//  MagicCatalog
//
//  Created by Alexander Rubtsov on 25.12.2022.
//

import UIKit
import SwiftUI

enum InteractiveCardViewModelState {
    case loading,
         loaded,
         error
}

class InteractiveCardViewModel: ObservableObject {
    
    // MARK: - Properties
    
    @Published var stateModel: InteractiveCardStateProtocol
    
    // MARK: - Private properties
    
    private let imageDownloader = ImageDownloaderManager()
    private var currentState: InteractiveCardViewModelState
    
    private let imageURLString: String
    private let cardViewSize: CardViewSize
    private var cardImage = UIImage()
    
    // MARK: - Construction
    
    init(imageURLString: String, cardViewSize: CardViewSize) {
        self.imageURLString = imageURLString
        self.cardViewSize = cardViewSize
        
        stateModel = InteractiveCardLoadingStateModel(cardSize: cardViewSize)
        
        currentState = .loading
        updateStateModel()
        
        imageDownloader.delegate = self
        imageDownloader.getImageByURL(imageURLString)
    }
    
    // MARK: - Private functions
    
    func updateStateModel() {
        switch currentState {
        case .loading:
            stateModel = InteractiveCardLoadingStateModel(cardSize: cardViewSize)
        case .loaded:
            stateModel = InteractiveCardLoadedStateModel(image: cardImage, cardSize: cardViewSize)
        case .error:
            stateModel = InteractiveCardErrorStateModel()
        }
    }
}

extension InteractiveCardViewModel: ImageDownloaderManagerDelegate {
    func didReceiveImage(_ image: UIImage) {
        cardImage = image
        currentState = .loaded
        updateStateModel()
    }
    
    func didReceiveError(_ error: ImageDownloaderManagerError) {
        currentState = .error
        updateStateModel()
    }
}
