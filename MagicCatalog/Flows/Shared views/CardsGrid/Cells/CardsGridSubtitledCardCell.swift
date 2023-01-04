//
//  MainScreenCardCell.swift
//  MagicCatalog
//
//  Created by Alexander Rubtsov on 24.12.2022.
//

import SwiftUI

struct CardsGridSubtitledCardCell: View {
    
    // MARK: - Properties
    
    weak var delegate: CardsGridCardCellDelegate?
    
    let stateManager: CardViewStateManager
    
    let cardTitle: String
    let cardType: String
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
        VStack {
            CardViewStateAdapter(stateManager: stateManager)
                .layoutPriority(1)
            
            subtitleBlock
            
            Spacer()
        }
    }
    
    
    private var subtitleBlock: some View {
        VStack(spacing: 5) {
            Text(cardTitle)
                .font(.system(size: FontSize.pt14))
                .multilineTextAlignment(.center)
                .foregroundColor(.black)
            
            Text(cardType)
                .font(.system(size: FontSize.pt10))
                .multilineTextAlignment(.center)
                .foregroundColor(.gray)
        }
    }
}
