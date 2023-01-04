//
//  InteractiveCardView.swift
//  MagicCatalog
//
//  Created by Alexander Rubtsov on 04.01.2023.
//

import SwiftUI

struct InteractiveCardView: View {
    
    // MARK: - Properties
    
    let frontCardImage: UIImage
    let backCardImage: UIImage?
    
    // MARK: - Private properties
    
    @GestureState private var magnifyBy = 1.0
    
    @State private var backDegree = -90.0
    @State private var frontDegree = 0.0
    @State private var isFlipped = true
    @State private var dragAmount = CGSize.zero
    @State private var magnificationAmount: CGFloat = 0
    
    private let durationAndDelay: CGFloat = 0.3
    
    private var magnification: some Gesture {
        MagnificationGesture()
            .updating($magnifyBy) { currentState, gestureState, transaction in
                gestureState = currentState.magnitude
            }
    }
    
    // MARK: - Body view
    
    var body: some View {
        ZStack {
            cardView
            flipButton
        }
    }
    
    // MARK: - Private Body view
    
    private var cardView: some View {
        CardView(frontCardImage: frontCardImage, backCardImage: backCardImage, backDegree: $backDegree, frontDegree: $frontDegree)
        .rotation3DEffect(.degrees(-Double(dragAmount.width) / 5), axis: (x: 0, y: -1, z: 0.1))
        .rotation3DEffect(.degrees(Double(dragAmount.height / 5)), axis: (x: -1, y: 0, z: 0.1))
        .scaleEffect(magnifyBy)
        .gesture(magnification)
    }
    
    private var flipButton: some View {
        Button {
            flipCard()
        } label: {
            Image(systemName: "arrow.triangle.2.circlepath.circle.fill")
                .resizable()
                .frame(width: 50, height: 50)
                .foregroundColor(.white)
                .opacity(0.4)
                .shadow(color: .black, radius: 5)
        }
    }
    
    // MARK: - Private functions
    
    private func flipCard () {
        isFlipped.toggle()
        
        if isFlipped {
            withAnimation(.linear(duration: durationAndDelay)) {
                backDegree = 90
            }
            withAnimation(.linear(duration: durationAndDelay)
                .delay(durationAndDelay)){
                frontDegree = 0
            }
        } else {
            withAnimation(.linear(duration: durationAndDelay)
                .delay(durationAndDelay)){
                backDegree = 0
            }
            withAnimation(.linear(duration: durationAndDelay)) {
                frontDegree = -90
            }
        }
    }
}

struct InteractiveCardView_Previews: PreviewProvider {
    static var previews: some View {
        InteractiveCardView(frontCardImage: UIImage(named: "mtgBackImage") ?? UIImage() , backCardImage: nil)
            .padding(30)
    }
}
