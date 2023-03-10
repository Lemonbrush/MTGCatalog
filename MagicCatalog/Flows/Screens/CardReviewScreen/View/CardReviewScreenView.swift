//
//  CardReviewScreenView.swift
//  MagicCatalog
//
//  Created by Alexander Rubtsov on 21.12.2022.
//

import SwiftUI

struct CardReviewScreenView: View {
    
    // MARK: - Private properties
    
    @ObservedObject private var viewModel: CardReviewScreenViewModel
    
    @State private var scrollOffset: CGFloat = .zero
    
    private let contentEdgeInsets = EdgeInsets(top: 20, leading: 20, bottom: 100, trailing: 20)
    private var navBarLinearGradient: LinearGradient = {
        let gradient = Gradient(stops: [.init(color: Color(UIColor.systemGray5).opacity(0.01), location: 0),
                                        .init(color: Color(UIColor.systemGray3), location: 1)])
        return LinearGradient(gradient: gradient, startPoint: .bottom, endPoint: .top)
    }()
    
    // MARK: - Construction
    
    init(viewModel: CardReviewScreenViewModel) {
        self.viewModel = viewModel
        UIScrollView.appearance().bounces = false
    }
    
    // MARK: - Body view
    
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
            CardView(frontCardImage: viewModel.cardImage, backCardImage: nil)
                .padding([.top], 100)
                .padding([.bottom], 40)
                .padding([.leading, .trailing], 10)
            
            
            customeNavBarBlockView
            
        }.padding([.bottom], 20)
    }
    
    private var customeNavBarBlockView: some View {
        VStack {
            HStack {
                Button(action: {
                    viewModel.didPressBackButton()
                }) {
                    Image(systemName: "arrow.left")
                        .padding(10)
                        .foregroundColor(.black)
                }
                
                Spacer()
            }.padding([.leading, .trailing], 20)
            
            Spacer()
        }.padding([.top], 50)
    }
    
    private var cardReviewContentBlockView: some View {
        VStack(spacing: 30) {
            cardReviewContentBlockCardTitleView
            
            if scrollOffset >= 0 {
                Spacer(minLength: 50)
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
    
    private var cardReviewContentBlockCardTitleView: some View {
        VStack {
            if let cardTitle = viewModel.cardModel.cardTitle {
                Text(cardTitle)
                    .font(.custom(MTGFontName.mtgBold, fixedSize: FontSize.pt36))
                    .padding([.bottom], 5)
                    .multilineTextAlignment(.center)
            }
            
            
            if let creatureType = viewModel.cardModel.creatureType {
                Text(creatureType)
                    .font(.system(size: FontSize.pt18))
                    .foregroundColor(.gray)
                    .multilineTextAlignment(.center)
            }
        }.padding([.bottom], 20)
    }
    
    private var cardReviewScrollView: some View {
        ScrollViewOffset(showsIndicators: false) {
            interactiveCardBlockView
            cardReviewContentBlockView.padding(contentEdgeInsets)
        } onOffsetChange: { value in
            withAnimation(Animation.easeInOut.speed(1)) {
                scrollOffset = value
            }
        }.edgesIgnoringSafeArea(.all)
    }
}
