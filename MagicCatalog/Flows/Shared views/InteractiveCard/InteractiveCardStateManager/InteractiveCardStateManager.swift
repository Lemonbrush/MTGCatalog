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
    
    @Published var stateModel: InteractiveCardStateProtocol = InteractiveCardErrorStateModel()
    
    // MARK: - Private properties
    
    private var cardImage = UIImage()
    private let imageDownloader = ImageDownloaderManager()
    private var currentState: InteractiveCardViewModelState = .loading
    
    private let imageURLString: String
    
    // MARK: - Construction
    
    init(imageURLString: String) {
        self.imageURLString = imageURLString
        
        stateModel = InteractiveCardLoadingStateModel()
        
        currentState = .loading
        updateStateModel()
        
        imageDownloader.delegate = self
        imageDownloader.getImageByURL(imageURLString)
    }
    
    // MARK: - Private functions
    
    private func updateStateModel() {
        switch currentState {
        case .loading:
            stateModel = InteractiveCardLoadingStateModel()
        case .loaded:
            stateModel = InteractiveCardLoadedStateModel(image: cardImage)
        case .error:
            stateModel = InteractiveCardErrorStateModel()
        }
    }
}

extension InteractiveCardStateManager: ImageDownloaderManagerDelegate {
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
