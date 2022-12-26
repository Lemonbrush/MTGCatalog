//
//  MainScreenCardCell.swift
//  MagicCatalog
//
//  Created by Alexander Rubtsov on 24.12.2022.
//

import SwiftUI

protocol MainScreenCardCellDelegate: AnyObject {
    func didPressOnCardCell(_ cell: Int)
}

struct MainScreenGridThreeCardCell: View {
    
    // MARK: - Properties
    
    weak var delegate: MainScreenCardCellDelegate?
    
    let stateManager: InteractiveCardStateManager
    
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
            InteractiveCardView(stateManager: stateManager)
                .shadow(color: .gray, radius: 4, x: 0, y: 0)
            
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
            
            Spacer()
        }
    }
}
