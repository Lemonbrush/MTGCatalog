//
//  InteractiveCardStateManagerModel.swift
//  MagicCatalog
//
//  Created by Alexander Rubtsov on 04.01.2023.
//

import Foundation

struct CardViewStateManagerModel {
    
    // MARK: - Properties
    
    let frontImageURLString: String
    let backImageURLString: String?
    let cardViewType: CardViewType
    
    // MARK: - Construction
    
    init(frontImageURLString: String,
         backImageURLString: String? = nil,
         cardViewType: CardViewType) {
        self.frontImageURLString = frontImageURLString
        self.backImageURLString = backImageURLString
        self.cardViewType = cardViewType
    }
}
