//
//  InteractiveCardViewModel.swift
//  MagicCatalog
//
//  Created by Alexander Rubtsov on 25.12.2022.
//

import UIKit
import SwiftUI

enum InteractiveCardViewModelState {
    case loading, loaded, error
}

class InteractiveCardStateManager: ObservableObject {
    
    // MARK: - Properties
    
    @Published var stateModel: InteractiveCardStateProtocol = InteractiveCardLoadingStateModel()
    
    var cardFrontImage = UIImage()
    var cardBackImage: UIImage? = nil
    
    // MARK: - Private properties
    
    private let imageDownloader = ImageDownloaderManager()
    private var currentState: InteractiveCardViewModelState = .loading
    
    private let cardManagerModel: InteractiveCardStateManagerModel
    
    // MARK: - Construction
    
    init(cardManagerModel: InteractiveCardStateManagerModel) {
        self.cardManagerModel = cardManagerModel
        
        requestCardImages()
    }
    
    // MARK: - Private functions
    
    private func updateStateModel() {
        DispatchQueue.main.async { [weak self] in
            guard let self = self else {
                return
            }
            
            switch self.currentState {
            case .loading:
                self.stateModel = InteractiveCardLoadingStateModel()
            case .loaded:
                self.stateModel = InteractiveCardLoadedStateModel(frontFace: self.cardFrontImage,
                                                                  backFace: self.cardBackImage)
            case .error:
                self.stateModel = InteractiveCardErrorStateModel()
            }
        }
    }
    
    private func requestCardImages() {
        currentState = .loading
        updateStateModel()
        
        imageDownloader.getImageByURL(cardManagerModel.frontImageURLString) { [weak self] image, error in
            guard let self = self else {
                return
            }
            
            if let image = image {
                self.cardFrontImage = image
                self.currentState = .loaded
                self.updateStateModel()
            } else if let error = error {
                self.didReceiveError(error)
            }
        }
        
        guard let backImageURLString = cardManagerModel.backImageURLString else {
            return
        }
        
        imageDownloader.getImageByURL(backImageURLString) { [weak self] image, error in
            guard let self = self else {
                return
            }
            
            if let image = image {
                self.cardBackImage = image
                self.currentState = .loaded
                self.updateStateModel()
            } else if let error = error {
                self.didReceiveError(error)
            }
        }
    }
    
    private func didReceiveImage(_ image: UIImage) {
        cardFrontImage = image
        currentState = .loaded
        updateStateModel()
    }
    
    private func didReceiveError(_ error: ImageDownloaderManagerError) {
        currentState = .error
        updateStateModel()
    }
}
