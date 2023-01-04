//
//  CardView.swift
//  MagicCatalog
//
//  Created by Alexander Rubtsov on 21.12.2022.
//

import SwiftUI

struct CardView: View {
    
    // MARK: - Properties
    
    @Binding var backDegree: Double
    @Binding var frontDegree: Double
    
    var frontCardImage: UIImage
    var backCardImage: UIImage?
    
    // MARK: - Construction
    
    init(frontCardImage: UIImage,
         backCardImage: UIImage? = nil,
         backDegree: Binding<Double> = .constant(-90.0),
         frontDegree: Binding<Double> = .constant(0.0)) {
        self.frontCardImage = frontCardImage
        self.backCardImage = backCardImage
        _backDegree = backDegree
        _frontDegree = frontDegree
    }
    
    // MARK: - Body view
    
    var body: some View {
        ZStack {
            CardSideView(cardImage: backCardImage ?? UIImage(named: "mtgBackImage") ?? UIImage(), degree: $backDegree)
            CardSideView(cardImage: frontCardImage, degree: $frontDegree)
        }
    }
}
