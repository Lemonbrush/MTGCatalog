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
    
    var cardImage = UIImage()
    
    // MARK: - Private properties
    
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
        DispatchQueue.main.async { [weak self] in
            guard let self = self else {
                return
            }
            
            switch self.currentState {
            case .loading:
                self.stateModel = InteractiveCardLoadingStateModel()
            case .loaded:
                self.stateModel = InteractiveCardLoadedStateModel(image: self.cardImage)
            case .error:
                self.stateModel = InteractiveCardErrorStateModel()
            }
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
