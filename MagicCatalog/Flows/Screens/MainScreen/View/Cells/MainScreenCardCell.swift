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

struct MainScreenCardCell: View {
    
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
                .padding(.bottom, 10)
            
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
        }.padding(.bottom, 10)
    }
}
