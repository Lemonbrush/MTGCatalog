//
//  CardReviewScreenTextBlockView.swift
//  MagicCatalog
//
//  Created by Alexander Rubtsov on 21.12.2022.
//

import SwiftUI

struct CardReviewScreenTextBlockView: View {
    
    // MARK: - Properties
    
    let title: String
    let text: String
    
    // MARK: - Construction
    
    init(title: String, text: String = "") {
        self.title = title
        self.text = text
    }
    
    // MARK: - View body
    
    var body: some View {
        VStack {
            HStack {
                Text(title)
                    .font(.custom(MTGFontName.matrixBold, fixedSize: FontSize.pt24))
                    .padding([.bottom], 10)
                    .multilineTextAlignment(.leading)
                    .foregroundColor(.gray)
                Spacer()
            }
            
            if !text.isEmpty {
                HStack {
                    Text(text)
                    Spacer()
                }
            }
        }
    }
}
