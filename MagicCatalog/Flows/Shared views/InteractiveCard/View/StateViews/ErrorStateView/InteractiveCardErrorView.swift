//
//  InteractiveCardErrorView.swift
//  MagicCatalog
//
//  Created by Alexander Rubtsov on 25.12.2022.
//

import SwiftUI

struct InteractiveCardErrorView: View {
    
    // MARK: - Private properties
    
    @State private var imageHeight: CGFloat = 0
    
    private let defaultImage = UIImage(named: "mtgBackImage") ?? UIImage()
    
    // MARK: - Body view
    
    var body: some View {
        ZStack {
            Image(uiImage: defaultImage)
                .resizable()
                .opacity(0)
                .aspectRatio(contentMode: .fit)
            
            RoundedRectangle(cornerRadius: 10)
                .strokeBorder(style: StrokeStyle(lineWidth: 2, dash: [10]))
                .clipShape(RoundedRectangle(cornerRadius: imageHeight / 25))
                .foregroundColor(Color(UIColor.systemGray3))
                .background(imageHeightCatcher)
        }
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
