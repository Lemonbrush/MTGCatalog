//
//  MainScreenErrorStateCell.swift
//  MagicCatalog
//
//  Created by Alexander Rubtsov on 24.12.2022.
//

import SwiftUI

protocol MainScreenErrorStateCellDelegate: AnyObject {
    func didPressButton()
}

struct MainScreenErrorStateCell: View {
    
    // MARK: - Properties
    
    weak var delegate: MainScreenErrorStateCellDelegate?
    
    let image: UIImage?
    let topText: String?
    let bottomText: String?
    let buttonTLabelText: String?
    
    // MARK: - Body view
    
      var body: some View {
          VStack(spacing: 30) {
              
              if let image = image {
                  Image(uiImage: image)
                      .resizable()
                      .aspectRatio(contentMode: .fit)
                      .frame(width: 60, height: 60)
                      .foregroundColor(Color(UIColor.systemGray5))
              }
              
              errorCellTextBlock
              
          }.frame(height: UIScreen.main.bounds.size.height / 1.5)
      }
    
    // MARK: - Private body views
    
    private var errorCellTextBlock: some View {
        VStack(spacing: 10) {
            if let topText = topText {
                Text(topText)
                    .font(.title.weight(.bold))
            }
            
            VStack(spacing: 5) {
                if let bottomText = bottomText {
                    Text(bottomText)
                        .multilineTextAlignment(.center)
                        .foregroundColor(.gray)
                }
                
                if let buttonTLabelText = buttonTLabelText {
                    Button(action: {
                        delegate?.didPressButton()
                    }) {
                        Text(buttonTLabelText)
                    }.foregroundColor(.blue)
                }
            }
        }
    }
}
