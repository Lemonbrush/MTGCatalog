//
//  InteractiveCardLoadingView.swift
//  MagicCatalog
//
//  Created by Alexander Rubtsov on 25.12.2022.
//

import SwiftUI

struct InteractiveCardLoadingView : View {
    
    // MARK: - Private properties
    
    @State private var imageHeight: CGFloat = 0
    
    private let defaultImage = UIImage(named: "mtgBackImage") ?? UIImage()
    
    // MARK: - Body view
    
    var body : some View{
        ZStack {
            Image(uiImage: defaultImage)
                .resizable()
                .opacity(0)
                .aspectRatio(contentMode: .fit)
            
            Rectangle()
                .clipShape(RoundedRectangle(cornerRadius: imageHeight / 25))
                .foregroundColor(Color(UIColor.systemGray6))
                .shimmer()
                .background(imageHeightCatcher)
        }
    }
    
    // MARK: - Private body views

    private var imageHeightCatcher: some View {
        GeometryReader { geo -> Color in
            DispatchQueue.main.async {
                imageHeight = geo.size.height
            }
            return .clear
        }
    }
}
