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
    
    let interactiveCardViewModel: InteractiveCardViewModel
    
    let cardTitle: String
    let cardType: String
    
    // MARK: - Body view
    
    var body: some View {
        VStack {
            InteractiveCardView(viewModel: interactiveCardViewModel)
                .padding(.bottom, 10)
            
            VStack(spacing: 5) {
                Text(cardTitle)
                    .font(.system(size: FontSize.pt14))
                    .multilineTextAlignment(.center)
                
                Text(cardType)
                    .font(.system(size: FontSize.pt10))
                    .multilineTextAlignment(.center)
                    .foregroundColor(.gray)
            }
            
            Spacer()
        }.padding(.bottom, 10)
    }
}
