//
//  MainScreenGridTwoCardCell.swift
//  MagicCatalog
//
//  Created by Alexander Rubtsov on 26.12.2022.
//

import SwiftUI

struct MainScreenGridTwoCardCell: View {
    
    // MARK: - Properties
    
    weak var delegate: MainScreenCardCellDelegate?
    
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
        VStack {
            InteractiveCardView(stateManager: stateManager)
                .shadow(color: .gray, radius: 4, x: 0, y: 0)
        }
    }
}
