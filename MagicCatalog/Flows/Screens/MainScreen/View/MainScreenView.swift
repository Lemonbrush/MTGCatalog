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
    
    private var menuButton: some View {
        Menu {
            Button(action: {
                // Action
            }) {
                Label("Key words dictionary", systemImage: "questionmark.circle")
            }
            
            Button(action: {
                // Action
            }) {
                Label("Advanced search", systemImage: "list.bullet.rectangle")
            }
            
            Button(action: {
                // Action
            }) {
                Label("All Sets", systemImage: "crown")
            }
        } label: {
            Image(systemName: "ellipsis.circle")
        }
    }
    
    var body: some View {
        VStack(spacing: 10) {
                Text("Find a card").font(.title.weight(.bold))
            
            VStack(spacing: 5) {
                Text("Start searching for an mtg card or get a ").multilineTextAlignment(.center)
                Button(action: {
                    viewModel.didPressRandomCardButton()
                }) {
                    Text("Random card")
                }.foregroundColor(.blue)
            }
                
            }.padding()
                .foregroundColor(.gray)
                .navigationTitle("Magic cards")
                .toolbar {
                    menuButton
                }.searchable(text: $searchCardText){
                    // last searches
                    // Cards collectionview
                }
    }
}
