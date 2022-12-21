//
//  InteractiveCardView.swift
//  MagicCatalog
//
//  Created by Alexander Rubtsov on 21.12.2022.
//

import SwiftUI

struct InteractiveCardView: View {
    
    // MARK: - Private properties
    
    private var magnification: some Gesture {
        MagnificationGesture()
            .updating($magnifyBy) { currentState, gestureState, transaction in
                gestureState = currentState.magnitude
            }
    }
    
    private var cardView: some View {
        ZStack {
            CardSideView(width: width, height: height, cardImage: cardImage, degree: $frontDegree)
            CardSideView(width: width, height: height, cardImage: UIImage(named: "mtgBackImage") ?? UIImage(), degree: $backDegree)
        }
    }
    
    @Binding var cardImage: UIImage

    @State private var backDegree = 0.0
    @State private var frontDegree = -90.0
    @State private var isFlipped = false
    @State private var dragAmount = CGSize.zero
    @State private var magnificationAmount: CGFloat = 0
    
    @GestureState private var magnifyBy = 1.0
    
    private let width: CGFloat = 350
    private let height: CGFloat = 490
    private let durationAndDelay: CGFloat = 0.3
    
    // MARK: - View body
    
    var body: some View {
        cardView
        .rotation3DEffect(.degrees(-Double(dragAmount.width) / 5), axis: (x: 0, y: -1, z: 0.1))
        .rotation3DEffect(.degrees(Double(dragAmount.height / 5)), axis: (x: -1, y: 0, z: 0.1))
        .gesture(DragGesture()
                .onChanged { dragAmount = $0.translation }
                .onEnded { remainedDragAmount in
                    handleDragEnd(remainedDegrees: remainedDragAmount.translation.width)
                })
        .scaleEffect(magnifyBy)
        .gesture(magnification)
    }
    
    // MARK: - Private functions
    
    private func handleDragEnd(remainedDegrees: CGFloat) {
            if remainedDegrees > 200 || remainedDegrees < -200 {
                flipCard()
            }
            withAnimation(.spring()) {
                dragAmount = .zero
            }
    }
    
    private func flipCard () {
        isFlipped.toggle()
        
        if isFlipped {
            withAnimation(.linear(duration: durationAndDelay)) {
                backDegree = 90
            }
            withAnimation(.linear(duration: durationAndDelay).delay(durationAndDelay)){
                frontDegree = 0
            }
        } else {
            withAnimation(.linear(duration: durationAndDelay).delay(durationAndDelay)){
                backDegree = 0
            }
            withAnimation(.linear(duration: durationAndDelay)) {
                frontDegree = -90
            }
        }
    }
}
