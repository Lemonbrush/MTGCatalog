//
//  MainScreenViewModel+CollectionViewAdapterDelegate.swift
//  MagicCatalog
//
//  Created by Alexander Rubtsov on 26.12.2022.
//

import Foundation

extension MainScreenViewModel: MainScreenCollectionViewAdapterDelegate {
    func didPressCardCell(_ cellId: Int) {
        let cardModel = cardModels[cellId]
        onNavigation?(.cardReview, cardModel)
    }
    
    func didPressErrorCellButton() {
        showRandomCardReviewScreen()
    }
}
