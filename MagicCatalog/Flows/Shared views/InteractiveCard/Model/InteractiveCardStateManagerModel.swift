//
//  InteractiveCardStateManagerModel.swift
//  MagicCatalog
//
//  Created by Alexander Rubtsov on 04.01.2023.
//

import Foundation

struct InteractiveCardStateManagerModel {
    
    // MARK: - Properties
    
    let frontImageURLString: String
    let backImageURLString: String?
    
    // MARK: - Construction
    
    init(frontImageURLString: String, backImageURLString: String? = nil) {
        self.frontImageURLString = frontImageURLString
        self.backImageURLString = backImageURLString
    }
}
