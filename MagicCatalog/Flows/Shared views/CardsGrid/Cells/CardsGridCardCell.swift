//
//  MainScreenGridTwoCardCell.swift
//  MagicCatalog
//
//  Created by Alexander Rubtsov on 26.12.2022.
//

import SwiftUI

protocol CardsGridCardCellDelegate: AnyObject {
    func didPressOnCardCell(_ cell: Int)
}

struct CardsGridCardCell: View {
    
    // MARK: - Properties
    
    weak var delegate: CardsGridCardCellDelegate?
    
    let stateManager: InteractiveCardStateManager
    let cellId: Int
    
    // MARK: - Body view
    
    var body: some View {
        Button {
            delegate?.didPressOnCardCell(cellId)
        } label: {
            cellContent
        }
    }
    
    // MARK: - Private body views
    
    private var cellContent: some View {
        InteractiveCardView(stateManager: stateManager)
    }
}
