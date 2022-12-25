//
//  CardSideView.swift
//  MagicCatalog
//
//  Created by Alexander Rubtsov on 21.12.2022.
//

import SwiftUI

struct CardSideView: View {
    
    // MARK: - Properties
    
    let cardSize: CardViewSize
    let cardImage: UIImage
    
    @Binding var degree: Double
    
    // MARK: - View body
    
    var body: some View {
        ZStack {
            Image(uiImage: cardImage)
                .resizable()
                .aspectRatio(contentMode: .fit)
                .frame(width: cardSize.width, height: cardSize.height, alignment: .center)
                .clipShape(RoundedRectangle(cornerRadius: cardSize.cornerRadius))
                .shadow(color: .gray, radius: 10, x: 0, y: 10)
                
        }.rotation3DEffect(Angle(degrees: degree), axis: (x: 0, y: 1, z: 0))
    }
}
