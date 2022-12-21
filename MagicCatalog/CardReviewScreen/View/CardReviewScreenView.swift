//
//  CardReviewScreenView.swift
//  MagicCatalog
//
//  Created by Alexander Rubtsov on 21.12.2022.
//

import SwiftUI

struct CardReviewScreenView: View {
    
    // MARK: - Private properties
    
    @StateObject private var viewModel = CardReviewScreenViewModel()
    
    private let contentEdgeInsets = EdgeInsets(top: 0, leading: 20, bottom: 100, trailing: 20)
    private var navBarLinearGradient: LinearGradient = {
        let gradient = Gradient(stops: [.init(color: Color(UIColor.systemGray5).opacity(0.01), location: 0),
                                        .init(color: Color(UIColor.systemGray3), location: 1)])
        return LinearGradient(gradient: gradient, startPoint: .bottom, endPoint: .top)
    }()
    
    // MARK: - Construction
    
    init() {
        UIScrollView.appearance().bounces = false
    }
    
    // MARK: - View body
    
    var body: some View {
        GeometryReader { gp in
            cardReviewScrollView
            Rectangle()
                .fill(navBarLinearGradient)
                .frame(height: 0.1 * gp.size.height)
                .frame(maxWidth: .infinity, alignment: .trailing)
                .allowsHitTesting(false)
                .edgesIgnoringSafeArea(.all)
        }
    }
    
    // MARK: - Private body views
    
    private var interactiveCardBlockView: some View {
        ZStack {
            Rectangle()
                .fill(Color(UIColor.systemGray5))
                .frame(width: UIScreen.main.bounds.size.width, height: 720, alignment: .center)
                .cornerRadius(50, corners: [.bottomLeft, .bottomRight])
            InteractiveCardView(cardImage: $viewModel.cardImage)
                .frame(maxWidth: .infinity)
                .padding([.top], 70)
                .padding([.bottom], 40)
        }.padding([.bottom], 20)
    }
    
    private var cardReviewContentBlockView: some View {
        VStack(spacing: 30) {
            VStack {
                Text(viewModel.cardModel.cardTitle)
                    .font(.custom(MTGFontName.mtgBold, fixedSize: 36))
                    .padding([.bottom], 5)
                    .multilineTextAlignment(.center)
                Text(viewModel.cardModel.creatureType)
                    .font(.system(size: 18))
                    .foregroundColor(.gray)
                    .multilineTextAlignment(.center)
            }
            
            if let cardText = viewModel.cardModel.cardText {
                CardReviewScreenTextBlockView(title: "Card text", text: cardText)
            }
            
            if let flavourText = viewModel.cardModel.flavourText {
                CardReviewScreenTextBlockView(title: "Flavour text", text: flavourText)
            }
            
            if let cardArtist = viewModel.cardModel.cardArtist {
                CardReviewScreenTextBlockView(title: "Illustrated by \(cardArtist)")
            }
            
            Spacer()
        }
    }
    
    private var cardReviewScrollView: some View {
        ScrollView(showsIndicators: false) {
            interactiveCardBlockView
            cardReviewContentBlockView.padding(contentEdgeInsets)
        }.edgesIgnoringSafeArea(.all)
    }
}
