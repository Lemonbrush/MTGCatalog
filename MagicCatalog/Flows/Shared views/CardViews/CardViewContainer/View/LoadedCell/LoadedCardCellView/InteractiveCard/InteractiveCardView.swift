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
    
    private var dragGesture: some Gesture {
        DragGesture()
            .onChanged { dragAmount = $0.translation }
            .onEnded { remainedDragAmount in
                handleDragEnd(remainedDegrees: remainedDragAmount.translation.width)
            }
    }
    
    // MARK: - Body view
    
    var body: some View {
        CardView(frontCardImage: frontCardImage, backCardImage: backCardImage, backDegree: backDegree, frontDegree: frontDegree)
        .rotation3DEffect(.degrees(-Double(dragAmount.width) / 5), axis: (x: 0, y: -1, z: 0.1))
        .rotation3DEffect(.degrees(Double(dragAmount.height / 5)), axis: (x: -1, y: 0, z: 0.1))
        .gesture(dragGesture)
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
