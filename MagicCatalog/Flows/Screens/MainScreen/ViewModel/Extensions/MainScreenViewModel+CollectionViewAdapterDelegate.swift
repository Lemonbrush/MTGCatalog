//
//  MainScreenViewModel+CollectionViewAdapterDelegate.swift
//  MagicCatalog
//
//  Created by Alexander Rubtsov on 26.12.2022.
//

import Foundation

extension MainScreenViewModel: MainScreenCardsGridAdapterDelegate {
    func didPressCardCell(_ cellId: Int) {
        let cardModel = cardModels[cellId]
        onNavigation?(.cardReview, cardModel.cardModel)
    }
    
    func didPressErrorCellButton() {
        showRandomCardReviewScreen()
    }
}
