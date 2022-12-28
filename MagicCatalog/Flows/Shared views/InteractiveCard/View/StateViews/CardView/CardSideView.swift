//
//  CardSideView.swift
//  MagicCatalog
//
//  Created by Alexander Rubtsov on 21.12.2022.
//

import SwiftUI

struct CardSideView: View {
    
    // MARK: - Properties
    
    let cardImage: UIImage
    
    @Binding var degree: Double
    
    // MARK: - Private properties
    
    @State private var imageHeight: CGFloat = 0
    
    // MARK: - View body
    
    var body: some View {
        Image(uiImage: cardImage)
            .resizable()
            .aspectRatio(contentMode: .fit)
            .clipShape(RoundedRectangle(cornerRadius: imageHeight / 25))
            .background(imageHeightCatcher)
            .rotation3DEffect(Angle(degrees: degree), axis: (x: 0, y: 1, z: 0))
    }
    
    // MARK: - Private body views
    
    private var imageHeightCatcher: some View {
        GeometryReader { geo -> Color in
            DispatchQueue.main.async {
                imageHeight = geo.size.height
            }
            return Color.clear
        }
    }
}
