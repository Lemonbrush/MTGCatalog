//
//  MainScreenCardCell.swift
//  MagicCatalog
//
//  Created by Alexander Rubtsov on 24.12.2022.
//

import SwiftUI

protocol MainScreenCardCellDelegate: AnyObject {
    func didPressOnCardCell()
}

struct MainScreenCardCell: View {
    
    // MARK: - Properties
    
    weak var delegate: MainScreenCardCellDelegate?
    
    let cardTitle: String
    
    // MARK: - Body view
    
    var body: some View {
        VStack {
            if let image = UIImage(named: "mtgBackImage") {
                InteractiveCardView(cardImage: image).padding(20)
            }
            
            Text(cardTitle)
        }
    }
}
