//
//  CardsGridInlineCardCell.swift
//  MagicCatalog
//
//  Created by Alexander Rubtsov on 03.01.2023.
//

import SwiftUI

struct CardsGridInlineCardCell: View {
    
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
        HStack {
            CardViewStateAdapter(stateManager: stateManager)
                .frame(width: 50, height: 70)
                .padding([.trailing, .leading], 10)
                .padding([.top, .bottom], 5)
            
            
            VStack {
                HStack {
                    Text(cardTitle)
                        .font(.system(size: FontSize.pt14))
                        .foregroundColor(.black)
                        .multilineTextAlignment(.leading)
                    Spacer()
                }
                
                HStack {
                    Text(cardType)
                        .font(.system(size: FontSize.pt10))
                        .foregroundColor(.gray)
                        .multilineTextAlignment(.leading)
                    
                    Spacer()
                }
                
            }
            
            Spacer()
        }
    }
}
