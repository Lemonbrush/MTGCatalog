//
//  MainScreenView.swift
//  MagicCatalog
//
//  Created by Alexander Rubtsov on 22.12.2022.
//

import SwiftUI

struct MainScreenView: View {
    
    // MARK: - Properties
    
    @ObservedObject var viewModel: MainScreenViewModel
    
    @State var searchCardText: String = ""
    @State var shouldShowSearchButton = false
    
    var backgroundGradient: LinearGradient = {
        let gradient = Gradient(colors: [Color(UIColor.brandDarkPurple),
                                         Color(UIColor.brandPurple)])
        return LinearGradient(gradient: gradient,
                              startPoint: .top,
                              endPoint: .bottom)
    }()
    
    // MARK: - Body view
    
    private var searchTextField: some View {
        HStack(spacing: 10) {
            TextField("", text: $searchCardText)
                .placeholder(when: searchCardText.isEmpty) {
                    Text("Search card").foregroundColor(Color(UIColor.systemGray3))
                }
                .padding([.leading, .trailing], 30)
                .padding([.top, .bottom], 15)
                .background(Color(UIColor.systemGray6))
                .foregroundColor(.black)
                .cornerRadius(10)
                .onChange(of: searchCardText) { newValue in
                    withAnimation(Animation.easeOut(duration: 0.2)) {
                        shouldShowSearchButton = !newValue.isEmpty
                    }
                }
            
            if shouldShowSearchButton {
                Button(action: {
                    viewModel.didPressRandomCardButton()
                }, label: {
                    Image(systemName: "magnifyingglass").foregroundColor(.white)
                }) .transition(.move(edge: .trailing))
                    .padding(15)
                    .background(.blue)
                    .cornerRadius(10)
            }
            
        }
    }
    
    var body: some View {
            VStack(spacing: 50) {
                Spacer()
                LinearGradient(
                    colors: [.red, .yellow],
                    startPoint: .topLeading,
                    endPoint: .bottomTrailing
                )
                .mask(
                    // 1
                Text("Magic\n   Catalog")
                    .font(.custom(MTGFontName.mtgBold, size: FontSize.pt72)))
                Spacer()
                
                searchTextField
                
                VStack(spacing: 10) {
                    MainScreenButton(text: "All Sets",
                                     backgroundButtonColor: .blue) {
                        viewModel.didPressRandomCardButton()
                    }
                    
                    MainScreenButton(text: "Random Card",
                                     backgroundButtonColor: .pink) {
                        viewModel.didPressRandomCardButton()
                    }
                    
                    MainScreenButton(text: "Key Words Guide",
                                     backgroundButtonColor: .green) {
                        viewModel.didPressRandomCardButton()
                    }
                }
            }.padding([.leading, .trailing], 20)
    }
}
