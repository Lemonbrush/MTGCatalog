//
//  InteractiveCardView.swift
//  MagicCatalog
//
//  Created by Alexander Rubtsov on 21.12.2022.
//

import SwiftUI

struct CardView: View {
    
    // MARK: - Properties
    
    @State var backDegree: Double
    @State var frontDegree: Double
    
    var frontCardImage: UIImage
    var backCardImage: UIImage?
    
    // MARK: - Construction
    
    init(frontCardImage: UIImage,
         backCardImage: UIImage? = nil,
         backDegree: Double = -90.0,
         frontDegree: Double = 0.0) {
        self.frontCardImage = frontCardImage
        self.backCardImage = backCardImage
        self.backDegree = backDegree
        self.frontDegree = frontDegree
    }
    
    // MARK: - Body view
    
    var body: some View {
        ZStack {
            CardSideView(cardImage: backCardImage ?? UIImage(named: "mtgBackImage") ?? UIImage(), degree: $backDegree)
            CardSideView(cardImage: frontCardImage, degree: $frontDegree)
        }
    }
}
